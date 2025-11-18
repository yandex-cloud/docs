---
title: Подключение к кластеру {{ SPRK }}
description: Следуя данной инструкции, вы сможете подключиться к кластеру {{ SPRK }}.
keywords:
  - Подключение к кластеру {{ SPRK }}
---

# Подключение к кластеру {{ SPRK }}

В этом разделе представлены настройки для подключения к кластеру {{ msp-full-name }} с помощью [Spark Connect](https://spark.apache.org/docs/3.5.6/spark-connect-overview.html).

## Подключение с помощью Spark Connect {#connection-spark-connect}

1. Создайте [IAM-токен](../../iam/concepts/authorization/iam-token.md) и сохраните его в переменной окружения:

   ```bash
   export TOKEN=$(yc iam create-token)
   ```

1. [Создайте задание SparkConnect](jobs-sparkconnect.md#create) без указания параметров в вашем кластере.
1. Скопируйте эндпоинт Spark Connect Server созданного задания для подключения.

   Эндпоинт можно получить с [информацией о задании](jobs-sparkconnect.md#get-info). Его значение указано в поле **{{ ui-key.yacloud.spark.label_connect-url }}** в консоли управления или в поле `connect_url` в CLI и API.

1. Установите пакет `pyspark` и [необходимые зависимости](https://spark.apache.org/docs/3.5.6/api/python/getting_started/install.html#dependencies) в вашем окружении с помощью менеджера пакетов [pip](https://pip.pypa.io/en/stable/).

   {% note info %}

   В настоящее время поддерживается подключение только с версией PySpark `3.5.6`.

   {% endnote %}

1. Выполните код для подключения к кластеру:

   ```python
   import os
   from pyspark.sql import SparkSession

   url_spark = "<эндпоинт_для_подключения_к_кластеру>"
   TOKEN = os.environ.get("TOKEN")

   spark = SparkSession.builder.remote(f"{url_spark}/;use_ssl=true;token={TOKEN}").getOrCreate()
   df = spark.createDataFrame([(1, "Sarah"), (2, "Maria")]).toDF(*["id", "name"])
   df.show()
   ```

   Результат:

   ```text
   +---+-----+
   | id| name|
   +---+-----+
   |  1|Sarah|
   |  2|Maria|
   +---+-----+
   ```
