#!/bin/bash
set -x 
set -e

export PATH="$(pwd)/anaconda/bin:${PATH}"

anaconda/bin/nosetests -vsw cymtests

exit $?
