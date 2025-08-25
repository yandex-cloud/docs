# Начало работы со {{ schema-registry-name }}

Управляйте версиями схем со {{ schema-registry-name }}.



{% include notitle [preview](../../_includes/note-preview.md) %}




## Создайте пространство имен {#create-namespace}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [new namespace](../../_includes/metadata-hub/create-name-space.md) %}


{% endlist %}

## Загрузите схему в субъект {#add-schema}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [load schema](../../_includes/metadata-hub/add-subject.md) %}

- API {#api}

  
  1. Установите [cURL](https://curl.haxx.se).
  1. [Авторизуйтесь](../api-ref/authentication.md) для выполнения операций в API.
  1. [В настройках созданного пространства имен](../operations/update-name-space.md) скопируйте его идентификатор.
  1. Воспользуйтесь методом API POST, чтобы загрузить и зарегистрировать схему для субъекта. Передайте в запросе: 
     
      * `schemaType` — формат данных: [PROTOBUF](https://protobuf.dev/), [AVRO](https://avro.apache.org/) или [JSON](https://json-schema.org/). Если параметр `schemaType` не указан, по умолчанию используется `AVRO`.
      * `schema.type` — тип данных. Например, `record`.
      * `schema.name` — имя схемы, которая будет загружена в субъект.
      * `schema.fields` — поля схемы. Пример: `[{\"name\": \"age\", \"type\": \"int\"}]`.
      * Идентификатор пространства имен.
      * Имя субъекта, в который будет загружена схема.

      Формат запроса:

            
      ```bash
      curl \
        --request POST \
        --header "accept: application/json" \
        --header "Authorization: <токен>" \
        --header "Content-Type: application/json" \
        --data '{
           "schemaType": "<формат данных>",
           "schema": '{
             \"type\": \"<тип данных>\", 
             \"name\": \"<имя_схемы>\", 
             \"fields\":[поля_схемы]}
            }' \
        https://<идентификатор_пространства_имен>.schema-registry.yandexcloud.net/subjects/<имя_субъекта>/versions
      ```

      В ответ на успешный запрос придет уникальный идентификатор схемы. Пример: `{"id":1}`.

      Примеры запросов см. в [документации Confluent](https://docs.confluent.io/platform/current/schema-registry/develop/api.html#post--subjects-(string-%20subject)-versions).

{% endlist %}

## Что дальше {what-is-next}

После создания пространства имен и регистрации схемы:
1. [Подключитесь к пространству имен](../operations/connect-to-namespace.md).
1. [Добавляйте схемы в субъект](../operations/add-schema.md).
1. [Сравнивайте версии схем](../operations/compare-schemas.md).
