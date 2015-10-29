#! /bin/sh 

echo "Please enter your golang path (ex: $HOME/golang) :"
read gopath

echo "Please enter your github username (ex: vsouza) :"
read user

mkdir $gopath
mkdir -p $gopath/src/github.com/$user

export GOPATH=$gopath
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

go get golang.org/x/tools/cmd/vet

#godoc
go get golang.org/x/tools/cmd/godoc

# goimports
go get -u golang.org/x/tools/cmd/goimports

# gocode
go get -u github.com/nsf/gocode

# godef
go get -u github.com/rogpeppe/godef

# golint
go get -u github.com/golang/lint/golint

# errcheck
go get -u github.com/kisielk/errcheck

# gocodeexaminer
go get golang.org/x/tools/cmd/vet

# oracle
go get -u golang.org/x/tools/cmd/oracle

echo "go to https://golang.org/doc/code.html and enjoy :D"
echo "also make sure that you put the exports into .zsh/.profile"
