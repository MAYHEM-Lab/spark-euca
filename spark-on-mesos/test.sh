#bin/bash

pushd /root

echo "I love UCSB" > /tmp/file0
chown hdfs:hadoop /tmp/file0

hadoop fs -mkdir -p /user/foo/data
hadoop fs -put /tmp/file0 /user/foo/data

wget -P /executor_tars http://php.cs.ucsb.edu/spark-related-packages/executor_tars/spark-1.1.0-bin-2.3.0.tgz
/root/spark/bin/spark-submit --class WordCount3 --master mesos://zk://$ACTIVE_MASTER_PRIVATE/mesos ~/test-code/simple-project_2.10-1.0.jar $ACTIVE_MASTER_PRIVATE

popd /root