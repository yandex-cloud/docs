# {{ dataproc-full-name }} image release notes

For a complete list of current and deprecated {{ dataproc-name }} images, see [{#T}](../concepts/environment.md).

## 2.2.x images (beta) {#2-2-x}

### 2.2.7 (beta) {#2-2-7}
* Upgraded to Java 11.

### 2.2.6 (beta) {#2-2-6}
* Fixed an error where the `dataproc:nodemanager_available_memory_ratio` property was ignored when reserving a memory share for YARN NodeManager.

### 2.2.5 (beta) {#2-2-5}

* The following components were updated:

    * Hadoop to 3.3.2
    * Spark to 3.5.0

* Python upgraded to version [3.11.10](https://docs.python.org/3.11/whatsnew/3.11.html#summary-release-highlights "Список изменений").

* The following libraries were updated:

    * IPython to 8.22.0
    * ipykernel to 6.29.5
    * Matplotlib to 3.9.2
    * pandas to 2.2.2
    * PyArrow to 14.0.2
    * scikit-learn to 1.5.1

## 2.1.x images {#2-1-x}

### 2.1.21 {#2-1-21}
* Added the option to set the following environment variables:

    * `HADOOP_HEAPSIZE_MIN` and `HADOOP_HEAPSIZE_MAX` for `hadoop`
    * `HADOOP_HEAPSIZE` for `hive`

### 2.1.19 {#2-1-19}
* Fixed an error where the `dataproc:nodemanager_available_memory_ratio` property was ignored when reserving a memory share for YARN NodeManager.

### 2.1.18 {#2-1-18}
* Updated Conda and changed the default solver to [Mamba](https://www.anaconda.com/blog/a-faster-conda-for-a-growing-community).
* Added logging during Conda package installation.
* Deleted `[ERROR] can't parse line` lines from cluster startup logs.

### 2.1.17 {#2-1-17}
* Enabled publishing {{ resmgr-name }} events in Job History Server by default.

### 2.1.16 {#2-1-16}
* Added rotation of Yarn Timelinserver logs.

### 2.1.15 {#2-1-15}
* Stabilized the 2.1 image line.
* Implemented deletion of properties from configuration files when deleting them from the cluster configuration.
* The following components were updated:

    * Hadoop to 3.3.2
    * Livy to 0.8.0
    * Spark to 3.3.2
    * Tez to 0.10.1
    * Zeppelin to 0.10.1

* Deprecated components were removed:

    * HBase
    * Hive
    * Zookeeper
    * Oozie

* Python updated to version [3.8.13](https://docs.python.org/3.8/whatsnew/changelog.html#python-3-8-13-final "Change log").

* The following libraries were updated:

    * IPython to 7.22.0
    * ipykernel to 5.3.4
    * Matplotlib to 3.4.2
    * pandas to 1.2.4
    * PyArrow to 14.0.2
    * scikit-learn to 0.24.1

## Image 2.0.x {#2-0-x}

### 2.0.80 {#2-0-80}
* Added the option to set the following environment variables:

    * `HADOOP_HEAPSIZE_MIN` and `HADOOP_HEAPSIZE_MAX` for `hadoop`
    * `HADOOP_HEAPSIZE` for `hive`

### 2.0.78 {#2-0-78}
* Fixed an error where the `dataproc:nodemanager_available_memory_ratio` property was ignored when reserving a memory share for YARN NodeManager.

### 2.0.77 {#2-0-77}
* Added logging during Conda package installation.
* Deleted `[ERROR] can't parse line` lines from cluster startup logs.

### 2.0.76 {#2-0-76}
* Added rotation of Yarn Timelinserver logs.

### 2.0.74 {#2-0-74}
* Implemented deletion of properties from configuration files when deleting them from the cluster configuration.

### 2.0.69 {#2-0-69}

* Added the `kafka-clients` and `commons-pool2` libraries required for {{ SPRK }} and {{ KF }} integration.

### 2.0.66 {#2-0-66}

* Fixed an issue where YARN NodeManager would run on a new host before the initialization scripts were executed.

### 2.0.64 {#2-0-64}

* Added support for Helium.
* Fixed the redundant decommission issue.
* Log delivery to {{ cloud-logging-name }} is run once a node is started.

### 2.0.62 {#2-0-62}

* Fixed an error when the Zeppelin default plugins were missing.
* Fixed an issue when Hive job errors were handled incorrectly.

### 2.0.61 {#2-0-61}

* Internal changes.

### 2.0.59 {#2-0-59}

* Added support for Spark and MapReduce services in a single-host cluster.

### 2.0.58 {#2-0-58}

* Added the ability to keep user-defined properties of the Zeppelin interpreter when restarting a cluster. The `spark.submit.deployMode`, `spark.driver.cores`, `spark.driver.memory`, `spark.executor.cores`, `spark.executor.memory`, `spark.files`, `spark.jars`, and `spark.jars.packages` properties are not saved: they are rewritten from Spark properties.

### 2.0.56 {#2-0-56}

* Optimized requests to the metadata service when interacting with s3.

### 2.0.55 {#2-0-55}

* Improved logging in the initialization scripts.

### 2.0.54 {#2-0-54}

* Fixed errors in the TEZ component configuration.

### 2.0.53 {#2-0-53}

* Fixed an error with cores/memory configuration for Spark/Yarn when specifying the `spark:spark.submit.deployMode` cluster property.
* Fixed the `spark-defaults.yaml` configuration file update when updating the cluster properties.

### 2.0.52 {#2-0-52}

* Added a script to hosts for adjusting the initialization script status manually.

### 2.0.50 {#2-0-50}

* The execution results of user scenarios now go to `masternode` by default.

### 2.0.49 {#2-0-49}

* Fixed an error when user-defined settings were ignored in Hive Metastore Server.

### 2.0.48 {#2-0-48}

* Added the ability to use [Apache Spark Thrift Server](https://spark.apache.org/docs/latest/sql-distributed-sql-engine.html). To learn more, see [{#T}](../concepts/settings-list.md#spark-thrift-server).
* Fixed the `YandexMetadataCredentialsProvider does not implement AWSCredentialsProvider` error which could appear on lightweight Apache Spark configurations.

### 2.0.47 {#2-0-47}

* Corrected a TCP session leak with the metadata service on high-load clusters. The leak could have resulted in an IAM token not updating for authorization in {{ objstorage-name }} and other services.
* Fixed the `YandexMetadataCredentialsProvider does not implement AWSCredentialsProvider` error that prevented Hive Metastore tables from loading.

### 2.0.46 {#2-0-46}

* Some Spark properties are now used in Zeppelin as well, e.g., `spark.submit.deployMode`, `spark.driver.cores`, `spark.driver.memory`, `spark.executor.cores`, `spark.executor.memory`, `spark.files`, `spark.jars`, and `spark.jars.packages`.

### 2.0.45 {#2-0-45}

* Fixed an error with the MapReduce Application History Server not being hosted on the cluster master host.
* Enabled the HIVE configuration without YARN.
* Allowed running HiveServer2 with MapReduce only.

### 2.0.43 {#2-0-43}

* Unified cores/memory calculations for Spark/YARN.

### 2.0.42 {#2-0-42}

* Upgraded Apache Spark to version 3.0.3 and built it with the [hadoop-cloud](https://spark.apache.org/docs/3.0.3/cloud-integration.html) profile to use [Magic Committer](https://hadoop.apache.org/docs/r3.2.3/hadoop-aws/tools/hadoop-aws/committers.html#Using_the_Magic_committer) and Parquet format.
* Fixed an error where the `hive.metastore.uris` settings for Spark were ignored when using an external Hive metastore.

### 2.0.41 {#2-0-41}

* Added `hive-site.xml` to classpath for Spark apps.
* Fixed an error when system Python was used instead of a Conda environment while running PySpark.

### 2.0.40 {#2-0-40}

* Fixed an error when user scenarios failed to run.

### 2.0.39 {#2-0-39}

* Added support for lightweight clusters (without HDFS and data storage subclusters).

### 2.0.38 {#2-0-38}

* Adapted images to be used in subnets with a user-defined DNS zone.

### 2.0.37 {#2-0-37}

* Added the CLI to `PATH` for initialization scripts.

### 2.0.36 {#2-0-36}

* The CLI is installed on all cluster hosts by default.
* Added the following values to environment variables for initialization scripts: `CLUSTER_ID`, `S3_BUCKET`, `ROLE`, `CLUSTER_SERVICES`, `MIN_WORKER_COUNT`, and `MAX_WORKER_COUNT`.

### 2.0.35 {#2-0-35}

* Added support for cluster initialization scripts.

### 2.0 {#2-0}

* The following components were updated:

    * HBase to 2.2.7
    * Hadoop to 3.2.2
    * Hive to 3.1.2
    * Livy to 0.8.0
    * Oozie to 5.2.1
    * Spark to 3.0.2
    * Tez to 0.10.0
    * Zeppelin to 0.9.0

* Deprecated components have been removed:

    * Flume
    * Sqoop

* Python updated to version [3.8.10](https://docs.python.org/3.8/whatsnew/changelog.html#python-3-8-10-final "Change log").

* The following libraries were updated:

    * IPython to 7.19.0
    * ipykernel to 5.3.4
    * Matplotlib to 3.2.2
    * pandas to 1.1.3
    * PyArrow to 1.0.1
    * PyHive to 0.6.1
    * scikit-learn to 0.23.2

* The following libraries were deleted:

    * CatBoost
    * LightGBM
    * TensorFlow
    * XGBoost

## Image 1.4.x {#1-4-x}

### 1.4.35 {#1-4-35}

* Adapted images to be used in subnets with a user-defined DNS zone.

### 1.4 {#1-4}

* The following components were updated:

    * HBase to 1.3.5
    * Hadoop to 2.10.0
    * Hive to 2.3.6
    * Flume to 1.9.0
    * Livy to 0.7.0
    * Oozie to 5.2.0
    * Spark to 2.4.6
    * Sqoop to 1.4.7
    * Tez to 0.9.2
    * Zeppelin to 0.8.2
    * ZooKeeper to 3.4.14

* Python updated to version [3.7.9](https://docs.python.org/3.7/whatsnew/changelog.html#python-3-7-9-final "Change log").

* The following libraries were updated:

    * CatBoost to 0.20.2
    * IPython to 7.9.0
    * ipykernel to 5.1.3
    * LightGBM to 2.3.0
    * Matplotlib to 3.1.1
    * pandas to 0.25.3
    * PyArrow to 0.13.0
    * PyHive to 0.6.1
    * scikit-learn to 0.21.3
    * TensorFlow to 1.15.0
    * XGBoost to 0.90
