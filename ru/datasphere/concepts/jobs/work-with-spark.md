---
title: Как работать с коннекторами Spark из {{ ds-jobs }}
description: Из этой статьи вы узнаете, как работать с коннекторами Spark из {{ ds-jobs }}.
---

# Работа с коннекторами Spark

Интеграция {{ ds-jobs }} с [{{ dataproc-full-name }}](../../../data-proc/) через [коннекторы Spark](../spark-connector.md) отличается от стандартной работы заданий. Кластеры {{ dataproc-name }} имеют строгие требования к окружению, поэтому для заданий есть ряд ограничений:

* Для заданий, использующих коннектор Spark, нельзя изменить Docker-образ. Попытка указать новый образ приведет к ошибке.
* [Python-окружение](environment.md) {{ ds-jobs }} должно соответствовать [окружению](../../../data-proc/concepts/environment.md#current-images) кластера {{ dataproc-name }}, версии Python и основных библиотек должны совпадать. Для работы с {{ dataproc-name }} из заданий предпочтительнее использовать [ручное задание](environment.md#manual).
* Для корректного исполнения задания могут потребоваться дополнительные пакеты. Список пакетов и их версии зависят от версии кластера {{ dataproc-name }}. Информация о дополнительных пакетах отражается в [логе](cli.md#logs) задания.
* Для подключения к кластеру {{ dataproc-name }} из задания необходимо использовать {{ ml-platform-name }} SDK из Python-пакета `datasphere`.

{% note warning %}

Задания не поддерживают работу с [временными кластерами](../temporary-data-processing-clusters.md).

{% endnote %}

## Настройка задания {#settings}

Для работы с коннекторами Spark необходимо добавить в [файл конфигурации](index.md#config) задания поле c идентификатором коннектора.

```yaml
spark:
  connector: <идентификатор_коннектора>
```

Убедитесь, что коннектор Spark [доступен](../../operations/data/spark-connectors.md#share) в проекте.

{% note warning %}

Для работы с коннекторами Spark в {{ ds-jobs }} требуется [{{ ds-cli }}](cli.md) версии `0.10.0` или выше.

{% endnote %}

## Подключение к кластеру {{ dataproc-name }} из кода задания {#connect}

Для подключения к кластеру {{ dataproc-name }} из задания используется {{ ml-platform-name }} SDK из Python-пакета `datasphere`. Укажите пакет `datasphere` в `requirements.txt` и подключитесь к кластеру в коде.

```python
from datasphere.sdk import SDK

sdk = SDK()

spark_wrapper = sdk.connect_to_spark()  # Конфигурирует и создает сессию подключения к кластеру {{ dataproc-name }}

spark_session = spark_wrapper.spark # Сессия Spark
spark_context = spark_wrapper.sc # Контекст Spark

# Далее можно использовать spark_session и spark_context так же, как при работе c pyspark
```

### Локальная отладка задания {#debug}

При работе с кластерами {{ dataproc-name }} в {{ ml-platform-name }} SDK предусмотрена возможность создания [локальной сессии PySpark](https://spark.apache.org/docs/latest/api/python/reference/pyspark.sql/api/pyspark.sql.SparkSession.builder.master.html) в момент вызова `sdk.connect_to_spark()`.

Для запуска локальной сессии создайте файл в директории задания с именем `.spark_local_config.json` (или укажите путь до файла через переменную окружения `JOB_DATAPROC_CONNECTION_CONFIG`) и укажите в нем следующие параметры:

```json
{
    "master_node_host": "localhost",
    "connection_mode": "SPARK_LOCAL", // Обязательно для локальной отладки
    "session_params": {} // Параметры сессии PySpark
}
```

### Пример задания с подключением к кластеру {{ dataproc-name }} {#example}

1. Создайте файл конфигурации задания `config.yaml`:

   ```yaml
   name: job-spark-connector-example
   cmd: python main.py
   env:
     python:
       type: manual
       version: 3.8
       requirements-file: requirements.txt
   spark:
     connector: <идентификатор_коннектора>
   ```

1. Создайте файл с параметрами окружения `requirements.txt`:

   ```python   
   datasphere==0.10.0
   ```

1. Создайте файл точки входа в задание `main.py`:

   ```python
   import random
   from datasphere.sdk import SDK
   
   sdk = SDK()
   
   spark_wrapper = sdk.connect_to_spark()
   spark_context = spark_wrapper.sc
   
   NUM_SAMPLES = 10_000_000
   
   def inside(*args, **kwargs):
       x, y = random.random(), random.random()
       return x * x + y * y < 1
   
   count = spark_context.parallelize(range(0, NUM_SAMPLES)).filter(inside).count()
   print("Pi:", 4.0 * count / NUM_SAMPLES)
   ```
