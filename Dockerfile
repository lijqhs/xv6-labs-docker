FROM ubuntu:22.04

RUN apt-get update && apt-get install -y git build-essential gdb-multiarch qemu-system-misc gcc-riscv64-linux-gnu binutils-riscv64-linux-gnu zsh curl

RUN (echo "add-auto-load-safe-path /xv6-labs/.gdbinit" > /root/.gdbinit)

WORKDIR /xv6-labs

RUN git config --global credential.helper 'store --file=/etc/.git-credentials'

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

RUN chsh -s /bin/zsh

ENTRYPOINT ["/bin/zsh"]