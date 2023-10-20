# Working with MapReduce jobs

{% include [MapReduce](../../_includes/data-proc/mapreduce-intro.md) %}

In this article, we use a simple example to show how MapReduce works in {{ dataproc-name }}. We will use MapReduce to compute the population of the world's 500 largest cities based on a set of data on the cities.

To run MapReduce on Hadoop, we use the Streaming interface. At the same time, the data preprocessing (map) and the final output computation (reduce) stages use programs that read data from a standard program input (`stdin`) and write their output to a standard output (`stdout`).

## Getting started {#before-you-begin}

1. [Create a service account](../../iam/operations/sa/create.md) with the `mdb.dataproc.agent` role.

1. {% include [basic-before-buckets](../../_includes/data-proc/tutorials/basic-before-buckets.md) %}

1. [Create a {{ dataproc-name }} cluster](../operations/cluster-create.md) with the following settings:

   * **{{ ui-key.yacloud.mdb.forms.config_field_services }}**:
      * `HDFS`
      * `MAPREDUCE`
      * `YARN`
   * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}**: Select the previously created service account with the `mdb.dataproc.agent` role.
   * **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}**: Select a bucket to hold the processing results.

## Create a MapReduce job {#create-job}

1. [Download](http://download.geonames.org/export/dump/cities500.zip) an archived CSV file with a dataset on the cities and [upload it to the input data bucket](../../storage/operations/objects/upload.md).
1. Upload Python files to the input data bucket: `mapper.py`, which contains the code for data preprocessing (map stage), and `reducer.py`, which contains the code for the final computations (reduce stage):

   `mapper.py`

   ```python
   #!/usr/bin/python
   import sys

   population = sum(int(line.split('\t')[14]) for line in sys.stdin)
   print(population)
   ```

   `reducer.py`

   ```python
   #!/usr/bin/python
   import sys

   population = sum(int(value) for value in sys.stdin)
   print(population)
   ```

1. [Create a MapReduce job](../operations/jobs-mapreduce.md#create) with the following parameters:

   * **{{ ui-key.yacloud.dataproc.jobs.field_main-class }}**: `org.apache.hadoop.streaming.HadoopStreaming`
   * **{{ ui-key.yacloud.dataproc.jobs.field_args }}**:
      * `-mapper`
      * `mapper.py`
      * `-reducer`
      * `reducer.py`
      * `-numReduceTasks`
      * `1`
      * `-input`
      * `s3a://<input data bucket name>/cities500.txt`
      * `-output`
      * `s3a://<output processing bucket name>/<output folder>`
   * **{{ ui-key.yacloud.dataproc.jobs.field_files }}**:
      * `s3a://<input data bucket name>/mapper.py`
      * `s3a://<input data bucket name>/reducer.py`
   * **{{ ui-key.yacloud.dataproc.jobs.field_properties }}**:
      * `mapreduce.job.maps: 6`
      * `yarn.app.mapreduce.am.resource.mb: 2048`
      * `yarn.app.mapreduce.am.command-opts: -Xmx2048m`

1. Wait for the [job status](../operations/jobs-mapreduce.md#get-info) to change to `Done`.

1. [Download from the bucket](../../storage/operations/objects/download.md) and review the file with the result from the bucket:

    `part-00000`

    ```text
    3157107417
    ```

## Delete the resources you created {#clear-out}

{% include [basic-clear-out](../../_includes/data-proc/tutorials/basic-clear-out.md) %}
