# Ways to use Apache Spark™ clusters in {{ ml-platform-name }}

[{{ dataproc-full-name }}](../../data-proc/) allows you to deploy Apache Spark™ clusters. You can use {{ dataproc-name }} clusters to run distributed training.

## Cluster deployment options {#types}

To work with {{ dataproc-name }} clusters in {{ ml-platform-name }}, you can use the following:

* [Spark connector](data-processing-operations.md#spark-with-existing-cluster)
* [Livy session](data-processing-operations.md#livy-sessions)

If you have no existing {{ dataproc-name }} clusters or you need a cluster for a short time, use temporary {{ dataproc-name }} clusters. You can create them using the following:

* [Spark connector](temporary-data-processing-clusters.md#spark-with-temporary-cluster) (preferred)
* [{{ dataproc-name }} template](temporary-data-processing-clusters.md#template)

Regardless of the deployment option, all {{ dataproc-name }} clusters are charged based on the [{{ dataproc-name }} pricing policy](../../data-proc/pricing.md).

## Setting up a {{ ml-platform-name }} project to work with {{ dataproc-name }} clusters {#settings}

{% include [preferences](../../_includes/datasphere/settings-for-data-processing.md) %}

#### See also {#see-also}

* [{#T}](data-processing-template.md)
* [{#T}](../tutorials/data-processing-integration.md)
* [{#T}](spark-connector.md)
