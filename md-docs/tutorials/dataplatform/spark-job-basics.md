[Документация Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > [Построение Data Platform](index.md) > Работа с заданиями Yandex Data Processing > Работа с заданиями Spark

# Работа с заданиями Spark

[Apache Spark](https://spark.apache.org/) — это фреймворк для реализации распределенной обработки неструктурированных и слабоструктурированных данных, входящий в экосистему проектов Hadoop.

В этой статье на простом примере показывается, как в Yandex Data Processing использовать интерфейс Spark для языков Scala и Java. При помощи Spark в приведенном примере подсчитывается число случаев употребления каждого из слов, которые встречаются в коротком образце текста.

Чтобы выполнить задание Spark:

1. [Подготовьте инфраструктуру](#infra).
1. [Создайте задание Spark](#create-job).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

* Кластер Yandex Data Processing: использование вычислительных ресурсов с наценкой за сервис Yandex Data Processing, использование сетевых дисков, получение и хранение логов, объем исходящего трафика ([тарифы Yandex Data Processing](../../data-proc/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).
* Бакеты Yandex Object Storage: использование хранилища и выполнение операций с данными ([тарифы Object Storage](../../storage/pricing.md)).


## Подготовьте инфраструктуру {#infra}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролями `dataproc.agent` и `dataproc.provisioner`.

1. В Object Storage [создайте бакеты](../../storage/operations/buckets/create.md) и [настройте доступ](../../storage/operations/buckets/edit-acl.md) к ним:
   
   1. Создайте бакет для исходных данных и предоставьте сервисному аккаунту кластера разрешение `READ` для этого бакета.
   1. Создайте бакет для результатов обработки и предоставьте сервисному аккаунту кластера разрешение `READ и WRITE` для этого бакета.

1. [Создайте кластер Yandex Data Processing](../../data-proc/operations/cluster-create.md) со следующими настройками:

    * **Окружение** — `PRODUCTION`.
    * **Сервисы**:
        * `HDFS`
        * `SPARK`
        * `YARN`
    * **Сервисный аккаунт**: выберите созданный ранее сервисный аккаунт.
    * **Имя бакета**: выберите бакет для результатов обработки.

## Создайте задание Spark {#create-job}

1. Загрузите файл для обработки:
   
   1. Скопируйте и сохраните в файле `text.txt`:
   
       {% cut "text.txt" %}
   
       ```text
       she sells sea shells on the sea shore
       the shells that she sells are sea shells I am sure
       so if she sells sea shells on the sea shore
       I am sure that the shells are sea shore shells
       ```
   
       {% endcut %}
   
   1. [Загрузите](../../storage/operations/objects/upload.md) файл `text.txt` в бакет для исходных данных.

1. Скачайте и загрузите в бакет для исходных данных jar-файл `spark-app_2.11-0.1.0-SNAPSHOT.jar`, собранный из исходного текста программы анализа [word_count.scala](https://storage.yandexcloud.net/examples/scala-spark/word_count.scala) на языке Scala:

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

    Подробнее о том, как собрать приложение для Spark, написанное на языке Scala, смотрите в разделе [Использование Spark Submit](../../data-proc/tutorials/run-spark-job.md#spark-submit).

1. [Создайте задание Spark](../../data-proc/operations/jobs-spark.md#create) с параметрами:

    * **Основной JAR файл**: `s3a://<имя_бакета_для_исходных_данных>/spark-app_2.11-0.1.0-SNAPSHOT.jar`
    * **Основной класс**: `com.yandex.cloud.dataproc.scala.Main`
    * **Аргументы**:
        * `s3a://<имя_бакета_для_исходных_данных>/text.txt`
        * `s3a://<имя_бакета_для_результатов_обработки>/<папка_для_результатов>`

1. Подождите, пока [статус задания](../../data-proc/operations/jobs-spark.md#get-info) изменится на `Done`.

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

{% note info %}

Вы можете просматривать логи выполнения заданий и искать в них информацию с помощью сервиса [Yandex Cloud Logging](../../logging/index.md). Подробнее в разделе [Работа с логами](../../data-proc/operations/logging.md).

{% endnote %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите кластер](../../data-proc/operations/cluster-delete.md).
1. [Удалите бакеты](../../storage/operations/buckets/delete.md).
1. [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md).