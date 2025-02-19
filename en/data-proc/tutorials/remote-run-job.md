# Running jobs from remote hosts that are not part of the {{ dataproc-name }} cluster

This guide describes how to use the [spark-submit utility](https://spark.apache.org/docs/latest/submitting-applications.html#submitting-applications) to run Spark jobs in the {{ dataproc-name }} cluster from hosts that are not part of the {{ dataproc-name }} cluster.

{% note info %}

You can also run jobs in the {{ dataproc-name }} cluster from {{ ml-platform-full-name }}. For more information, see [this concept](../../datasphere/concepts/data-processing.md#existing-clusters).

{% endnote %}

## Getting started {#before-you-begin}

Create and configure a host to run jobs remotely on the {{ dataproc-name }} cluster:

{% list tabs %}

- Image version 1.4

  1. [Create a VM](../../compute/operations/vm-create/create-linux-vm.md) with Ubuntu 16.04 LTS.
  1. To provide network access to the {{ dataproc-name }} cluster hosting the created VM, [set up security groups](../operations/connect.md#configuring-security-groups) for the cluster.
  1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM over SSH:

      ```bash
      ssh -A <username>@<VM_FQDN>
      ```

  1. Copy the repository settings from any of the {{ dataproc-name }} cluster hosts. To do this, run a sequence of commands on the VM you created.
     1. Copy the repository address:

        ```bash
        ssh root@<cluster_host_FQDN> \
        "cat /etc/apt/sources.list.d/yandex-dataproc.list" | \
        sudo tee /etc/apt/sources.list.d/yandex-dataproc.list
        ```

     1. Copy the GPG key to verify Debian package signatures:

        ```bash
        ssh root@<cluster_host_FQDN> \
        "cat /srv/dataproc.gpg" | sudo apt-key add -
        ```

     1. Update the repository cache:

        ```bash
        sudo apt update
        ```

  1. Install the required packages:

     ```bash
     sudo apt install openjdk-8-jre-headless hadoop-client hadoop-hdfs spark-core spark-python
     ```

     {% note info %}

     You only need the `spark-python` package to run PySpark jobs.

     {% endnote %}

  1. Copy the Hadoop and Spark configuration files:

     ```bash
     sudo -E scp -r \
         root@<cluster_host_FQDN>:/etc/hadoop/conf/* \
         /etc/hadoop/conf/ && \
     sudo -E scp -r \
         root@<cluster_host_FQDN>:/etc/spark/conf/* \
         /etc/spark/conf/
     ```

  1. Create a user named `sparkuser` to run jobs:

     ```bash
     sudo useradd sparkuser && \
     ssh root@<cluster_host_FQDN> "
       hadoop fs -mkdir /user/sparkuser
       sudo -u hdfs hdfs dfs -chown sparkuser:sparkuser /user/sparkuser
       sudo -u hdfs hdfs dfs -ls /user/sparkuser
     "
     ```

- Image version 2.0

  1. [Create a VM](../../compute/operations/vm-create/create-linux-vm.md) with Ubuntu 20.04 LTS.
  1. To provide network access to the {{ dataproc-name }} cluster hosting the created VM, [set up security groups](../operations/connect.md#configuring-security-groups) for the cluster.
  1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM over SSH:

     ```bash
     ssh -A <username>@<VM_FQDN>
     ```

  1. Copy the repository settings from any of the {{ dataproc-name }} cluster hosts. To do this, run a sequence of commands on the VM you created.
     1. Copy the repository address:

        ```bash
        ssh ubuntu@<cluster_host_FQDN> \
        "cat /etc/apt/sources.list.d/yandex-dataproc.list" | \
        sudo tee /etc/apt/sources.list.d/yandex-dataproc.list
        ```

     1. Copy the GPG key to verify Debian package signatures:

        ```bash
        ssh ubuntu@<cluster_host_FQDN> \
        "cat /srv/dataproc.gpg" | sudo apt-key add -
        ```

     1. Update the repository cache:

        ```bash
        sudo apt update
        ```

  1. Install the required packages:

     ```bash
     sudo apt install openjdk-8-jre-headless hadoop-client hadoop-hdfs spark-core spark-python
     ```

     {% note info %}

     You only need the `spark-python` package to run PySpark jobs.

     {% endnote %}

  1. Copy the Hadoop and Spark configuration files:

     ```bash
     sudo -E scp -r \
         ubuntu@<cluster_host_FQDN>:/etc/hadoop/conf/* \
         /etc/hadoop/conf/ && \
     sudo -E scp -r \
         ubuntu@<cluster_host_FQDN>:/etc/spark/conf/* \
         /etc/spark/conf/
     ```

  1. Create a user named `sparkuser` to run jobs:

     ```bash
     sudo useradd sparkuser && \
     ssh ubuntu@<cluster_host_FQDN> "
       hadoop fs -mkdir /user/sparkuser
       sudo -u hdfs hdfs dfs -chown sparkuser:sparkuser /user/sparkuser
       sudo -u hdfs hdfs dfs -ls /user/sparkuser
     "
     ```

{% endlist %}

## Running a job {#spark-submit}

{% list tabs %}

- Spark job

  1. Run a job using the command:

     ```bash
     sudo -u sparkuser spark-submit \
          --master yarn \
          --deploy-mode cluster \
          --class org.apache.spark.examples.SparkPi \
              /usr/lib/spark/examples/jars/spark-examples.jar 1000
     ```

     Result:

     ```text
     20/04/19 16:43:58 INFO client.RMProxy: Connecting to ResourceManager at rc1b-dataproc-m-ds7lj5gnnnqggbqd.{{ dns-zone }}/  10.13.13.18:8032
     20/04/19 16:43:58 INFO client.AHSProxy: Connecting to Application History server at rc1b-dataproc-m-ds7lj5gnnnqggbqd.{{ dns-zone }}/10.13.13.18:10200
     20/04/19 16:43:58 INFO yarn.Client: Requesting a new application from cluster with 4 NodeManagers
     ...
     20/04/19 16:43:58 INFO yarn.Client: Preparing resources for our AM container
     20/04/19 16:43:58 INFO yarn.Client: Uploading resource file:/usr/lib/spark/examples/jars/spark-examples.jar -> hdfs://  rc1b-dataproc-m-ds7lj5gnnnqggbqd.{{ dns-zone }}/user/sparkuser/.sparkStaging/application_1586176069782_0003/  spark-examples.jar
     20/04/19 16:43:58 INFO yarn.Client: Uploading resource file:/etc/spark/conf/hive-site.xml -> hdfs://  rc1b-dataproc-m-ds7lj5gnnnqggbqd.{{ dns-zone }}/user/sparkuser/.sparkStaging/application_1586176069782_0003/hive-site.  xml
     20/04/19 16:43:58 INFO yarn.Client: Uploading resource file:/tmp/spark-6dff3163-089b-4634-8f74-c8301d424567/  __spark_conf__8717606866210190000.zip -> hdfs://rc1b-dataproc-m-ds7lj5gnnnqggbqd.{{ dns-zone }}/user/sparkuser/.  sparkStaging/application_1586176069782_0003/__spark_conf__.zip
     20/04/19 16:44:00 INFO yarn.Client: Submitting application application_1586176069782_0003 to ResourceManager
     20/04/19 16:44:00 INFO impl.YarnClientImpl: Submitted application application_1586176069782_0003
     20/04/19 16:44:01 INFO yarn.Client: Application report for application_1586176069782_0003 (state: ACCEPTED)
     20/04/19 16:44:01 INFO yarn.Client:
        client token: N/A
        diagnostics: AM container is launched, waiting for AM container to Register with RM
        ApplicationMaster host: N/A
        ApplicationMaster RPC port: -1
        queue: default
        start time: 1587314639386
        final status: UNDEFINED
        tracking URL: http://rc1b-dataproc-m-ds7lj5gnnnqggbqd.{{ dns-zone }}:8088/proxy/application_1586176069782_0003/
        user: sparkuser
     20/04/19 16:44:05 INFO yarn.Client: Application report for application_1586176069782_0003 (state: RUNNING)
     20/04/19 16:44:05 INFO yarn.Client:
        client token: N/A
        diagnostics: N/A
        ApplicationMaster host: rc1b-dataproc-d-9cd9yoenm4npsznt.{{ dns-zone }}
        ApplicationMaster RPC port: 41648
        queue: default
        start time: 1587314639386
        final status: UNDEFINED
        tracking URL: http://rc1b-dataproc-m-ds7lj5gnnnqggbqd.{{ dns-zone }}:8088/proxy/application_1586176069782_0003/
        user: sparkuser
     20/04/19 16:44:06 INFO yarn.Client: Application report for application_1586176069782_0003 (state: RUNNING)
     20/04/19 16:44:07 INFO yarn.Client: Application report for application_1586176069782_0003 (state: RUNNING)
     20/04/19 16:44:08 INFO yarn.Client: Application report for application_1586176069782_0003 (state: RUNNING)
     20/04/19 16:44:09 INFO yarn.Client: Application report for application_1586176069782_0003 (state: FINISHED)
     20/04/19 16:44:09 INFO yarn.Client:
        client token: N/A
        diagnostics: N/A
        ApplicationMaster host: rc1b-dataproc-d-9cd9yoenm4npsznt.{{ dns-zone }}
        ApplicationMaster RPC port: 41648
        queue: default
        start time: 1587314639386
        final status: SUCCEEDED
        tracking URL: http://rc1b-dataproc-m-ds7lj5gnnnqggbqd.{{ dns-zone }}:8088/proxy/application_1586176069782_0003/
        user: sparkuser
     20/04/19 16:44:09 INFO util.ShutdownHookManager: Shutdown hook called
     20/04/19 16:44:09 INFO util.ShutdownHookManager: Deleting directory /tmp/spark-6dff3163-089b-4634-8f74-c8301d424567
     20/04/19 16:44:09 INFO util.ShutdownHookManager: Deleting directory /tmp/spark-826498b1-8dec-4229-905e-921203b7b1d0
     ```

  1. Check the job execution status using the [yarn application](https://hadoop.apache.org/docs/r2.10.0/hadoop-yarn/hadoop-yarn-site/YarnCommands.html#application) utility:

     ```bash
     yarn application -status application_1586176069782_0003
     ```

     Result:

     ```text
     20/04/19 16:47:03 INFO client.RMProxy: Connecting to ResourceManager at rc1b-dataproc-m-ds7lj5gn********.{{ dns-zone }}/10.13.13.18:8032
     20/04/19 16:47:03 INFO client.AHSProxy: Connecting to Application History server at rc1b-dataproc-m-ds7lj5gn********.{{ dns-zone }}/10.13.13.18:10200
     Application Report :
         Application-Id : application_1586176069782_0003
         Application-Name : org.apache.spark.examples.SparkPi
         Application-Type : SPARK
         User : sparkuser
         Queue : default
         Application Priority : 0
         Start-Time : 1587314639386
         Finish-Time : 1587314647621
         Progress : 100%
         State : FINISHED
         Final-State : SUCCEEDED
         Tracking-URL : rc1b-dataproc-m-ds7lj5gn********.{{ dns-zone }}:18080/history/application_1586176069782_0003/1
         RPC Port : 41648
         AM Host : rc1b-dataproc-d-9cd9yoen********.{{ dns-zone }}
         Aggregate Resource Allocation : 141510 MB-seconds, 11 vcore-seconds
         Aggregate Resource Preempted : 0 MB-seconds, 0 vcore-seconds
         Log Aggregation Status : SUCCEEDED
         Diagnostics :
         Unmanaged Application : false
         Application Node Label Expression : <Not set>
         AM container Node Label Expression : <DEFAULT_PARTITION>
         TimeoutType : LIFETIME    ExpiryTime : UNLIMITED    RemainingTime : -1seconds
     ```

  1. View logs from all running containers using the [yarn logs](https://hadoop.apache.org/docs/r2.10.0/hadoop-yarn/hadoop-yarn-site/YarnCommands.html#logs) utility:

     ```bash
     sudo -u sparkuser yarn logs \
          -applicationId application_1586176069782_0003 | grep "Pi is"
     ```

     Result:

     ```text
     Pi is roughly 3.14164599141646
     ```

- PySpark job

  1. On the VM, create a file named `month_stat.py` with the following code:

     ```python
     import sys

     from pyspark import SparkContext, SparkConf
     from pyspark.sql import SQLContext

     def main():
         conf = SparkConf().setAppName("Month Stat - Python")
         conf.set("fs.s3a.aws.credentials.provider", "org.apache.hadoop.fs.s3a.AnonymousAWSCredentialsProvider")
         sc = SparkContext(conf=conf)

         sql = SQLContext(sc)
         df = sql.read.parquet("s3a://yc-mdb-examples/dataproc/example01/set01")
         defaultFS = sc._jsc.hadoopConfiguration().get("fs.defaultFS")
         month_stat = df.groupBy("Month").count()
         month_stat.repartition(1).write.format("csv").save(defaultFS+"/tmp/month_stat")

     if __name__ == "__main__":
             main()
     ```

  1. Copy the `month_stat.py` file to the cluster's master host:

     ```bash
     sudo -E scp month_stat.py <username>@<cluster_host_FQDN>:~/month_stat.py
     ```

     {% include [user name](../../_includes/data-processing/tutorials/user-name-images.md) %}

  1. Run the application:

     ```bash
     sudo -u sparkuser spark-submit \
          --master yarn \
          --deploy-mode cluster \
          month_stat.py
     ```

  1. The result of running the application will be exported to HDFS on the cluster. You can list the resulting files using the command:

     ```bash
     ssh <username>@<cluster_host_FQDN> "hdfs dfs -ls /tmp/month_stat"
     ```

     {% include [user name](../../_includes/data-processing/tutorials/user-name-images.md) %}

{% endlist %}

{% include [get-logs-info](../../_includes/data-processing/note-info-get-logs.md) %}
