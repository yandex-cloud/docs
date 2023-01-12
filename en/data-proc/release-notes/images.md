# {{ dataproc-full-name }} image releases

For a complete listing of current and deprecated {{ dataproc-name }} images, please see [{#T}](../concepts/environment.md).

{% if product == "yandex-cloud" %}

## 2.0.53 {#2.0.53}

* Fixed an error that occurred in the cores/memory configuration for Spark/Yarn when specifying the `spark:spark.submit.deployMode` cluster property.
* Fixed the `spark-defaults.yaml` configuration file update when updating the cluster properties.

## 2.0.52 {#2.0.52}

* Added a script to hosts for adjusting the initialization script status manually.

## 2.0.50 {#2.0.50}

* The results of running user scenarios are now sent to the `masternode` by default.

## 2.0.49 {#2.0.49}

* Fixed an error when user-defined settings were ignored in Hive Metastore Server.

## 2.0.48 {#2.0.48}

* Added the ability to use [Apache Spark Thrift Server](https://spark.apache.org/docs/latest/sql-distributed-sql-engine.html). For more information, see [{#T}](../concepts/settings-list.md#spark-thrift-server).
* Corrected the `YandexMetadataCredentialsProvider does not implement AWSCredentialsProvider` error that might have appeared on lightweight Apache Spark configurations.

## 2.0.47 {#2.0.47}

* Corrected a TCP session leak with the metadata service on high-load clusters. The leak could have resulted in an IAM token not updating for authorization in {{ objstorage-name }} and other services.
* Corrected the `YandexMetadataCredentialsProvider does not implement AWSCredentialsProvider` error that caused tables from Hive Metastore not to load.

## 2.0.46 {#2.0.46}

* Some Spark properties are also used in Zeppelin, such as `spark.submit.deployMode`, `spark.driver.cores`, `spark.driver.memory`, `spark.executor.cores`, `spark.executor.memory`, `spark.files`, `spark.jars`, and `spark.jars.packages`.

## 2.0.45 {#2.0.45}

* Fixed an error with the MapReduce Application History Server not being hosted on the cluster master host.
* Enabled the HIVE configuration without YARN.
* Allowed running HiveServer2 with MapReduce only.

## 2.0.43 {#2.0.43}

* Unified cores/memory calculations for Spark/YARN.

## 2.0.42 {#2.0.42}

* Upgraded Apache Spark to version 3.0.3 and built it with the [hadoop-cloud](https://spark.apache.org/docs/3.0.3/cloud-integration.html) profile to use [Magic Committer](https://hadoop.apache.org/docs/r3.2.3/hadoop-aws/tools/hadoop-aws/committers.html#Using_the_Magic_committer) and Parquet format.
* Fixed an error when the `hive.metastore.uris` settings were ignored for Spark while using external Hive metastore.

## 2.0.41 {#2.0.41}

* Added `hive-site.xml` to classpath for Spark apps.
* Fixed an error when system Python was used instead of a Conda environment while running PySpark.

## 2.0.40 {#2.0.40}

* Fixed an error when user scenarios failed to run.

## 2.0.39 {#2.0.39}

* Added support for lightweight clusters (without HDFS and data storage subclusters).

## 2.0.38 and 1.4.35 {#2.0.38-1.4.35}

* Adapted images to be used in subnets with a user-defined DNS zone.

## 2.0.37 {#2.0.37}

* Added the YC CLI to `PATH` for initialization scripts.

## 2.0.36 {#2.0.36}

* The YC CLI is installed on all cluster hosts by default.
* Added the following values to environment variables for initialization scripts: `CLUSTER_ID`, `S3_BUCKET`, `ROLE`, `CLUSTER_SERVICES`, `MIN_WORKER_COUNT`, and `MAX_WORKER_COUNT`.

## 2.0.35 {#2.0.35}

* Added support for cluster initialization scripts.

## 2.0 {#2.0}

### Base components {#base-2.0}

The following components have been updated:

* HBase — 2.2.7.
* Hadoop — 3.2.2.
* Hive — 3.1.2.
* Livy — 0.8.0.
* Oozie — 5.2.1.
* Spark — 3.0.2.
* Tez — 0.10.0.
* Zeppelin — 0.9.0.

Deprecated components have been removed:

* Flume
* Sqoop

### Python and machine learning libraries {#python-ml-2.0}

Python has been updated to version [3.8.10](https://docs.python.org/3.8/whatsnew/changelog.html#python-3-8-10-final "Change log").

The following libraries have been updated:

* IPython — 7.19.0.
* ipykernel — 5.3.4.
* Matplotlib — 3.2.2.
* pandas — 1.1.3.
* PyArrow — 1.0.1.
* PyHive — 0.6.1.
* scikit-learn — 0.23.2.

The following libraries have been deleted:

* CatBoost
* LightGBM
* TensorFlow
* XGBoost

## 1.4 {#1.4}

### Base components {#base-1.4}

The following components have been updated:

* HBase — 1.3.5.
* Hadoop — 2.10.0.
* Hive — 2.3.6.
* Flume — 1.9.0.
* Livy — 0.7.0.
* Oozie — 5.2.0.
* Spark — 2.4.6.
* Sqoop — 1.4.7.
* Tez — 0.9.2.
* Zeppelin — 0.8.2.
* Zookeeper — 3.4.14.

### Python and machine learning libraries {#python-ml-1.4}

Python has been updated to version [3.7.9](https://docs.python.org/3.7/whatsnew/changelog.html#python-3-7-9-final "Change log").

The following libraries have been updated:

* CatBoost — 0.20.2.
* IPython — 7.9.0.
* ipykernel — 5.1.3.
* LightGBM — 2.3.0.
* Matplotlib — 3.1.1.
* pandas — 0.25.3.
* PyArrow — 0.13.0.
* PyHive — 0.6.1.
* scikit-learn — 0.21.3.
* TensorFlow— 1.15.0.
* XGBoost — 0.90.

{% endif %}
