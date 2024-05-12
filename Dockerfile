FROM ubuntu:22.04

RUN apt-get update && apt-get install -y git build-essential gdb-multiarch qemu-system-misc gcc-riscv64-linux-gnu binutils-riscv64-linux-gnu

RUN (echo "add-auto-load-safe-path /xv6-labs/.gdbinit" > /root/.gdbinit)

WORKDIR /xv6-labs

ENTRYPOINT ["/bin/bash"]