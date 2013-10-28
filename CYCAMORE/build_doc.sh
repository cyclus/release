set -x
set -e


cd cycamore/build
make cycamoredoc | tee  doc.out
line=`grep -i warning doc.out|wc -l`
ls

if [  $line -ne 0 ] 
 then
	echo HERE
        exit 1
fi
mv doc ../../cycamoredoc
cd ../..

cd cyclus
make cyclusdoc | tee  doc.out
line=`grep -i warning doc.out|wc -l`
if [ $line -ne 0 ]
 then
    exit 1
fi
ls -l
mv doc ../cyclusdoc
cd ..

tar -czf results.tar.gz cycamoredoc cyclusdoc


