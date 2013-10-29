#!/bin/bash
set -x
set -e


tar -xzf results.tar.gz
ls -l

cd cyclus
git checkout gh-pages
rsync -a ../cycamoredoc/html/* API/
git add -A
git commit -m "nightly build"
git push -f ssh://git@github.com/cyclus/cyclus.git gh-pages
cd ..


cd cycamore
git checkout gh-pages
rsync -a ../cycamoredoc/html/* API/
git add -A
git commit -m "nightly build"
git push -f ssh://git@github.com/cyclus/cycamore.git gh-pages



