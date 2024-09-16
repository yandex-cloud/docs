# {{ dataproc-full-name }} release notes

This section contains {{ dataproc-name }} release notes.

{% include [Tags](../../_includes/mdb/release-notes-tags.md) %}


## September 2024 {#sep-2024}

{{ metastore-name }} clusters have become part of {{ metadata-hub-full-name }}. See information about {{ metastore-name }} clusters in [{{ metadata-hub-name }} documentation](../../metadata-hub/concepts/metastore.md).

## April 2024 {#apr-2024}

A stable line of 2.1 images is available. With it, you can create a cluster with more recent [Spark 3.3.2](https://spark.apache.org/releases/spark-release-3-3-2.html) and [Hadoop 3.3.2](https://hadoop.apache.org/docs/r3.3.2/hadoop-project-dist/hadoop-common/release/3.3.2/RELEASENOTES.3.3.2.html) versions.

## Q2 2023 {#q2-2023}

Creating [{{ metastore-name }}](../concepts/metastore.md) clusters is now available. This feature is at the [Preview](../../overview/concepts/launch-stages.md) stage.

## Q3 2022 {#q3-2022}

* Added support for [new settings](https://github.com/apache/airflow/pull/25158) in the `DataprocCreateClusterOperator` Airflow operator.
* Added `cpu-optimized` host classes with 2:1 GB RAM to vCPU ratio. The new configurations are only available for Intel Ice Lake.
* Published a [guide](../tutorials/geesefs-init-actions.md) for using initialization scripts to set up GeeseFS.

## Q2 2022 {#q2-2022}

* Image version 2.1 available.
* Added the ability to enable public internet access for subclusters of all types. {{ tag-con }} {{ tag-cli }} {{ tag-api }}
* Lightweight Spark is available starting with image version 2.0.39. You can now create a cluster without data storage subclusters because YARN and SPARK services are no longer dependent on HDFS.
* Added support for [initialization scripts](../concepts/init-action.md) in the CLI. {{ tag-cli }}

## Q1 2022 {#q1-2022}

* You can now create clusters on non-replicated network drives up to 8 TB. Non-replicated drives are much simpler than standard network SSD storage, which makes them perform several times faster.
* Added the ability to [cancel a job](../operations/jobs-spark#cancel). {{ tag-con }} {{ tag-cli }}
* Added the build number in [image version {{ dataproc-name }}](../concepts/environment.md).
* Added the ability to pass the `packages`, `repositories`, and `exclude_packages` parameters for Spark and PySpark jobs. By using these parameters, you can download additional dependencies and packages from external repositories. {{ tag-con }} {{ tag-cli }}

