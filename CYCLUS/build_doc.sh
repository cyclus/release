set -x
set -e



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



