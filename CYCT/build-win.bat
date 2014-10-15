:: This builds cyclist conda packages as well as its dependencies, namely
::  * java-jre
::  * java-jdk
::  * ant
::  * cyclist

set PATH=%cd%\\anaconda\\Library\\bin;%PATH%
set PATH=%cd%\\anaconda\\bin;%PATH%
set PATH=%cd%\\anaconda\\Scripts;%PATH%
set CONDA=anaconda\\bin\\conda
set PKGS=anaconda\\pkgs
%CONDA% list

:: Install conda
call bin\\conda-inst.bat

:: build
call:conda_build java-jre
call:conda_build java-jdk
call:conda_build ant
call:conda_build cyclist

:: return packages
gzip results.tar
echo ""
echo "Results Listing"
echo "---------------"
tar -ztvf results.tar.gz

:conda_build
  conda build --no-test --no-binstar-upload %~1
  python -c "from os.path import basename; print(basename('%~1'))" > basename.txt
  set BNAME=<basename.txt
  tar -uf results.tar -C %PKGS% %BNAME%
goto:eof