---
editable: false
apiPlayground:
  - url: https://serverless-functions.{{ api-host }}/functions/v1/networks/used/{networkId}
    method: get
    path:
      type: object
      properties:
        networkId:
          description: |-
            **string**
            Required field. ID of the network to return.
          type: string
      required:
        - networkId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/serverless/functions/v1/functions/api-ref/Network/getUsed.md
---

# Cloud Functions Service, REST: Network.GetUsed

Returns the specified network used in serverless resources.

## HTTP request

```
GET https://serverless-functions.{{ api-host }}/functions/v1/networks/used/{networkId}
```

## Path parameters

#|
||Field | Description ||
|| networkId | **string**

Required field. ID of the network to return. ||
|#

## Response {#yandex.cloud.serverless.functions.v1.UsedNetwork}

**HTTP Code: 200 - OK**

```json
{
  "networkId": "string",
  "cloudId": "string",
  "folderId": "string",
  "status": "string",
  "willBeCleanedUpAt": "string",
  "connectionsCount": "string"
}
```

A VPC network used in serverless resources.

#|
||Field | Description ||
|| networkId | **string**

ID of the VPC network. ||
|| cloudId | **string**

ID of the cloud that the network belongs to. ||
|| folderId | **string**

ID of the folder that the network belongs to. ||
|| status | **enum** (Status)

Status of the network.

- `STATUS_UNSPECIFIED`
- `CREATING`: Network is connecting to its first serverless resource.
- `ACTIVE`: Network is already being used by some serverless resources.
- `OBSOLETE`: Network is no longer used by any serverless resources.
It will be cleaned-up after a while. ||
|| willBeCleanedUpAt | **string** (date-time)

Clean-up timestamp of the obsolete network.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| connectionsCount | **string** (int64)

Number of serverless resources connected to the network. ||
|#