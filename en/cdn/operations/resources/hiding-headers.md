---
title: Setting up hiding of origin headers
description: Follow this guide to hide HTTP headers received from the content origin from end users.
---

# Setting up hiding of origin headers

You can set up [hiding of origin headers](../../concepts/hiding-headers.md) using the API when [creating](create-resource.md) or [updating](configure-basics.md) a CDN resource.

{% note warning %}

Hiding important headers may disrupt the operation of the web application.

{% endnote %}

{% list tabs group=instructions %}

- REST API {#rest-api}

  To enable the option, add the `headerFilter` section when using the [create](../../api-ref/Resource/create.md) or [update](../../api-ref/Resource/update.md) method for a [Resource](../../api-ref/Resource/index.md):

  ```json
  "headerFilter": {
    "enabled": "<true_or_false>",
    "headers": [
      "<list_of_headers>"
    ]
  }
  ```

  Where:

  * `enabled`: Enabling the option:
      * `true` enables the option.
      * `false` disables the option.

  * `headers`: A list of HTTP headers to be passed to the client. All other origin headers will be hidden.

- gRPC API {#grpc-api}

  To enable the option, add the `header_filter` section when using the [ResourceService/Create](../../api-ref/grpc/Resource/create.md) or [ResourceService/Update](../../api-ref/grpc/Resource/update.md) call:

  ```json
  "header_filter": {
    "enabled": "<true_or_false>",
    "headers": [
      "<list_of_headers>"
    ]
  }
  ```

  Where:

  * `enabled`: Enabling the option:
      * `true` enables the option.
      * `false` disables the option.

  * `headers`: A list of HTTP headers to be passed to the client. All other origin headers will be hidden.

{% endlist %}


## Example {#example}

In this example, a CDN resource is created for a corporate portal that should hide technical headers from the source to enhance security. Only the main headers required for the correct functioning of the web application are allowed.

1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and write it into a variable:

    ```bash
    export IAM_TOKEN=`yc iam create-token`
    ```

1. Create a CDN resource with a configured header hiding:

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

      Result:

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

      Result:

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
    