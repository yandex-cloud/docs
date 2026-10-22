---
title: Интеграция {{ msp-full-name }} и {{ maf-full-name }}
description: На странице представлен список практических руководств о запуске PySpark-заданий в {{ msp-name }} с помощью {{ maf-name }} и работе с таблицами в {{ objstorage-name }} с использованием {{ metastore-name }}.
---

{% include [airflow-overview](../../_tutorials/dataplatform/spark/airflow-overview.md) %}

* [{#T}](airflow-spark-min.md) — простой пример для знакомства с интеграцией сервисов. Задание создает данные в памяти и выводит результат в лог. Бакет {{ objstorage-name }} хранит DAG-файл и скрипт задания.
* [{#T}](airflow-and-spark.md) — пример работы с таблицами, данные которых хранятся в {{ objstorage-name }}, а метаданные — в {{ metastore-name }}. В руководстве приведены варианты настройки инфраструктуры с разделением прав доступа и с упрощенной конфигурацией.
