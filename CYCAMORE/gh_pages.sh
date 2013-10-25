#!/bin/bash
set -x
set -e
#`pwd`/../CYCLUS/gh_pages.sh


#cd cycamore
#git checkout gh-pages
ls -l
tar -xzf results.tar.gz

cd cycamore
ls
git checkout gh-pages
rsync -a ../cycamoredoc/* .
git add -A
git commit -m "nightly build"
git push ssh://git@github.com/zwelchWI/cycamore.git develop



