# Свойства компонентов

При [создании кластера {{ dataproc-name }}](../operations/cluster-create.md) вы можете задать свойства компонентов кластера, заданий и среды окружения в формате:

```text
<ключ>:<значение>
```

Ключ может быть как простой строкой, так и содержать префикс, указывающий на принадлежность к [определенному компоненту](environment.md):

```text
<префикс ключа>:<тело ключа>:<значение>
```

Например:

```text
hdfs:dfs.replication : 2
hdfs:dfs.blocksize : 1073741824
spark:spark.driver.cores : 1
```

Доступные свойства перечислены в официальной документации компонентов:

| Префикс              | Путь к файлу конфигурации               | Документация                                                                                                                |
|:---------------------|:----------------------------------------|:----------------------------------------------------------------------------------------------------------------------------|
| `core`               | `/etc/hadoop/conf/core-site.xml`        | [Hadoop](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/core-default.xml)                         |
| `hdfs`               | `/etc/hadoop/conf/hdfs-site.xml`        | [HDFS](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-hdfs/hdfs-default.xml)                             |
| `yarn`               | `/etc/hadoop/conf/yarn-site.xml`        | [YARN](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-common/yarn-default.xml)                              |
| `mapreduce`          | `/etc/hadoop/conf/mapred-site.xml`      | [MapReduce](https://hadoop.apache.org/docs/current/hadoop-mapreduce-client/hadoop-mapreduce-client-core/mapred-default.xml) |
| `capacity-scheduler` | `/etc/hadoop/capacity-scheduler.xml`    | [CapacityScheduler](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/CapacityScheduler.html)             |
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

 Настройки запуска заданий указываются в особых свойствах:

 * `dataproc:version` — версия dataproc-agent, который выполняет задания, отсылает признак состояния кластера и проксирует UI. Используется для отладки. Значение по умолчанию — `latest`.
 * `dataproc:max-concurrent-jobs` — количество одновременно запускаемых заданий. Значение по умолчанию — `auto` (рассчитывается исходя из свойств `min-free-memory-to-enqueue-new-job` и `job-memory-footprint`).
 * `dataproc:min-free-memory-to-enqueue-new-job` — минимальное количество свободной памяти для запуска задания (в байтах). Значение по умолчанию — `1073741824` (1 ГБ).
 * `dataproc:job-memory-footprint` — количество памяти для запуска задания на управляющем хосте кластера, используется для оценки максимального количества заданий в кластере. Значение по умолчанию — `536870912` (512 МБ).

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
| conda             | `conda:<имя пакета>` | Номер версии пакета согласно [спецификации conda](https://docs.conda.io/projects/conda/en/latest/user-guide/concepts/pkg-specs.html#package-match-specifications) | `conda:koalas : 1.5.0` |
| pip               | `pip:<имя пакета>`   | Номер версии пакета согласно [спецификации pip](https://www.python.org/dev/peps/pep-0440/#version-specifiers)                                                     | `pip:psycopg2 : 2.7.0` |

## Использование Apache Spark Thrift Server {#spark-thrift-server}

Сервис [Apache Spark Thrift Server](https://spark.apache.org/docs/latest/sql-distributed-sql-engine.html) может использоваться как распределенный движок SQL-запросов поверх Apache Spark.

Чтобы включить его, задайте настройку `dataproc:hive.thrift.impl : spark` — сервер будет доступен на TCP-порте `10000`. По умолчанию задано значение `dataproc:hive.thrift.impl : hive` — на TCP-порте `10000` запускается Apache HiveServer2, если используется сервис Hive.


Функциональность доступна начиная [с версии образа 2.0.48](../release-notes/images.md#2.0.48).

