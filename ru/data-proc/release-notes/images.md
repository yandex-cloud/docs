# История изменений образов {{ dataproc-full-name }}

Полный состав актуальных и устаревших образов {{ dataproc-name }} см. в разделе [{#T}](../concepts/environment.md).

{% if product == "yandex-cloud" %}

## 2.0.45 {#2.0.45}

* Исправлена ошибка с MapReduce Application History Server не на мастер-хосте кластера.
* Разрешена конфигурация HIVE без YARN.
* Разрешен запуск HiveServer2 только вместе с MapReduce.

## 2.0.43 {#2.0.43}

* Унифицированы расчеты cores/memory для Spark/YARN.

## 2.0.42 {#2.0.42}

* Apache Spark обновлен до версии 3.0.3 и собран с профилем [hadoop-cloud](https://spark.apache.org/docs/3.0.3/cloud-integration.html) для использования [Magic Committer](https://hadoop.apache.org/docs/r3.2.3/hadoop-aws/tools/hadoop-aws/committers.html#Using_the_Magic_committer) и формата Parquet.
* Исправлена ошибка с игнорированием настроек `hive.metastore.uris` для Spark при использовании внешнего Hive metastore.

## 2.0.41 {#2.0.41}

* Для приложений Spark `hive-site.xml` добавлен в classpath.
* Исправлена ошибка с использованием системного Python вместо Conda-окружения при ручном запуске PySpark.

## 2.0.40 {#2.0.40}

* Исправлена ошибка с незапуском пользовательских сценариев.

## 2.0.39 {#2.0.39}

* Добавлена поддержка легковесных кластеров (без HDFS и подкластеров для хранения данных).

## 2.0.38 и 1.4.35 {#2.0.38-1.4.35}

* Образы адаптированы для работы в подсетях с заданной пользователем DNS-зоной.

## 2.0.37 {#2.0.37}

* YC CLI добавлен в `PATH` для скриптов инициализации.

## 2.0.36 {#2.0.36}

* YC CLI по умолчанию установлен на все хосты кластера.
* Для скриптов инициализации в переменные окружения добавлены значения: `CLUSTER_ID`, `S3_BUCKET`, `ROLE`, `CLUSTER_SERVICES`, `MIN_WORKER_COUNT`, `MAX_WORKER_COUNT`.

## 2.0.35 {#2.0.35}

* Добавлена поддержка скриптов инициализации для кластера.

## 2.0 {#2.0}

### Базовые компоненты {#base-2.0}

Обновлены версии компонентов:

* HBase — 2.2.7.
* Hadoop — 3.2.2.
* Hive — 3.1.2.
* Livy — 0.8.0.
* Oozie — 5.2.1.
* Spark — 3.0.2.
* Tez — 0.10.0.
* Zeppelin — 0.9.0.

Удалены устаревшие компоненты:

* Flume
* Sqoop

### Python и библиотеки машинного обучения {#python-ml-2.0}

Python обновлен до версии [3.8.10](https://docs.python.org/3.8/whatsnew/changelog.html#python-3-8-10-final "Список изменений").

Обновлены версии библиотек:

* IPython — 7.19.0.
* ipykernel — 5.3.4.
* Matplotlib — 3.2.2.
* pandas — 1.1.3.
* PyArrow — 1.0.1.
* PyHive — 0.6.1.
* scikit-learn — 0.23.2.

Удалены библиотеки:

* CatBoost
* LightGBM
* TensorFlow
* XGBoost

## 1.4 {#1.4}

### Базовые компоненты {#base-1.4}

Обновлены версии компонентов:

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

### Python и библиотеки машинного обучения {#python-ml-1.4}

Python обновлен до версии [3.7.9](https://docs.python.org/3.7/whatsnew/changelog.html#python-3-7-9-final "Список изменений").

Обновлены версии библиотек:

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

{% endif %}
