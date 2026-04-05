---
title: Configuring a TLS profile for a CDN resource
description: Follow this guide to configure a TLS profile for a CDN resource.
---

# Configuring a TLS profile for a CDN resource

{% include [tls-profiles-intro](../../../_includes/cdn/tls-profiles-intro.md) %}

For more information, see [{#T}](../../concepts/clients-to-servers-tls.md#tls-profiles).

{% list tabs group=instructions %}

- REST API {#rest-api}

  To enable the option, add the `tls` section to the CDN resource specification in the request body when using the [create](../../api-ref/Resource/create.md) or [update](../../api-ref/Resource/update.md) method for a [Resource](../../api-ref/Resource/index.md):

  ```json
  "tls": {
    "profile": "<TLS_security_profile>"
  }
  ```

  {% include [tls-profiles-list](../../../_includes/cdn/tls-profiles-list.md) %}

  Here is an example:

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

  To enable the option, add the `tls` section to the CDN resource specification in the request body when calling [ResourceService/Create](../../api-ref/grpc/Resource/create.md) or [ResourceService/Update](../../api-ref/grpc/Resource/update.md):

  ```json
  "tls": {
    "profile": "<TLS_security_profile>"
  }
  ```

  {% include [tls-profiles-list](../../../_includes/cdn/tls-profiles-list.md) %}

  Here is an example:

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
    "response": {..."options":{..."tls":{"profile":"PROFILE_SECURE"}},...}
  }
  ```

{% endlist %}

## See also {#see-also}

* [{#T}](../../concepts/clients-to-servers-tls.md#tls-profiles)
* [{#T}](../../api-ref/authentication.md)
