#!/bin/sh
set -x
set -e


if [ ! -e results.tar.gz ]
then
exit 0
fi
tar -xzf results.tar.gz

cd cyclus
git checkout gh-pages
rsync -a ../cyclusdoc/html/* api/
if [ -n "$(git status --porcelain)" ]; then 
git add -A
git commit -m "nightly build"
git push -f ssh://git@github.com/cyclus/cyclus.git gh-pages
fi
cd ..


cd cycamore
git checkout gh-pages
rsync -a ../cycamoredoc/html/* api/
if [ -n "$(git status --porcelain)" ]; then 
git add -A
git commit -m "nightly build"
git push -f ssh://git@github.com/cyclus/cycamore.git gh-pages
fi
