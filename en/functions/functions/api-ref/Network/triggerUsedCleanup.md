---
editable: false
apiPlayground:
  - url: https://serverless-functions.{{ api-host }}/functions/v1/networks/used/{networkId}:triggerCleanup
    method: post
    path:
      type: object
      properties:
        networkId:
          description: |-
            **string**
            Required field. ID of the obsolete network to start the cleanup process for.
          type: string
      required:
        - networkId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/serverless/functions/v1/functions/api-ref/Network/triggerUsedCleanup.md
---

# Cloud Functions Service, REST: Network.TriggerUsedCleanup

Forces obsolete used network to start cleanup process as soon as possible.
Invocation does not wait for start or end of the cleanup process.
Second invocation with the same network does nothing until network is completely cleaned-up.

## HTTP request

```
POST https://serverless-functions.{{ api-host }}/functions/v1/networks/used/{networkId}:triggerCleanup
```

## Path parameters

#|
||Field | Description ||
|| networkId | **string**

Required field. ID of the obsolete network to start the cleanup process for. ||
|#

## Response {#yandex.cloud.serverless.functions.v1.TriggerUsedNetworkCleanupResponse}

**HTTP Code: 200 - OK**

```json
{
  "networkCleanupTime": "string"
}
```

#|
||Field | Description ||
|| networkCleanupTime | **string** (date-time)

Timestamp when cleanup of the specified network will be started.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#