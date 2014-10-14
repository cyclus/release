:: Setup
set INSTLOC=%LIBRARY_PREFIX%\\share\\cyclist
where java > where-java.txt
set /p JAVA_EXE=<where-java.txt
python -c "from os.path import dirname; print(dirname(dirname(r'%JAVA_EXE%')))" > java-home.txt
set /p JAVA_HOME=<java-home.txt

:: Build
ant
del deploy\\dist\\externalApps\\*linux* deploy\\dist\\externalApps\\*darwin*

:: Install
mkdir %INSTLOC%
robocopy deploy\\dist %INSTLOC%
echo "java -jar %~f0\\..\\share\\cyclist\\cyclist.jar" > %LIBRARY_BIN%\\cyclist.bat

