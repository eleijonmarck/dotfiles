#! /bin/sh 

mkdir -p $HOME/dev/go
mkdir -p $HOME/dev/go/src/github.com/eleijonmarck

go get golang.org/x/tools/cmd/godoc
go get golang.org/x/tools/cmd/vet


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

# oracle
go get -u golang.org/x/tools/cmd/oracle
