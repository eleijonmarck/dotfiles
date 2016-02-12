#!/bin/sh

if test ! $(which python); then
    echo "Installing homebrew"
    brew install python
fi

echo "Installing Python modules.... "
pip install --upgrade distribute
pip install --upgrade pip

# virtual env
pip install virtualenv

# command line
pip install csvkit # data cleaner
pip install tldr # man pages for unix commands

# matplotlib
pip install matplotlib

# web
pip install grip # markdown checkout
pip install requests
pip install lxml
pip install flask

# test
pip install nose

# machine-learning
pip install https://storage.googleapis.com/tensorflow/mac/tensorflow-0.5.0-py2-none-any.whl

# install ipython
pip install pygments
pip install "ipython[all]"

pip install scipy
pip install pandas
exit 0
