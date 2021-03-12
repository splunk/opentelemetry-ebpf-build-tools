# Flowmill build container

This repository builds the Docker image which is in turn used to build binaries and docker
images from the code in the main repository.

## MacOS prerequisites:

* The ["Homebrew"](https://brew.sh/) package manager
* [Docker Desktop](https://hub.docker.com/editions/community/docker-ce-desktop-mac)
* cmake: `brew install cmake`
* make: installed along with developer tools; if Homebrew is working you should have make

## Building the build environment:

* Check out this repository
* Run the build script: `./build.sh`

## Adding a new dependency

Use `add_dependency.sh` and follow instructions.
