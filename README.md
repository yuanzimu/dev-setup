# Instructions for setting up Stucco development environment

## Set up Eclipse

1. Install Eclipse: Download [Eclipse IDE for Java EE Developers](eclipse.org/downloads/). Then open Eclipse and set up the default workspace somewhere on your drive.
2. Install Maven plugin: Help menu -> Eclipse Marketplace -> search for 'Maven' -> Install `Maven Integration for Eclipse`
3. Install e-git plugin: Help menu -> Eclipse Marketplace -> search for 'git' -> Install `EGit - Git Team Provider`
4. Create a new project: File menu -> New -> Other… -> Maven Project, then check 'Create a simple project', assign a 'Group Id' (project/org path) and 'Artifact Id' (project name)
5. Open the project: Click on workbench (top right)

## Set up Maven

For an example Maven project, see the [storm wiki](https://github.com/nathanmarz/storm/wiki/Maven)

View the [Maven Compiler Plugin options](http://maven.apache.org/plugins/maven-compiler-plugin/compile-mojo.html).

## Test within Eclipse

Right click on Project -> 'Run As…' -> 'Maven Build…' -> Edit the Goals to 'clean package' (built in Maven tasks) -> click 'Run'

## Set up Git Repo

1. Right click on Project -> 'Team' -> 'Share'. Create a repo (within project folder)
2. Commit files
3. Push to add remote

## Set up Storm

To be able to push code out to a storm cluster, you will need to download the storm project:

    cd /usr/local
    sudo curl -LO https://dl.dropbox.com/u/133901206/storm-0.8.2.zip
    sudo unzip -o storm-0.8.2.zip
    sudo ln -s ../storm-0.8.2/bin/storm bin/storm
    sudo rm -f storm-0.8.2.zip

## Set up Vagrant

This project will set up the test and demonstration environment for Stucco using Vagrant. Your directory structure should look something like this:

    - stucco
      |-- vagrant-setup
      |-- other-stucco-project-1
      |-- other-stucco-project-2

First, [download VirtualBox](https://www.virtualbox.org/wiki/Downloads) and install. This was tested with version 4.2.12, but any 4.2.x version should work.

[Download a Vagrant installer](http://downloads.vagrantup.com/) for Mac OS, Windows, and Linux and install it. This was tested with version 1.2.2, but any 1.x version should work.

To build the VM, run `init.sh`. This script installs the [Vagrant Plugins](http://docs.vagrantup.com/v2/plugins/index.html) and runs `vagrant up` to build the VM.

To log into the VM, run `vagrant ssh`. The parent directory from this project (where you ran the `init.sh` script) will be mounted under /stucco within the VM.

## Deploy to Storm

**needs to be documented**