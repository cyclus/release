:: Setup
set BUILD_CACHE=%RECIPE_DIR%\\..\\build\\cache
if not exist %BUILD_CACHE% (
  mkdir %BUILD_CACHE%
)

set URL=http://download.oracle.com/otn-pub/java/jdk/8u20-b26/jre-8u20-windows-x64.tar.gz

:: Download
if not exist %BUILD_CACHE%\\jre.tar.gz (
  curl -L -C - -k -b "oraclelicense=accept-securebackup-cookie" -o %BUILD_CACHE%\\jre.tar.gz %URL%
)

copy %BUILD_CACHE%\\jre.tar.gz jre.tar.gz

:: Install
python -c "import tarfile; f = tarfile.open('jre.tar.gz', 'r:gz'); f.extractall(); f.close()"
python -c "import os; from glob import glob; r = [x for x in glob('jre*') if os.path.isdir(x)];  print('\n'.join(r))" > dirs.txt
set /p JRE_DIR=<dirs.txt 
robocopy %JRE_DIR%\\bin %LIBRARY_BIN% /S /MOVE 
robocopy %JRE_DIR%\\lib %LIBRARY_LIB% /S /MOVE 
move %JRE_DIR%\\COPYRIGHT %PREFIX%\\COPYRIGHT-JRE
move %JRE_DIR%\\LICENSE %PREFIX%\\LICENSE-JRE
move %JRE_DIR%\\THIRDPARTYLICENSEREADME.txt %PREFIX%\\THIRDPARTYLICENSEREADME-JRE.txt
move %JRE_DIR%\\THIRDPARTYLICENSEREADME-JAVAFX.txt %PREFIX%\\THIRDPARTYLICENSEREADME-JAVAFX.txt
