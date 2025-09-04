# Работа с топиками {{ KF }} с помощью PySpark-заданий в {{ dataproc-full-name }}

Кластеры {{ dataproc-name }} поддерживают интеграцию с кластерами {{ mkf-name }}. Вы можете записывать сообщения в топики {{ KF }} и читать сообщения из топиков с помощью [PySpark-заданий](../../../data-proc/operations/jobs-pyspark.md). При чтении поддерживается пакетная обработка (batch processing) и потоковая обработка (stream processing).

Чтобы настроить интеграцию между кластерами {{ mkf-name }} и {{ dataproc-name }}:

1. [Подготовьте инфраструктуру](#infra).
1. [Создайте задания PySpark](#create-jobs).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер {{ mkf-name }}: использование вычислительных ресурсов, выделенных хостам (в том числе хостам {{ ZK }}), и дискового пространства (см. [тарифы {{ KF }}](../../../managed-kafka/pricing.md)).
* Плата за кластер {{ dataproc-name }} (см. [тарифы {{ dataproc-name }}](../../../data-proc/pricing.md)).
* Плата за NAT-шлюз (см. [тарифы {{ vpc-name }}](../../../vpc/pricing.md)).
* Плата за бакет {{ objstorage-name }}: хранение данных и выполнение операций с ними (см. [тарифы {{ objstorage-name }}](../../../storage/pricing.md)).


## Подготовьте инфраструктуру {#infra}

{% list tabs group=instructions %}

* Вручную {#manual}

   1. [Создайте облачную сеть](../../../vpc/operations/network-create.md) `dataproc-network` без подсетей.
   1. [Создайте подсеть](../../../vpc/operations/subnet-create.md) `dataproc-subnet-b` в зоне доступности `{{ region-id }}-b`.
   1. [Настройте NAT-шлюз](../../../vpc/operations/create-nat-gateway.md) для подсети `dataproc-subnet-b`.
   1. [Создайте группу безопасности](../../../vpc/operations/security-group-create.md) `dataproc-security-group` в сети `dataproc-network`.
   1. [Настройте группу безопасности](../../../data-proc/operations/cluster-create.md#change-security-groups).
   1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) `dataproc-sa` с ролями:

      * `storage.viewer`;
      * `storage.uploader`;
      * `dataproc.agent`;
      * `dataproc.user`.

   1. [Создайте бакет](../../../storage/operations/buckets/create.md) `dataproc-bucket`.
   1. [Предоставьте сервисному аккаунту](../../../storage/operations/buckets/edit-acl.md) `dataproc-sa` разрешение `FULL_CONTROL` на бакет `dataproc-bucket`.
   1. [Создайте кластер {{ dataproc-name }}](../../../data-proc/operations/cluster-create.md#create) с параметрами:

      * **{{ ui-key.yacloud.mdb.forms.base_field_name }}** — `dataproc-cluster`.
      * **{{ ui-key.yacloud.mdb.forms.base_field_environment }}** — `PRODUCTION`.
      * **{{ ui-key.yacloud.mdb.forms.config_field_version }}** — `2.1`.
      * **{{ ui-key.yacloud.mdb.forms.config_field_services }}**:

         * `HDFS`
         * `LIVY`
         * `SPARK`
         * `TEZ`
         * `YARN`

      * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** — `dataproc-sa`.
      * **{{ ui-key.yacloud.mdb.forms.config_field_zone }}** — `{{ region-id }}-b`.
      * **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}** — `dataproc-bucket`.
      * **{{ ui-key.yacloud.mdb.forms.config_field_network }}** — `dataproc-network`.
      * **{{ ui-key.yacloud.mdb.forms.field_security-group }}** — `dataproc-security-group`.
      * **{{ ui-key.yacloud.mdb.forms.section_subclusters }}** — мастер, один подкластер `Data` и один подкластер `Compute`.

   1. [Создайте кластер {{ mkf-name }}](../../../managed-kafka/operations/cluster-create.md#create-cluster) с параметрами:

      * **{{ ui-key.yacloud.mdb.forms.base_field_name }}** — `dataproc-kafka`.
      * **{{ ui-key.yacloud.mdb.forms.base_field_environment }}** — `PRODUCTION`.
      * **{{ ui-key.yacloud.mdb.forms.base_field_version }}** — `3.5`.
      * **{{ ui-key.yacloud.mdb.forms.config_field_zone }}** — `{{ region-id }}-b`.
      * **{{ ui-key.yacloud.mdb.forms.config_field_network }}** — `dataproc-network`.
      * **{{ ui-key.yacloud.mdb.forms.field_security-group }}** — `dataproc-security-group`.
      * **Подсеть** — `dataproc-subnet-b`.

   1. [Создайте топик {{ KF }}](../../../managed-kafka/operations/cluster-topics.md#create-topic) с параметрами:

      * **Имя** — `dataproc-kafka-topic`.
      * **{{ ui-key.yacloud.kafka.label_partitions }}** — `1`.
      * **{{ ui-key.yacloud.kafka.label_replication-factor }}** — `1`.

   1. [Создайте пользователя {{ KF }}](../../../managed-kafka/operations/cluster-accounts.md#create-user) с параметрами:

      * **Имя** — `user1`.
      * **Пароль** — `password1`.
      * **Топики, на которые выдаются разрешения пользователю** — `*` (все топики).
      * **Разрешения на топики** — `ACCESS_ROLE_CONSUMER`, `ACCESS_ROLE_PRODUCER` и `ACCESS_ROLE_ADMIN`.

* {{ TF }} {#tf}

   1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
   1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
   1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}
   1. Скачайте в ту же рабочую директорию файл конфигурации [kafka-and-data-proc.tf](https://github.com/yandex-cloud-examples/yc-data-proc-spark-kafka/blob/main/kafka-and-data-proc.tf).

      В этом файле описаны:

      * [сеть](../../../vpc/concepts/network.md#network);
      * [NAT-шлюз](../../../vpc/concepts/gateways.md) и таблица маршрутизации, необходимые для работы {{ dataproc-name }};
      * [подсеть](../../../vpc/concepts/network.md#subnet);
      * [группа безопасности](../../../vpc/concepts/security-groups.md), необходимая для кластеров {{ dataproc-name }} и {{ mkf-name }};
      * [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), необходимый для работы кластера {{ dataproc-name }};
      * сервисный аккаунт для управления бакетом {{ objstorage-full-name }};
      * [бакет {{ objstorage-full-name }}](../../../storage/concepts/bucket.md);
      * [статический ключ доступа](../../../iam/concepts/authorization/access-key.md), необходимый для выдачи сервисному аккаунту нужных разрешений на бакет;
      * кластер {{ dataproc-name }};
      * кластер {{ mkf-name }};
      * пользователь {{ KF }};
      * топик {{ KF }}.

   1. Укажите в файле `kafka-and-data-proc.tf`:

      * `folder_id` — идентификатор облачного каталога, такой же, как в настройках провайдера.
      * `dp_ssh_key` — абсолютный путь к публичному ключу для кластера {{ dataproc-name }}. [Подробнее о подключении к хосту {{ dataproc-name }} по SSH](../../../data-proc/operations/connect-ssh.md).

   1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

      ```bash
      terraform validate
      ```

      Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

   1. Создайте необходимую инфраструктуру:

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Создайте задания PySpark {#create-jobs}

1. На локальном компьютере сохраните следующие скрипты:

   {% cut "`kafka-write.py`" %}

   Скрипт для записи сообщений в топик {{ KF }}:

   ```python
   #!/usr/bin/env python3

   from pyspark.sql import SparkSession, Row
   from pyspark.sql.functions import to_json, col, struct

   def main():
      spark = SparkSession.builder.appName("dataproc-kafka-write-app").getOrCreate()

      df = spark.createDataFrame([
         Row(msg="Test message #1 from dataproc-cluster"),
         Row(msg="Test message #2 from dataproc-cluster")
      ])
      df = df.select(to_json(struct([col(c).alias(c) for c in df.columns])).alias('value'))
      df.write.format("kafka") \
         .option("kafka.bootstrap.servers", "<FQDN_хоста>:9091") \
         .option("topic", "dataproc-kafka-topic") \
         .option("kafka.security.protocol", "SASL_SSL") \
         .option("kafka.sasl.mechanism", "SCRAM-SHA-512") \
         .option("kafka.sasl.jaas.config",
                 "org.apache.kafka.common.security.scram.ScramLoginModule required "
                 "username=user1 "
                 "password=password1 "
                 ";") \
         .save()

   if __name__ == "__main__":
      main()
   ```

   {% endcut %}

   {% cut "`kafka-read-batch.py`" %}

   Скрипт для чтения из топика и для пакетной обработки:

   ```python
   #!/usr/bin/env python3

   from pyspark.sql import SparkSession, Row
   from pyspark.sql.functions import to_json, col, struct

   def main():
      spark = SparkSession.builder.appName("dataproc-kafka-read-batch-app").getOrCreate()

      df = spark.read.format("kafka") \
         .option("kafka.bootstrap.servers", "<FQDN_хоста>:9091") \
         .option("subscribe", "dataproc-kafka-topic") \
         .option("kafka.security.protocol", "SASL_SSL") \
         .option("kafka.sasl.mechanism", "SCRAM-SHA-512") \
         .option("kafka.sasl.jaas.config",
                 "org.apache.kafka.common.security.scram.ScramLoginModule required "
                 "username=user1 "
                 "password=password1 "
                 ";") \
         .option("startingOffsets", "earliest") \
         .load() \
         .selectExpr("CAST(value AS STRING)") \
         .where(col("value").isNotNull())

      df.write.format("text").save("s3a://dataproc-bucket/kafka-read-batch-output")

   if __name__ == "__main__":
      main()
   ```

   {% endcut %}

   {% cut "`kafka-read-stream.py`" %}

   Скрипт для чтения из топика и для потоковой обработки:

   ```python
   #!/usr/bin/env python3

   from pyspark.sql import SparkSession, Row
   from pyspark.sql.functions import to_json, col, struct

   def main():
      spark = SparkSession.builder.appName("dataproc-kafka-read-stream-app").getOrCreate()

      query = spark.readStream.format("kafka")\
         .option("kafka.bootstrap.servers", "<FQDN_хоста>:9091") \
         .option("subscribe", "dataproc-kafka-topic") \
         .option("kafka.security.protocol", "SASL_SSL") \
         .option("kafka.sasl.mechanism", "SCRAM-SHA-512") \
         .option("kafka.sasl.jaas.config",
                 "org.apache.kafka.common.security.scram.ScramLoginModule required "
                 "username=user1 "
                 "password=password1 "
                 ";") \
         .option("startingOffsets", "earliest")\
         .load()\
         .selectExpr("CAST(value AS STRING)")\
         .where(col("value").isNotNull())\
         .writeStream\
         .trigger(once=True)\
         .queryName("received_messages")\
         .format("memory")\
         .start()

      query.awaitTermination()

      df = spark.sql("select value from received_messages")

      df.write.format("text").save("s3a://dataproc-bucket/kafka-read-stream-output")

   if __name__ == "__main__":
      main()
   ```

   {% endcut %}

1. [Получите FQDN хоста {{ KF }}](../../../managed-kafka/operations/connect/index.md#get-fqdn) и укажите FQDN в каждом скрипте.
1. [Загрузите в корень бакета](../../../storage/operations/objects/upload.md) подготовленные скрипты.
1. [Создайте задание PySpark](../../../data-proc/operations/jobs-pyspark.md#create) для записи сообщения в топик {{ KF }}. В поле **{{ ui-key.yacloud.dataproc.jobs.field_main-python-file }}** укажите путь до скрипта `s3a://dataproc-bucket/kafka-write.py`.
1. Дождитесь, когда [статус задания](../../../data-proc/operations/jobs-pyspark.md#get-info) изменится на `Done`.
1. Убедитесь, что данные в топик были успешно записаны. Для этого создайте новое задание PySpark для чтения из топика и для пакетной обработки данных. В поле **{{ ui-key.yacloud.dataproc.jobs.field_main-python-file }}** укажите путь до скрипта `s3a://dataproc-bucket/kafka-read-batch.py`.
1. Дождитесь, когда статус нового задания изменится на `Done`.
1. [Скачайте из бакета](../../../storage/operations/objects/download.md) файл с прочитанными данными:

   {% cut "part-00000" %}

   ```text
   {"msg":"Test message #1 from dataproc-cluster"}
   {"msg":"Test message #2 from dataproc-cluster"}
   ```

   {% endcut %}

   Файл хранится в новой папке `kafka-read-batch-output` в бакете.

1. Прочитайте сообщения из топика при потоковой обработке. Для этого создайте еще одно задание PySpark. В поле **{{ ui-key.yacloud.dataproc.jobs.field_main-python-file }}** укажите путь до скрипта `s3a://dataproc-bucket/kafka-read-stream.py`.
1. Дождитесь, когда статус нового задания изменится на `Done`.
1. Скачайте из бакета файлы с прочитанными данными:

   {% cut "part-00000" %}

   ```text
   {"msg":"Test message #1 from dataproc-cluster"}
   ```

   {% endcut %}

   {% cut "part-00001" %}

   ```text
   {"msg":"Test message #2 from dataproc-cluster"}
   ```

   {% endcut %}

   Файлы хранятся в новой папке `kafka-read-stream-output` в бакете.

{% include [get-logs-info](../../../_includes/data-processing/note-info-get-logs.md) %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

1. [Удалите объекты](../../../storage/operations/objects/delete.md) из бакета.
1. Остальные ресурсы удалите в зависимости от способа их создания:

    {% list tabs group=instructions %}

    * Вручную {#manual}

        1. [Кластер {{ dataproc-name }}](../../../data-proc/operations/cluster-delete.md).
        1. [Кластер {{ mkf-name }}](../../../managed-kafka/operations/cluster-delete.md).
        1. [Бакет](../../../storage/operations/buckets/delete.md).
        1. [Группу безопасности](../../../vpc/operations/security-group-delete.md).
        1. [Подсеть](../../../vpc/operations/subnet-delete.md).
        1. [Таблицу маршрутизации](../../../vpc/operations/delete-route-table.md).
        1. [NAT-шлюз](../../../vpc/operations/delete-nat-gateway.md).
        1. [Сеть](../../../vpc/operations/network-delete.md).
        1. [Сервисный аккаунт](../../../iam/operations/sa/delete.md).

    * {{ TF }} {#tf}

        {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}
