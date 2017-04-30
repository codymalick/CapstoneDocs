# CapstoneDocs
Documents related to senior capstone group #51, Intel Cloud Orchestration

The git submodule points to our Ciao development branch, `ovsdev`. 

# Building and running Ciao
The simplest way to run Ciao is in single VM mode with ciao-down.

## Requirements
- CPU that supports nested KVM.
- Ubuntu 16+ or Arch Linux.
- Golang 1.8 or newer.
- Ciao-down requires several other binaries. If you are missing any ciao-down will prompt you to install them.

## Building and running our code in Ciao down
- Download the master version of Ciao by running 
`go get github.com/01org/ciao`
- Change directories into the Ciao git repo
- Add our Ciao repo as a remote with `git remote set-url origin git@github.com:matthewrsj/ciao.git`
- Run `git fetch` to get our changes
- Checkout the ovsdev branch with `git checkout ovsdev`
- Follow the [ciao-down documentation](https://github.com/01org/ciao/tree/master/testutil/ciao-down) starting at the top with `go get github.com/01org/ciao/testutil/ciao-down`.