# {{ dataproc-full-name }} revision history

{% include [Tags](../../_includes/mdb/release-notes-tags.md) %}

## 01.06.2022 {#01.06.2022}

* Lightweight Spark is available starting with image version 2.0.39. You can now create a cluster without `DATANODE` hosts because YARN and SPARK services are no longer dependent on HDFS.

## 01.05.2022 {#01.05.2022}

* Added support for [initialization scripts](../concepts/init-action.md) in the CLI. {{ tag-cli }}

## 01.04.2022 {#01.04.2022}

* You can now create clusters on non-replicated network drives up to 8 TB. Non-replicated drives are much simpler than standard network SSD storage, which makes them perform several times faster.
* Added the ability to [cancel a job](operations/jobs-spark#cancel). {{ tag-con }} {{ tag-cli }}
* Added the build number in [image version {{ dataproc-name }}](../concepts/environment.md).
* Added the ability to pass the `packages`, `repositories`, and `exclude_packages` parameters for Spark and PySpark jobs. By using these parameters, you can download additional dependencies and packages from external repositories. {{ tag-con }} {{ tag-cli }}
