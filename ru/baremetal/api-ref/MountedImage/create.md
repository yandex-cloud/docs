---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v1alpha/mountedImages
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        serverId:
          description: |-
            **string**
            Required field. ID of the server to mount image to.
          type: string
        imageId:
          description: |-
            **string**
            Required field. ID of the image to mount.
          type: string
      required:
        - serverId
        - imageId
      additionalProperties: false
    definitions: null
---

# BareMetal API, REST: MountedImage.Create

Mount user image.

## HTTP request

```
POST https://baremetal.{{ api-host }}/baremetal/v1alpha/mountedImages
```

## Body parameters {#yandex.cloud.baremetal.v1alpha.CreateMountedImageRequest}

```json
{
  "serverId": "string",
  "imageId": "string"
}
```

#|
||Field | Description ||
|| serverId | **string**

Required field. ID of the server to mount image to. ||
|| imageId | **string**

Required field. ID of the image to mount. ||
|#

## Response {#google.protobuf.Empty}

**HTTP Code: 200 - OK**