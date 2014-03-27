#!/bin/bash


echo HERE
CFLAGS=
CXXFLAGS=
LDFLAGS=

./configure  --prefix=$PREFIX
make
make install


