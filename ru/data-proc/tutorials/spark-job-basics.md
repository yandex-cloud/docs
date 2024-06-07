# Работа с заданиями Spark

[Apache Spark](https://spark.apache.org/) — это фреймворк для реализации распределенной обработки неструктурированных и слабоструктурированных данных, входящий в экосистему проектов Hadoop.

В этой статье на простом примере показывается, как в {{ dataproc-name }} использовать интерфейс Spark для языков Scala и Java. При помощи Spark в приведенном примере подсчитывается число случаев употребления каждого из слов, которые встречаются в коротком образце текста.

## Перед началом работы {#before-you-begin}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролью `dataproc.agent`.

1. {% include [Создать бакеты и выдать SA права на них](../../_includes/data-proc/tutorials/basic-before-buckets.md) %}

1. [Создайте кластер {{ dataproc-name }}](../operations/cluster-create.md) со следующими настройками:

    * **{{ ui-key.yacloud.mdb.forms.config_field_services }}**:
        * `HDFS`
        * `SPARK`
        * `YARN`
    * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}**: выберите созданный ранее сервисный аккаунт с ролью `dataproc.agent`.
    * **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}**: выберите бакет для результатов обработки.

## Создайте задание Spark {#create-job}

1. {% include [Скачать и загрузить файл с текстовыми данными](../../_includes/data-proc/tutorials/sample-txt.md) %}

1. Скачайте и загрузите в бакет для исходных данных [jar-файл](https://{{ s3-storage-host }}/examples/scala-spark/jar/spark-app_2.11-0.1.0-SNAPSHOT.jar), собранный из исходного текста программы анализа [word_count.scala](https://{{ s3-storage-host }}/examples/scala-spark/word_count.scala) на языке Scala:

    {% cut "word_count.scala" %}

    ```scala
    package com.yandex.cloud.dataproc.scala

    import org.apache.spark.{SparkConf, SparkContext}


    object Main {
        def main(args: Array[String]) {
            if (args.length != 2){ // check number of args
                System.err.println("Usage spark-app.jar <входная_директория> <выходная_директория>");
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

    Подробнее о том, как собрать приложение для Spark, написанное на языке Scala, см. в разделе [{#T}](./run-spark-job.md#spark-submit).

1. [Создайте задание Spark](../operations/jobs-spark#create) с параметрами:

    * **{{ ui-key.yacloud.dataproc.jobs.field_main-jar }}**: `s3a://<имя_бакета_для_исходных_данных>/spark-app_2.11-0.1.0-SNAPSHOT.jar`
    * **{{ ui-key.yacloud.dataproc.jobs.field_main-class }}**: `com.yandex.cloud.dataproc.scala.Main`
    * **{{ ui-key.yacloud.dataproc.jobs.field_args }}**:
        * `s3a://<имя_бакета_для_исходных_данных>/text.txt`
        * `s3a://<имя_бакета_для_результатов_обработки>/<папка_для_результатов>`

1. Подождите, пока [статус задания](../operations/jobs-spark.md#get-info) изменится на `Done`.

1. [Скачайте из бакета](../../storage/operations/objects/download.md) и просмотрите файлы с результатами обработки:

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

{% include [get-logs-info](../../_includes/data-proc/note-info-get-logs.md) %}

## Удалите созданные ресурсы {#clear-out}

{% include [Удаление кластера, бакетов и сервисного аккаунта](../../_includes/data-proc/tutorials/basic-clear-out.md) %}
