# История изменений образов {{ dataproc-full-name }}

Полный состав актуальных и устаревших образов {{ dataproc-name }} см. в разделе [{#T}](../concepts/environment.md).

## Образы 2.2.x (бета) {#2-2-x}

### 2.2.9 (бета) {#2-2-9}

* Apache Spark обновлен до версии 3.5.6.

### 2.2.8 (бета) {#2-2-8}

{% include [envvars-hadoop-heapsize](../../_includes/data-processing/envvars-hadoop-heapsize.md) %}

* Поддержан {{ oslogin }} для хостов кластера. Опция включает доступ через [{{ oslogin }}](../../organization/concepts/os-login.md) ко всем создаваемым хостам кластера.

### 2.2.7 (бета) {#2-2-7}

* Версия Java изменена на 11.

### 2.2.6 (бета) {#2-2-6}

* Исправлена ошибка с тем, что свойство `dataproc:nodemanager_available_memory_ratio` не влияло на долю памяти, резервируемую для YARN NodeManager.

### 2.2.5 (бета) {#2-2-5}

* Обновлены версии компонентов:

    * Hadoop — 3.3.2.
    * Spark — 3.5.0.

* Python обновлен до версии [3.11.10](https://docs.python.org/3.11/whatsnew/3.11.html#summary-release-highlights "Список изменений").

* Обновлены версии библиотек:

    * IPython — 8.22.0.
    * ipykernel — 6.29.5.
    * Matplotlib — 3.9.2.
    * pandas — 2.2.2.
    * PyArrow — 14.0.2.
    * scikit-learn — 1.5.1.

## Образы 2.1.x {#2-1-x}

### 2.1.21 {#2-1-21}

{% include [envvars-hadoop-heapsize](../../_includes/data-processing/envvars-hadoop-heapsize.md) %}

### 2.1.20 {#2-1-20}

* Поддержан {{ oslogin }} для хостов кластера. Опция включает доступ через [{{ oslogin }}](../../organization/concepts/os-login.md) ко всем создаваемым хостам кластера.

### 2.1.19 {#2-1-19}

* Исправлена ошибка с тем, что свойство `dataproc:nodemanager_available_memory_ratio` не влияло на долю памяти, резервируемую для YARN NodeManager.

### 2.1.18 {#2-1-18}

* Обновлена Conda, solver по умолчанию заменен на [Mamba](https://www.anaconda.com/blog/a-faster-conda-for-a-growing-community).
* Добавлено логирование при установке Conda-пакетов.
* Из логов запуска кластера удалены строки `[ERROR] can't parse line`.

### 2.1.17 {#2-1-17}

* По умолчанию включена публикация событий {{ resmgr-name }} в Job History Server.

### 2.1.16 {#2-1-16}

* Добавлена ротация логов Yarn TimelineServer.

### 2.1.15 {#2-1-15}

* Стабилизирована линейка образов 2.1.
* Реализовано удаление свойств из конфигурационных файлов при удалении их в конфигурации кластера.
* Обновлены версии компонентов:

    * Hadoop — 3.3.2.
    * Livy — 0.8.0.
    * Spark — 3.3.2.
    * Tez — 0.10.1.
    * Zeppelin — 0.10.1.

* Удалены устаревшие компоненты:

    * HBase
    * Hive
    * Zookeeper
    * Oozie

* Python обновлен до версии [3.8.13](https://docs.python.org/3.8/whatsnew/changelog.html#python-3-8-13-final "Список изменений").

* Обновлены версии библиотек:

    * IPython — 7.22.0.
    * ipykernel — 5.3.4.
    * Matplotlib — 3.4.2.
    * pandas — 1.2.4.
    * PyArrow — 14.0.2.
    * scikit-learn — 0.24.1.

## Образы 2.0.x {#2-0-x}

### 2.0.80 {#2-0-80}

{% include [envvars-hadoop-heapsize](../../_includes/data-processing/envvars-hadoop-heapsize.md) %}

### 2.0.79 {#2-0-79}

* Поддержан {{ oslogin }} для хостов кластера. Опция включает доступ через [{{ oslogin }}](../../organization/concepts/os-login.md) ко всем создаваемым хостам кластера.

### 2.0.78 {#2-0-78}

* Исправлена ошибка с тем, что свойство `dataproc:nodemanager_available_memory_ratio` не влияло на долю памяти, резервируемую для YARN NodeManager.

### 2.0.77 {#2-0-77}

* Добавлено логирование при установке Conda-пакетов.
* Из логов запуска кластера удалены строки `[ERROR] can't parse line`.

### 2.0.76 {#2-0-76}

* Добавлена ротация логов Yarn TimelineServer.

### 2.0.74 {#2-0-74}

* Реализовано удаление свойств из конфигурационных файлов при удалении их в конфигурации кластера.

### 2.0.69 {#2-0-69}

* Добавлены библиотеки `kafka-clients` и `commons-pool2`, необходимые для интеграции {{ SPRK }} и {{ KF }}.

### 2.0.66 {#2-0-66}

* Исправлена проблема с тем, что YARN NodeManager включался на новом хосте до выполнения скриптов инициализации.

### 2.0.64 {#2-0-64}

* Добавлена поддержка Helium.
* Исправлена проблема с излишней декомиссией.
* Запуск поставки логов в {{ cloud-logging-name }} осуществляется в самом начале запуска узла.

### 2.0.62 {#2-0-62}

* Устранена ошибка с отсутствием плагинов, используемых по умолчанию в Zeppelin.
* Исправлена проблема с некорректной обработкой ошибок в Hive-заданиях.

### 2.0.61 {#2-0-61}

* Внутренние изменения.

### 2.0.59 {#2-0-59}

* Поддержана работа сервисов Spark и MapReduce на однохостовом кластере.

### 2.0.58 {#2-0-58}

* Добавлена возможность сохранения пользовательских свойств интерпретатора Zeppelin при перезагрузке кластера. Свойства `spark.submit.deployMode`, `spark.driver.cores`, `spark.driver.memory`, `spark.executor.cores`, `spark.executor.memory`, `spark.files`, `spark.jars` и `spark.jars.packages` не сохраняются и переписываются из свойств Spark.

### 2.0.56 {#2-0-56}

* Оптимизированы запросы в сервис метаданных при взаимодействии с s3.

### 2.0.55 {#2-0-55}

* Улучшено логирование в скриптах инициализации.

### 2.0.54 {#2-0-54}

* Исправлены ошибки в конфигурации компонента TEZ.

### 2.0.53 {#2-0-53}

* Исправлена ошибка с конфигурацией cores/memory для Spark/Yarn при указании свойства кластера `spark:spark.submit.deployMode`.
* Исправлено обновление конфигурационного файла `spark-defaults.yaml` при обновлении свойств кластера.

### 2.0.52 {#2-0-52}

* На хосты добавлен скрипт ручного исправления статуса скриптов инициализации.

### 2.0.50 {#2-0-50}

* Результаты выполнения пользовательских сценариев теперь по умолчанию отправляются на `masternode`.

### 2.0.49 {#2-0-49}

* Устранена ошибка с игнорированием пользовательских настроек в Hive Metastore Server.

### 2.0.48 {#2-0-48}

* Добавлена возможность использования [Apache Spark Thrift Server](https://spark.apache.org/docs/latest/sql-distributed-sql-engine.html). Подробнее см. в разделе [{#T}](../concepts/settings-list.md#spark-thrift-server).
* Исправлена ошибка `YandexMetadataCredentialsProvider does not implement AWSCredentialsProvider`, которая могла появляться на легковесных конфигурациях Apache Spark.

### 2.0.47 {#2-0-47}

* Устранена утечка TCP-сессий с сервисом метаданных на высоконагруженных кластерах. Утечка могла приводить к ситуации, когда не обновлялся IAM-токен для авторизации в {{ objstorage-name }} и других сервисах.
* Исправлена ошибка, из-за которой могли не подгружаться таблицы из Hive Metastore: `YandexMetadataCredentialsProvider does not implement AWSCredentialsProvider`.

### 2.0.46 {#2-0-46}

* Часть свойств Spark теперь применяется также и в Zeppelin: `spark.submit.deployMode`, `spark.driver.cores`, `spark.driver.memory`, `spark.executor.cores`, `spark.executor.memory`, `spark.files`, `spark.jars` и `spark.jars.packages`.

### 2.0.45 {#2-0-45}

* Исправлена ошибка с MapReduce Application History Server не на хосте-мастере кластера.
* Разрешена конфигурация HIVE без YARN.
* Разрешен запуск HiveServer2 только вместе с MapReduce.

### 2.0.43 {#2-0-43}

* Унифицированы расчеты cores/memory для Spark/YARN.

### 2.0.42 {#2-0-42}

* Apache Spark обновлен до версии 3.0.3 и собран с профилем [hadoop-cloud](https://spark.apache.org/docs/3.0.3/cloud-integration.html) для использования [Magic Committer](https://hadoop.apache.org/docs/r3.2.3/hadoop-aws/tools/hadoop-aws/committers.html#Using_the_Magic_committer) и формата Parquet.
* Исправлена ошибка с игнорированием настроек `hive.metastore.uris` для Spark при использовании внешнего Hive metastore.

### 2.0.41 {#2-0-41}

* Для приложений Spark `hive-site.xml` добавлен в classpath.
* Исправлена ошибка с использованием системного Python вместо Conda-окружения при ручном запуске PySpark.

### 2.0.40 {#2-0-40}

* Исправлена ошибка с незапуском пользовательских сценариев.

### 2.0.39 {#2-0-39}

* Добавлена поддержка легковесных кластеров (без HDFS и подкластеров для хранения данных).

### 2.0.38 {#2-0-38}

* Образы адаптированы для работы в подсетях с заданной пользователем DNS-зоной.

### 2.0.37 {#2-0-37}

* CLI добавлен в `PATH` для скриптов инициализации.

### 2.0.36 {#2-0-36}

* CLI по умолчанию установлен на все хосты кластера.
* Для скриптов инициализации в переменные окружения добавлены значения: `CLUSTER_ID`, `S3_BUCKET`, `ROLE`, `CLUSTER_SERVICES`, `MIN_WORKER_COUNT`, `MAX_WORKER_COUNT`.

### 2.0.35 {#2-0-35}

* Добавлена поддержка скриптов инициализации для кластера.

### 2.0 {#2-0}

* Обновлены версии компонентов:

    * HBase — 2.2.7.
    * Hadoop — 3.2.2.
    * Hive — 3.1.2.
    * Livy — 0.8.0.
    * Oozie — 5.2.1.
    * Spark — 3.0.2.
    * Tez — 0.10.0.
    * Zeppelin — 0.9.0.

* Удалены устаревшие компоненты:

    * Flume
    * Sqoop

* Python обновлен до версии [3.8.10](https://docs.python.org/3.8/whatsnew/changelog.html#python-3-8-10-final "Список изменений").

* Обновлены версии библиотек:

    * IPython — 7.19.0.
    * ipykernel — 5.3.4.
    * Matplotlib — 3.2.2.
    * pandas — 1.1.3.
    * PyArrow — 1.0.1.
    * PyHive — 0.6.1.
    * scikit-learn — 0.23.2.

* Удалены библиотеки:

    * CatBoost
    * LightGBM
    * TensorFlow
    * XGBoost

## Образы 1.4.x {#1-4-x}

### 1.4.35 {#1-4-35}

* Образы адаптированы для работы в подсетях с заданной пользователем DNS-зоной.

### 1.4 {#1-4}

* Обновлены версии компонентов:

    * HBase — 1.3.5.
    * Hadoop — 2.10.0.
    * Hive — 2.3.6.
    * Flume — 1.9.0.
    * Livy — 0.7.0.
    * Oozie — 5.2.0.
    * Spark — 2.4.6.
    * Sqoop — 1.4.7.
    * Tez — 0.9.2.
    * Zeppelin — 0.8.2.
    * Zookeeper — 3.4.14.

* Python обновлен до версии [3.7.9](https://docs.python.org/3.7/whatsnew/changelog.html#python-3-7-9-final "Список изменений").

* Обновлены версии библиотек:

    * CatBoost — 0.20.2.
    * IPython — 7.9.0.
    * ipykernel — 5.1.3.
    * LightGBM — 2.3.0.
    * Matplotlib — 3.1.1.
    * pandas — 0.25.3.
    * PyArrow — 0.13.0.
    * PyHive — 0.6.1.
    * scikit-learn — 0.21.3.
    * TensorFlow— 1.15.0.
    * XGBoost — 0.90.
