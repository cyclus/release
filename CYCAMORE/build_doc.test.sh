set -x
set -e


cd cycamore/build
make cycamoredoc | tee  doc.out
line=$(grep -i 'warning' doc.out)
if [ ! -z "$line" ] 
 then
        exit 1
fi
mv doc cycamoredoc
cd ../..

cd cyclus/build
make cyclusdoc | tee  doc.out
line=$(grep -i 'warning' doc.out)
if [ ! -z "$line" ]
 then
    exit 1
fi
ls -l
mv doc cyclusdoc
cd ../..
