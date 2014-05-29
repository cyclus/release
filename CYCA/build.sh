#!/bin/bash
set -x 
set -e

`pwd`/CYCL/build.sh
PATH=$PATH:`pwd`/install/bin

anaconda/bin/conda build --no-test cycamore
anaconda/bin/conda install --use-local cycamore
tar -czf results.tar.gz anaconda
