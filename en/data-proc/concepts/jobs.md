# Jobs in {{ dataproc-name }}

In a {{ dataproc-name }} cluster, you can create and run jobs. This allows you to regularly upload datasets from [{{ objstorage-name }} buckets](../../storage/concepts/bucket.md), use them in calculations, and generate analytics.

The following job types are supported:

* [Hive](https://cwiki.apache.org/confluence/display/HIVE#Home-HiveDocumentation)
* [MapReduce](https://hadoop.apache.org/docs/stable/hadoop-mapreduce-client/hadoop-mapreduce-client-core/MapReduceTutorial.html)
* [PySpark](https://spark.apache.org/docs/latest/api/python/index.html)
* [Spark](https://spark.apache.org/docs/latest/)

When creating a job, specify:

* _Arguments_: Values used by the job's main executable file.
* _Properties_: The <q>key:value</q> pairs that configure [image components](./environment.md).

To create and [start jobs](../operations/running-jobs.md), you can:

* Use the {{ yandex-cloud }} interfaces. For more information, see [basic examples](../tutorials/job-overview.md#jobs-basic-tutorials) for working with jobs.


* Connect directly to the cluster node. For more information, see the example in the [Running jobs from remote hosts that are not part of the cluster](../tutorials/remote-run-job.md) section.


To successfully run a job:

* Grant access to the required {{ objstorage-name }} buckets for the cluster service account.

   We recommend using at least two buckets:
   * One with read-only permissions for storing the source data and files required to run the job.
   * Another one with read and write permissions for storing job run results. Specify it when creating a cluster.

* When creating a job, provide all files required for it.

If there are enough computing resources in the cluster, the jobs you created will be running concurrently; otherwise, a job queue will be formed.


## Job logs {#logs}

Job logs are saved in {{ cloud-logging-full-name }}. For more information, see [{#T}](../operations/logging.md).
