# Working with Spark jobs

[Apache Spark](https://spark.apache.org/) is a distributed processing framework for unstructured and semi-structured data and a part of the Hadoop project ecosystem.

In this section, we provide a simple example that demonstrates how to use the Spark interface for Scala and Java in {{ dataproc-name }}. In the example, we use Spark to count the number of times each word appears in a short text.

## Getting started {#before-you-begin}

1. [Create a service account](../../../iam/operations/sa/create.md) with the `dataproc.agent` and `dataproc.provisioner` roles.

1. {% include [basic-before-buckets](../../../_includes/data-processing/tutorials/basic-before-buckets.md) %}

1. [Create a {{ dataproc-name }} cluster](../../../data-proc/operations/cluster-create.md) with the following settings:

    * **{{ ui-key.yacloud.mdb.forms.base_field_environment }}**: `PRODUCTION`.
    * **{{ ui-key.yacloud.mdb.forms.config_field_services }}**:
        * `HDFS`
        * `SPARK`
        * `YARN`
    * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}**: Select the service account you created earlier.
    * **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}**: Select a bucket for the processing results.

## Create a Spark job {#create-job}

1. {% include [sample-txt](../../../_includes/data-processing/tutorials/sample-txt.md) %}

1. Download the `spark-app_2.11-0.1.0-SNAPSHOT.jar` file containing the Scala code of the [word_count.scala](https://{{ s3-storage-host }}/examples/scala-spark/word_count.scala) analysis program and upload it to the input data bucket:

    {% cut "word_count.scala" %}

    ```scala
    package com.yandex.cloud.dataproc.scala

    import org.apache.spark.{SparkConf, SparkContext}


    object Main {
        def main(args: Array[String]) {
            if (args.length != 2){ // check number of args
                System.err.println("Usage spark-app.jar <input_directory> <output_directory>");
                System.exit(-1);
            }


            val inDir = args(0); //input URI
            val outDir = args(1); //output URI

            val conf = new SparkConf().setAppName("Word count - Scala App")
            val sc = new SparkContext(conf)

            val text_file = sc.textFile(inDir)
            val counts = text_file.flatMap(line => line.split(" "))
            .map(word => (word, 1))
            .reduceByKey(_ + _)

            val defaultFS = sc.hadoopConfiguration.get("fs.defaultFS")

            if (outDir.toLowerCase().startsWith("s3a://")) {
                counts.saveAsTextFile(outDir)
            } else {
                counts.saveAsTextFile(defaultFS + "/" + outDir)
            }

            sc.stop()
        }
    }
    ```

    {% endcut %}

    For more information about building an application written in Scala for Spark, see [{#T}](../../../data-proc/tutorials/run-spark-job.md#spark-submit).

1. [Create a Spark job](../../../data-proc/operations/jobs-spark#create) with the following parameters:

    * **{{ ui-key.yacloud.dataproc.jobs.field_main-jar }}**: `s3a://<input_data_bucket_name>/spark-app_2.11-0.1.0-SNAPSHOT.jar`
    * **{{ ui-key.yacloud.dataproc.jobs.field_main-class }}**: `com.yandex.cloud.dataproc.scala.Main`
    * **{{ ui-key.yacloud.dataproc.jobs.field_args }}**:
        * `s3a://<input_data_bucket_name>/text.txt`
        * `s3a://<output_bucket_name>/<output_directory>`

1. Wait for the [job status](../../../data-proc/operations/jobs-spark.md#get-info) to change to `Done`.

1. [Download](../../../storage/operations/objects/download.md) the files with the results from the bucket and review them:

    {% cut "part-00000" %}

    ```text
    (are,2)
    (am,2)
    (she,3)
    (so,1)
    ```

    {% endcut %}

    {% cut "part-00001" %}

    ```text
    (shore,3)
    (if,1)
    (that,2)
    (on,2)
    (shells,6)
    (I,2)
    (sure,2)
    (sea,6)
    (the,4)
    (sells,3)
    ```

    {% endcut %}

{% include [get-logs-info](../../../_includes/data-processing/note-info-get-logs.md) %}

## Delete the resources you created {#clear-out}

{% include [basic-clear-out](../../../_includes/data-processing/tutorials/basic-clear-out.md) %}
