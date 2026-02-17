---
title: Настройка следования перенаправлениям запросов
description: Следуя данной инструкции, вы сможете настроить перенаправление запросов, полученных от источников контента.
---

# Настройка следования перенаправлениям запросов

Вы можете выключить [следование перенаправлениям запросов](../../concepts/follow-redirects.md) с помощью API при [создании](create-resource.md) или [изменении](configure-basics.md) CDN-ресурса.

{% note info %}

Опция работает только при включенной функции [экранирования источников](enable-shielding.md).

{% endnote %}

{% list tabs group=instructions %}

- REST API {#rest-api}

  Чтобы включить опцию, добавьте блок `followRedirects` при использовании метода [create](../../api-ref/Resource/create.md) или [update](../../api-ref/Resource/update.md) для ресурса [Resource](../../api-ref/Resource/index.md):

  ```json
  "followRedirects": {
    "enabled": "<true_или_false>",
    "codes": [
      "<список_кодов>"
    ],
    "useCustomHost": "<true_или_false>"
  }
  ```

  Где:

  * `enabled` — включение опции:
      * `true` — включить опцию.
      * `false` — отключить опцию.

  * `codes` — список кодов перенаправления, по которым {{ cdn-name }} будет следовать. Возможные значения:
      * `301` — Moved Permanently (перемещено навсегда).
      * `302` — Found (найдено).
      * `303` — See Other (смотреть другое).
      * `307` — Temporary Redirect (временное перенаправление).
      * `308` — Permanent Redirect (постоянное перенаправление).

  * `useCustomHost` — управление заголовком `Host`:
      * `true` — использовать заголовок `Host` от основного источника. Например, если источник `example.com` вернет редирект на `ya.ru`, запрос будет сделан с `Host: example.com`.
      * `false` — использовать заголовок `Host` от домена перенаправления. Например, если источник `example.com` вернет редирект на `ya.ru`, запрос будет сделан с `Host: ya.ru`.

- gRPC API {#grpc-api}

  Чтобы включить опцию, добавьте блок `follow_redirects` при использовании вызова [ResourceService/Create](../../api-ref/grpc/Resource/create.md) или [ResourceService/Update](../../api-ref/grpc/Resource/update.md):

  ```json
  "follow_redirects": {
    "enabled": "<true_или_false>",
    "codes": [
      "<список_кодов>"
    ],
    "use_custom_host": "<true_или_false>"
  }
  ```

  Где:

  * `enabled` — включение опции:
      * `true` — включить опцию.
      * `false` — отключить опцию.

  * `codes` — список кодов перенаправления, по которым {{ cdn-name }} будет следовать. Возможные значения:
      * `301` — Moved Permanently (перемещено навсегда).
      * `302` — Found (найдено).
      * `303` — See Other (смотреть другое).
      * `307` — Temporary Redirect (временное перенаправление).
      * `308` — Permanent Redirect (постоянное перенаправление).

  * `use_custom_host` — управление заголовком `Host`:
      * `true` — использовать заголовок `Host` от основного источника. Например, если источник `example.com` вернет редирект на `ya.ru`, запрос будет сделан с `Host: example.com`.
      * `false` — использовать заголовок `Host` от домена перенаправления. Например, если источник `example.com` вернет редирект на `ya.ru`, запрос будет сделан с `Host: ya.ru`.

{% endlist %}


## Пример {#example}

В этом примере создается CDN-ресурс для интернет-магазина, который использует несколько доменов. Основной источник `shop.example.com` может перенаправлять запросы на `cdn-content.example.net` для оптимизации доставки статических файлов. Здесь разрешено следование редиректам для кодов `301` и `302` с сохранением оригинального заголовка `Host` для корректной обработки запросов.

1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и запишите его в переменную:

    ```bash
    export IAM_TOKEN=`yc iam create-token`
    ```

1. Создайте CDN-ресурс с разрешенным следованием перенаправлениям запросов:

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
          "cname": "cdn-shop.example.com",
          "origin": {
            "originSourceParams": {
              "source": "shop.example.com",
              "meta": {
                "common": { "name": "shop.example.com" }
              }
            }
          },
          "originProtocol": "HTTPS",
          "options": {
            "followRedirects": {
              "enabled": true,
              "codes": ["301", "302"],
              "useCustomHost": true
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
        "resourceId": "bc8rt2ynimae********"
      },
      "response": {
        ...
        "followRedirects": {
          "enabled": true,
          "codes": [
          "301",
          "302"
          ],
          "useCustomHost": true
        }
        },
        ...
      "id": "bc82j4x6n6pb********",
      "description": "Create resource",
      "createdAt": "2026-02-03T09:27:51.714683Z",
      "createdBy": "aje9k8luj4qf********",
      "modifiedAt": "2026-02-03T09:27:51.714683Z"
      }
      ```

    - gRPCurl {#grpc-api}

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "folder_id": "b12m81qm6abc********",
              "cname": "cdn-shop.example.com",
              "origin": {
                "origin_source_params": {
                  "source": "shop.example.com",
                  "meta": {
                    "common": { "name": "shop.example.com" }
                  }
                }
              },
              "origin_protocol": "HTTPS",
              "options": {
                "follow_redirects": {
                  "enabled": true,
                  "codes": ["301", "302"],
                  "use_custom_host": true
                }
              }
            }' \
        cdn.{{ api-host }}:443 \
        yandex.cloud.cdn.v1.ResourceService/Create
      ```

      Результат:

      ```text
      {
        "id": "bc87tcdmptuy********",
        "description": "Create resource",
        "createdAt": "2026-02-03T09:09:04.967980Z",
        "createdBy": "aje8m8lur3qf********",
        "modifiedAt": "2026-02-03T09:09:04.967980Z",
        "done": true,
        "metadata": {"@type":"type.googleapis.com/yandex.cloud.cdn.v1.CreateResourceMetadata","resourceId":"bc8rskqqnd23********"},
        "response": {"@type":"type.googleapis.com/yandex.cloud.cdn.v1.Resource","active":true,"cname":"altaraskin.online","createdAt":"2026-02-03T09:09:04.808428Z","folderId":"b1g652qoimb4********","id":"bc8rskqqnd23********","options":{ ... "followRedirects":{"enabled":true,"codes":["301","302"],"useCustomHost":true}}, ... }
      }
      ```

    {% endlist %}

1. Включите экранирование источников:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      {% include [enable-shielding-console](../../../_includes/cdn/enable-shielding-console.md) %}

    - gRPCurl {#grpc-api}

      ```bash
      grpcurl \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/cdn/v1/shielding_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "resource_id": "bc8rskqqnd23********",
              "location_id": "1"
            }' \
        cdn.{{ api-host }}:443 \
        yandex.cloud.cdn.v1.ShieldingService/Activate
      ```

      Результат:

      ```text
      {
        "id": "bc8yiwltf3hg********",
        "description": "Activate Origin Shielding",
        "createdAt": "2026-02-03T09:13:43.226165Z",
        "createdBy": "aje9k8luj4qf********",
        "modifiedAt": "2026-02-03T09:13:43.226165Z",
        "done": true,
        "metadata": {"@type":"type.googleapis.com/yandex.cloud.cdn.v1.ActivateShieldingMetadata","resourceId":"bc8rskqqnd23********"},
        "response": {"@type":"type.googleapis.com/yandex.cloud.cdn.v1.ShieldingDetails","city":"Moscow","country":"Russia","dataCenter":"msk","locationId":"1"}
      }
      ```

    {% endlist %}