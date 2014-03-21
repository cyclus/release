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


cd cycamore
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
