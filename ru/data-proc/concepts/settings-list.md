---
title: "Свойства компонентов в {{ dataproc-full-name }}"
description: "Из статьи вы узнаете, какие свойства есть у компонентов кластера, как они хранятся, а также какие у них есть настройки."
---

# Свойства компонентов

Свойства компонентов кластера, заданий и среды окружения хранятся в формате:

```text
<ключ>:<значение>
```

Ключ может быть как простой строкой, так и содержать префикс, указывающий на принадлежность к [определенному компоненту](environment.md):

```text
<префикс_ключа>:<тело_ключа>:<значение>
```

Например:

```text
hdfs:dfs.replication : 2
hdfs:dfs.blocksize : 1073741824
spark:spark.driver.cores : 1
```

## Изменение свойств компонентов {#change-properties}

Изменить свойства компонентов можно:

* На уровне кластера при его [создании](../operations/cluster-create.md) или [изменении](../operations/cluster-update.md). Переданные таким образом свойства применяются по умолчанию ко всем новым заданиям в кластере.
* На уровне отдельного [задания](./jobs.md) при его [создании](../operations/jobs.md). Переданные таким образом свойства применяются только к данному заданию и переопределяют для него свойства, заданные на уровне кластера.

## Доступные свойства компонентов {#available-properties}

Доступные свойства перечислены в официальной документации компонентов:

