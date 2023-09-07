# Использование {{ objstorage-full-name }} в {{ dataproc-name }}

В этом разделе рассмотрены различные способы доступа к объектам из [бакетов](../../storage/concepts/bucket.md) {{ objstorage-name }} для процессов, запущенных на кластерах {{ dataproc-name }}.

{% note info %}

[Настройте сеть кластера](./configure-network.md) перед настройкой доступа к сервисам {{ yandex-cloud }} и интернет-ресурсам.

{% endnote %}

На скорость чтения и записи файлов в бакеты влияют настройки компонентов:

* Настройки, заданные при [создании](../operations/cluster-create.md) кластера, влияют на все запущенные в кластере задания.
* Настройки, заданные при создании заданий, переопределяют настройки уровня кластера и могут быть индивидуальными для каждого задания.

## DistCp {#distcp}

Для копирования файлов из {{ objstorage-name }} в HDFS используйте утилиту [DistCp](https://hadoop.apache.org/docs/current/hadoop-distcp/DistCp.html). Она предназначена для копирования данных как внутри кластера, так и между кластерами и внешними хранилищами.

Для аутентификации в {{ objstorage-name }} можно использовать один из подходов:

1. Использовать [IAM-токен сервисного аккаунта](../../iam/operations/iam-token/create-for-sa.md) кластера.
1. Использовать [CredentialProvider](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/CredentialProviderAPI.html).
1. Передавать параметры `access key` и `secret key` [статических ключей доступа](../../iam/concepts/authorization/access-key.md) при создании задачи.

### Доступ в S3 с аутентификацией через IAM-токен сервисного аккаунта кластера {#s3-access-using-iam}

1. При создании кластера укажите [сервисный аккаунт](../../iam/operations/sa/create.md#create-sa). Если кластер уже создан, добавьте сервисный аккаунт с помощью кнопки **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** в консоли управления.

1. У сервисного аккаунта должен быть доступ к нужному бакету. Для этого выдайте сервисному аккаунту права в [ACL бакета](../../storage/concepts/acl), либо роль `storage.viewer` или `storage.editor`.

    Подробнее про эти роли см. в [документации {{ objstorage-name }}](../../storage/security/index.md).

> Например, получите список файлов, находящихся в публичном бакете `yc-mdb-examples` по пути `dataproc/example01/set01`. Для этого [подключитесь](../operations/connect.md) к кластеру и выполните команду:
>
> ```bash
> hadoop fs -ls s3a://yc-mdb-examples/dataproc/example01/set01
> ```
>
> Результат:
> 
> ```text
> Found 12 items
> -rw-rw-rw-   1 root root   19327838 2019-09-13 17:17 s3a://yc-mdb-examples/dataproc/example01/set01/On_Time_Reporting_Carrier_On_Time_Performance_(1987_present)_2018_1.parquet
> -rw-rw-rw-   1 root root   21120204 2019-09-13 17:17 s3a://yc-mdb-examples/dataproc/example01/set01/On_Time_Reporting_Carrier_On_Time_Performance_(1987_present)_2018_10.parquet
> -rw-rw-rw-   1 root root   20227757 2019-09-13 17:17 s3a://yc-mdb-examples/dataproc/example01/set01/
> ...
> ```

### Копирование с использованием CredentialProvider {#copying-via-credentialprovider}

Чтобы воспользоваться провайдером для хранения секретов, разместите эти секреты в компонентах, которым нужен доступ к {{ objstorage-name }}. Для этого можно воспользоваться [JCEKS](https://docs.oracle.com/javase/8/docs/technotes/guides/security/crypto/CryptoSpec.html) (Java Cryptography Extension KeyStore). 
В примере вы создадите файл с секретами, который затем разместите в HDFS:

1. Укажите `access key` и `secret key`, например:

    ```bash
    hadoop credential create fs.s3a.access.key \
           -value <access key> \
           -provider localjceks://file/home/jack/yc.jceks && \
    hadoop credential create fs.s3a.secret.key \
           -value <secret key> \
           -provider localjceks://file/home/jack/yc.jceks
    ```

1. Перенесите файл секрета в локальный HDFS:

    ```bash
    hdfs dfs -put /home/jack/yc.jceks /user/root/
    ```

1. Скопируйте файл из {{ objstorage-name }} непосредственно в HDFS:

    ```bash
    hadoop distcp \
           -D fs.s3a.bucket.dataproc-examples.endpoint={{ s3-storage-host }} \
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
       -D fs.s3a.bucket.dataproc-examples.endpoint={{ s3-storage-host }} \
       -D hadoop.security.credential.provider.path=jceks://hdfs/user/root/yc.jceks \
       -update \
       -skipcrccheck \
       -numListstatusThreads 10 \
       s3a://yc-mdb-examples/dataproc/example01/set01 \
       hdfs://rc1b-dataproc-m-d31bs470ivkyrz60.{{ dns-zone }}/user/root/datasets/set01/
```

### Копирование файлов с передачей ключей в аргументах {#copying-files-by-passing-keys-in-arguments}

Вы можете не создавать файл секретов, а передавать ключи в аргументах команды:

```bash
hadoop distcp \
       -D fs.s3a.bucket.dataproc-examples.endpoint={{ s3-storage-host }} \
       -D fs.s3a.bucket.dataproc-examples.access.key=<access_key> \
       -D fs.s3a.bucket.dataproc-examples.secret.key=<secret_key> \
       -update \
       -skipcrccheck \
       -numListstatusThreads 10 \
       s3a://yc-mdb-examples/dataproc/example01/set01 \
       hdfs://rc1b-dataproc-m-d31bs470ivkyrz60.{{ dns-zone }}/user/root/datasets/set01/
```


## Оптимизация чтения файлов из {{ objstorage-name }} {#s3-read-optimize}

Способ чтения данных из бакета определяется [настройкой](https://hadoop.apache.org/docs/stable/hadoop-aws/tools/hadoop-aws/performance.html#Improving_data_input_performance_through_fadvise) `fs.s3a.experimental.input.fadvise`. Ее значение зависит от версии используемого образа:

* В образах версий `1.0`—`1.4` по умолчанию используется значение `sequential`. Оно подходит для операций последовательного чтения файлов, но для произвольного работает медленно. Если вы чаще используете произвольный доступ к файлам, добавьте в свойства компонентов кластера или укажите в настройках задания значение `random`.
* В образе версии `2.0` по умолчанию используется значение `normal`: работа с файлами происходит в последовательном режиме, но если приложение выполняет операции произвольного доступа, режим автоматически переключается на `random`.

Подробнее об используемых версиях компонентов см. в разделе [{#T}](../concepts/environment.md).


## Оптимизация записи файлов в {{ objstorage-name }} {#s3-write-optimize}

Чтобы увеличить скорость записи файлов в {{ objstorage-name }}, вы можете:

* [использовать коммиттеры S3A](#s3a-committers);
* [задать настройки Apache Hadoop](#s3-write-optimize-hadoop);
* [задать настройки Apache Spark](#s3-write-optimize-spark).

### Использование коммиттеров S3A {#s3a-committers}

Коммиттеры S3A — входящий в состав Apache Hadoop набор программных модулей для записи данных в объектное хранилище по [протоколу S3](../../glossary/s3.md), обеспечивающий эффективное и приближенное к атомарному подтверждение выполненных изменений. Подробнее см. в документации [Apache Hadoop](https://hadoop.apache.org/docs/stable/hadoop-aws/tools/hadoop-aws/committers.html) и [Apache Spark](https://spark.apache.org/docs/3.0.3/cloud-integration.html).

{% note info %}

Коммиттеры S3A не используются и не требуются для работы с таблицами, управляемыми средствами библиотеки [DeltaLake](https://delta.io), которая реализует собственную логику для работы с данными в объектном хранилище.

{% endnote %}

Есть три основных режима работы коммиттеров S3A:

| Режим         | Среда            | Необходим HDFS             | Запись в партиционированные</br>таблицы | Скорость записи |
|---------------|------------------|----------------------------|-------------------------------------|-----------------|
| `directory`   | MapReduce, Spark | Да^*^                      | Полная перезапись                   | Обычная         |
| `magic`       | MapReduce, Spark | Нет (запись напрямую в S3) | Не поддерживается                   | Максимальная    |
| `partitioned` | Spark            | Да^*^                      | Замена и дополнение партиций        | Обычная         |

^*^ В режимах `directory` и `partitioned` не производится проверка на фактическое наличие HDFS для хранения промежуточных данных. При этом часть заданий могут успешно отрабатывать без HDFS, однако в сложных заданиях могут возникнуть проблемы, проявляющиеся в виде ошибок «файл не найден» или неполной записи результатов задания в {{ objstorage-name }}.

Чтобы включить коммиттеры S3A, задайте значения следующих [настроек](../concepts/settings-list.md):

* `core:fs.s3a.committer.magic.enabled : true`, если задания будут использовать режим `magic`.
* `core:fs.s3a.committer.name` — используемый режим по умолчанию: `directory`, `magic` или `partitioned`.
* `core:fs.s3a.committer.staging.abort.pending.uploads : false` для Hadoop 3.2.2 в составе [образа {{ dataproc-name }}](../concepts/environment.md#current-images) версии 2.0 или `core:fs.s3a.committer.abort.pending.uploads : false` для Hadoop 3.3.2 в составе образа 2.1, если несколько параллельно работающих заданий выполняют запись в одну и ту же таблицу.
* `core:mapreduce.outputcommitter.factory.scheme.s3a : org.apache.hadoop.fs.s3a.commit.S3ACommitterFactory`.
* `spark:spark.hadoop.fs.s3a.committer.name` — используемый режим по умолчанию: `directory`, `magic` или `partitioned`.
* `spark:spark.sql.parquet.output.committer.class : org.apache.spark.internal.io.cloud.BindingParquetOutputCommitter`.
* `spark:spark.sql.sources.commitProtocolClass : org.apache.spark.internal.io.cloud.PathOutputCommitProtocol`.
* (опционально) `core:fs.s3a.committer.staging.conflict-mode` — действие при обнаружении в целевой таблице уже существующих партиций с данными (при использовании режима `partitioned`):
    * `append` — данные в существующей партиции дополняются новыми данными.
    * `fail` — при попытке перезаписи существующей партиции задание останавливается с ошибкой.
    * `replace` — данные в существующей партиции заменяются данными новой партиции.

Используемый режим работы коммиттеров S3A может переопределяться для конкретного задания путем установки настроек `fs.s3a.committer.name` и `spark.hadoop.fs.s3a.committer.name` в необходимое значение (`directory`, `magic` или `partitioned`).

Не следует менять значение по умолчанию для настройки `spark.hadoop.mapreduce.fileoutputcommitter.algorithm.version`, поскольку {{ objstorage-full-name }} не поддерживает атомарные переименования каталогов.

### Настройки Apache Hadoop {#s3-write-optimize-hadoop}


Способ записи данных в бакет {{ objstorage-name }} определяется настройкой `core:fs.s3a.fast.upload`. Ее значение зависит от версии используемого образа:

* В образах версий `1.0`—`1.4` по умолчанию используется значение `false` для экономии RAM. Укажите для этой настройки значение `true` в свойствах компонентов кластера или настройках задания. Это ускорит запись в бакет больших файлов и предотвратит переполнение хранилищ узлов.
* В образе версии `2.0` настройка `fs.s3a.fast.upload` включена по умолчанию.



При необходимости укажите значения [других настроек](https://hadoop.apache.org/docs/r2.10.0/hadoop-aws/tools/hadoop-aws/index.html), отвечающих за режим записи в {{ objstorage-name }}:

* `fs.s3a.committer.threads` — количество потоков, выполняющих фиксацию изменений в {{ objstorage-name }} в конце работы задания.
* `fs.s3a.connection.maximum` — количество разрешенных соединений с {{ objstorage-name }}.
* `fs.s3a.connection.timeout` — максимальное время ожидания соединения с {{ objstorage-name }} в миллисекундах.
* `fs.s3a.fast.upload.active.blocks` — максимальное количество блоков в одном потоке вывода.
* `fs.s3a.fast.upload.buffer` — тип буфера, используемого для временного хранения загружаемых данных:
    * `disk` — данные сохраняются в каталог, указанный в настройке `fs.s3a.buffer.dir`;
    * `array` — используются массивы в куче JVM;
    * `bytebuffer` — используется RAM вне кучи JVM.
* `fs.s3a.max.total.tasks` — размер очереди операций над бакетом {{ objstorage-name }}, которые не могут быть запущены из-за исчерпания рабочих потоков.
* `fs.s3a.multipart.size` — размер кусков (chunk) в байтах, на которые будут разбиты данные при копировании или выгрузке в бакет.
* `fs.s3a.threads.max` — количество рабочих потоков в менеджере загрузок (AWS Transfer Manager).

{% note info %}

Большие значения этих параметров могут привести к увеличению потребления вычислительных ресурсов на хостах кластера {{ dataproc-name }}.

{% endnote %}

Подробнее см. в [документации Apache Hadoop](https://hadoop.apache.org/docs/stable/hadoop-aws/tools/hadoop-aws/performance.html) и разделе [Свойства компонентов](../concepts/settings-list.md).

### Настройки Apache Spark {#s3-write-optimize-spark}

При доступе к данным в {{ objstorage-name }} из заданий Spark рекомендовано использовать значение `true` для настройки `spark.sql.hive.metastorePartitionPruning`.

При работе с данными в формате Parquet в заданиях Spark рекомендованы настройки:

* `spark.hadoop.parquet.enable.summary-metadata : false`
* `spark.sql.parquet.mergeSchema : false`
* `spark.sql.parquet.filterPushdown : true`

При работе с данными в формате Orc в заданиях Spark рекомендованы настройки:

* `spark.sql.orc.cache.stripe.details.size : 10000`
* `spark.sql.orc.filterPushdown : true`
* `spark.sql.orc.splits.include.file.footer : true`

Задания, создающие или обновляющие большое количество (сотни и тысячи) партиций в таблицах, могут тратить много времени на актуализацию записей о партициях в {{ metastore-full-name }}. Для ускорения этого процесса увеличьте значения следующих настроек:

* `hive:datanucleus.connectionPool.maxPoolSize` — максимальный размер пула соединений к БД {{ metastore-full-name }}.
* `hive:hive.metastore.fshandler.threads` — количество рабочих потоков, выполняющих фоновые операции с файловой системой в рамках сервиса {{ metastore-full-name }}.
* `spark:spark.sql.addPartitionInBatch.size` — количество партиций, актуализируемых за один вызов {{ metastore-full-name }}. Оптимальное значение — `10 × <значение настройки hive:hive.metastore.fshandler.threads>` или выше.

{% note info %}

Чрезмерно большие значения перечисленных параметров могут привести к исчерпанию системных ресурсов {{ metastore-full-name }}. Большой размер пула соединений к БД {{ metastore-full-name }} может потребовать изменения настроек и увеличения объема вычислительных ресурсов кластера.

{% endnote %}

Подробнее см. в [документации Apache Spark](https://spark.apache.org/docs/3.0.3/cloud-integration.html) и разделе [Свойства компонентов](../concepts/settings-list.md).

## Использование s3fs {#s3fs}

`s3fs` позволяет монтировать бакеты {{ objstorage-name }} посредством Fuse. Более подробно об использовании утилиты можно узнать на странице [s3fs](../../storage/tools/s3fs.md).

## Использование {{ objstorage-name }} в Spark {#objstorage-spark}

{% list tabs %}

- Spark Shell

  Реализуйте нужный вариант доступа:

  * С использованием JCEKS:

    ```scala
    sc.hadoopConfiguration.set("fs.s3a.endpoint", "{{ s3-storage-host }}");
    sc.hadoopConfiguration.set("fs.s3a.signing-algorithm", "");
    sc.hadoopConfiguration.set("fs.s3a.aws.credentials.provider", "org.apache.hadoop.fs.s3a.SimpleAWSCredentialsProvider");
    sc.hadoopConfiguration.set("hadoop.security.credential.provider.path", "jceks://hdfs/<путь к файлу JCEKS>");
    ```
  * По ключу доступа и секрету:

    ```scala
    sc.hadoopConfiguration.set("fs.s3a.endpoint", "{{ s3-storage-host }}");
    sc.hadoopConfiguration.set("fs.s3a.signing-algorithm", "");
    sc.hadoopConfiguration.set("fs.s3a.aws.credentials.provider", "org.apache.hadoop.fs.s3a.SimpleAWSCredentialsProvider");
    sc.hadoopConfiguration.set("fs.s3a.access.key","<ключ доступа>");
    sc.hadoopConfiguration.set("fs.s3a.secret.key","<секрет бакета>");
    ```

  После этого можно читать файл из {{ objstorage-name }}:

  ```scala
  val sqlContext = new org.apache.spark.sql.SQLContext(sc)
  val df = sqlContext.read.parquet("s3a://<имя бакета>/<путь к объекту>")
  ```

- PySpark Shell

  Выберите способ доступа:

  * Доступ к объектам {{ objstorage-name }} c использованием JCEKS:

    ```python
    sc._jsc.hadoopConfiguration().set("fs.s3a.endpoint", "{{ s3-storage-host }}")
    sc._jsc.hadoopConfiguration().set("fs.s3a.signing-algorithm", "")
    sc._jsc.hadoopConfiguration().set("fs.s3a.aws.credentials.provider", "org.apache.hadoop.fs.s3a.SimpleAWSCredentialsProvider")
    sc._jsc.hadoopConfiguration().set("hadoop.security.credential.provider.path", "jceks://hdfs/<путь к файлу JCEKS>")
    ```

  * Доступ по ключу доступа и секрету бакета:

    ```python
    sc._jsc.hadoopConfiguration().set("fs.s3a.endpoint", "{{ s3-storage-host }}")
    sc._jsc.hadoopConfiguration().set("fs.s3a.signing-algorithm", "")
    sc._jsc.hadoopConfiguration().set("fs.s3a.aws.credentials.provider", "org.apache.hadoop.fs.s3a.SimpleAWSCredentialsProvider")
    sc._jsc.hadoopConfiguration().set("fs.s3a.access.key","<ключ доступа>")
    sc._jsc.hadoopConfiguration().set("fs.s3a.secret.key","<секрет бакета>")
    ```

  Получив доступ, вы можете читать файл напрямую из {{ objstorage-name }}:

  ```python
  from pyspark.sql import SQLContext

  sql = SQLContext(sc)
  df = sql.read.parquet("s3a://<имя бакета>/<путь к объекту>")
  ```

{% endlist %}

Подробнее см. на странице [{#T}](../concepts/settings-list.md#spark-settings).
