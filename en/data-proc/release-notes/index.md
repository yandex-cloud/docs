---
title: '{{ dataproc-full-name }} release notes'
description: This section contains {{ dataproc-name }} release notes.
---

# {{ dataproc-full-name }} release notes

## December 2024 {#dec-2024}

Added [environment](../concepts/environment.md#environment) selection (`PRODUCTION` / `PRESTABLE`) during cluster creation and modification.

## September 2024 {#sep-2024}

{{ metastore-name }} cluster functionality has been integrated in {{ metadata-hub-full-name }}. For more information about {{ metastore-name }} clusters, see the [{{ metadata-hub-name }} documentation](../../metadata-hub/concepts/metastore.md).

## April 2024 {#apr-2024}

A stable image version line 2.1 is now available. This update enables cluster creation with newer runtime versions: [Spark 3.3.2](https://spark.apache.org/releases/spark-release-3-3-2.html) and [Hadoop 3.3.2](https://hadoop.apache.org/docs/r3.3.2/hadoop-project-dist/hadoop-common/release/3.3.2/RELEASENOTES.3.3.2.html).

## Q2 2023 {#q2-2023}

Added support for creating [{{ metastore-name }}](../../metadata-hub/concepts/metastore.md) clusters. This feature is currently in [Preview](../../overview/concepts/launch-stages.md).

## Q3 2022 {#q3-2022}

* Added support for [new configuration settings](https://github.com/apache/airflow/pull/25158) in the `DataprocCreateClusterOperator` Airflow operator.
* Added `cpu-optimized` host classes configured with 2GB RAM per 1 vCPU core. The new configurations are exclusively available for Intel Ice Lake processors.
* Published a [guide](../tutorials/geesefs-init-actions.md) for using initialization scripts to configure GeeseFS.

## Q2 2022 {#q2-2022}

* Image version 2.1 is now available.
* Added support for public internet access across all subcluster types.
* Lightweight Spark support is now available starting with image version 2.0.39. You can now create clusters without data storage subclusters, as YARN and SPARK services no longer depend on HDFS.
* Added support for [initialization scripts](../concepts/init-action.md) in the CLI.

## Q1 2022 {#q1-2022}

* You can now create clusters using non-replicated network drives up to 8 TB in size. Non-replicated drives have a simpler architecture than network SSD storage, resulting in significantly higher performance.
* Added support for [job cancellation](../operations/jobs-spark#cancel).
* Build numbers have been added to [{{ dataproc-name }} image versions](../concepts/environment.md).
* Spark and PySpark jobs now accept `packages`, `repositories`, and `exclude_packages` parameters. You can use these parameters to download additional dependencies and packages from third-party repositories.
