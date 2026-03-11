---
title: Настройка профиля безопасности TLS для CDN-ресурса
description: Следуя данной инструкции, вы сможете настроить профиль безопасности TLS для CDN-ресурса.
---

# Настройка профиля безопасности TLS для CDN-ресурса

{% include [tls-profiles-intro](../../../_includes/cdn/tls-profiles-intro.md) %}

Подробнее см. в разделе [{#T}](../../concepts/clients-to-servers-tls.md#tls-profiles).

{% list tabs group=instructions %}

- REST API {#rest-api}

  Чтобы включить опцию, добавьте в спецификацию CDN-ресурса в теле запроса блок `tls` при использовании метода [create](../../api-ref/Resource/create.md) или [update](../../api-ref/Resource/update.md) для ресурса [Resource](../../api-ref/Resource/index.md):

  ```json
  "tls": {
    "profile": "<профиль_безопасности_TLS>"
  }
  ```

  {% include [tls-profiles-list](../../../_includes/cdn/tls-profiles-list.md) %}

  Например:

  ```bash
  export IAM_TOKEN=`yc iam create-token`
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
        "tls": {
          "profile": "PROFILE_SECURE"
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
    "tls": {
      "profile": "PROFILE_SECURE"
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

- gRPC API {#grpc-api}

  Чтобы включить опцию, добавьте в спецификацию CDN-ресурса в теле запроса блок `tls` при использовании вызова [ResourceService/Create](../../api-ref/grpc/Resource/create.md) или [ResourceService/Update](../../api-ref/grpc/Resource/update.md):

  ```json
  "tls": {
    "profile": "<профиль_безопасности_TLS>"
  }
  ```

  {% include [tls-profiles-list](../../../_includes/cdn/tls-profiles-list.md) %}

  Например:

  ```bash
  export IAM_TOKEN=`yc iam create-token`
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
            "tls": {
              "profile": "PROFILE_SECURE"
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
    "response": {..."options":{..."tls":{"profile":"PROFILE_SECURE"}},...}
  }
  ```

{% endlist %}

## См. также {#see-also}

* [{#T}](../../concepts/clients-to-servers-tls.md#tls-profiles)
* [{#T}](../../api-ref/authentication.md)
* [{#T}](../../../glossary/tls.md)