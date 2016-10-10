sudo: required

services:
  - docker

install: true

before_script:
  - sudo apt-get --yes --no-install-recommends install binfmt-support qemu-user-static
  - echo ':arm:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-arm-static:' | sudo tee -a /proc/sys/fs/binfmt_misc/register

env:
  - DISTRO=wheezy
  - DISTRO=jessie
  - DISTRO=latest

script:
  - cp /usr/bin/qemu-arm-static ${DISTRO}/
  - docker build -t sedden/rpi-raspbian-qemu:${DISTRO} ${DISTRO}/
  - docker run --rm -i -t sedden/rpi-raspbian-qemu:${DISTRO} /bin/echo 'Running ' $DISTRO ' build...'