Cyclus Continuous Integration
_______________________________________________________________________


Continuous Integration scripts for the Cyclus nuclear fuel cycle simulator on the University of Wisconsin - Madison's `Batlab <http://batlab.org>`_ using the `Conda <http://conda.pydata.org/>`_ package manager.

To see user and developer documentation for Cyclus, please visit the `Cyclus Homepage`_.

------------------------------------------------------------------
Running Tests on Batlab
------------------------------------------------------------------
Once you have created a Batlab account and logged into the submit node, clone this repo.
Runs in Batlab are defined in run specification files (``.run-spec`` files). These files
contain a list of input files, scripts to run at Batlab-defined stages, and other test options.
The scripts Batlab runs on the test node can be found in ``CYCL`` and ``CYCA`` directories
depending on their usage. 

To submit Batlab tests without making any changes, simply call ::

    ~/path_to_repo/$ ./submit.sh file.run_spec

``cyclus.run-spec`` will build Cyclus and run its unit tests, while ``cycamore.run-spec``
will build and run unit tests for both Cyclus and Cycamore. 

----------------------------------------------------------------
Building Cyclus With Conda
---------------------------------------------------------------
The process of building Conda packages involves a system called `Conda Recipes <http://conda.pydata.org/docs/build.html>`_.
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


------------------------------------------------------------------
Customizing Your Tests on Batlab with Conda
------------------------------------------------------------------
There are many ways to customize the files in this repo to have Batlab run useful tests.

1) Push a package to Binstar
Currently the process for uploading a package to Binstar is rather clunky and must be done
manually. If you create a results.tar.gz somewhere of the anaconda directory after building
cyclus and cycamore, Batlab will know to bring that file back, and it can be found in that
 tests run directory. The submit script should print the run directory for a test when you submit it.
Once this file is fetched, it can be untarred and the command ::

        binstar upload -u cyclus anaconda/conda-bld/linux-64/cyclus.<VERSION>.tar.gz

can be used to upload a linux version.

2) Have Batlab run code from a different repo
Say you want to test your fork of Cyclus before making a pull request. To 
customize what repos Cyclus and Cycamore are pulled from, look in ``cyclus/meta.yaml``
and ``cycamore/meta.yaml`` respectively.  In these files you can change the ``git_url`` field to point 
to the repo of your choice.

3) Have Batlab run code in a non-default git branch
In ``cyclus/meta.yaml`` (or cycamore), alter the ``git_tag`` field to the branch or tag you want to use.

4) Get email updates when your job is finished
To get email updates, add a line in your local run-spec file a reading
``notify=<your_email_address>``

5) Test a new build process for Cyclus and Cycamore
To alter Cyclus or Cycamore's build process, look at ``build.sh`` in cyclus or cycamore
 respectively. 

6) Set up nightly runs
To set up what Batlab refers to as recurring runs, you must set the ``cron_minute`` and 
``cron_hour`` fields in your run-spec to specify the hour and minute you want the run
to occur each day.

7) Run tests only ins OSX or Ubuntu (or try a new OS)
There is a ``platforms`` field in all run specification files that list the operating
systems to run.  Some stages also have platform prefixes to specify which script should
be run in each OS stage.  To get a complete list of available systems run
``nmi_list_platforms`` on Batlab's submit node.

8) Create/upload a new version of a dependency
Alter the dependency's ``meta.yaml`` file to point to the correct version of dependency source 
code.  Change the ``CYCA/build.sh`` and ``CYCL/build.sh`` to build the dependency instead of 
Cyclus and Cycamore.  Follow instructions in 1 to upload to binstar.

The `Cyclus Homepage`_ has much more detailed guides and information.  If
you intend to develop for *Cyclus*, please visit it to learn more.


.. _`Cyclus Homepage`: http://cyclus.github.com

