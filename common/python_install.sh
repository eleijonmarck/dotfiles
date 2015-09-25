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

# matplotlib
pip install matplotlib

# web
pip install requests
pip install lxml

# test
pip install nose

# install ipython
pip install "ipython[all]"
pip install nose
pip install pygments

# installing jupyter
pip install --upgrade setuptools pip pycurl

exit 0
