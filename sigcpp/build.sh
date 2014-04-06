#!/bin/bash



echo HERE
          
echo  $CXX      
echo  $CXXFLAGS  
echo  $LDFLAGS    
          
echo  $LIBS     
echo $CPPFLAGS  
           
echo  $CC        
echo  $CFLAGS     
echo  $CPP  
echo  $CXXCPP
echo  $M4     
echo  $PERL    
echo  $DOT      
echo  $DOXYGEN   
echo  $XSLTPROC   
echo  $PKG_CONFIG  
echo  $PKG_CONFIG_PATH
echo  $PKG_CONFIG_LIBDIR


./configure  --prefix=$PREFIX
make
make install


