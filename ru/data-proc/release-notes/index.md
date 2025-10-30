---
title: История изменений в {{ dataproc-full-name }}
description: В разделе представлена история изменений сервиса {{ dataproc-name }}.
---

# История изменений в {{ dataproc-full-name }}

## III квартал 2025 {#q3-2025}

В образе 2.2.9 (бета) {{ SPRK }} обновлен до версии 3.5.6.

## II квартал 2025 {#q2-2025}

* Добавлена опция {{ oslogin }} при создании кластера. Опция включает доступ через [{{ oslogin }}](../../organization/concepts/os-login.md) ко всем создаваемым хостам кластера.

{% include [envvars-hadoop-heapsize](../../_includes/data-processing/envvars-hadoop-heapsize.md) %}

## I квартал 2025 {#q1-2025}

В образах 2.2.X версия Java изменена на 11.

## IV квартал 2024 {#q4-2024}

* При создании или изменении кластера теперь можно выбрать [окружение](../concepts/environment.md#environment): `PRODUCTION` или `PRESTABLE`.
* В образах 2.2.X обновлен Python до версии 3.1.

## III квартал 2024 {#q3-2024}

* Кластеры {{ metastore-name }} стали частью сервиса {{ metadata-hub-full-name }}. Информацию о кластерах {{ metastore-name }} читайте в [документации {{ metadata-hub-name }}](../../metadata-hub/concepts/metastore.md).
* В образах 2.1.X и 2.2.X обновлена Conda, solver по умолчанию заменен на [Mamba](https://www.anaconda.com/blog/a-faster-conda-for-a-growing-community).

## II квартал 2024 {#q2-2024}

Доступна стабильная линейка образов 2.1. В ее рамках можно создать кластер с более свежими версиями [Spark 3.3.2](https://spark.apache.org/releases/spark-release-3-3-2.html) и [Hadoop 3.3.2](https://hadoop.apache.org/docs/r3.3.2/hadoop-project-dist/hadoop-common/release/3.3.2/RELEASENOTES.3.3.2.html).

## II квартал 2023 {#q2-2023}

Доступно создание кластеров [{{ metastore-name }}](../../metadata-hub/concepts/metastore.md). Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md).

## III квартал 2022 {#q3-2022}

* Добавлена поддержка [новых настроек](https://github.com/apache/airflow/pull/25158) в Airflow-операторе `DataprocCreateClusterOperator`.
* Добавлены классы хостов `cpu-optimized` с соотношением количества гигабайт RAM к количеству vCPU 2 к 1. Новые конфигурации доступны только для платформы Intel Ice Lake.
* Опубликовано [руководство](../tutorials/geesefs-init-actions.md) по использованию скриптов инициализации для настройки GeeseFS.

## II квартал 2022 {#q2-2022}

* Доступна версия образа 2.1.
* Появилась возможность включить публичный доступ из интернета для всех видов подкластеров.
* Lightweight Spark стал доступен начиная с версии образа 2.0.39. Теперь можно создавать кластер без подкластеров для хранения данных, так как сервисы YARN и SPARK больше не зависят от HDFS.
* Добавлена поддержка [скриптов инициализации](../concepts/init-action.md) в CLI.

## I квартал 2022 {#q1-2022}

* Доступно создание кластеров на сетевых нереплицируемых дисках размером до 8 ТБ. Устройство нереплицируемых дисков существенно проще стандартных сетевых хранилищ SSD, благодаря чему их производительность выше в несколько раз.
* Добавлена возможность [отмены заданий](../operations/jobs-spark.md#cancel).
* Добавлен номер сборки в версии [образов {{ dataproc-name }}](../concepts/environment.md).
* Добавлена возможность передачи параметров `packages`, `repositories` и `exclude_packages` для заданий Spark и PySpark. Использование этих параметров позволяет скачивать дополнительные зависимости и пакеты из внешних репозиториев.
