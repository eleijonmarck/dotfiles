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
pip install grip # markdown checkout
pip install requests
pip install lxml
pip install flask

# test
pip install nose

# install ipython
pip install pygments
pip install "ipython[all]"

pip install scipy
pip install pandas
exit 0
