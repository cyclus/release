:: Setup
set BUILD_CACHE=%RECIPE_DIR%\\..\\build\\cache
if not exist %BUILD_CACHE% (
  mkdir %BUILD_CACHE%
)
set URL=http://download.oracle.com/otn-pub/java/jdk/8u20-b26/jdk-8u20-windows-x64.exe

:: Download
if not exist %BUILD_CACHE%\\jdk.exe (
  curl -L -C - -k -b "oraclelicense=accept-securebackup-cookie" -o %BUILD_CACHE%\\jdk.exe %URL%
)
copy %BUILD_CACHE%\\jdk.exe jdk.exe

:: Install
:: This page was pretty helpful http://stackoverflow.com/questions/15292464/how-to-silently-install-java-jdk-into-a-specific-directory-on-windows
jdk.exe /s /log jdk-install.log INSTALLDIR:%LIBRARY_PREFIX%
