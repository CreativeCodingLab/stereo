#!/bin/bash

javac -cp lib/'*' src/stereo/*.java

cd src
jar cvf ../dist/Stereo.jar stereo/*.class

cd ..
