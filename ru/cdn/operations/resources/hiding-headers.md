---
title: Настройка скрытия заголовков от источника
description: Следуя данной инструкции, вы сможете настроить скрытие HTTP-заголовков, полученных от источника контента, от конечных клиентов.
---

# Настройка скрытия заголовков от источника

Вы можете настроить [скрытие заголовков от источника](../../concepts/hiding-headers.md) с помощью API при [создании](create-resource.md) или [изменении](configure-basics.md) CDN-ресурса.

{% note warning %}

Скрытие важных заголовков может нарушить работу веб-приложения.

{% endnote %}

{% list tabs group=instructions %}

- REST API {#rest-api}

  Чтобы включить опцию, добавьте блок `headerFilter` при использовании метода [create](../../api-ref/Resource/create.md) или [update](../../api-ref/Resource/update.md) для ресурса [Resource](../../api-ref/Resource/index.md):

  ```json
  "headerFilter": {
    "enabled": "<true_или_false>",
    "headers": [
      "<список_заголовков>"
    ]
  }
  ```

  Где:

  * `enabled` — включение опции:
      * `true` — включить опцию.
      * `false` — отключить опцию.

  * `headers` — список HTTP-заголовков, которые будут переданы клиенту. Все остальные заголовки от источника будут скрыты.

- gRPC API {#grpc-api}

  Чтобы включить опцию, добавьте блок `header_filter` при использовании вызова [ResourceService/Create](../../api-ref/grpc/Resource/create.md) или [ResourceService/Update](../../api-ref/grpc/Resource/update.md):

  ```json
  "header_filter": {
    "enabled": "<true_или_false>",
    "headers": [
      "<список_заголовков>"
    ]
  }
  ```

  Где:

  * `enabled` — включение опции:
      * `true` — включить опцию.
      * `false` — отключить опцию.

  * `headers` — список HTTP-заголовков, которые будут переданы клиенту. Все остальные заголовки от источника будут скрыты.

{% endlist %}


## Пример {#example}

В этом примере создается CDN-ресурс для корпоративного портала, который должен скрывать технические заголовки от источника для повышения безопасности. Разрешены только основные заголовки, необходимые для корректной работы веб-приложения.

1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и запишите его в переменную:

    ```bash
    export IAM_TOKEN=`yc iam create-token`
    ```

1. Создайте CDN-ресурс с настроенным скрытием заголовков:

    {% list tabs group=instructions %}

    - cURL {#rest-api}

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://cdn.{{ api-host }}/cdn/v1/resources' \
        --data '{
          "folderId": "b12m81qm6abc********",
          "cname": "cdn-portal.example.com",
          "origin": {
            "originSourceParams": {
              "source": "portal.example.com",
              "meta": {
                "common": { "name": "portal.example.com" }
              }
            }
          },
          "originProtocol": "HTTPS",
          "options": {
            "headerFilter": {
              "enabled": true,
              "headers": [
                "Content-Type",
                "Cache-Control",
                "Content-Length",
                "Last-Modified",
                "ETag"
              ]
            }
          }
        }'
      ```

      Результат:

      ```text
      {
      "done": true,
      "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.cdn.v1.CreateResourceMetadata",
        "resourceId": "bc8rgivxwhcy********"
      },
      "response": {
        "@type": "type.googleapis.com/yandex.cloud.cdn.v1.Resource",
        "active": true,
        "options": {
        ...
        "headerFilter": {
          "enabled": true,
          "headers": [
          "Content-Type",
          "Cache-Control",
          "Content-Length",
          "Last-Modified",
          "ETag"
          ]
        }
        },
        ...
      },
      "id": "bc8y2mnkri2d********",
      "description": "Create resource",
      "createdAt": "2026-02-05T18:02:30.735628Z",
      "createdBy": "aje9k8luj4qf********",
      "modifiedAt": "2026-02-05T18:02:30.735628Z"
      }
      ```

    - gRPCurl {#grpc-api}

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "folder_id": "b12m81qm6abc********",
              "cname": "cdn-portal.example.com",
              "origin": {
                "origin_source_params": {
                  "source": "portal.example.com",
                  "meta": {
                    "common": { "name": "portal.example.com" }
                  }
                }
              },
              "origin_protocol": "HTTPS",
              "options": {
                "header_filter": {
                  "enabled": true,
                  "headers": [
                    "Content-Type",
                    "Cache-Control",
                    "Content-Length",
                    "Last-Modified",
                    "ETag"
                  ]
                }
              }
            }' \
        cdn.{{ api-host }}:443 \
        yandex.cloud.cdn.v1.ResourceService/Create
      ```

      Результат:

      ```text
      {
        "id": "bc8h7teov4q7********",
        "description": "Create resource",
        "createdAt": "2026-02-05T18:19:01.262477Z",
        "createdBy": "aje9k8luj4qf********",
        "modifiedAt": "2026-02-05T18:19:01.262477Z",
        "done": true,
        "metadata": {"@type":"type.googleapis.com/yandex.cloud.cdn.v1.CreateResourceMetadata","resourceId":"bc8r4gogfqeb********"},
        "response": {..."options":{..."headerFilter":{"enabled":true,"headers":["Content-Type","Cache-Control","Content-Length","Last-Modified","ETag"]}},...}
      }
      ```

    {% endlist %}