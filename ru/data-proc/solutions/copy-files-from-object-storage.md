---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Использование {{ objstorage-full-name }} в {{ dataproc-name }}

В этом разделе рассмотрены различные способы доступа к объектам из бакетов {{ objstorage-name }} для процессов, запущенных на кластерах {{ dataproc-name }}.

{% note info %}

Перед настройкой доступа к сервисам {{ yandex-cloud }} и интернет-ресурсам убедитесь, что сеть кластера [настроена правильно](./configure-network.md).

{% endnote %}


## DistCp {#distcp}

Для копирования файлов из {{objstorage-name}} в HDFS рекомендуется использовать утилиту [DistCp](https://hadoop.apache.org/docs/current/hadoop-distcp/DistCp.html), которая предназначена для копирования данных как внутри кластера, так и между кластерами и внешними хранилищами.

Для аутентификации в {{objstorage-name}} можно использовать два подхода:

1. Использовать [CredentialProvider](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/CredentialProviderAPI.html).
1. Передавать параметры `access key` и `secret key` при запуске задачи.

### Копирование с использованием CredentialProvider {#copying-via-credentialprovider}

Чтобы воспользоваться провайдером для хранения секретов, разместите эти секреты в компонентах, которым нужен доступ к {{objstorage-name}}. Для этого можно воспользоваться [JCEKS](https://docs.oracle.com/javase/8/docs/technotes/guides/security/crypto/CryptoSpec.html) (Java Cryptography Extension KeyStore): в примере вы создадите файл с секретами, который затем разместите в HDFS.

1. Укажите `access key` и `secret key`, например:

    ```bash
    hadoop credential create fs.s3a.access.key -value <access key> -provider localjceks://file/home/jack/yc.jceks
    hadoop credential create fs.s3a.secret.key -value <secret key> -provider localjceks://file/home/jack/yc.jceks
    ```
1. Перенесите файл секрета в локальный HDFS:

    ```bash
    hdfs dfs -put /home/jack/yc.jceks /user/root/
    ```

1. Скопируйте файл из {{objstorage-name}} непосредственно в HDFS:

    ```bash
    hadoop distcp \
           -D fs.s3a.bucket.dataproc-examples.endpoint=storage.yandexcloud.net \
           -D hadoop.security.credential.provider.path=jceks://hdfs/user/root/yc.jceks \
           -update \
           -skipcrccheck \
           -numListstatusThreads 10 \
           s3a://yc-mdb-examples/dataproc/example01/set01 \
           hdfs://<хост HDFS>/<путь>/
    ```

    `<хост HDFS>` — целевой сервер HDFS, который вы используете. Сервер по умолчанию можно получить с помощью команды:

    ```bash
    hdfs getconf -confKey fs.defaultFS
    ```

Пример команды копирования файлов из бакета:

```bash
hadoop distcp \
       -D fs.s3a.bucket.dataproc-examples.endpoint=storage.yandexcloud.net \
       -D hadoop.security.credential.provider.path=jceks://hdfs/user/root/yc.jceks \
       -update \
       -skipcrccheck \
       -numListstatusThreads 10 \
       s3a://yc-mdb-examples/dataproc/example01/set01 \
       hdfs://rc1b-dataproc-m-d31bs470ivkyrz60.mdb.yandexcloud.net/user/root/datasets/set01/
```

## Копирование файлов с передачей ключей в аргументах {#copying-files-by-passing-keys-in-arguments}

Вы можете не создавать файл секретов, а передавать ключи в аргументах команды:

```bash
hadoop distcp \
       -D fs.s3a.bucket.dataproc-examples.endpoint=storage.yandexcloud.net \
       -D fs.s3a.bucket.dataproc-examples.access.key=<access_key> \
       -D fs.s3a.bucket.dataproc-examples.secret.key=<secret_key> \
       -update \
       -skipcrccheck \
       -numListstatusThreads 10 \
       s3a://yc-mdb-examples/dataproc/example01/set01 \
       hdfs://rc1b-dataproc-m-d31bs470ivkyrz60.mdb.yandexcloud.net/user/root/datasets/set01/
```

## Использование s3fs {#s3fs}

`s3fs` позволяет монтировать бакеты {{objstorage-name}} посредством Fuse. Более подробно о ее использовании можно узнать на странице [s3fs](../../storage/tools/s3fs.md)

## Использование {{objstorage-name}} в Spark {#objstorage-spark}

{% list tabs %}

- Spark Shell

  Реализуйте нужный вариант доступа:

  * С использованием JCEKS:

    ```scala
    sc.hadoopConfiguration.set("fs.s3a.endpoint", "storage.yandexcloud.net");
    sc.hadoopConfiguration.set("hadoop.security.credential.provider.path", "jceks://hdfs/<путь к файлу JCEKS>");
    ```
  * По ключу доступа и секрету:

    ```scala
    sc.hadoopConfiguration.set("fs.s3a.endpoint", "storage.yandexcloud.net");
    sc.hadoopConfiguration.set("fs.s3a.access.key","<access key>>");
    sc.hadoopConfiguration.set("fs.s3a.secret.key","<secret_key>");
    ```

  После этого можно читать файл из {{objstorage-name}}:

  ```scala
  val sqlContext = new org.apache.spark.sql.SQLContext(sc)
  val df = sqlContext.read.parquet("s3a://<имя бакета>/<путь к объекту>")
  ```

- PySpark Shell

  Выберите способ доступа:

  * Доступ к объектам {{objstorage-name}} c использование JCEKS:

    ```python
    sc._jsc.hadoopConfiguration().set("fs.s3a.endpoint", "storage.yandexcloud.net")
    sc._jsc.hadoopConfiguration().set("hadoop.security.credential.provider.path", "jceks://hdfs/<путь к файлу JCEKS>")
    ```
  * Доступ по ключу доступа и секрету бакета:

    ```python
    sc._jsc.hadoopConfiguration().set("fs.s3a.endpoint", "storage.yandexcloud.net")
    sc._jsc.hadoopConfiguration().set("fs.s3a.access.key","<ключ доступа>>")
    sc._jsc.hadoopConfiguration().set("fs.s3a.secret.key","<секрет бакета>")
    ```

  Получив доступ, вы можете читать файл напрямую из {{objstorage-name}}:

  ```python
  sql = SQLContext(sc)
  df = sql.read.parquet("s3a://<bucket_name>/<path_to_file_or_directory>")
  ```

{% endlist%}
