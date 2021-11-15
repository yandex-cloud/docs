# Working with PySpark jobs

[Apache Spark](https://spark.apache.org/) is a distributed processing framework for unstructured and semi-structured data and a part of the Hadoop project ecosystem.

In this section, we provide a simple example that demonstrates how to use [PySpark](https://spark.apache.org/docs/latest/api/python/), the Spark interface for Python, in {{ dataproc-name }}. In the example, we use PySpark to count the number of times each word is seen in a short text.

## Before you start {#before-you-begin}

1. [Create a service account](../../iam/operations/sa/create.md) with the `mdb.dataproc.agent` role.

1. {% include [Create buckets and configure SA access to them](../../_includes/data-proc/solutions/basic-before-buckets.md) %}

1. [Create a {{ dataproc-name }} cluster](../operations/cluster-create.md) with the following configuration:
    * **Services**:
        * `HDFS`
        * `SPARK`
        * `YARN`
    * **Service account**: Select the service account with the `mdb.dataproc.agent` role you created earlier.
    * **Bucket name**: Select a bucket to hold the processing output.

## Create a PySpark job {#create-job}

1. {% include [Download and upload a sample file](../../_includes/data-proc/solutions/sample-txt.md) %}

1. Download a file and upload it to the input data bucket containing the Python code for the [word_count.py](https://storage.yandexcloud.net/examples/pyspark/word_count.py) analysis routine:

    {% cut "word_count.py" %}

    ```python
    import sys
    from pyspark import SparkConf, SparkContext
    
    
    def main():
    
        if len(sys.argv) != 3:
            print('Usage job.py <input_dir> <output_dir>')
            sys.exit(1)
    
        in_dir = sys.argv[1]
        out_dir = sys.argv[2]
    
        conf = SparkConf().setAppName("Word count - PySpark")
        sc = SparkContext(conf=conf)
    
        text_file = sc.textFile(in_dir)
        counts = text_file.flatMap(lambda line: line.split(" ")) \
            .map(lambda word: (word, 1)) \
            .reduceByKey(lambda a, b: a + b)
    
        if out_dir.startswith('s3a://'):
            counts.saveAsTextFile(out_dir) 
        else:
            default_fs = sc._jsc.hadoopConfiguration().get('fs.defaultFS')
            counts.saveAsTextFile(default_fs + out_dir)
    
    
    if __name__ == "__main__":
        main()
    ```

    {% endcut %}

1. [Create a PySpark job](../operations/jobs-pyspark#create) with the following parameters:

    * **Main python file**: `s3a://<input data bucket name>/word_count.py`

    * **Job arguments**:
        * `s3a://<input data bucket name>/text.txt`
        * `s3a://<output processing bucket name>/<output folder>`

1. Wait for the [job status](../operations/jobs-pyspark.md#get-info) to change to `Done`.

1. [Download](../../storage/operations/objects/download.md) and review the output files from the bucket:

    {% cut "part-00000" %}

    ```text
    ('sea', 6)
    ('are', 2)
    ('am', 2)
    ('sure', 2)
    ```

    {% endcut %}

    {% cut "part-00001" %}

    ```text
    ('she', 3)
    ('sells', 3)
    ('shells', 6)
    ('on', 2)
    ('the', 4)
    ('shore', 3)
    ('that', 2)
    ('I', 2)
    ('so', 1)
    ('if', 1)
    ```

    {% endcut %}

## Delete the resources you created {#clear-out}

{% include [Delete the cluster, buckets and the service account](../../_includes/data-proc/solutions/basic-clear-out.md) %}
