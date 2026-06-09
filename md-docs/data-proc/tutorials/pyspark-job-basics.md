# Работа с заданиями PySpark

[Apache Spark](https://spark.apache.org/) — это фреймворк для реализации распределенной обработки неструктурированных и слабоструктурированных данных, входящий в экосистему проектов Hadoop.

В этой статье на простом примере показывается, как в {{ dataproc-name }} использовать [PySpark](https://spark.apache.org/docs/latest/api/python/) — интерфейс Spark для языка Python. При помощи PySpark в приведенном примере подсчитывается число случаев употребления каждого из слов, которые встречаются в коротком образце текста.

## Перед началом работы {#before-you-begin}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролями `dataproc.agent` и `dataproc.provisioner`.

1. В {{ objstorage-short-name }} [создайте бакеты](../../storage/operations/buckets/create.md) и [настройте доступ](../../storage/operations/buckets/edit-acl.md) к ним:
   
   1. Создайте бакет для исходных данных и предоставьте сервисному аккаунту кластера разрешение `READ` для этого бакета.
   1. Создайте бакет для результатов обработки и предоставьте сервисному аккаунту кластера разрешение `READ и WRITE` для этого бакета.

1. [Создайте кластер {{ dataproc-name }}](../operations/cluster-create.md) со следующими настройками:

    * **{{ ui-key.yacloud.mdb.forms.base_field_environment }}** — `PRODUCTION`.
    * **{{ ui-key.yacloud.mdb.forms.config_field_services }}**:
        * `HDFS`
        * `SPARK`
        * `YARN`
    * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}**: выберите созданный ранее сервисный аккаунт.
    * **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}**: выберите бакет для результатов обработки.

## Создайте задание PySpark {#create-job}

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

1. Загрузите файл с кодом программы анализа на языке Python:

    1. Скопируйте и сохраните в файле `word_count.py`:


        {% cut "word_count.py" %}

        ```python
        import sys
        from pyspark import SparkConf, SparkContext


        def main():

            if len(sys.argv) != 3:
                print('Usage job.py <входная_директория> <выходная_директория>')
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

    1. [Загрузите](../../storage/operations/objects/upload.md) файл `word_count.py` в бакет для исходных данных.

1. [Создайте задание PySpark](../operations/jobs-pyspark.md#create) с параметрами:

    * **{{ ui-key.yacloud.dataproc.jobs.field_main-python-file }}**: `s3a://<имя_бакета_для_исходных_данных>/word_count.py`
    * **{{ ui-key.yacloud.dataproc.jobs.field_args }}**:

        * `s3a://<имя_бакета_для_исходных_данных>/text.txt`
        * `s3a://<имя_бакета_для_результатов_обработки>/<папка_для_результатов>`

1. Подождите, пока [статус задания](../operations/jobs-pyspark.md#get-info) изменится на `Done`.

1. [Скачайте из бакета](../../storage/operations/objects/download.md) и просмотрите файлы с результатами обработки:

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

{% note info %}

Вы можете просматривать логи выполнения заданий и искать в них информацию с помощью сервиса [{{ cloud-logging-full-name }}](../../logging/index.md). Подробнее в разделе [{#T}](../operations/logging.md).

{% endnote %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите кластер](../operations/cluster-delete.md).
1. [Удалите бакеты](../../storage/operations/buckets/delete.md).
1. [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md).