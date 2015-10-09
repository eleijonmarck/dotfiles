#! /bin/sh 

mkdir -p $HOME/dev/go
mkdir -p $HOME/dev/go/src/github.com/eleijonmarck

go get golang.org/x/tools/cmd/godoc
go get golang.org/x/tools/cmd/vet
