#!/bin/bash

pushd /root

if [ -d "scala" ]; then
  echo "Scala seems to be installed. Exiting."
  return 0
fi

SCALA_VERSION="2.10.3"

if [[ "0.7.3 0.8.0 0.8.1" =~ $SPARK_VERSION ]]; then
  SCALA_VERSION="2.9.3"
fi

echo "Unpacking Scala"
wget http://www.scala-lang.org/files/archive/scala-$SCALA_VERSION.tgz
tar xvzf scala-*.tgz > /tmp/spark-euca_scala.log
rm scala-*.tgz
mv `ls -d scala-* | grep -v euca` scala

popd
