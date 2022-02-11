# Running jobs from remote hosts that are not part of a cluster {{ dataproc-name }}

To run Spark jobs on a {{ dataproc-name }} cluster from hosts that are not part of the {{ dataproc-name }} cluster, use the [spark-submit](https://spark.apache.org/docs/latest/submitting-applications.html#submitting-applications) utility. Make sure you [meet the remote job launch requirements](#requirements) and [install and set up](#setup-vm) spark-submit.

## Requirements for running jobs remotely using spark-submit {#requirements}

To run jobs from a remote host, follow these requirements:

1. Provide network access from the remote host to all {{ dataproc-name }} cluster hosts.
1. Install Hadoop and Spark packages on the remote host. Make sure their versions are similar to the {{ dataproc-name }} cluster host versions.
1. Prepare Hadoop and Spark configuration files. Make sure they're identical on the cluster and remote host.

## Creating and configuring a remote host {#setup-vm}

To configure a remote host:

1. [Create a VM](../../compute/operations/vm-create/create-linux-vm.md) running Ubuntu 16.04 LTS.

1. Connect to the VM over SSH:

    ```bash
    ssh -A ubuntu@remote-run
    ```

1. Copy the repository settings from any of the {{ dataproc-name }} cluster hosts. To do this, run the following commands on the VM you created.

    1. Copy the repository address:

        ```bash
        ssh root@rc1b-dataproc-m-ds7lj5gnnnqggbqd.mdb.yandexcloud.net "cat /etc/apt/sources.list.d/yandex-dataproc.list" | sudo tee /etc/apt/sources.list.d/yandex-dataproc.list
        deb [arch=amd64] http://storage.yandexcloud.net/dataproc/releases/0.2.10 xenial main
        ```

    1. Copy the GPG key to verify Debian package signatures:

        ```bash
        ssh root@rc1b-dataproc-m-ds7lj5gnnnqggbqd.mdb.yandexcloud.net "cat /srv/dataproc.gpg"  | sudo apt-key add -
        OK
        ```

    1. Update the repository cache:

        ```bash
        sudo apt update
        Hit:1 http://storage.yandexcloud.net/dataproc/releases/0.2.10 xenial InRelease
        Hit:2 http://mirror.yandex.ru/ubuntu xenial InRelease
        Hit:3 http://mirror.yandex.ru/ubuntu xenial-updates InRelease
        Hit:4 http://mirror.yandex.ru/ubuntu xenial-backports InRelease
        Hit:5 http://security.ubuntu.com/ubuntu xenial-security InRelease
        Reading package lists... Done
        Building dependency tree
        Reading state information... Done
        All packages are up to date.
        ```

1. Install the necessary packages:

    ```bash
    sudo apt install openjdk-8-jre-headless hadoop-client hadoop-hdfs spark-core
    ```

1. Copy the Hadoop and Spark configuration files:

    ```bash
    sudo -E scp -r root@rc1b-dataproc-m-ds7lj5gnnnqggbqd.mdb.yandexcloud.net:/etc/hadoop/conf/* /etc/hadoop/conf/
    sudo -E scp -r root@rc1b-dataproc-m-ds7lj5gnnnqggbqd.mdb.yandexcloud.net:/etc/spark/conf/* /etc/spark/conf/
    ```

1. Create a new user to run jobs under:

    ```bash
    sudo useradd sparkuser
    ssh root@rc1b-dataproc-m-ds7lj5gnnnqggbqd.mdb.yandexcloud.net "sudo -u hdfs hdfs dfs -ls /user/sparkuser"
    ssh root@rc1b-dataproc-m-ds7lj5gnnnqggbqd.mdb.yandexcloud.net "sudo -u hdfs hdfs dfs -chown sparkuser:sparkuser /user/sparkuser"
    ```

The host is ready to remotely run jobs on the {{ dataproc-name }} cluster.

### Running Spark jobs {#spark-submit}

Run a job using the command:

```bash
sudo -u sparkuser spark-submit --master yarn --deploy-mode cluster --class org.apache.spark.examples.SparkPi /usr/lib/spark/examples/jars/spark-examples.jar 1000
...
20/04/19 16:43:58 INFO client.RMProxy: Connecting to ResourceManager at rc1b-dataproc-m-ds7lj5gnnnqggbqd.mdb.yandexcloud.net/10.13.13.18:8032
20/04/19 16:43:58 INFO client.AHSProxy: Connecting to Application History server at rc1b-dataproc-m-ds7lj5gnnnqggbqd.mdb.yandexcloud.net/10.13.13.18:10200
20/04/19 16:43:58 INFO yarn.Client: Requesting a new application from cluster with 4 NodeManagers
...
20/04/19 16:43:58 INFO yarn.Client: Preparing resources for our AM container
20/04/19 16:43:58 INFO yarn.Client: Uploading resource file:/usr/lib/spark/examples/jars/spark-examples.jar -> hdfs://rc1b-dataproc-m-ds7lj5gnnnqggbqd.mdb.yandexcloud.net/user/sparkuser/.sparkStaging/application_1586176069782_0003/spark-examples.jar
20/04/19 16:43:58 INFO yarn.Client: Uploading resource file:/etc/spark/conf/hive-site.xml -> hdfs://rc1b-dataproc-m-ds7lj5gnnnqggbqd.mdb.yandexcloud.net/user/sparkuser/.sparkStaging/application_1586176069782_0003/hive-site.xml
20/04/19 16:43:58 INFO yarn.Client: Uploading resource file:/tmp/spark-6dff3163-089b-4634-8f74-c8301d424567/__spark_conf__8717606866210190000.zip -> hdfs://rc1b-dataproc-m-ds7lj5gnnnqggbqd.mdb.yandexcloud.net/user/sparkuser/.sparkStaging/application_1586176069782_0003/__spark_conf__.zip
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
	 tracking URL: http://rc1b-dataproc-m-ds7lj5gnnnqggbqd.mdb.yandexcloud.net:8088/proxy/application_1586176069782_0003/
	 user: sparkuser
20/04/19 16:44:05 INFO yarn.Client: Application report for application_1586176069782_0003 (state: RUNNING)
20/04/19 16:44:05 INFO yarn.Client:
	 client token: N/A
	 diagnostics: N/A
	 ApplicationMaster host: rc1b-dataproc-d-9cd9yoenm4npsznt.mdb.yandexcloud.net
	 ApplicationMaster RPC port: 41648
	 queue: default
	 start time: 1587314639386
	 final status: UNDEFINED
	 tracking URL: http://rc1b-dataproc-m-ds7lj5gnnnqggbqd.mdb.yandexcloud.net:8088/proxy/application_1586176069782_0003/
	 user: sparkuser
20/04/19 16:44:06 INFO yarn.Client: Application report for application_1586176069782_0003 (state: RUNNING)
20/04/19 16:44:07 INFO yarn.Client: Application report for application_1586176069782_0003 (state: RUNNING)
20/04/19 16:44:08 INFO yarn.Client: Application report for application_1586176069782_0003 (state: RUNNING)
20/04/19 16:44:09 INFO yarn.Client: Application report for application_1586176069782_0003 (state: FINISHED)
20/04/19 16:44:09 INFO yarn.Client:
	 client token: N/A
	 diagnostics: N/A
	 ApplicationMaster host: rc1b-dataproc-d-9cd9yoenm4npsznt.mdb.yandexcloud.net
	 ApplicationMaster RPC port: 41648
	 queue: default
	 start time: 1587314639386
	 final status: SUCCEEDED
	 tracking URL: http://rc1b-dataproc-m-ds7lj5gnnnqggbqd.mdb.yandexcloud.net:8088/proxy/application_1586176069782_0003/
	 user: sparkuser
20/04/19 16:44:09 INFO util.ShutdownHookManager: Shutdown hook called
20/04/19 16:44:09 INFO util.ShutdownHookManager: Deleting directory /tmp/spark-6dff3163-089b-4634-8f74-c8301d424567
20/04/19 16:44:09 INFO util.ShutdownHookManager: Deleting directory /tmp/spark-826498b1-8dec-4229-905e-921203b7b1d0
```

### Viewing the job execution status {#status-check}

Check the execution status using [yarn application](https://hadoop.apache.org/docs/r2.10.0/hadoop-yarn/hadoop-yarn-site/YarnCommands.html#application):

```bash
yarn application -status application_1586176069782_0003
20/04/19 16:47:03 INFO client.RMProxy: Connecting to ResourceManager at rc1b-dataproc-m-ds7lj5gnnnqggbqd.mdb.yandexcloud.net/10.13.13.18:8032
20/04/19 16:47:03 INFO client.AHSProxy: Connecting to Application History server at rc1b-dataproc-m-ds7lj5gnnnqggbqd.mdb.yandexcloud.net/10.13.13.18:10200
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
	Tracking-URL : rc1b-dataproc-m-ds7lj5gnnnqggbqd.mdb.yandexcloud.net:18080/history/application_1586176069782_0003/1
	RPC Port : 41648
	AM Host : rc1b-dataproc-d-9cd9yoenm4npsznt.mdb.yandexcloud.net
	Aggregate Resource Allocation : 141510 MB-seconds, 11 vcore-seconds
	Aggregate Resource Preempted : 0 MB-seconds, 0 vcore-seconds
	Log Aggregation Status : SUCCEEDED
	Diagnostics :
	Unmanaged Application : false
	Application Node Label Expression : <Not set>
	AM container Node Label Expression : <DEFAULT_PARTITION>
	TimeoutType : LIFETIME	ExpiryTime : UNLIMITED	RemainingTime : -1seconds
```

### Viewing job execution logs {#get-log}

View logs from all running containers using [yarn logs](https://hadoop.apache.org/docs/r2.10.0/hadoop-yarn/hadoop-yarn-site/YarnCommands.html#logs):

```bash
sudo -u sparkuser yarn logs -applicationId application_1586176069782_0003 | grep "Pi is"
Pi is roughly 3.14164599141646
```

