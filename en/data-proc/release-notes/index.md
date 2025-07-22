---
title: '{{ dataproc-full-name }} release notes'
description: This section contains {{ dataproc-name }} release notes.
---

# {{ dataproc-full-name }} release notes

## Q2 2025 {#q2-2025}

* Added the {{ oslogin }} option to use when creating a cluster. This option enables [{{ oslogin }}](../../organization/concepts/os-login.md) access to all hosts you create in the cluster.
* Added the option to set environment variables via cluster properties.

## Q1 2025 {#q1-2025}

In 2.2.X images, Java version updated to 11.

## Q4 2024 {#q4-2024}

* Added [environment](../concepts/environment.md#environment) selection (`PRODUCTION` / `PRESTABLE`) during cluster creation and modification.
* In 2.2.X images, Python version updated to 3.1.

## Q3 2024 {#q3-2024}

* {{ metastore-name }} cluster functionality has been integrated in {{ metadata-hub-full-name }}. For more information about {{ metastore-name }} clusters, see the [{{ metadata-hub-name }} documentation](../../metadata-hub/concepts/metastore.md).
* In 2.1.X and 2.2.X images, Conda now uses [Mamba](https://www.anaconda.com/blog/a-faster-conda-for-a-growing-community) as its default solver.

## Q2 2024 {#q2-2024}

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
* Lightweight Spark support is now available starting with image version 2.0.39. You can now create a cluster without data storage subclusters because YARN and SPARK services are no longer dependent on HDFS.
* Added support for [initialization scripts](../concepts/init-action.md) in the CLI.

## Q1 2022 {#q1-2022}

* You can now create clusters using non-replicated network drives up to 8 TB in size. Non-replicated drives have a simpler architecture than network SSD storage, resulting in significantly higher performance.
* Added support for [job cancellation](../operations/jobs-spark#cancel).
* Added the build number in [{{ dataproc-name }} image version](../concepts/environment.md).
* Spark and PySpark jobs now accept `packages`, `repositories`, and `exclude_packages` parameters. You can use these parameters to download additional dependencies and packages from third-party repositories.
