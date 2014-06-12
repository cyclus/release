#!/bin/bash
set -x
set -e

tar -xzf results.tar.gz

if [[ ! -d cycamoredoc ]] 
then
exit 0
fi


cd cyclsrc
git checkout gh-pages
git checkout develop
git branch -D gh-pages
git checkout -b  gh-pages

git rm -r * .gitignore

git reflog expire --expire-unreachable=now --all
git gc --prune

rsync -a ../cyclusdoc/html/* api/
git add -A
git commit -m "nightly build"
git push -f ssh://git@github.com/cyclus/cyclus.git gh-pages
cd ..


cd cycasrc
git checkout gh-pages
git checkout develop
git branch -D gh-pages
git checkout -b  gh-pages

git rm -r * .gitignore

git reflog expire --expire-unreachable=now --all
git gc --prune

rsync -a ../cycamoredoc/html/* api/
git add -A
git commit -m "nightly build"
git push -f ssh://git@github.com/cyclus/cycamore.git gh-pages
