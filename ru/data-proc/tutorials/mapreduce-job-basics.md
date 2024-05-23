# Работа с заданиями MapReduce

{% include [MapReduce](../../_includes/data-proc/mapreduce-intro.md) %}

В этой статье на простом примере показывается, как в {{ dataproc-name }} использовать MapReduce. При помощи MapReduce подсчитывается количество жителей 500 самых населенных городов мира из набора данных о городах.

Чтобы запустить MapReduce на Hadoop, используется интерфейс Streaming. При этом для этапов предобработки данных (map) и вычисления финальных данных (reduce) используются программы, читающие из стандартного программного ввода (stdin) и выдающие результат в стандартный вывод (stdout).

## Перед началом работы {#before-you-begin}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролью `mdb.dataproc.agent`.

1. {% include [Создать бакеты и выдать SA кластера права на них](../../_includes/data-proc/tutorials/basic-before-buckets.md) %}

1. [Создайте кластер {{ dataproc-name }}](../operations/cluster-create.md) со следующими настройками:

    * **{{ ui-key.yacloud.mdb.forms.config_field_services }}**:
        * `HDFS`
        * `MAPREDUCE`
        * `YARN`
    * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}**: выберите созданный ранее сервисный аккаунт с ролью `mdb.dataproc.agent`.
    * **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}**: выберите бакет для результатов обработки.

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

1. [Создайте задание MapReduce](../operations/jobs-mapreduce.md#create) с параметрами:

    * **{{ ui-key.yacloud.dataproc.jobs.field_main-class }}**: `org.apache.hadoop.streaming.HadoopStreaming`
    * **{{ ui-key.yacloud.dataproc.jobs.field_args }}**:
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
    * **{{ ui-key.yacloud.dataproc.jobs.field_files }}**:
       * `s3a://<имя_бакета_для_исходных_данных>/mapper.py`
       * `s3a://<имя_бакета_для_исходных_данных>/reducer.py`        
    * **{{ ui-key.yacloud.dataproc.jobs.field_properties }}**:
       * `mapreduce.job.maps: 6`
       * `yarn.app.mapreduce.am.resource.mb: 2048`
       * `yarn.app.mapreduce.am.command-opts: -Xmx2048m`

1. Подождите, пока [статус задания](../operations/jobs-mapreduce.md#get-info) изменится на `Done`.

1. [Скачайте из бакета](../../storage/operations/objects/download.md) и просмотрите файл с результатом обработки:

    `part-00000`

    ```text
    3157107417
    ```
    
## Удалите созданные ресурсы {#clear-out}

{% include [Удаление кластера, бакетов и сервисного аккаунта](../../_includes/data-proc/tutorials/basic-clear-out.md) %}
