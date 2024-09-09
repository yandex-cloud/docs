# Working with PySpark jobs

[Apache Spark](https://spark.apache.org/) is a distributed processing framework for unstructured and semi-structured data and a part of the Hadoop project ecosystem.

In this section, we provide a simple example that demonstrates how to use [PySpark](https://spark.apache.org/docs/latest/api/python/), the Spark interface for Python, in {{ dataproc-name }}. In the example, we use PySpark to count the number of times each word is seen in a short text.

## Getting started {#before-you-begin}

1. [Create a service account](../../iam/operations/sa/create.md) with the `dataproc.agent` and `dataproc.provisioner` roles.

1. {% include [Create buckets and configure SA access to them](../../_includes/data-proc/tutorials/basic-before-buckets.md) %}

1. [Create a {{ dataproc-name }} cluster](../operations/cluster-create.md) with the following settings:

   * **{{ ui-key.yacloud.mdb.forms.config_field_services }}**:
      * `HDFS`
      * `SPARK`
      * `YARN`
   * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}**: Select the service account you previously created.
   * **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}**: Select a bucket to hold the processing results.

## Create a PySpark job {#create-job}

1. {% include [Download and upload a sample file](../../_includes/data-proc/tutorials/sample-txt.md) %}

1. Download a file and upload it to the input data bucket containing the Python code for the [word_count.py](https://{{ s3-storage-host }}/examples/pyspark/word_count.py) analysis routine:

   {% cut "word_count.py" %}

   ```python
   import sys
   from pyspark import SparkConf, SparkContext


   def main():

       if len(sys.argv) != 3:
           print('Usage job.py <input_directory> <output_directory>')
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

   * **{{ ui-key.yacloud.dataproc.jobs.field_main-python-file }}**: `s3a://<input_data_bucket_name>/word_count.py`
   * **{{ ui-key.yacloud.dataproc.jobs.field_args }}**:

      * `s3a://<input_data_bucket_name>/text.txt`
      * `s3a://<processing_output_bucket_name>/<output_folder>`

1. Wait for the [job status](../operations/jobs-pyspark.md#get-info) to change to `Done`.

1. [Download from the bucket](../../storage/operations/objects/download.md) and review the files with the results from the bucket:

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

{% include [get-logs-info](../../_includes/data-proc/note-info-get-logs.md) %}

## Delete the resources you created {#clear-out}

{% include [Delete the cluster, buckets and the service account](../../_includes/data-proc/tutorials/basic-clear-out.md) %}
