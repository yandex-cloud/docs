В кластерах {{ mkf-name }} можно работать с [{{ mkf-msr }}](../../../managed-kafka/concepts/managed-schema-registry.md#msr) либо [с помощью клиентов {{ KF }}](../../../managed-kafka/tutorials/managed-schema-registry.md) для различных языков программирования, либо с помощью [REST API](../../../managed-kafka/concepts/available-apis.md#managed-kafka-api).

Также {{ mkf-name }} предоставляет [REST API для {{ KF }}](../../../managed-kafka/concepts/available-apis.md#managed-kafka-api). В том числе, с помощью этого API можно отправлять и получать сообщения без использования сторонних производителей и потребителей. Эти возможности также будут продемонстрированы в этом практическом руководстве.

Чтобы познакомиться с возможностями REST API для {{ mkf-msr }} и {{ KF }}:

1. [Создайте схемы формата данных](#create-schemas).
1. [Отправьте сообщения в топик](#send-messages).
1. [Получите сообщения из топика](#receive-messages).
1. [Удалите созданные ресурсы](#clear-out).

## Перед началом работы {#before-you-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте кластер {{ mkf-name }}](../../../managed-kafka/operations/cluster-create.md) любой подходящей конфигурации.

        При создании кластера включите опции:

        * **{{ ui-key.yacloud.kafka.field_schema-registry }}**.

            В кластере будет развернут реестр схем формата данных {{ mkf-msr }} и станет доступен REST API для {{ mkf-msr }}.

        * **{{ ui-key.yacloud.kafka.field_rest-api-config }}**.

            В кластере станет доступен REST API для {{ KF }}.

        * **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.

            Хосты-брокеры станут доступны из интернета.

    1. [Создайте топик](../../../managed-kafka/operations/cluster-topics.md#create-topic) с именем `messages` для обмена сообщениями между производителем и потребителем.

    1. [Создайте пользователя](../../../managed-kafka/operations/cluster-accounts.md#create-account) с именем `user1` и [выдайте ему права](../../../managed-kafka/operations/cluster-accounts.md#grant-permission) на топик `messages`:

        * `ACCESS_ROLE_CONSUMER`,
        * `ACCESS_ROLE_PRODUCER`.

        Этот пользователь сможет отправлять и получать сообщения в рамках топика, а также [выполнять любые операции над субъектами в {{ mkf-msr }}](../../../managed-kafka/concepts/managed-schema-registry.md#msr-auth), которые связаны с топиком.

    1. [Выполните все шаги по предварительной настройке для подключения к кластеру](../../../managed-kafka/operations/connect/index.md).

{% endlist %}

### Установите утилиты {#install-utilities}

1. Установите утилиту [cURL](https://curl.se/):

    ```bash
    sudo apt install curl -y
    ```

    С ее помощью будут выполняться запросы к API.

    Для удобства в этом практическом руководстве при выполнении запросов к API будет использоваться опция cURL [--user](https://curl.se/docs/manpage.html#-u). При указанной опции cURL сам добавит в запрос HTTP-заголовок [Authorization](https://developer.mozilla.org/ru-RU/docs/Web/HTTP/Headers/Authorization) с необходимым значением для [авторизации](../../../managed-kafka/concepts/available-apis.md#managed-kafka-api-usage).

    {% note tip %}

    Вы можете самостоятельно сконструировать заголовок `Authorization`, например, если вы не используете cURL.

    {% endnote %}

1. Установите утилиту [jq](https://github.com/jqlang/jq):

    ```bash
    sudo apt install jq -y
    ```

    С ее помощью описания схем будут приводиться к нужному формату.

    При использовании REST API для {{ mkf-msr }} описания схем необходимо передавать в виде строки с экранированными символами, например:

    ```json
    "schema": "{\"type\": \"record\", \"name\": \"Obj\", \"fields\":[...]}"
    ```

    Для удобства в этом практическом руководстве схемы представлены в виде JSON-документов c отступами и переносами строк, а при выполнении запросов к API схемы приводятся к нужному формату с помощью `jq`.

    {% note tip %}

    После выполнения запроса к REST API с помощью cURL, ответ сервера представляется в виде одной JSON-строки.

    Вы можете дополнительно обработать вывод команд из этого практического руководства с помощью `jq`, чтобы сделать ответ сервера удобочитаемым.

    {% endnote %}

## Создайте схемы формата данных {#create-schemas}

{% note info %}

В этом практическом руководстве используются схемы типа [Avro](https://avro.apache.org/docs/1.12.0/specification/).

Вы можете использовать другие типы схем, которые поддерживаются в {{ mkf-msr }}.

{% endnote %}

Пусть сообщение {{ KF }} в топике `messages` должно состоять из ключа и значения в следующем формате:

#|
|| **Ключ** | **Значение** ||
||

```json
{
  "id": <int>,
  "sid": "<string>"
}
```

|

```json
{
  "name": "<string>",
  "city": "<string>",
  "age": <int>
}
```

||
|#

Создайте соответствующие схемы формата данных:

1. Создайте файл `schema-key.json`, который содержит схему формата данных для ключа сообщения {{ KF }}.

    {% cut "schema-key.json" %}

    ```json
    {
      "type": "record",
      "name": "my_key",
      "fields": [
        {
          "name": "id",
          "type": "int"
        },
        {
          "name": "sid",
          "type": "string"
        }
      ]
    }
    ```

    {% endcut %}

1. Создайте схему формата данных для ключа сообщения {{ KF }}.

    [Имя субъекта для схемы](../../../managed-kafka/concepts/managed-schema-registry#subjects) должно состоять из имени топика, в котором будет использоваться эта схема (`messages`) и суффикса `-key`.

    Воспользуйтесь методом [POST /subjects/(subject)/versions](https://docs.confluent.io/platform/{{ mkf.kp-api-version }}/schema-registry/develop/api.html#post--subjects-(string-%20subject)-versions) REST API для {{ mkf-msr }} и выполните запрос:

    ```bash
    jq \
        -n --slurpfile data schema-key.json \
        '{
           "schemaType": "AVRO",
           "schema": "\($data)"
        }' \
    | curl \
          --request POST \
          --url 'https://<FQDN_хоста-брокера>:{{ port-https }}/subjects/messages-key/versions' \
          --user user1:<пароль_пользователя> \
          --header 'Content-Type: application/vnd.schemaregistry.v1+json' \
          --data "@-"
    ```

    В ответе на запрос будет возвращен идентификатор созданной схемы, например, `{"id":1}`.

1. Создайте файл `schema-value.json`, который содержит схему формата данных для значения сообщения {{ KF }}.

    {% cut "schema-value.json" %}

    ```json
    {
      "type": "record",
      "name": "my_value",
      "fields": [
        {
          "name": "name",
          "type": "string"
        },
        {
          "name": "city",
          "type": "string"
        },
        {
          "name": "age",
          "type": "int"
        }
      ]
    }
    ```

    {% endcut %}

1. Создайте схему формата данных для значения сообщения {{ KF }}.

    [Имя субъекта для схемы](../../../managed-kafka/concepts/managed-schema-registry#subjects) должно состоять из имени топика, в котором будет использоваться эта схема (`messages`) и суффикса `-value`.

    Воспользуйтесь методом [POST /subjects/(subject)/versions](https://docs.confluent.io/platform/{{ mkf.kp-api-version }}/schema-registry/develop/api.html#post--subjects-(string-%20subject)-versions) REST API для {{ mkf-msr }} и выполните запрос:

    ```bash
    jq \
        -n --slurpfile data schema-value.json \
        '{
           "schemaType": "AVRO",
           "schema": "\($data)"
        }' \
    | curl \
          --request POST \
          --url 'https://<FQDN_хоста-брокера>:{{ port-https }}/subjects/messages-value/versions' \
          --user user1:<пароль_пользователя> \
          --header 'Content-Type: application/vnd.schemaregistry.v1+json' \
          --data "@-"
    ```

    В ответе на запрос будет возвращен идентификатор созданной схемы, например, `{"id":2}`.

## Отправьте сообщения в топик {#send-messages}

1. Получите идентификаторы схем формата данных для ключа и значения.

    Воспользуйтесь методом `GET /schemas` REST API для {{ mkf-msr }} и выполните запрос:

    ```bash
    curl \
        --request GET \
        --url 'https://<FQDN_хоста-брокера>:{{ port-https }}/schemas' \
        --user user1:<пароль_пользователя> \
        --header 'Accept: application/vnd.schemaregistry.v1+json'
    ```

    В ответе на запрос содержатся идентификаторы схем формата данных (`id`). Эти идентификаторы будут использоваться позднее.

    {% cut "Пример ответа на запрос" %}

     Для краткости схема формата данных `schema` в виде JSON-строк не приводится.

    ```json
    [
      {
        "id": 1,
        "schema": "<схема_формата_данных>",
        "schemaType": "AVRO",
        "subject": "messages-key",
        "version": 1
      },
      {
        "id": 2,
        "schema": "<схема_формата_данных>",
        "schemaType": "AVRO",
        "subject": "messages-value",
        "version": 1
      }
    ]
    ```

    {% endcut %}

1. Создайте файл `message-list.json`, который содержит два сообщения. Для каждого сообщения указаны ключ и значение в соответствии с созданными ранее схемами формата данных.

    {% cut "message-list.json" %}

    ```json
    [
      {
        "key": {
          "id": 1111,
          "sid": "AAAAA-BBBBB-CCCCC"
        },
        "value": {
          "name": "Anna",
          "city": "Moscow",
          "age": 44
        }
      },
      {
        "key": {
          "id": 2222,
          "sid": "DDDDD-EEEEE-FFFFF"
        },
        "value": {
          "name": "Alex",
          "city": "London",
          "age": 32
        }
      }
    ]
    ```

    {% endcut %}

1. Отправьте сообщения в топик `messages`.

    Воспользуйтесь методом [POST /topics/(topic)](https://docs.confluent.io/platform/{{ mkf.kp-api-version }}/kafka-rest/api.html#post--topics-(string-topic_name)) REST API для {{ KF }} и выполните запрос:

    ```bash
    jq \
        -n --slurpfile data message-list.json \
        '{
          "key_schema_id": <идентификатор_схемы_messages-key>,
          "value_schema_id": <идентификатор_схемы_messages-value>,
          "records": $data.[]
        }' \
    | curl \
          --request POST \
          --url 'https://<FQDN_хоста-брокера>:{{ port-https }}/topics/messages' \
          --user user1:<пароль_пользователя> \
          --header 'Content-Type: application/vnd.kafka.avro.v2+json' \
          --header 'Accept: application/vnd.kafka.v2+json' \
          --data "@-"
    ```

    Значения идентификаторов схем были получены ранее с помощью запроса к эндпоинту `GET /schemas`.

    {% cut "Пример ответа на запрос" %}

    ```json
    {
      "key_schema_id": 1,
      "offsets": [
        {
          "offset": 0,
          "partition": 0
        },
        {
          "offset": 0,
          "partition": 1
        }
      ],
      "value_schema_id": 2
    }
    ```

    {% endcut %}

## Получите сообщения из топика {#receive-messages}

1. Создайте потребителя `my-consumer` в группе потребителей `my-group`.

    Воспользуйтесь методом [POST /consumers/(group)](https://docs.confluent.io/platform/{{ mkf.kp-api-version }}/kafka-rest/api.html#post--consumers-(string-group_name)) REST API для {{ KF }} и выполните запрос:

    ```bash
    curl \
        --request POST \
        --url 'https://<FQDN_хоста-брокера>:{{ port-https }}/consumers/my-group' \
        --user user1:<пароль_пользователя> \
        --header 'Content-Type: application/vnd.kafka.v2+json' \
        --header 'Accept: application/vnd.kafka.v2+json' \
        --data '{
                  "name": "my-consumer",
                  "format": "avro",
                  "auto.offset.reset": "earliest"
                }'
    ```

    {% cut "Пример ответа на запрос" %}

    ```json
    {
      "base_uri": "https://<FQDN_хоста-брокера>:{{ port-https }}/consumers/my-group/instances/my-consumer",
      "instance_id": "my-consumer"
    }
    ```

    {% endcut %}

1. Подпишитесь на топик `messages` для потребителя `my-consumer` из группы потребителей `my-group`.

    Воспользуйтесь методом [POST /consumers/(group)/instances/(instance)/subscription](https://docs.confluent.io/platform/{{ mkf.kp-api-version }}/kafka-rest/api.html#post--consumers-(string-group_name)-instances-(string-instance)-subscription) REST API для {{ KF }} и выполните запрос:

    ```bash
    curl \
        --request POST \
        --url 'https://<FQDN_хоста-брокера>:{{ port-https }}/consumers/my-group/instances/my-consumer/subscription' \
        --user user1:<пароль_пользователя> \
        --header 'Content-Type: application/vnd.kafka.v2+json' \
        --header 'Accept: application/vnd.kafka.v2+json' \
        --data '{"topics": ["messages"]}'
    ```

    Сервер API не возвращает ответа на этот запрос, только HTTP-статус.

1. Получите все сообщения из топика `messages` для потребителя `my-consumer` из группы потребителей `my-group`.

    Воспользуйтесь методом [GET /consumers/(group)/instances/(instance)/records](https://docs.confluent.io/platform/{{ mkf.kp-api-version }}/kafka-rest/api.html#get--consumers-(string-group_name)-instances-(string-instance)-records) REST API для {{ KF }} и выполните запрос:

    ```bash
    curl \
        --request GET \
        --url 'https://<FQDN_хоста-брокера>:{{ port-https }}/consumers/my-group/instances/my-consumer/records' \
        --user user1:<пароль_пользователя> \
        --header 'Accept: application/vnd.kafka.avro.v2+json'
    ```

    Если в ответе на запрос содержатся отправленные ранее сообщения, то это значит, что производитель и потребитель успешно интерпретируют сообщения в соответствии с заданными схемами формата данных.

    {% cut "Пример ответа на запрос" %}

    ```json
    [
      {
        "key": {
          "id": 2222,
          "sid": "DDDDD-EEEEE-FFFFF"
        },
        "offset": 0,
        "partition": 1,
        "timestamp": 1726031054186,
        "topic": "messages",
        "value": {
          "age": 32,
          "city": "London",
          "name": "Alex"
        }
      },
      {
        "key": {
          "id": 1111,
          "sid": "AAAAA-BBBBB-CCCCC"
        },
        "offset": 0,
        "partition": 0,
        "timestamp": 1726031054186,
        "topic": "messages",
        "value": {
          "age": 44,
          "city": "Moscow",
          "name": "Anna"
        }
      }
    ]
    ```

    {% endcut %}

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

* [Удалите кластер {{ mkf-name }}](../../../managed-kafka/operations/cluster-delete.md).
* Если вы зарезервировали публичные статические IP-адреса, освободите и [удалите их](../../../vpc/operations/address-delete.md).
