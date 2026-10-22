[Документация Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > [Построение Data Platform](index.md) > Managed Service for Apache Spark™ > Работа с данными в Object Storage из Managed Service for Apache Spark™ > Обзор

# Работа с данными в Yandex Object Storage из Yandex Managed Service for Apache Spark™

С помощью PySpark-заданий в Yandex Managed Service for Apache Spark™ можно создавать, читать и изменять таблицы, данные которых хранятся в бакетах Yandex Object Storage. Выберите руководство в зависимости от способа хранения метаданных и формата таблицы:

* [Использование Yandex Object Storage в сервисе Yandex Managed Service for Apache Spark™](spark-objstorage-integration.md) — пример работы с таблицей с использованием встроенного локального каталога Hive. Подходит, если метаданные нужны только одному кластеру Managed Service for Apache Spark™.
* [Интеграция Yandex Managed Service for Apache Spark™ и Apache Hive™ Metastore](metastore-and-spark.md) — пример подключения глобального каталога Apache Hive™ Metastore для централизованного хранения метаданных. Подходит, если к таблицам нужно обращаться из разных кластеров.
* [Работа с таблицей формата Apache Iceberg™ в Yandex Managed Service for Apache Spark™](spark-simple-rw-job.md) — пример создания таблицы формата Apache Iceberg™ и чтения ее текущего и предыдущего состояний. Для хранения метаданных используется кластер Apache Hive™ Metastore.