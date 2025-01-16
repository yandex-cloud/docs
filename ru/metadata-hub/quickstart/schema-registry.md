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
     
      * `subject` — имя субъекта для загрузки схем;
      * `subject` — имя схемы для загрузки в указанный субъект;
      * `schemaType` — тип схемы: [Avro](https://avro.apache.org/), [JSON Schema](https://json-schema.org/) или [Protobuf](https://protobuf.dev/).

      
      ```bash
      curl \
        --request POST "https://<идентификатор_пространства_имен>.schema-registry.yandexcloud.net/v1/namespace"\
        --header "accept: application/json" \
        --header "Authorization: <токен>" \
        --header "Content-Type: application/json" \
        --data "{
         \ "schema": "{
             \"type": <тип>, 
             \"name": "<имя_схемы>, 
             \"fields":[поля_схемы]}
            }' \
        $<идентификатор_пространства_имен>/subjects/<имя_субъекта>/versions
        {"id":1}
      ```
{% endlist %}

## Что дальше {what-is-next}

После создания пространства имен и регистрации схемы:
1. [Добавляйте схемы в субъект](../operations/add-schema.md).
1. [Сравнивайте версии схем](../operations/compare-schemas.md).
