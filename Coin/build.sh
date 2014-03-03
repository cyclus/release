#!/bin/bash
find -exec touch \{\} \;
./configure --prefix=$PREFIX
make
make install


