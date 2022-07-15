# Working with MapReduce jobs

[MapReduce](http://hadoop.apache.org/docs/current/hadoop-mapreduce-client/hadoop-mapreduce-client-core/MapReduceTutorial.html) is a parallel processing tool for large datasets (on the order of several dozen TB) on clusters in the Hadoop ecosystem. Enables the handling of data in different formats. Job input and output are stored in {{ objstorage-full-name }}.

In this article, a simple example demonstrates how MapReduce is used in {{ dataproc-name }}. Using MapReduce, we compute the population of the 500 largest cities in the world based on a set of data on the cities.

To run MapReduce on Hadoop, we use the Streaming interface. At the same time, the data preprocessing (map) and the final output computation (reduce) stages use programs that read from a standard program input (stdin) and write their output to a standard output (stdout).

## Before you start {#before-you-begin}

1. [Create a service account](../../iam/operations/sa/create.md) with the `mdb.dataproc.agent` role.

1. {% include [basic-before-buckets](../../_includes/data-proc/tutorials/basic-before-buckets.md) %}

1. [Create a {{ dataproc-name }} cluster](../operations/cluster-create.md) with the following configuration:

    * **Services**:
        * `HDFS`
        * `mapreduce`
        * `YARN`
    * **Service account**: Select the service account with the `mdb.dataproc.agent` role you created earlier.
    * **Bucket name**: Select a bucket to hold the processing output.

## Create a MapReduce job {#create-job}

1. For our input data, [download](http://download.geonames.org/export/dump/cities500.zip) and [upload to a bucket](../../storage/operations/objects/upload.md) an archived CSV file with a dataset on the cities.
1. Upload Python files to the input data bucket: `mapper.py`, which contains the code for data preprocessing (map stage), and `reducer.py`, which contains the code for the final output computations (reduce stage):

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

    * **Main class**: `org.apache.hadoop.streaming.HadoopStreaming`
    * **Job arguments**:
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
    * **Files**:
       * `s3a://<input data bucket name>/mapper.py`
       * `s3a://<input data bucket name>/reducer.py`
    * **Settings**:
       * `mapreduce.job.maps: 6`
       * `yarn.app.mapreduce.am.resource.mb: 2048`
       * `yarn.app.mapreduce.am.command-opts: -Xmx2048m`

1. Wait for the [job status](../operations/jobs-mapreduce.md#get-info) to change to `Done`.

1. [Download](../../storage/operations/objects/download.md) and view the file with the processing output:

    `part-00000`

    ```text
    3157107417
    ```

## Delete the resources you created {#clear-out}

{% include [basic-clear-out](../../_includes/data-proc/tutorials/basic-clear-out.md) %}