| Префикс              | Путь к файлу конфигурации               | Документация                                                                                                                |
|:---------------------|:----------------------------------------|:----------------------------------------------------------------------------------------------------------------------------|
| `core`               | `/etc/hadoop/conf/core-site.xml`        | [Hadoop](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/core-default.xml)                         |
| `hdfs`               | `/etc/hadoop/conf/hdfs-site.xml`        | [HDFS](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-hdfs/hdfs-default.xml)                             |
| `yarn`               | `/etc/hadoop/conf/yarn-site.xml`        | [YARN](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-common/yarn-default.xml)                              |
| `mapreduce`          | `/etc/hadoop/conf/mapred-site.xml`      | [MapReduce](https://hadoop.apache.org/docs/current/hadoop-mapreduce-client/hadoop-mapreduce-client-core/mapred-default.xml) |
| `capacity-scheduler` | `/etc/hadoop/conf/capacity-scheduler.xml` | [CapacityScheduler](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/CapacityScheduler.html)             |
| `resource-type`      | `/etc/hadoop/conf/resource-types.xml`   | [ResourceTypes](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/ResourceModel.html)                     |
| `node-resources`     | `/etc/hadoop/conf/node-resources.xml`   | [NodeResources](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/ResourceModel.html)                     |
| `spark`              | `/etc/spark/conf/spark-defaults.xml`    | [Spark](https://spark.apache.org/docs/latest/configuration.html)                                                            |
| `hbase`              | `/etc/hbase/conf/hbase-site.xml`        | [HBASE](https://hbase.apache.org/book.html#config.files)                                                                    |
| `hbase-policy`       | `/etc/hbase/conf/hbase-policy.xml`      | [HBASE](https://hbase.apache.org/book.html#config.files)                                                                    |
| `hive`               | `/etc/hive/conf/hive-site.xml`          | [HIVE](https://cwiki.apache.org/confluence/display/Hive/Configuration+Properties)                                           |
| `hivemetastore`      | `/etc/hive/conf/hivemetastore-site.xml` | [HIVE Metastore](https://cwiki.apache.org/confluence/display/Hive/Configuration+Properties)                                 |
| `hiveserver2`        | `/etc/hive/conf/hiveserver2-site.xml`   | [HIVE Server2](https://cwiki.apache.org/confluence/display/Hive/Configuration+Properties)                                   |
| `tez`                | `/etc/tez/conf/tez-site.xml`            | [Tez 0.9.2](https://tez.apache.org/releases/0.9.2/tez-api-javadocs/configs/TezConfiguration.html) и [Tez 0.10.0](https://tez.apache.org/releases/0.10.0/tez-api-javadocs/configs/TezConfiguration.html) |
| `zeppelin`           | `/etc/zeppelin/conf/zeppelin-site.xml`  | [Zeppelin](https://zeppelin.apache.org/docs/0.9.0/setup/operation/configuration.html)                                       |

Настройки запуска заданий указаны в особых свойствах:

* `dataproc:version` — версия `dataproc-agent`, который выполняет задания, отсылает признак состояния кластера и проксирует UI. Используется для отладки. Значение по умолчанию — `latest`.
* `dataproc:max-concurrent-jobs` — количество одновременно запускаемых заданий. Значение по умолчанию — `auto` (рассчитывается исходя из свойств `min-free-memory-to-enqueue-new-job` и `job-memory-footprint`).
* `dataproc:min-free-memory-to-enqueue-new-job` — минимальное количество свободной памяти для запуска задания (в байтах). Значение по умолчанию — `1073741824` (1 ГБ).
* `dataproc:job-memory-footprint` — количество памяти для запуска задания на хосте-мастере кластера, используется для оценки максимального количества заданий в кластере. Значение по умолчанию — `536870912` (512 МБ).
* `dataproc:spark_executors_per_vm` — максимальное количество контейнеров на одном вычислительном хосте при выполнении [заданий Spark](./spark-sql.md). Значения по умолчанию:

    * `1` для [легковесных кластеров](./index.md#light-weight-clusters);
    * `2` для кластеров с HDFS.

* `dataproc:spark_driver_memory_fraction` — доля памяти вычислительного хоста, резервируемая для драйвера при выполнении [заданий Spark](./spark-sql.md). Значение по умолчанию — `0.25`.

## Настройки JVM для приложений Spark, выставляемые в {{ dataproc-name }} по умолчанию {#jvm-settings-for-spark}

Для улучшения производительности работы JVM в общем случае на кластерах {{ dataproc-name }} выставляются следующие настройки по умолчанию:

* **spark.driver.extraJavaOptions**:
    * `-XX:+UseConcMarkSweepGC`
    * `-XX:CMSInitiatingOccupancyFraction=70`
    * `-XX:MaxHeapFreeRatio=70`
    * `-XX:+CMSClassUnloadingEnabled`
    * `-XX:OnOutOfMemoryError='kill -9 %p'`
* **spark.executor.extraJavaOptions**:
    * `-verbose:gc`
    * `-XX:+PrintGCDetails`
    * `-XX:+PrintGCDateStamps`
    * `-XX:+UseConcMarkSweepGC`
    * `-XX:CMSInitiatingOccupancyFraction=70`
    * `-XX:MaxHeapFreeRatio=70`
    * `-XX:+CMSClassUnloadingEnabled`
    * `-XX:OnOutOfMemoryError='kill -9 %p'`

{% note info %}

Изменение свойств кластера `spark:spark.driver.defaultJavaOptions` или `spark:spark.executor.defaultJavaOptions` на значения, конфликтующие с настройками в `extraJavaOptions`, может приводить к ошибкам конфигурации кластера.

{% endnote %}

## Настройки Spark для работы с {{ objstorage-full-name }} {#spark-settings}

Для Apache Spark доступны следующие настройки:

| Настройка                         | Значение по умолчанию                                   | Описание                                                                           |
|:----------------------------------|:--------------------------------------------------------|:-----------------------------------------------------------------------------------|
| `fs.s3a.access.key`               | —                                                       | Идентификатор [статического ключа](../../iam/concepts/authorization/access-key.md) |
| `fs.s3a.secret.key`               | —                                                       | Секретный ключ                                                                     |
| `fs.s3a.endpoint`                 | `{{ s3-storage-host }}`                                 | Эндпоинт для подключения к {{ objstorage-name }}                                   |
| `fs.s3a.signing-algorithm`        | Пустое значение                                         | Алгоритм подписи                                                                   |
| `fs.s3a.aws.credentials.provider` | `org.apache.hadoop.fs.s3a.SimpleAWSCredentialsProvider` | Поставщик учетных данных                                                           |

Подробнее см. в [документации Apache Hadoop](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/core-default.xml).

## Установка пакетов Python {#python-packages-install}

Для установки дополнительных пакетов Python можно использовать пакетные менеджеры conda или pip. Передайте имя пакета в свойствах кластера следующим образом:

| Пакетный менеджер | Ключ                 | Значение                                                                                                                                                          | Пример                 |
|:------------------|:---------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------|
| conda             | `conda:<имя_пакета>` | Номер версии пакета согласно [спецификации conda](https://docs.conda.io/projects/conda/en/latest/user-guide/concepts/pkg-specs.html#package-match-specifications) | `conda:koalas : 1.5.0` |
| pip               | `pip:<имя_пакета>`   | Номер версии пакета согласно [спецификации pip](https://www.python.org/dev/peps/pep-0440/#version-specifiers)                                                     | `pip:requests : 2.31.0` |

## Использование Apache Spark Thrift Server {#spark-thrift-server}

Сервис [Apache Spark Thrift Server](https://spark.apache.org/docs/latest/sql-distributed-sql-engine.html) может использоваться как распределенный движок SQL-запросов поверх Apache Spark.

Чтобы включить его, задайте настройку `dataproc:hive.thrift.impl : spark` — сервер будет доступен на TCP-порте `10000`. По умолчанию задано значение `dataproc:hive.thrift.impl : hive` — на TCP-порте `10000` запускается Apache HiveServer2, если используется сервис Hive.


Функциональность доступна начиная [с версии образа 2.0.48](../release-notes/images.md#2.0.48).

