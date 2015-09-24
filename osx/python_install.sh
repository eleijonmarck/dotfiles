#!/bin/sh

echo "Installing Python modules.... "
pip install --upgrade distribute
pip install --upgrade pip

pip install virtualenv

# matplotlib
pip install matplotlib

# web
pip install requests
pip install lxml

# installing jupyter
pip install --upgrade setuptools pip pycurl
git clone https://github.com/jupyter/notebook.git

exit 0
