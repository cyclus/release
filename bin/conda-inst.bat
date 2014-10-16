:: Installs conda locally

:: Setup
set MINICONDA_VER=3.7.0
set PATH=%cd%\\anaconda\\Library\\bin;%PATH%
set PATH=%cd%\\anaconda\\bin;%PATH%
set PATH=%cd%\\anaconda\\Scripts;%PATH%

:: Install
move condarc %HOME%\\.condarc
dir "%cd%"
echo %PATH%
dir 
::start /W Miniconda-%MINICONDA_VER%-Windows-x86_64.exe /S /D="%cd%\\anaconda" /AddToPath=0 /RegisterPython=0
::%cd%\Miniconda-%MINICONDA_VER%-Windows-x86_64.exe /S /D=%cd%\anaconda /AddToPath=0 /RegisterPython=0
::call %cd%\Miniconda-%MINICONDA_VER%-Windows-x86_64.exe /S /D=%cd%\anaconda || exit 1
::Miniconda-%MINICONDA_VER%-Windows-x86_64.exe /S /D=C:\anaconda
%~dp0Miniconda-%MINICONDA_VER%-Windows-x86_64.exe /S 
::conda install conda=3.6.1  :: is this needed?
conda update conda
conda install jinja2
conda install setuptools
conda install binstar  
conda install conda-build
