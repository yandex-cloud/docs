# {{ dataproc-full-name }} releases

This section presents the revision history for {{ dataproc-name }}.

{% include [Tags](../../_includes/mdb/release-notes-tags.md) %}


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

