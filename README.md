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
### Linux/Unix
A bash script is provided to build the container, it can be executed by entering
the following command:

```bash
   $ ./001_build_images.sh
```

### Windows
For Windows, use the premade image at https://drive.google.com/drive/folders/1KqxEocjVeOtsky2f2vomWljWc7ir1reJ?usp=sharing and perform the steps in the next section.

## How to start the container

### Linux/Unix
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

### Windows
Open Powershell. 

Enter the following command to load the docker image:
`docker load -i /<path>/<to>/pxl_ml_image.tar`

```
cd 01_ml_docker
```

While in the 01_ml_docker folder in powershell, execute the following command to run the container:
```
docker run --privileged -it --rm --name pxl_ml_container --hostname pxl_ml_container -v $PWD/../commands/bin:/home/user/bin -v $PWD/../notebooks:/home/user/notebooks -v $PWD/../data:/home/user/data -v $PWD/../app:/home/user/app  -p 7777:7777 -p 8080:8080 -p 5000:5000 pxl_ml_image:latest bash
```

When you're in the container execute this command to start jupyter:
```
start_jupyter
```

or

```
jupyter-notebook --ip=0.0.0.0 --allow-root --no-browser --port=7777
```

When you're done exploring / training / etc, you can edit the `app.py` file in the app folder to configure your flask backend.
In the container, navigate to the app folder and execute `python3 app.py` 


## Prebuilt image
You can find a prebuilt version of the image [right here](https://drive.google.com/drive/folders/1KqxEocjVeOtsky2f2vomWljWc7ir1reJ?usp=sharing).

Use `docker load --input anr_ml_image.tar` to import it.
