#!/bin/sh
set -x
set -e


if [ ! -e results.tar.gz ]
then
exit 0
fi
tar -xzf results.tar.gz
ls -l

cd cyclus
git checkout gh-pages
rsync -a ../cycamoredoc/html/* api/
git add -A
val=`git commit -m "nightly build" | wc -l`
if [ $val == 0 ]
then
git push -f ssh://git@github.com/cyclus/cyclus.git gh-pages
fi
cd ..


cd cycamore
git checkout gh-pages
rsync -a ../cycamoredoc/html/* api/
git add -A
val=`git commit -m "nightly build" | wc -l`
if [ $val == 0 ]
then

git push -f ssh://git@github.com/cyclus/cycamore.git gh-pages
fi

