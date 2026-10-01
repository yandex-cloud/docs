# Передача данных из топика {{ mkf-full-name }} в таблицу {{ IBRG }} в {{ objstorage-full-name }}

Вы можете настроить передачу данных из [топика {{ mkf-name }}](../../../managed-kafka/concepts/topics.md#topics) в таблицу {{ IBRG }}. Схема и таблица создаются через [{{ mtr-full-name }}](../../../managed-trino/index.yaml). Данные хранятся в бакете [{{ objstorage-name }}](../../../storage/index.yaml), а метаданные — в [{{ metastore-name }}](../../../metadata-hub/concepts/metastore.md). В {{ mkf-name }} настраивается [коннектор {{ ui-key.yacloud.kafka.label_connector_icebergsink }}](../../../managed-kafka/concepts/connectors.md#iceberg-sink) для передачи данных из топика в таблицу.

Таблицу {{ IBRG }} также можно создавать через [{{ msp-full-name }}](../../../managed-spark/index.yaml) с помощью PySpark-задания. Подробнее в руководстве [{#T}](../../../managed-spark/tutorials/spark-simple-rw-job.md).

Чтобы настроить передачу данных:

1. [Подготовьте инфраструктуру](#infra).
1. [Создайте таблицу {{ IBRG }}](#create-iceberg-table).
1. [Создайте коннектор и проверьте его работу](#connector-create).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

* Кластер {{ mkf-name }}: использование выделенных хостам вычислительных ресурсов и объем хранилища ([тарифы {{ mkf-name }}](../../../managed-kafka/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы {{ vpc-full-name }}](../../../vpc/pricing.md)).
* Кластер {{ metastore-name }}: вычислительные ресурсы компонентов кластера ([тарифы {{ metadata-hub-full-name }}](../../../metadata-hub/pricing.md)).
* Кластер {{ mtr-name }}: вычислительные ресурсы компонентов кластера и объем исходящего трафика из {{ yandex-cloud }} в интернет ([тарифы {{ mtr-name }}](../../../managed-trino/pricing.md)).
* Бакет {{ objstorage-name }}: использование хранилища и выполнение операций с данными ([тарифы {{ objstorage-name }}](../../../storage/pricing.md)).
* NAT-шлюз: почасовое использование шлюза и исходящий через него трафик ([тарифы {{ vpc-name }}](../../../vpc/pricing.md)).


## Подготовьте инфраструктуру {#infra}

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md#create-sa) `sa-metastore` и назначьте ему роли:

    * [storage.editor](../../../storage/security/index.md#storage-editor) — для работы с бакетом {{ objstorage-name }}.
    * [managed-metastore.integrationProvider](../../../metadata-hub/security/metastore-roles.md#managed-metastore-integrationProvider) — для [взаимодействия кластера {{ metastore-name }} с сервисами {{ yandex-cloud }}](../../../metadata-hub/concepts/metastore-impersonation.md).

1. Создайте сервисный аккаунт `sa-trino` и назначьте ему роли:

    * [storage.editor](../../../storage/security/index.md#storage-editor) — для работы с бакетом {{ objstorage-name }}.
    * [managed-trino.integrationProvider](../../../managed-trino/security.md#managed-trino-integrationProvider) — для [взаимодействия кластера {{ mtr-name }} с сервисами {{ yandex-cloud }}](../../../managed-trino/concepts/impersonation.md).

1. [Создайте бакет](../../../storage/operations/buckets/create.md) {{ objstorage-name }}.
1. [Создайте статический ключ доступа](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) для сервисного аккаунта `sa-metastore`.

    Сохраните идентификатор ключа и секретный ключ, они понадобятся при [создании коннектора](#connector-create).

1. [Создайте облачную сеть](../../../vpc/operations/network-create.md) с именем `demo-network`.

    Вместе с ней будут автоматически созданы три подсети в разных зонах доступности.

1. [Настройте NAT-шлюз](../../../vpc/operations/create-nat-gateway.md) для подсети `demo-network-{{ region-id }}-a`.

    NAT-шлюз нужен для взаимодействия кластера {{ metastore-name }} с сервисами {{ yandex-cloud }}.

1. В сети `demo-network` [создайте группу безопасности](../../../vpc/operations/security-group-create.md) `metastore-sg` для кластера {{ metastore-name }} и [добавьте в группу правила](../../../metadata-hub/operations/metastore/configure-security-group.md), необходимые для работы кластера.

1. В сети `demo-network` создайте группу безопасности `mkf-sg` для кластера {{ mkf-name }} и добавьте в нее следующие правила:

    * Правило для входящего трафика, которое разрешает подключения к кластеру через интернет:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-mkf-ssl }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

    * Правило для исходящего трафика, которое разрешает доступ к {{ metastore-name }}:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-metastore }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

1. [Создайте кластер {{ metastore-name }}](../../../metadata-hub/operations/metastore/cluster-create.md) со следующими настройками:

    * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** — `sa-metastore`.
    * **{{ ui-key.yacloud.metastore.label_warehouse-bucket }}** — имя созданного ранее бакета.
    * **{{ ui-key.yacloud.mdb.forms.label_network }}** — `demo-network`.
    * **{{ ui-key.yacloud.mdb.forms.network_field_subnetwork }}** — `demo-network-{{ region-id }}-a`.
    * **{{ ui-key.yacloud.mdb.forms.field_security-group }}** — `metastore-sg`.

1. [Создайте кластер {{ mtr-name }}](../../../managed-trino/operations/cluster-create.md) со следующими настройками:

    * **{{ ui-key.yacloud.mdb.forms.label_network }}** — `demo-network`.
    * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** — `sa-trino`.
    * Параметры каталога:

      * **{{ ui-key.yacloud.trino.catalogs.field_catalog-name }}** — `iceberg`.
      * **{{ ui-key.yacloud.trino.catalogs.field_catalog-type }}** — `Iceberg`.
      * **Тип Metastore** — `Hive Metastore`.
      * **URI** — `thrift://<IP-адрес_кластера_Metastore>:9083`.

        IP-адрес кластера {{ metastore-name }} можно получить с [информацией о кластере](../../../metadata-hub/operations/metastore/cluster-list.md#get-cluster).

      * **Файловое хранилище** — `{{ objstorage-full-name }}`.

1. [Создайте кластер {{ mkf-name }}](../../../managed-kafka/operations/cluster-create.md) со следующими настройками:

    * **{{ ui-key.yacloud.mdb.forms.label_network }}** — `demo-network`.
    * **{{ ui-key.yacloud.mdb.forms.field_security-group }}** — `mkf-sg`.
    * **{{ ui-key.yacloud.mdb.forms.field_assign-public-ip }}** — включен.

      {% include [public-access](../../../_includes/mdb/note-public-access.md) %}

1. В кластере {{ mkf-name }} [создайте топики](../../../managed-kafka/operations/cluster-topics.md#create-topic):

    * `iceberg_control_topic` — для управления коннектором;
    * `my_topic` — для обмена сообщениями.

1. В кластере {{ mkf-name }} [создайте пользователя](../../../managed-kafka/operations/cluster-accounts.md#create-account) `kafka-producer` с ролью [производителя](../../../managed-kafka/concepts/producers-consumers.md) и предоставьте ему доступ к топику `my_topic`.

    Этот пользователь используется для отправки сообщений в `my_topic`.


## Создайте таблицу {{ IBRG }} {#create-iceberg-table}

1. [Подключитесь](../../../managed-trino/operations/connect.md) к кластеру {{ mtr-name }}.
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

1. Проверьте, что в бакете создана [структура каталогов](../../../storage/operations/objects/list.md) `iceberg/warehouse/myschema/mytable-*/metadata/`, где `*` — системная часть имени таблицы.


## Создайте коннектор и проверьте его работу {#connector-create}

1. В {{ mkf-name }} [создайте коннектор](../../../managed-kafka/operations/cluster-connector.md#create) типа `{{ ui-key.yacloud.kafka.label_connector_icebergsink }}` со следующими параметрами:

    * **{{ ui-key.yacloud.kafka.field_connector-control-topic }}** — `iceberg_control_topic`.
    * **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-topics }}** — `my_topic`.
    * **{{ ui-key.yacloud.kafka.field_connector-static-tables }}** — `myschema.mytable`.
    * **{{ ui-key.yacloud.kafka.field_connector-catalog-uri }}** — `thrift://<IP-адрес_кластера_Metastore>:9083`.

      IP-адрес кластера {{ metastore-name }} можно получить с [информацией о кластере](../../../metadata-hub/operations/metastore/cluster-list.md#get-cluster).

    * **{{ ui-key.yacloud.kafka.field_connector-warehouse }}** — `s3a://<имя_бакета>/iceberg/warehouse`.
    * **{{ ui-key.yacloud.kafka.field_connector-endpoint }}** — `storage.yandexcloud.net`.
    * **{{ ui-key.yacloud.kafka.field_connector-access-key-id }}**, **{{ ui-key.yacloud.kafka.field_connector-secret-access-key }}** — [полученные ранее](#infra) данные о статическом ключе.
    * **{{ ui-key.yacloud.kafka.field_connector-commit-interval-ms }}** — `5000` миллисекунд.
    * **{{ ui-key.yacloud.kafka.section_properties }}**:

      * `key.converter`: `org.apache.kafka.connect.json.JsonConverter`
      * `key.converter.schemas.enable`: `false`
      * `value.converter`: `org.apache.kafka.connect.json.JsonConverter`
      * `value.converter.schemas.enable`: `false`

1. Проверьте работу коннектора:

    1. [Установите SSL-сертификат](../../../managed-kafka/operations/connect/index.md#get-ssl-cert).
    1. [Установите утилиту kcat (kafkacat)](../../../managed-kafka/operations/connect/clients.md#bash-zsh).
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

        Подробнее о получении FQDN хоста-брокера читайте в разделе [{#T}](../../../managed-kafka/operations/connect/index.md#get-fqdn).

1. После коммита проверьте, что в каталоге бакета `iceberg/warehouse/myschema/mytable-*/` создан каталог `data` с данными в формате `PARQUET`.

    Чтобы посмотреть записанные данные, выполните SQL-запрос в {{ mtr-name }}:

    ```sql
    SELECT * FROM iceberg.myschema.mytable;
    ```


## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Кластер {{ mkf-name }}](../../../managed-kafka/operations/cluster-delete.md).
1. [Кластер {{ metastore-name }}](../../../metadata-hub/operations/metastore/cluster-delete.md).
1. [Кластер {{ mtr-name }}](../../../managed-trino/operations/cluster-delete.md).
1. [Бакет {{ objstorage-name }}](../../../storage/operations/buckets/delete.md). Перед удалением бакета [удалите из него все объекты](../../../storage/operations/objects/delete.md).
1. [NAT-шлюз](../../../vpc/operations/delete-nat-gateway.md).
