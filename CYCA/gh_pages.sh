#!/bin/bash
set -x
set -e

tar -xzf results.tar.gz

if [ -d "anaconda/conda-bld/linux-64" ]; then
os=linux-64
else
os=osx-64
fi

for f in `ls anaconda/conda-bld/$os/*tar.bz2`;do
     echo $f
    /home/$USER/miniconda/bin/binstar upload -u cyclus --force $f
done

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
