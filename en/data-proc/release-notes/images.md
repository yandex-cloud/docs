# {{ dataproc-full-name }} image release notes

For a complete list of available and deprecated {{ dataproc-name }} images, see [{#T}](../concepts/environment.md).

## 2.2.x images (beta) {#2-2-x}

### 2.2.9 (beta) {#2-2-9}

* Updated Apache Spark to version 3.5.6.

### 2.2.8 (beta) {#2-2-8}

{% include [envvars-hadoop-heapsize](../../_includes/data-processing/envvars-hadoop-heapsize.md) %}

* Supported {{ oslogin }} for cluster hosts. This option enables [{{ oslogin }}](../../organization/concepts/os-login.md) access to all hosts you create in the cluster.

### 2.2.7 (beta) {#2-2-7}

* Updated Java version to 11.

### 2.2.6 (beta) {#2-2-6}

* Resolved an issue where the `dataproc:nodemanager_available_memory_ratio` property was ignored when reserving memory for YARN NodeManager.

### 2.2.5 (beta) {#2-2-5}

* Updated component versions:

    * Hadoop updated to version 3.3.2.
    * Spark updated to version 3.5.0.

* Python updated to version [3.11.10](https://docs.python.org/3.11/whatsnew/3.11.html#summary-release-highlights "Список изменений").

* Updated library versions:

    * IPython updated to version 8.22.0.
    * ipykernel updated to version 6.29.5.
    * Matplotlib updated to version 3.9.2.
    * pandas updated to version 2.2.2.
    * PyArrow updated to version 14.0.2.
    * scikit-learn updated to version 1.5.1.

## 2.1.x images {#2-1-x}

### 2.1.21 {#2-1-21}

{% include [envvars-hadoop-heapsize](../../_includes/data-processing/envvars-hadoop-heapsize.md) %}

### 2.1.20 {#2-1-20}

* Supported {{ oslogin }} for cluster hosts. This option enables [{{ oslogin }}](../../organization/concepts/os-login.md) access to all hosts you create in the cluster.

### 2.1.19 {#2-1-19}

* Resolved an issue where the `dataproc:nodemanager_available_memory_ratio` property was ignored when reserving memory for YARN NodeManager.

### 2.1.18 {#2-1-18}

* Conda now uses [Mamba](https://www.anaconda.com/blog/a-faster-conda-for-a-growing-community) as its default solver.
* Added logging for Conda package installation.
* Removed `[ERROR] can't parse line` messages from cluster startup logs.

### 2.1.17 {#2-1-17}

* {{ resmgr-name }} events are now published to Job History Server by default.

### 2.1.16 {#2-1-16}

* Added log rotation for Yarn TimelineServer.

### 2.1.15 {#2-1-15}

* Stabilized the 2.1 image version line.
* Configuration file properties are now automatically removed when deleted in cluster settings.
* The following components were updated:

    * Hadoop updated to version 3.3.2.
    * Livy updated to version 0.8.0.
    * Spark updated to version 3.3.2.
    * Tez updated to version 0.10.1.
    * Zeppelin updated to version 0.10.1.

* Removed deprecated components:

    * HBase
    * Hive
    * Zookeeper
    * Oozie

* Python updated to version [3.8.13](https://docs.python.org/3.8/whatsnew/changelog.html#python-3-8-13-final "Change log").

* The following libraries were updated:

    * IPython updated to version 7.22.0.
    * ipykernel updated to version 5.3.4.
    * Matplotlib updated to version 3.4.2.
    * pandas updated to version 1.2.4.
    * PyArrow updated to version 14.0.2.
    * scikit-learn updated to version 0.24.1.

## Image 2.0.x {#2-0-x}

### 2.0.80 {#2-0-80}

{% include [envvars-hadoop-heapsize](../../_includes/data-processing/envvars-hadoop-heapsize.md) %}

### 2.0.79 {#2-0-79}

* Supported {{ oslogin }} for cluster hosts. This option enables [{{ oslogin }}](../../organization/concepts/os-login.md) access to all hosts you create in the cluster.

### 2.0.78 {#2-0-78}

* Resolved an issue where the `dataproc:nodemanager_available_memory_ratio` property was ignored when reserving memory for YARN NodeManager.

### 2.0.77 {#2-0-77}

* Added logging during Conda package installation.
* Deleted `[ERROR] can't parse line` lines from cluster startup logs.

### 2.0.76 {#2-0-76}

* Added log rotation for Yarn TimelineServer.

### 2.0.74 {#2-0-74}

* Configuration file properties are now automatically removed when deleted in cluster settings.

### 2.0.69 {#2-0-69}

* Added the `kafka-clients` and `commons-pool2` libraries required for {{ SPRK }} and {{ KF }} integration.

### 2.0.66 {#2-0-66}

* Resolved an issue where YARN NodeManager installed on a new host launched prematurely before initialization scripts finished.

### 2.0.64 {#2-0-64}

* Added Helium support.
* Prevented unnecessary node decommissioning.
* Log shipping to {{ cloud-logging-name }} now starts during node initialization.

### 2.0.62 {#2-0-62}

* Fixed missing default Zeppelin plugins.
* Fixed error handling in Hive jobs.

### 2.0.61 {#2-0-61}

* Internal changes.

### 2.0.59 {#2-0-59}

* Added single-node cluster support for Spark and MapReduce services.

### 2.0.58 {#2-0-58}

* User-defined Zeppelin interpreter settings are now retained after the cluster reboot, with the exception of `spark.submit.deployMode`, `spark.driver.cores`, `spark.driver.memory`, `spark.executor.cores`, `spark.executor.memory`, `spark.files`, `spark.jars`, and `spark.jars.packages` settings that get rewritten from Spark properties.

### 2.0.56 {#2-0-56}

* Optimized metadata service queries for s3 interactions.

### 2.0.55 {#2-0-55}

* Improved logging in initialization scripts.

### 2.0.54 {#2-0-54}

* Fixed TEZ component configuration errors.

### 2.0.53 {#2-0-53}

* Fixed incorrect cores/memory configuration in Spark/Yarn when using the `spark:spark.submit.deployMode` cluster property.
* Configuration file `spark-defaults.yaml` now updates correctly when modifying cluster properties.

### 2.0.52 {#2-0-52}

* A script for manually correcting initialization script statuses has been added to the hosts.

### 2.0.50 {#2-0-50}

* User script’s execution results are now sent to `masternode` by default.

### 2.0.49 {#2-0-49}

* Fixed an issue where user-defined settings were ignored in the Hive Metastore Server.

### 2.0.48 {#2-0-48}

* Added support for [Apache Spark Thrift Server](https://spark.apache.org/docs/latest/sql-distributed-sql-engine.html). For more information, see [{#T}](../concepts/settings-list.md#spark-thrift-server).
* Fixed the `YandexMetadataCredentialsProvider does not implement AWSCredentialsProvider` error that could occured on lightweight Apache Spark configurations.

### 2.0.47 {#2-0-47}

* Fixed TCP connection leaks in the metadata service under high-load cluster conditions. These leaks could prevent IAM token updates, affecting authorization in {{ objstorage-name }} and other services.
* Fixed the `YandexMetadataCredentialsProvider does not implement AWSCredentialsProvider` error that prevented Hive Metastore tables from loading.

### 2.0.46 {#2-0-46}

* Implemented support for Spark properties in Zeppelin, including: `spark.submit.deployMode`, `spark.driver.cores`, `spark.driver.memory`, `spark.executor.cores`, `spark.executor.memory`, `spark.files`, `spark.jars`, and `spark.jars.packages`.

### 2.0.45 {#2-0-45}

* Fixed an issue preventing the MapReduce Application History Server from running on the cluster master node.
* Enabled HIVE configuration without YARN.
* Enabled HiveServer2 to run using only MapReduce.

### 2.0.43 {#2-0-43}

* Standartized CPU and memory allocation logic between Spark and YARN.

### 2.0.42 {#2-0-42}

* Apache Spark has been upgraded to version 3.0.3 and built with the [hadoop-cloud](https://spark.apache.org/docs/3.0.3/cloud-integration.html) profile to support the [Magic Committer](https://hadoop.apache.org/docs/r3.2.3/hadoop-aws/tools/hadoop-aws/committers.html#Using_the_Magic_committer) and Parquet format.
* Fixed an issue where `hive.metastore.uris` Spark settings were ignored when using an external Hive metastore.

### 2.0.41 {#2-0-41}

* Added `hive-site.xml` to the classpath for Spark applications.
* Fixed an issue where PySpark incorrectly used the system Python installation instead of the configured Conda environment during manual launch.

### 2.0.40 {#2-0-40}

* Fixed an issue preventing user scripts from launching successfully.

### 2.0.39 {#2-0-39}

* Added support for lightweight clusters that run without HDFS and dedicated storage subclusters.

### 2.0.38 {#2-0-38}

* Updated system images to support operations in subnets with user-defined DNS zones.

### 2.0.37 {#2-0-37}

* Added CLI to `PATH` for initialization scripts.

### 2.0.36 {#2-0-36}

* The CLI tool is now installed by default on all cluster nodes.
* Added the following environment variables for initialization scripts: `CLUSTER_ID`, `S3_BUCKET`, `ROLE`, `CLUSTER_SERVICES`, `MIN_WORKER_COUNT`, and `MAX_WORKER_COUNT`.

### 2.0.35 {#2-0-35}

* Added support for cluster initialization scripts.

### 2.0 {#2-0}

* Updated component versions:

    * HBase updated to version 2.2.7.
    * Hadoop updated to version 3.2.2.
    * Hive updated to version 3.1.2.
    * Livy updated to version 0.8.0.
    * Oozie updated to version 5.2.1.
    * Spark updated to version 3.0.2.
    * Tez updated to version 0.10.0.
    * Zeppelin updated to version 0.9.0.

* Deprecated components have been removed:

    * Flume
    * Sqoop

* Python updated to version [3.8.10](https://docs.python.org/3.8/whatsnew/changelog.html#python-3-8-10-final "Change log").

* Updated library versions:

    * IPython updated to version 7.19.0.
    * ipykernel updated to version 5.3.4.
    * Matplotlib updated to version 3.2.2.
    * pandas updated to version 1.1.3.
    * PyArrow updated to version 1.0.1.
    * PyHive updated to version 0.6.1.
    * scikit-learn updated to version 0.23.2.

* Removed the following deprecated libraries:

    * CatBoost
    * LightGBM
    * TensorFlow
    * XGBoost

## Image 1.4.x {#1-4-x}

### 1.4.35 {#1-4-35}

* Updated system images to support operations in subnets with user-defined DNS zones.

### 1.4 {#1-4}

* Updated component versions:

    * HBase updated to version 1.3.5.
    * Hadoop updated to version 2.10.0.
    * Hive updated to version 2.3.6.
    * Flume updated to version 1.9.0.
    * Livy updated to version 0.7.0.
    * Oozie updated to version 5.2.0.
    * Spark updated to version 2.4.6.
    * Sqoop updated to version 1.4.7.
    * Tez updated to version 0.9.2.
    * Zeppelin updated to version 0.8.2.
    * ZooKeeper updated to version 3.4.14.

* Python updated to version [3.7.9](https://docs.python.org/3.7/whatsnew/changelog.html#python-3-7-9-final "Change log").

* Updated library versions:

    * CatBoost updated to version 0.20.2.
    * IPython updated to version 7.9.0.
    * ipykernel updated to version 5.1.3.
    * LightGBM updated to version 2.3.0.
    * Matplotlib updated to version 3.1.1.
    * pandas updated to version 0.25.3.
    * PyArrow updated to version 0.13.0.
    * PyHive updated to version 0.6.1.
    * scikit-learn updated to version 0.21.3.
    * TensorFlow updated to version 1.15.0.
    * XGBoost updated to version 0.90.
