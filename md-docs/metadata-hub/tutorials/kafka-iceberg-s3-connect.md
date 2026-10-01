[Документация Yandex Cloud](../../index.md) > [Yandex MetaData Hub](../index.md) > Apache Hive™ Metastore > Практические руководства > Передача данных из Managed Service for Apache Kafka® в таблицу Apache Iceberg™ с использованием Apache Hive™ Metastore

# Передача данных из топика Yandex Managed Service for Apache Kafka® в таблицу Apache Iceberg™ с использованием Apache Hive™ Metastore

# Передача данных из топика Yandex Managed Service for Apache Kafka® в таблицу Apache Iceberg™ в Yandex Object Storage

Вы можете настроить передачу данных из [топика Managed Service for Apache Kafka®](../../managed-kafka/concepts/topics.md#topics) в таблицу Apache Iceberg™. Схема и таблица создаются через [Yandex Managed Service for Trino](../../managed-trino/index.md). Данные хранятся в бакете [Object Storage](../../storage/index.md), а метаданные — в [Apache Hive™ Metastore](../concepts/metastore.md). В Managed Service for Apache Kafka® настраивается [коннектор Iceberg Sink](../../managed-kafka/concepts/connectors.md#iceberg-sink) для передачи данных из топика в таблицу.

Таблицу Apache Iceberg™ также можно создавать через [Yandex Managed Service for Apache Spark™](../../managed-spark/index.md) с помощью PySpark-задания. Подробнее в руководстве [Работа с таблицей формата Apache Iceberg™ из PySpark-задания](../../managed-spark/tutorials/spark-simple-rw-job.md).

Чтобы настроить передачу данных:

1. [Подготовьте инфраструктуру](#infra).
1. [Создайте таблицу Apache Iceberg™](#create-iceberg-table).
1. [Создайте коннектор и проверьте его работу](#connector-create).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for Apache Kafka®: использование выделенных хостам вычислительных ресурсов и объем хранилища ([тарифы Managed Service for Apache Kafka®](../../managed-kafka/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).
* Кластер Apache Hive™ Metastore: вычислительные ресурсы компонентов кластера ([тарифы Yandex MetaData Hub](../pricing.md)).
* Кластер Managed Service for Trino: вычислительные ресурсы компонентов кластера и объем исходящего трафика из Yandex Cloud в интернет ([тарифы Managed Service for Trino](../../managed-trino/pricing.md)).
* Бакет Object Storage: использование хранилища и выполнение операций с данными ([тарифы Object Storage](../../storage/pricing.md)).
* NAT-шлюз: почасовое использование шлюза и исходящий через него трафик ([тарифы Virtual Private Cloud](../../vpc/pricing.md)).


## Подготовьте инфраструктуру {#infra}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) `sa-metastore` и назначьте ему роли:

    * [storage.editor](../../storage/security/index.md#storage-editor) — для работы с бакетом Object Storage.
    * [managed-metastore.integrationProvider](../security/metastore-roles.md#managed-metastore-integrationProvider) — для [взаимодействия кластера Apache Hive™ Metastore с сервисами Yandex Cloud](../concepts/metastore-impersonation.md).

1. Создайте сервисный аккаунт `sa-trino` и назначьте ему роли:

    * [storage.editor](../../storage/security/index.md#storage-editor) — для работы с бакетом Object Storage.
    * [managed-trino.integrationProvider](../../managed-trino/security.md#managed-trino-integrationProvider) — для [взаимодействия кластера Managed Service for Trino с сервисами Yandex Cloud](../../managed-trino/concepts/impersonation.md).

1. [Создайте бакет](../../storage/operations/buckets/create.md) Object Storage.
1. [Создайте статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key) для сервисного аккаунта `sa-metastore`.

    Сохраните идентификатор ключа и секретный ключ, они понадобятся при [создании коннектора](#connector-create).

1. [Создайте облачную сеть](../../vpc/operations/network-create.md) с именем `demo-network`.

    Вместе с ней будут автоматически созданы три подсети в разных зонах доступности.

1. [Настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) для подсети `demo-network-ru-central1-a`.

    NAT-шлюз нужен для взаимодействия кластера Apache Hive™ Metastore с сервисами Yandex Cloud.

1. В сети `demo-network` [создайте группу безопасности](../../vpc/operations/security-group-create.md) `metastore-sg` для кластера Apache Hive™ Metastore и [добавьте в группу правила](../operations/metastore/configure-security-group.md), необходимые для работы кластера.

1. В сети `demo-network` создайте группу безопасности `mkf-sg` для кластера Managed Service for Apache Kafka® и добавьте в нее следующие правила:

    * Правило для входящего трафика, которое разрешает подключения к кластеру через интернет:

      * **Диапазон портов** — `9091`.
      * **Протокол** — `TCP`.
      * **Источник** — `Диапазон адресов`.
      * **IPv4 CIDR** — `0.0.0.0/0`.

    * Правило для исходящего трафика, которое разрешает доступ к Apache Hive™ Metastore:

      * **Диапазон портов** — `9083`.
      * **Протокол** — `TCP`.
      * **Назначение** — `Диапазон адресов`.
      * **IPv4 CIDR** — `0.0.0.0/0`.

1. [Создайте кластер Apache Hive™ Metastore](../operations/metastore/cluster-create.md) со следующими настройками:

    * **Сервисный аккаунт** — `sa-metastore`.
    * **Имя бакета** — имя созданного ранее бакета.
    * **Сеть** — `demo-network`.
    * **Подсеть** — `demo-network-ru-central1-a`.
    * **Группы безопасности** — `metastore-sg`.

1. [Создайте кластер Managed Service for Trino](../../managed-trino/operations/cluster-create.md) со следующими настройками:

    * **Сеть** — `demo-network`.
    * **Сервисный аккаунт** — `sa-trino`.
    * Параметры каталога:

      * **Имя каталога** — `iceberg`.
      * **Тип коннектора** — `Iceberg`.
      * **Тип Metastore** — `Hive Metastore`.
      * **URI** — `thrift://<IP-адрес_кластера_Metastore>:9083`.

        IP-адрес кластера Apache Hive™ Metastore можно получить с [информацией о кластере](../operations/metastore/cluster-list.md#get-cluster).

      * **Файловое хранилище** — `Yandex Object Storage`.

1. [Создайте кластер Managed Service for Apache Kafka®](../../managed-kafka/operations/cluster-create.md) со следующими настройками:

    * **Сеть** — `demo-network`.
    * **Группы безопасности** — `mkf-sg`.
    * **Публичный доступ** — включен.

      {% note info %}
      
      Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
      
      {% endnote %}

1. В кластере Managed Service for Apache Kafka® [создайте топики](../../managed-kafka/operations/cluster-topics.md#create-topic):

    * `iceberg_control_topic` — для управления коннектором;
    * `my_topic` — для обмена сообщениями.

1. В кластере Managed Service for Apache Kafka® [создайте пользователя](../../managed-kafka/operations/cluster-accounts.md#create-account) `kafka-producer` с ролью [производителя](../../managed-kafka/concepts/producers-consumers.md) и предоставьте ему доступ к топику `my_topic`.

    Этот пользователь используется для отправки сообщений в `my_topic`.


## Создайте таблицу Apache Iceberg™ {#create-iceberg-table}

1. [Подключитесь](../../managed-trino/operations/connect.md) к кластеру Managed Service for Trino.
1. Выполните SQL-запросы:

    1. Создайте схему:

        ```sql
        CREATE SCHEMA iceberg.myschema
        WITH (
          location = 's3a://<имя_бакета>/iceberg/warehouse/myschema'
        );
        ```

    1. Создайте таблицу:

        ```sql
        CREATE TABLE iceberg.myschema.mytable (
          id BIGINT,
          name VARCHAR,
          created_at VARCHAR
        )
        WITH (format = 'PARQUET');
        ```

1. Проверьте, что в бакете создана [структура каталогов](../../storage/operations/objects/list.md) `iceberg/warehouse/myschema/mytable-*/metadata/`, где `*` — системная часть имени таблицы.


## Создайте коннектор и проверьте его работу {#connector-create}

1. В Managed Service for Apache Kafka® [создайте коннектор](../../managed-kafka/operations/cluster-connector.md#create) типа `Iceberg Sink` со следующими параметрами:

    * **Топик управления** — `iceberg_control_topic`.
    * **Топики** — `my_topic`.
    * **Таблицы** — `myschema.mytable`.
    * **URI каталога** — `thrift://<IP-адрес_кластера_Metastore>:9083`.

      IP-адрес кластера Apache Hive™ Metastore можно получить с [информацией о кластере](../operations/metastore/cluster-list.md#get-cluster).

    * **Warehouse** — `s3a://<имя_бакета>/iceberg/warehouse`.
    * **Эндпоинт** — `storage.yandexcloud.net`.
    * **Идентификатор ключа доступа**, **Секретный ключ** — [полученные ранее](#infra) данные о статическом ключе.
    * **Интервал коммита, мс** — `5000` миллисекунд.
    * **Дополнительные свойства**:

      * `key.converter`: `org.apache.kafka.connect.json.JsonConverter`
      * `key.converter.schemas.enable`: `false`
      * `value.converter`: `org.apache.kafka.connect.json.JsonConverter`
      * `value.converter.schemas.enable`: `false`

1. Проверьте работу коннектора:

    1. [Установите SSL-сертификат](../../managed-kafka/operations/connect/index.md#get-ssl-cert).
    1. [Установите утилиту kcat (kafkacat)](../../managed-kafka/operations/connect/clients.md#bash-zsh).
    1. Отправьте сообщение в `my_topic`:

        ```bash
        echo '{"id":1,"name":"Alice","created_at":"2024-01-15T10:30:00"}' | kcat -P \
            -b <FQDN_брокера>:9091 \
            -t my_topic \
            -X security.protocol=SASL_SSL \
            -X sasl.mechanism=SCRAM-SHA-512 \
            -X sasl.username="kafka-producer" \
            -X sasl.password="<пароль>" \
            -X ssl.ca.location=/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
        ```

        Подробнее о получении FQDN хоста-брокера читайте в разделе [Получение FQDN хостов Apache Kafka®](../../managed-kafka/operations/connect/index.md#get-fqdn).

1. После коммита проверьте, что в каталоге бакета `iceberg/warehouse/myschema/mytable-*/` создан каталог `data` с данными в формате `PARQUET`.

    Чтобы посмотреть записанные данные, выполните SQL-запрос в Managed Service for Trino:

    ```sql
    SELECT * FROM iceberg.myschema.mytable;
    ```


## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Кластер Managed Service for Apache Kafka®](../../managed-kafka/operations/cluster-delete.md).
1. [Кластер Apache Hive™ Metastore](../operations/metastore/cluster-delete.md).
1. [Кластер Managed Service for Trino](../../managed-trino/operations/cluster-delete.md).
1. [Бакет Object Storage](../../storage/operations/buckets/delete.md). Перед удалением бакета [удалите из него все объекты](../../storage/operations/objects/delete.md).
1. [NAT-шлюз](../../vpc/operations/delete-nat-gateway.md).