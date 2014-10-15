:: Installs conda locally

:: Setup
set MINICONDA_VER=3.7.0
set PATH=%cd%\\anaconda\\bin:%PATH%

:: Install
move condarc %HOME%\\.condarc
call Miniconda-%MINICONDA_VER%-Windows-x86_64.exe -b -p anaconda
::conda install conda=3.6.1  :: is this needed?
conda update conda
conda install jinja2
conda install setuptools
conda install binstar  
conda install conda-build
