#!/bin/bash

WORKSPACE=${WORKSPACE:=$(pwd)}

rm -rf build
mkdir build
DOCKER_CONTAINER=$(docker run -v ${WORKSPACE}:/app/source -v ${WORKSPACE}/build:/app/build quay.io/kumoru/slate rake build)

_=$(git branch -D gh-pages)
git checkout --orphan gh-pages
rm -rf fonts/ images/ javascripts/ stylesheets/ source/ includes/ layouts/
mv -f build/* ./
git add -A
git commit -m "auto commit"
git push -f origin gh-pages
git checkout master
