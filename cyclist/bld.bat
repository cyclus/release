:: Setup
set INSTLOC=%LIBRARY_PREFIX%\\share\\cyclist
where java > where-java.txt
set /p JAVA_EXE=<where-java.txt
python -c "from os.path import dirname; print(dirname(dirname(r'%JAVA_EXE%')))" > java-home.txt
set /p JAVA_HOME=<java-home.txt

:: Build
call ant
del deploy\\dist\\externalApps\\*linux* 
del deploy\\dist\\externalApps\\*darwin*

:: Install
mkdir %INSTLOC%
robocopy deploy\\dist %INSTLOC% /S
echo java -jar %%~dp0\\..\\Library\\share\\cyclist\\cyclist.jar > %SCRIPTS%\\cyclist.bat