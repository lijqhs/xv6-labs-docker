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

### Scenario 1: as an environment tool for Xv6 labs in host machine

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
docker run -it --rm --name xv6 --hostname xv6 -v $(pwd):/xv6-labs xv6-labs
```

`$(pwd)` is the path to your local xv6-labs repository on your host machine (in my machine, it is `/Users/lijqhs/learn/xv6-labs-2023`). This will mount the `xv6-labs-2023` directory as a volume inside the container.

4. Inside the container, the above command will navigate automatically to the `/xv6-labs` directory. To build and run xv6 labs, you can use the following commands:

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

4. Setup GitHub with PAT

```sh
echo "https://<github_username>:<github_PAT>@github.com" > /etc/.git-credentials
```

5. Git Clone Xv6 repo

```sh
git clone git://g.csail.mit.edu/xv6-labs-2023
cd xv6-labs-2023
```

To use qemu in this docker container, the same as step 4 in Scenario 1.

Connect to container with `Dev Container` extension in VS Code.


## Customization

If you need to install additional packages or make modifications to the Docker environment, you can edit the `Dockerfile` and rebuild the image using the `docker build` command.
