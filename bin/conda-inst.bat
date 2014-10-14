:: Installs conda locally

:: Setup
set MINICONDA_VER=3.7.0
set PATH=%cd%\\anaconda\\bin:%PATH%

:: Install
move condarc %HOME%\\.condarc
./${MINICONDA} -b -p %cd%\\anaconda
conda install conda=3.6.1  :: is this needed?
conda install jinja2
conda install setuptools
if [[  "$UNAME" == 'Linux' ]]; then
  conda install patchelf
fi
conda install git
conda install binstar  
conda install conda-build
