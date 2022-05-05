# AnR ML Docker
 This repository contains the necessary elements (code and artifacts) to build a
 Machine Learning container suitable to execute all the ML exercises of the AnR
 course.
 
The container is equipped with a few development tools such as vim, tmux, git,
... in order to process and analyse (a.k.a. engineer) data and to diagnose any
issue.

!!! Note: Do not clone this repository into a path containing a space !!!*

## Prerequisites
* A UNIX-like operating system, preferably Linux. (Ubuntu 20.04 is recommended.)
* The `glxinfo` command. (It's included with the `mesa-utils` package on Ubuntu. So, install this on the Linux host before building this repository. On an Ubuntu host, execute `sudo apt install mesa-utils` to install `glxinfo`.)
* An operational docker daemon.
* A terminal with a Nerd Font is highly recommended. ([Nerd Font Download page](https://www.nerdfonts.com/font-downloads))
* Standard Bash and basic ROS knowledge.
* A Nvidia graphics card capable of running hardware accelerated
  graphics. Although, any recent AMD or Intel GPU will also work flawlessly.

### Known issues
If Nvidia docker returns the following error:

```bash
   Docker: Error response from daemon: could not select device driver "" with capabilities: [[gpu]].
```

Look at the following site to solve it:

[https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#install-guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#install-guide)

## How to build the container
A bash script is provided to build the container, it can be executed by entering
the following command:

```bash
   $ ./001_build_images.sh
```

## How to start the container
To start the container execute the script below:

```bash
   $ 003_start_pxl_ml_container.sh
```
This script will check the available GPU and start the container accordingly.

To use multiple bash shells in the container, It's advised to either work with
`tmux` or execute the script with prefix `005` from the host:

```bash
   $ ./005_attach_bash_to_noetic_full_desktop.sh
```

**Pro-tip: Learn to use `tmux`. It's awesome!**


## Prebuilt image
You can find a prebuilt version of the image [right here](https://drive.google.com/drive/folders/1KqxEocjVeOtsky2f2vomWljWc7ir1reJ?usp=sharing).
