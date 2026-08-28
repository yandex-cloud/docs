---
title: Настройка скрытия заголовков от источника
description: Следуя данной инструкции, вы сможете настроить скрытие HTTP-заголовков, полученных от источника контента, от конечных клиентов.
---

# Настройка скрытия заголовков от источника

Вы можете настроить [скрытие заголовков от источника](../../concepts/hiding-headers.md) при [создании](create-resource.md) CDN-ресурса или изменении его настроек с помощью консоли управления или API.

{% include [hiding-headers-warning](../../../_includes/cdn/hiding-headers-warning.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен ресурс.
  1. [Перейдите]({{ link-console-main }}/link/cdn) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Нажмите на имя необходимого ресурса.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/arrow-up-to-line.svg) **{{ ui-key.yacloud.cdn.label_resource-http-headers }}**.
  1. В правом верхнем углу нажмите кнопку ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. В блоке **{{ ui-key.yacloud.cdn.label_resource-http-headers-response-headers }}** в поле **Скрытие заголовков источника** выберите `Скрывать все, кроме указанных`.
  1. В поле **Какие оставить** укажите заголовки, которые нужно передавать клиентам, например `Content-Type`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

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

{% include [after-changes-tip](../../../_includes/cdn/after-changes-tip.md) %}


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
