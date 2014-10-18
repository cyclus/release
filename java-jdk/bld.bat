:: Setup
set JDK_VER=8u20
if defined NMI_PLATFOM (
  set ON_BATLAB=TRUE
  set URL=http://regtests.fuelcycle.org/jdk-%JDK_VER%-windows-x64.zip
  set JDK=jdk-%JDK_VER%-windows-x64.zip
) else (
  set ON_BATLAB=FALSE
  set URL=http://download.oracle.com/otn-pub/java/jdk/8u20-b26/jdk-%JDK_VER%-windows-x64.exe
  set JDK=jdk-%JDK_VER%-windows-x64.exe
)

set BUILD_CACHE=%RECIPE_DIR%\\..\\build\\cache
if not exist %BUILD_CACHE% (
  mkdir %BUILD_CACHE%
)

:: Download
if not exist %BUILD_CACHE%\\%JDK% (
  curl -L -C - -k -b "oraclelicense=accept-securebackup-cookie" -o %BUILD_CACHE%\\%JDK% %URL%
)
copy %BUILD_CACHE%\\%JDK% %JDK%

:: Install
:: This page was pretty helpful http://stackoverflow.com/questions/15292464/how-to-silently-install-java-jdk-into-a-specific-directory-on-windows
if %ON_BATLAB% == "TRUE" (
  python -c "from zipfile import ZipFile; f = ZipFile(r'%JDK%', 'r'); f.extractall(r'%LIBRARY_PREFIX%'); f.close()"
) else (
  %JDK% /s /log jdk-install.log INSTALLDIR:%LIBRARY_PREFIX%
)
