#!/bin/bash

javac -cp jars/'*' src/stereo/*.java -d build

cd build
jar cvf ../library/Stereo.jar stereo/*.class

cd ..
