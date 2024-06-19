FROM ubuntu:22.04

RUN apt-get update && apt-get install -y git build-essential gdb-multiarch qemu-system-misc gcc-riscv64-linux-gnu binutils-riscv64-linux-gnu zsh curl vim

RUN (echo "add-auto-load-safe-path /code/xv6-labs-2023/.gdbinit" > /root/.gdbinit)

WORKDIR /code

RUN git config --global credential.helper 'store --file=/etc/.git-credentials'

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

RUN chsh -s /bin/zsh

ENTRYPOINT ["/bin/zsh"]
