Cyclus Release Repository
_______________________________________________________________________

This repository houses conda recipes for some Cyclus-related projects and/or
their dependencies as well as helpful utilities and scripts related to the
release process.

Utilities
----------
A number of utilities helpful to the release process can be found in the
`utils` folder. Their use is described in `Release Procedure
<http://fuelcycle.org/cep/cep3.html>`_.


----------------------------------------------------------------
Building Cyclus With Conda
----------------------------------------------------------------
The process of building Conda packages involves a system called `Conda Recipes <http://conda.pydata.org/docs/build.html>`_ .
A Conda Recipe is a directory containing at least two files, meta.yaml and build.sh.
Version information, build and run dependencies, the location of the source code, and other 
information about the package are stored in meta.yaml, while build.sh contains a script to
build from source. Packages are built from recipes using the ``conda build`` command. 
Necessary dependency packages will be automatically downloaded and installed before the 
build.sh script is run and installed.  The final output is a tar.bz2 file which is a conda package containing
the necessary binaries, libraries, etc.  This package can then be installed or can be uploaded to `Binstar <binstar.org>`_, 
which is a service provided to store and distribute conda packages. Notice that Conda requires all dependencies explicitly 
listed in meta.yaml must have an available Conda package to install. 


As part of installing and maintaining Cyclus with conda, recipes for a number of dependencies have also been created.  All 
lowercase directories in this repo (except fetch) are conda recipes.  Additionally, this repo contains a stock ``.condarc`` file
which automatically points to the `Cyclus Binstar Account <binstar.org/cyclus>`_. 

----------------------------------------------------------------
Building Cyclist with Conda
----------------------------------------------------------------
To build cyclist from scratch using conda, simply come into this directory, 
make sure that conda is on your path, and 
build the conda recipe::

    ~ $ export PATH=/home/scopatz/miniconda/bin:$PATH 
    ~ $ cd ciclus
    ~/ciclus $ conda build --no-binstar-upload cyclist

If you would also like to build the dependencies, please build their recipes as 
well::

    ~/ciclus $ conda build --no-binstar-upload java-jre
    ~/ciclus $ conda build --no-binstar-upload java-jdk
    ~/ciclus $ conda build --no-binstar-upload ant

If you would like to install any of these locally, pass in the ``--use-local`` flag.
For example::

    ~/ciclus $ conda install --use-local cyclist

You may also upload such packages to binstar, assuing that you have binstar install.
This is done via something like the following::

    ~ $ binstar upload --user cyclus ~/miniconda/conda-bld/linux-64/cyclist-0.0.tar.bz2

This should be enough to get you started.

.. _`Cyclus Homepage`: http://cyclus.github.com
