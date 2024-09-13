# Docker Image for xv6 labs

This repository contains a Dockerfile for setting up an Ubuntu 22.04 environment to work with the xv6 operating system labs. The Docker container includes all the necessary tools and dependencies for building, running, and debugging xv6 using QEMU.

xv6 course: https://pdos.csail.mit.edu/6.1810/2023/overview.html

For the labs, we can pull code:

```sh
git clone git://g.csail.mit.edu/xv6-labs-2023
cd xv6-labs-2023
```

## Prerequisites

- Docker installed on your system

## Usage

### Scenario 1: as an environment tool

The Xv6 labs repo is stored and uses git account in host machine. The container can be removed whenever you want. All your work is on your host machine.

1. Clone this repository:

   ```sh
   git clone https://github.com/lijqhs/xv6-labs-docker.git
   cd xv6-labs-docker
   ```

2. Build the Docker image:

   ```sh
   docker build -t xv6-labs .
   ```

3. Run the Docker container:

   ```sh
   docker run -it --rm --name xv6 --hostname xv6 -v $(pwd):/code/xv6-labs-2023 -w /code/xv6-labs-2023 xv6-labs
   ```

   - `$(pwd)` is the path to your local xv6-labs repository on your host machine (in my machine, it is `/Users/lijqhs/learn/xv6-labs-2023`). This will mount the `xv6-labs-2023` directory as a volume inside the container `/code/xv6-labs-2023`.
   - `-w` or `--workdir` option is to change the working directory to `/code/xv6-labs-2023` within the container.

4. Inside the container, the above command will navigate automatically to the `/code/xv6-labs-2023` directory. To build and run xv6 labs, you can use the following commands:

   ```sh
   make qemu
   ```

   To debug xv6 using GDB, you can use:

   ```sh
   make qemu-gdb
   ```

   The `.gdbinit` file is already configured to automatically load the `.gdbinit` file from the `/xv6-labs-2023` directory.

   Then open another shell window in your host machine, run into the same container:

   ```sh
   docker exec -it xv6 gdb-multiarch
   ```

5. When you're done, you can exit the container by typing `exit`.



### Scenario 2: as a new machine

The Xv6 labs repo is stored and uses git account in the container. You will set git account in container. The container cannot be simply removed before you push your work to GitHub, otherwise you will lose your work.

1. Clone this repository:

   ```sh
   git clone https://github.com/lijqhs/xv6-labs-docker.git
   cd xv6-labs-docker
   ```

2. Build the Docker image:

   ```sh
   docker build -t xv6-labs .
   ```

3. Run the Docker container:

   ```sh
   docker run -it --name xv6 --hostname xv6 xv6-labs
   ```

4. Setup GitHub Authentications
   1. with SSH 
   It is recommended to [use GitHub with SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent), which is more secure for long-term use.
   - Generate SSH key: `ssh-keygen -t ed25519 -C "your_email@example.com"`
   - Add SSH key: `cat ~/.ssh/id_ed25519.pub`, copy and paste to GitHub settings.
   - Test: `ssh -T git@github.com`

   2. with PAT
   
   Another optional way is to [use PAT](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens), which is very easy to setup. In the docker container:

   ```sh
   echo "https://<github_username>:<github_PAT>@github.com" > /etc/.git-credentials
   ```

1. Git Clone Xv6 repo

   In the docker container, download xv6 labs repo into `/code/xv6-labs-2023`:

   ```sh
   git clone git://g.csail.mit.edu/xv6-labs-2023
   cd xv6-labs-2023
   ```

To use qemu in this docker container, the same as step 4 in Scenario 1.

Connect to container with `Dev Container` extension in VS Code.

### Issues

When using VS Code to connect to the container, it seems that VS Code will change `.gitconfig` to be:

```
[credential]
        helper = "!f() { /root/.vscode-server/bin/89de5a8d4d6205e5b11647eb6a74844ca23d2573/node /tmp/vscode-remote-containers-f9efd0da-7ded-401b-9756-943f357e6db2.js git-credential-helper $*; }; f"
```

Then the credential setup in docker image will not be effective, VS Code asks you to input your username, which is not expected. The purpose of this Scenario is to separate Git account environment from the host machine. So we need to run this command in container again:

```sh
git config --global credential.helper 'store --file=/etc/.git-credentials'
```

## Customization

If you need to install additional packages or make modifications to the Docker environment, you can edit the `Dockerfile` and rebuild the image using the `docker build` command.
