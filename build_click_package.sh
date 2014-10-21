#!/bin/bash

if [ ! -d builddir ];
then
    mkdir builddir
fi

pushd builddir/

##### Execiting from build dir
cmake .. -DCLICK_MODE=on -DBZR_REVNO=$(cd ..; bzr revno)
make DESTDIR=package install
click build package

popd
