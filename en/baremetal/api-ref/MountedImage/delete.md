---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v1alpha/mountedImages/{serverId}
    method: delete
    path:
      type: object
      properties:
        serverId:
          description: |-
            **string**
            Required field. ID of the server to unmount image from.
          type: string
      required:
        - serverId
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# BareMetal API, REST: MountedImage.Delete

Unmount user image.

## HTTP request

```
DELETE https://baremetal.{{ api-host }}/baremetal/v1alpha/mountedImages/{serverId}
```

## Path parameters

#|
||Field | Description ||
|| serverId | **string**

Required field. ID of the server to unmount image from. ||
|#

## Response {#google.protobuf.Empty}

**HTTP Code: 200 - OK**