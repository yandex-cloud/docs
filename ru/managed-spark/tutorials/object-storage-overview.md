---
title: Работа с данными в {{ objstorage-name }} из {{ msp-full-name }}
description: На странице представлен список практических руководств о работе с таблицами в {{ objstorage-name }} из PySpark-заданий в {{ msp-name }} с использованием локального каталога Hive, {{ metastore-name }} и формата {{ IBRG }}.
canonical: '{{ link-docs }}/tutorials/dataplatform/spark-object-storage-overview'
noIndex: true
---

# Работа с данными в {{ objstorage-full-name }}

{% include notitle [object-storage-overview](../../_tutorials/dataplatform/spark/object-storage-overview.md) %}

* [{#T}](spark-objstorage-integration.md) — пример работы с таблицей с использованием встроенного локального каталога Hive. Подходит, если метаданные нужны только одному кластеру {{ msp-name }}.
* [{#T}](metastore-and-spark.md) — пример подключения глобального каталога {{ metastore-name }} для централизованного хранения метаданных. Подходит, если к таблицам нужно обращаться из разных кластеров.
* [{#T}](spark-simple-rw-job.md) — пример создания таблицы формата {{ IBRG }} и чтения ее текущего и предыдущего состояний. Для хранения метаданных используется кластер {{ metastore-name }}.
