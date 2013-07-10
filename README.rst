Cyclus Continuous Integration
_______________________________________________________________________


Continuous Integration scripts for the Cyclus nuclear fuel cycle simulator on the University of Wisconsin - Madison's `Batlab <http://batlab.org>`_

To see user and developer documentation for Cyclus, please visit the `Cyclus Homepage`_.

------------------------------------------------------------------
Running Tests on Batlab
------------------------------------------------------------------
Once you have logged onto a Batlab submit node, clone this repo into your home directory.  
Jobs are launched by submitting run specification files to batlab using the ``nmi_submit``
command. Run specification files contain a list of input files to be transfered to the
test node, an executable file name for each step of testing, and some other options to
control the tests. ``cyclopts.run-spec`` will build only cyclopts, ``cyclus.run-spec`` will
build cyclopts and cyclus and run the cyclus unit tests, and ``cycamore.run-spec`` will
build the entire stack and run all unit tests.  Run specifications ``cycamore.***.run-spec``
are for setting up continuous integration tests. A *0* indicates the most recent release,
while a *1* represents the development branch. So for example, ``cycamore.011.run-spec`` 
will use the stable release of cyclopts and development versions of cyclus and cycamore.
*Before submitting all jobs, please change your run-spec* ``notify`` *field to reflect your
desired email address* ::

    ~/$ cd cyclusCI
    ~/cyclusCI/$ nmi_submit cycamore.run-spec

The `Cyclus Homepage`_ has much more detailed guides and information.  If
you intend to develop for *Cyclus*, please visit it to learn more.


.. _`Cyclus Homepage`: http://cyclus.github.com

