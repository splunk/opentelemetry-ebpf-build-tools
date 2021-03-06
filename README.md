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

## Using the build container:

Add the following alias to your ~/.bash_profile:

```shell
. ~/flowmill/build-env/benv-alias.sh
```

Use this `benv` alias to fire up the build environment container. Inside the
container, run the `./build.sh` script to build everything.

## Adding a new dependency

Use `add_dependency.sh` and follow instructions.
