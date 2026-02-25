---
title: Setting up how to follow request redirects
description: Follow this guide to set up redirects for requests received from content origins.
---

# Setting up how to follow request redirects

You can deactivate [request redirects](../../concepts/follow-redirects.md) via the API when [creating](create-resource.md) or [updating](configure-basics.md) a CDN resource.

{% note info %}

The option works only if the [origin shielding](enable-shielding.md) function is on.

{% endnote %}

{% list tabs group=instructions %}

- REST API {#rest-api}

  To enable the option, add the `followRedirects` section when using the [create](../../api-ref/Resource/create.md) or [update](../../api-ref/Resource/update.md) method for a [Resource](../../api-ref/Resource/index.md):

  ```json
  "followRedirects": {
    "enabled": "<true_or_false>",
    "codes": [
      "<list_of_codes>"
    ],
    "useCustomHost": "<true_or_false>"
  }
  ```

  Where:

  * `enabled`: Enabling the option:
      * `true` enables the option.
      * `false` disables the option.

  * `codes`: List of redirect codes {{ cdn-name }} will follow. The possible values are:
      * `301`: Moved Permanently.
      * `302`: Found.
      * `303`: See Other.
      * `307`: Temporary Redirect.
      * `308`: Permanent Redirect.

  * `useCustomHost`: Managing the `Host` header:
      * `true`: Using the `Host` header from the primary origin. For example, if the `example.com` origin returns a redirect to `ya.ru`, the request will be sent with `Host: example.com`.
      * `false`: Using the `Host` header from the redirect domain. For example, if the `example.com` origin returns a redirect to `ya.ru`, the request will be sent with `Host: ya.ru`.

- gRPC API {#grpc-api}

  To enable the option, add the `follow_redirects` section when using the [ResourceService/Create](../../api-ref/grpc/Resource/create.md) or [ResourceService/Update](../../api-ref/grpc/Resource/update.md) call:

  ```json
  "follow_redirects": {
    "enabled": "<true_or_false>",
    "codes": [
      "<list_of_codes>"
    ],
    "use_custom_host": "<true_or_false>"
  }
  ```

  Where:

  * `enabled`: Enabling the option:
      * `true` enables the option.
      * `false` disables the option.

  * `codes`: List of redirect codes {{ cdn-name }} will follow. The possible values are:
      * `301`: Moved Permanently.
      * `302`: Found.
      * `303`: See Other.
      * `307`: Temporary Redirect.
      * `308`: Permanent Redirect.

  * `use_custom_host`: Managing the `Host` header:
      * `true`: Using the `Host` header from the primary origin. For example, if the `example.com` origin returns a redirect to `ya.ru`, the request will be sent with `Host: example.com`.
      * `false`: Using the `Host` header from the redirect domain. For example, if the `example.com` origin returns a redirect to `ya.ru`, the request will be sent with `Host: ya.ru`.

{% endlist %}


## Example {#example}

In this example, we will create a CDN resource for an online store that uses multiple domains. The primary origin, `shop.example.com`, can redirect requests to `cdn-content.example.net` to optimize delivery of static files. Here, we are allowed to follow redirects for codes `301` and `302` while preserving the original `Host` header to correctly process the requests.

1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and write it into a variable:

    ```bash
    export IAM_TOKEN=`yc iam create-token`
    ```

1. Create a CDN resource that allows to follow request redirects:

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

      Result:

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
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/cdn/v1/resource_service.proto \
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

      Result:

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

1. Enable origin shielding:

    {% list tabs group=instructions %}

    - Management console {#console}

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

      Result:

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