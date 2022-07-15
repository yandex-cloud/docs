# Работа с заданиями MapReduce

[MapReduce](http://hadoop.apache.org/docs/current/hadoop-mapreduce-client/hadoop-mapreduce-client-core/MapReduceTutorial.html) — инструмент параллельной обработки больших (порядка нескольких десятков ТБ) наборов данных на кластерах в экосистеме Hadoop. Позволяет работать с данными в разных форматах. Ввод и вывод задания хранится в {{ objstorage-full-name }}.

В этой статье на простом примере показывается, как в {{ dataproc-name }} использовать MapReduce. При помощи MapReduce подсчитывается количество жителей 500 самых населенных городов мира из набора данных о городах.

Чтобы запустить MapReduce на Hadoop, используется интерфейс Streaming. При этом для этапов предобработки данных (map) и вычисления финальных данных (reduce) используются программы, читающие из стандартного программного ввода (stdin) и выдающие результат в стандартный вывод (stdout).

## Перед началом работы {#before-you-begin}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролью `mdb.dataproc.agent`.

1. {% include [Создать бакеты и выдать SA кластера права на них](../../_includes/data-proc/tutorials/basic-before-buckets.md) %}

1. [Создайте кластер {{ dataproc-name }}](../operations/cluster-create.md) со следующими настройками:

    * **Сервисы**:
        * `HDFS`
        * `MAPREDUCE`
        * `YARN`
    * **Сервисный аккаунт**: выберите созданный ранее сервисный аккаунт с ролью `mdb.dataproc.agent`.
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

1. [Создайте задание MapReduce](../operations/jobs-mapreduce.md#create) с параметрами:

    * **Основной класс**: `org.apache.hadoop.streaming.HadoopStreaming`
    * **Аргументы задания**:
       * `-mapper`
       * `mapper.py`
       * `-reducer`
       * `reducer.py`
       * `-numReduceTasks`
       * `1`
       * `-input`
       * `s3a://<имя бакета для исходных данных>/cities500.txt`
       * `-output`
       * `s3a://<имя бакета для результатов обработки>/<папка для результатов>`
    * **Файлы**:
       * `s3a://<имя бакета для исходных данных>/mapper.py`
       * `s3a://<имя бакета для исходных данных>/reducer.py`        
    * **Настройки**:
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
