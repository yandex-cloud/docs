# Jobs in {{ dataproc-name }}

In a {{ dataproc-name }} cluster, you can create and execute jobs. This allows you to regularly upload a dataset from [{{ objstorage-name }} buckets](../../storage/concepts/bucket.md), use them in calculations, and generate {% if lang == "ru" and audience != "internal" %}[analytics](../../glossary/data-analytics.md){% else %}analytics{% endif %}.

The following job types are supported:

* [Hive](https://cwiki.apache.org/confluence/display/HIVE#Home-HiveDocumentation).
* [MapReduce](https://hadoop.apache.org/docs/stable/hadoop-mapreduce-client/hadoop-mapreduce-client-core/MapReduceTutorial.html).
* [PySpark](https://spark.apache.org/docs/latest/api/python/index.html).
* [Spark](https://spark.apache.org/docs/latest/).

When creating a job, specify:

* _Arguments_: Values used by the job's main executable file.
* _Properties_: The <q>key:value</q> pairs configuring [image components](./environment.md).

For placing and [starting a job](../operations/jobs.md):

* Use the {{ yandex-cloud }} interfaces. For more information, see [basic examples](../tutorials/job-overview.md#jobs-basic-tutorials) of working with jobs.

{% if audience == "draft" %}

* Connect directly to the cluster node. For more information, see [advanced examples](../tutorials/job-overview.md#jobs-advanced-tutorials) of working with jobs.

   We recommend using this method only for debugging jobs. Perform daily job management using {{ yandex-cloud }} interfaces.

{% else %}

* Connect directly to the cluster node. For more information, see the example in [{#T}](../tutorials/remote-run-job.md).

{% endif %}

For successful job execution:

* Grant access to the necessary {{ objstorage-name }} buckets for the cluster service account.

   It's recommended to use at least two buckets:
   * A bucket with read-only rights for storing source data and files necessary to run the job.
   * A bucket with read and write rights for storing job execution results. Specify it when creating a cluster.

* When creating a job, pass all the files necessary for its operation.

If there are enough computing resources in the cluster, several created jobs are executed in parallel. Otherwise, a job queue is formed.

{% if product == "yandex-cloud" %}

## Job logs {#logs}

Job logs are saved in {{ cloud-logging-full-name }}. For more information, see [{#T}](../operations/logging.md).

{% endif %}