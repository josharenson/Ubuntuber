#!/bin/bash

if [ ! -d builddir ];
then
    mkdir builddir
fi

pushd builddir/

##### Executing from build dir
cmake .. -DCLICK_MODE=on -DBZR_REVNO=$(cd ..; bzr revno)
make install
#make DESTDIR=package install
click build package

popd
