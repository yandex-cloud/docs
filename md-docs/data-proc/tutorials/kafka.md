# Работа с топиками Apache Kafka® с помощью PySpark-заданий в Yandex Data Processing

# Работа с топиками Apache Kafka® с помощью PySpark-заданий в Yandex Data Processing

Кластеры Yandex Data Processing поддерживают интеграцию с кластерами Managed Service for Apache Kafka®. Вы можете записывать сообщения в топики Apache Kafka® и читать сообщения из топиков с помощью [PySpark-заданий](../operations/jobs-pyspark.md). При чтении поддерживается пакетная обработка (batch processing) и потоковая обработка (stream processing).

Чтобы настроить интеграцию между кластерами Managed Service for Apache Kafka® и Yandex Data Processing:

1. [Подготовьте инфраструктуру](#infra).
1. [Создайте задания PySpark](#create-jobs).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for Apache Kafka®: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий ([тарифы Managed Service for Apache Kafka®](../../../managed-kafka/pricing.md)).
* Кластер Yandex Data Processing: использование вычислительных ресурсов с наценкой за сервис Yandex Data Processing, использование сетевых дисков, получение и хранение логов, объем исходящего трафика ([тарифы Yandex Data Processing](../../../data-proc/pricing.md)).
* NAT-шлюз: почасовое использование шлюза и исходящий через него трафик ([тарифы Yandex Virtual Private Cloud](../../../vpc/pricing.md)).
* Бакет Yandex Object Storage: использование хранилища и выполнение операций с данными ([тарифы Object Storage](../../../storage/pricing.md)).


## Подготовьте инфраструктуру {#infra}

{% list tabs group=instructions %}

* Вручную {#manual}

   1. [Создайте облачную сеть](../../vpc/operations/network-create.md) `dataproc-network` без подсетей.
   1. [Создайте подсеть](../../vpc/operations/subnet-create.md) `dataproc-subnet-b` в зоне доступности `ru-central1-b`.
   1. [Настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) для подсети `dataproc-subnet-b`.
   1. [Создайте группу безопасности](../../vpc/operations/security-group-create.md) `dataproc-security-group` в сети `dataproc-network`.
   1. [Настройте группу безопасности](../operations/cluster-create.md#change-security-groups).
   1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) `dataproc-sa` с ролями:

      * `storage.viewer`;
      * `storage.uploader`;
      * `dataproc.agent`;
      * `dataproc.user`.

   1. [Создайте бакет](../../storage/operations/buckets/create.md) с уникальным именем в рамках сервиса Object Storage.
   1. [Предоставьте сервисному аккаунту](../../storage/operations/buckets/edit-acl.md) `dataproc-sa` разрешение `FULL_CONTROL` на созданный бакет.
   1. [Создайте кластер Yandex Data Processing](../operations/cluster-create.md#create) с параметрами:

      * **Имя кластера** — `dataproc-cluster`.
      * **Окружение** — `PRODUCTION`.
      * **Версия** — `2.1`.
      * **Сервисы**:

         * `HDFS`
         * `LIVY`
         * `SPARK`
         * `TEZ`
         * `YARN`

      * **Сервисный аккаунт** — `dataproc-sa`.
      * **Зона доступности** — `ru-central1-b`.
      * **Имя бакета** — имя созданного бакета.
      * **Сеть** — `dataproc-network`.
      * **Группы безопасности** — `dataproc-security-group`.
      * **Подкластеры** — мастер, один подкластер `Data` и один подкластер `Compute`.

   1. [Создайте кластер Managed Service for Apache Kafka®](../../managed-kafka/operations/cluster-create.md#create-cluster) с параметрами:

      * **Имя кластера** — `dataproc-kafka`.
      * **Окружение** — `PRODUCTION`.
      * **Версия** — `3.5`.
      * **Зона доступности** — `ru-central1-b`.
      * **Сеть** — `dataproc-network`.
      * **Группы безопасности** — `dataproc-security-group`.
      * **Подсеть** — `dataproc-subnet-b`.

   1. [Создайте топик Apache Kafka®](../../managed-kafka/operations/cluster-topics.md#create-topic) с параметрами:

      * **Имя** — `dataproc-kafka-topic`.
      * **Количество разделов** — `1`.
      * **Фактор репликации** — `1`.

   1. [Создайте пользователя Apache Kafka®](../../managed-kafka/operations/cluster-accounts.md#create-user) с параметрами:

      * **Имя** — `user1`.
      * **Пароль** — `password1`.
      * **Топики, на которые выдаются разрешения пользователю** — `*` (все топики).
      * **Разрешения на топики** — `ACCESS_ROLE_CONSUMER`, `ACCESS_ROLE_PRODUCER` и `ACCESS_ROLE_ADMIN`.

* Terraform {#tf}

   1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
   1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
   1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.
   1. Скачайте в ту же рабочую директорию файл конфигурации [kafka-and-data-proc.tf](https://github.com/yandex-cloud-examples/yc-data-proc-spark-kafka/blob/main/kafka-and-data-proc.tf).

      В этом файле описаны:

      * [сеть](../../vpc/concepts/network.md#network);
      * [NAT-шлюз](../../vpc/concepts/gateways.md) и таблица маршрутизации, необходимые для работы Yandex Data Processing;
      * [подсеть](../../vpc/concepts/network.md#subnet);
      * [группа безопасности](../../vpc/concepts/security-groups.md), необходимая для кластеров Yandex Data Processing и Managed Service for Apache Kafka®;
      * [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), необходимый для работы кластера Yandex Data Processing;
      * сервисный аккаунт для управления бакетом Yandex Object Storage;
      * [бакет Yandex Object Storage](../../storage/concepts/bucket.md);
      * [статический ключ доступа](../../iam/concepts/authorization/access-key.md), необходимый для выдачи сервисному аккаунту нужных разрешений на бакет;
      * кластер Yandex Data Processing;
      * кластер Managed Service for Apache Kafka®;
      * пользователь Apache Kafka®;
      * топик Apache Kafka®.

   1. Укажите в файле `kafka-and-data-proc.tf`:

      * `folder_id` — идентификатор облачного каталога, такой же, как в настройках провайдера.
      * `dp_ssh_key` — абсолютный путь к публичному ключу для кластера Yandex Data Processing. [Подробнее о подключении к хосту Yandex Data Processing по SSH](../operations/connect-ssh.md).

   1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

      ```bash
      terraform validate
      ```

      Если в файлах конфигурации есть ошибки, Terraform на них укажет.

   1. Создайте необходимую инфраструктуру:

      1. Выполните команду для просмотра планируемых изменений:
      
         ```bash
         terraform plan
         ```
      
         Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
      
      1. Если вас устраивают планируемые изменения, внесите их:
         1. Выполните команду:
      
            ```bash
            terraform apply
            ```
      
         1. Подтвердите изменение ресурсов.
         1. Дождитесь завершения операции.

      В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

{% endlist %}

## Создайте задания PySpark {#create-jobs}

1. На локальном компьютере сохраните следующие скрипты:

   {% cut "`kafka-write.py`" %}

   Скрипт для записи сообщений в топик Apache Kafka®:

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

      df.write.format("text").save("s3a://<имя_созданного_бакета>/kafka-read-batch-output")

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

      df.write.format("text").save("s3a://<имя_созданного_бакета>/kafka-read-stream-output")

   if __name__ == "__main__":
      main()
   ```

   {% endcut %}

1. [Получите FQDN хоста Apache Kafka®](../../managed-kafka/operations/connect/index.md#get-fqdn) и укажите FQDN в каждом скрипте.
1. [Загрузите в корень бакета](../../storage/operations/objects/upload.md) подготовленные скрипты.
1. [Создайте задание PySpark](../operations/jobs-pyspark.md#create) для записи сообщения в топик Apache Kafka®. В поле **Main python файл** укажите путь до скрипта `s3a://<имя_созданного_бакета>/kafka-write.py`.
1. Дождитесь, когда [статус задания](../operations/jobs-pyspark.md#get-info) изменится на `Done`.
1. Убедитесь, что данные в топик были успешно записаны. Для этого создайте новое задание PySpark для чтения из топика и для пакетной обработки данных. В поле **Main python файл** укажите путь до скрипта `s3a://<имя_созданного_бакета>/kafka-read-batch.py`.
1. Дождитесь, когда статус нового задания изменится на `Done`.
1. [Скачайте из бакета](../../storage/operations/objects/download.md) файл с прочитанными данными:

   {% cut "part-00000" %}

   ```text
   {"msg":"Test message #1 from dataproc-cluster"}
   {"msg":"Test message #2 from dataproc-cluster"}
   ```

   {% endcut %}

   Файл хранится в новой папке `kafka-read-batch-output` в бакете.

1. Прочитайте сообщения из топика при потоковой обработке. Для этого создайте еще одно задание PySpark. В поле **Main python файл** укажите путь до скрипта `s3a://<имя_созданного_бакета>/kafka-read-stream.py`.
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

{% note info %}

Вы можете просматривать логи выполнения заданий и искать в них информацию с помощью сервиса [Yandex Cloud Logging](../../logging/index.md). Подробнее в разделе [Работа с логами](../operations/logging.md).

{% endnote %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите объекты](../../storage/operations/objects/delete.md) из бакета.
1. Остальные ресурсы удалите в зависимости от способа их создания:

    {% list tabs group=instructions %}

    * Вручную {#manual}

        1. [Кластер Yandex Data Processing](../operations/cluster-delete.md).
        1. [Кластер Managed Service for Apache Kafka®](../../managed-kafka/operations/cluster-delete.md).
        1. [Бакет](../../storage/operations/buckets/delete.md).
        1. [Группу безопасности](../../vpc/operations/security-group-delete.md).
        1. [Подсеть](../../vpc/operations/subnet-delete.md).
        1. [Таблицу маршрутизации](../../vpc/operations/delete-route-table.md).
        1. [NAT-шлюз](../../vpc/operations/delete-nat-gateway.md).
        1. [Сеть](../../vpc/operations/network-delete.md).
        1. [Сервисный аккаунт](../../iam/operations/sa/delete.md).

    * Terraform {#tf}

        1. В терминале перейдите в директорию с планом инфраструктуры.
        
            {% note warning %}
        
            Убедитесь, что в директории нет Terraform-манифестов с ресурсами, которые вы хотите сохранить. Terraform удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
        
            {% endnote %}
        
        1. Удалите ресурсы:
        
            1. Выполните команду:
        
                ```bash
                terraform destroy
                ```
        
            1. Подтвердите удаление ресурсов и дождитесь завершения операции.
        
            Все ресурсы, которые были описаны в Terraform-манифестах, будут удалены.

    {% endlist %}