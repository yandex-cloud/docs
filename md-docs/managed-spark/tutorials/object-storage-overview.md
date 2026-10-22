[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Apache Spark™](../index.md) > [Практические руководства](index.md) > Работа с данными в Object Storage > Обзор

# Работа с данными в Yandex Object Storage

# Работа с данными в Yandex Object Storage из Yandex Managed Service for Apache Spark™

С помощью PySpark-заданий в Yandex Managed Service for Apache Spark™ можно создавать, читать и изменять таблицы, данные которых хранятся в бакетах Yandex Object Storage. Выберите руководство в зависимости от способа хранения метаданных и формата таблицы:

* [Работа с Yandex Object Storage из PySpark-задания с использованием локального каталога Hive](spark-objstorage-integration.md) — пример работы с таблицей с использованием встроенного локального каталога Hive. Подходит, если метаданные нужны только одному кластеру Managed Service for Apache Spark™.
* [Интеграция с Apache Hive™ Metastore](metastore-and-spark.md) — пример подключения глобального каталога Apache Hive™ Metastore для централизованного хранения метаданных. Подходит, если к таблицам нужно обращаться из разных кластеров.
* [Работа с таблицей формата Apache Iceberg™ из PySpark-задания](spark-simple-rw-job.md) — пример создания таблицы формата Apache Iceberg™ и чтения ее текущего и предыдущего состояний. Для хранения метаданных используется кластер Apache Hive™ Metastore.