---
title: "История изменений в {{ dataproc-full-name }}"
description: "В разделе представлена история изменений сервиса {{ dataproc-name }}."
---

# История изменений в {{ dataproc-full-name }}

{% include [Tags](../../_includes/mdb/release-notes-tags.md) %}

## Сентябрь 2024 {#sep-2024}

Кластеры {{ metastore-name }} стали частью сервиса {{ metadata-hub-full-name }}. Информацию о кластерах {{ metastore-name }} читайте в [документации {{ metadata-hub-name }}](../../metadata-hub/concepts/metastore.md).

## Апрель 2024 {#apr-2024}

Доступна стабильная линейка образов 2.1. В ее рамках можно создать кластер с более свежими версиями [Spark 3.3.2](https://spark.apache.org/releases/spark-release-3-3-2.html) и [Hadoop 3.3.2](https://hadoop.apache.org/docs/r3.3.2/hadoop-project-dist/hadoop-common/release/3.3.2/RELEASENOTES.3.3.2.html).

## II квартал 2023 {#q2-2023}

Доступно создание кластеров [{{ metastore-name }}](../../metadata-hub/concepts/metastore.md). Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md).

## III квартал 2022 {#q3-2022}

* Добавлена поддержка [новых настроек](https://github.com/apache/airflow/pull/25158) в Airflow-операторе `DataprocCreateClusterOperator`.
* Добавлены классы хостов `cpu-optimized` с соотношением количества гигабайт RAM к количеству vCPU 2 к 1. Новые конфигурации доступны только для платформы Intel Ice Lake.
* Опубликовано [руководство](../tutorials/geesefs-init-actions.md) по использованию скриптов инициализации для настройки GeeseFS.

## II квартал 2022 {#q2-2022}

* Доступна версия образа 2.1.
* Появилась возможность включить публичный доступ из интернета для всех видов подкластеров. {{ tag-con }} {{ tag-cli }} {{ tag-api }}
* Lightweight Spark стал доступен начиная с версии образа 2.0.39. Теперь можно создавать кластер без подкластеров для хранения данных, так как сервисы YARN и SPARK больше не зависят от HDFS.
* Добавлена поддержка [скриптов инициализации](../concepts/init-action.md) в CLI. {{ tag-cli }}

## I квартал 2022 {#q1-2022}

* Доступно создание кластеров на сетевых нереплицируемых дисках размером до 8 ТБ. Устройство нереплицируемых дисков существенно проще стандартных сетевых хранилищ SSD, благодаря чему их производительность выше в несколько раз.
* Добавлена возможность [отмены заданий](../operations/jobs-spark#cancel). {{ tag-con }} {{ tag-cli }}
* Добавлен номер сборки в версии [образов {{ dataproc-name }}](../concepts/environment.md).
* Добавлена возможность передачи параметров `packages`, `repositories` и `exclude_packages` для заданий Spark и PySpark. Использование этих параметров позволяет скачивать дополнительные зависимости и пакеты из внешних репозиториев. {{ tag-con }} {{ tag-cli }}
