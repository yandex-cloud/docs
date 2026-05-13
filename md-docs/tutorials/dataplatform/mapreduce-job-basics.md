# Работа с заданиями MapReduce

[MapReduce](http://hadoop.apache.org/docs/current/hadoop-mapreduce-client/hadoop-mapreduce-client-core/MapReduceTutorial.html) — инструмент параллельной обработки больших (порядка нескольких десятков ТБ) наборов данных на кластерах в экосистеме Hadoop. Позволяет работать с данными в разных форматах. Ввод и вывод задания хранится в Yandex Object Storage. MapReduce использует ряд библиотек, путь к которым определяется сборщиком [Apache Bigtop](https://github.com/apache/bigtop).

В этой статье на простом примере показывается, как в Yandex Data Processing использовать MapReduce. При помощи MapReduce подсчитывается количество жителей 500 самых населенных городов мира из набора данных о городах.

Чтобы запустить MapReduce на Hadoop, используется интерфейс Streaming. При этом для этапов предобработки данных (map) и вычисления финальных данных (reduce) используются программы, читающие из стандартного программного ввода (stdin) и выдающие результат в стандартный вывод (stdout).

## Перед началом работы {#before-you-begin}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролями `dataproc.agent` и `dataproc.provisioner`.

1. В Object Storage [создайте бакеты](../../storage/operations/buckets/create.md) и [настройте доступ](../../storage/operations/buckets/edit-acl.md) к ним:
   
   1. Создайте бакет для исходных данных и предоставьте сервисному аккаунту кластера разрешение `READ` для этого бакета.
   1. Создайте бакет для результатов обработки и предоставьте сервисному аккаунту кластера разрешение `READ и WRITE` для этого бакета.

1. [Создайте кластер Yandex Data Processing](../../data-proc/operations/cluster-create.md) со следующими настройками:

    * **Окружение** — `PRODUCTION`.
    * **Сервисы**:
        * `HDFS`
        * `MAPREDUCE`
        * `YARN`
    * **Сервисный аккаунт**: выберите созданный ранее сервисный аккаунт.
    * **Имя бакета**: выберите бакет для результатов обработки.

## Создайте задание MapReduce {#create-job}

1. [Скачайте](http://download.geonames.org/export/dump/cities500.zip) и [загрузите в бакет](../../storage/operations/objects/upload.md) для исходных данных архив CSV-файла с набором данных о городах.
1. Загрузите в бакет для исходных данных файлы на языке Python с кодом программ предобработки данных (этап map) `mapper.py` и вычисления финальных данных (этап reduce) `reducer.py`:

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

1. [Создайте задание MapReduce](../../data-proc/operations/jobs-mapreduce.md#create) с параметрами:

    * **Основной класс**: `org.apache.hadoop.streaming.HadoopStreaming`
    * **Аргументы**:
       * `-mapper`
       * `mapper.py`
       * `-reducer`
       * `reducer.py`
       * `-numReduceTasks`
       * `1`
       * `-input`
       * `s3a://<имя_бакета_для_исходных_данных>/cities500.txt`
       * `-output`
       * `s3a://<имя_бакета_для_результатов_обработки>/<папка_для_результатов>`
    * **Файлы**:
       * `s3a://<имя_бакета_для_исходных_данных>/mapper.py`
       * `s3a://<имя_бакета_для_исходных_данных>/reducer.py`
    * **Настройки**:
       * `mapreduce.job.maps: 6`
       * `yarn.app.mapreduce.am.resource.mb: 2048`
       * `yarn.app.mapreduce.am.command-opts: -Xmx2048m`

1. Подождите, пока [статус задания](../../data-proc/operations/jobs-mapreduce.md#get-info) изменится на `Done`.

1. [Скачайте из бакета](../../storage/operations/objects/download.md) и просмотрите файл с результатом обработки:

    `part-00000`

    ```text
    3157107417
    ```

{% note info %}

Вы можете просматривать логи выполнения заданий и искать в них информацию с помощью сервиса [Yandex Cloud Logging](../../logging/index.md). Подробнее см. в разделе [Работа с логами](../../data-proc/operations/logging.md).

{% endnote %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите кластер](../../data-proc/operations/cluster-delete.md).
1. [Удалите бакеты](../../storage/operations/buckets/delete.md).
1. [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md).