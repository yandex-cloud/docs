---
editable: false
apiPlayground:
  - url: https://cloudrouter.{{ api-host }}/cloudrouter/v1/routingInstances
    method: patch
    path: null
    query: null
    body:
      type: object
      properties:
        routingInstanceId:
          description: |-
            **string**
            Required field. ID of the RoutingInstance resource to return.
          type: string
        updateMask:
          description: |-
            **string** (field-mask)
            A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
        name:
          description: |-
            **string**
            Name of the RoutingInstance.
            The name must be unique within the folder.
            Value must match the regular expression ``\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``.
          type: string
        description:
          description: |-
            **string**
            Optional description of the RoutingInstance. 0-256 characters long.
          type: string
        regionId:
          description: |-
            **string**
            ID of the region that the routingInstance belongs to.
          type: string
        vpcInfo:
          description: |-
            **[VpcInfo](/docs/cloud-router/api-ref/RoutingInstance/get#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcInfo)**
            List of the info about vpcNetworks which are attached to the RoutingInstance.
          deprecated: true
          type: array
          items:
            $ref: '#/definitions/VpcInfo'
        cicPrivateConnectionInfo:
          description: |-
            **[CicPrivateConnectionInfo](/docs/cloud-router/api-ref/RoutingInstance/get#yandex.cloud.cloudrouter.v1.RoutingInstance.CicPrivateConnectionInfo)**
            List of the info about privateConnections which are attached to the RoutingInstance.
          deprecated: true
          type: array
          items:
            $ref: '#/definitions/CicPrivateConnectionInfo'
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Resource labels, `key:value` pairs.
            No more than 64 per resource.
            The maximum string length in characters for each value is 63.
            Each value must match the regular expression `[-_0-9a-z]*`.
            The string length in characters for each key must be 1-63.
            Each key must match the regular expression `[a-z][-_0-9a-z]*`.
          pattern: '[a-z][-_0-9a-z]*'
          type: string
      required:
        - routingInstanceId
      additionalProperties: false
    definitions:
      VpcManualInfo:
        type: object
        properties:
          azId:
            description: |-
              **string**
              ID of the AZ
            type: string
          prefixes:
            description: |-
              **string**
              List of prefixes to announce
            type: array
            items:
              type: string
      VpcAzInfo:
        type: object
        properties:
          manualInfo:
            description: |-
              **[VpcManualInfo](/docs/cloud-router/api-ref/RoutingInstance/get#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcManualInfo)**
              VpcInfo which is set by user
            $ref: '#/definitions/VpcManualInfo'
      VpcInfo:
        type: object
        properties:
          vpcNetworkId:
            description: |-
              **string**
              ID of the vpcNetwork that is attached to the routingInstance.
            type: string
          azInfos:
            description: |-
              **[VpcAzInfo](/docs/cloud-router/api-ref/RoutingInstance/get#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcAzInfo)**
              List of the az-related info about vpcNetworks which are attached to routingInstance
            type: array
            items:
              $ref: '#/definitions/VpcAzInfo'
      CicPrivateConnectionInfo:
        type: object
        properties:
          cicPrivateConnectionId:
            description: |-
              **string**
              ID of the cicPrivateConnection that is attached to the routingInstance.
            type: string
sourcePath: en/_api-ref/cloudrouter/v1/api-ref/RoutingInstance/update.md
---

# Cloud Router API, REST: RoutingInstance.Update

Updates a RoutingInstance resource using the data specified in the request.
Method starts an asynchronous operation that can be cancelled while it is in progress.

## HTTP request

```
PATCH https://cloudrouter.{{ api-host }}/cloudrouter/v1/routingInstances
```

## Body parameters {#yandex.cloud.cloudrouter.v1.UpdateRoutingInstanceRequest}

```json
{
  "routingInstanceId": "string",
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "regionId": "string",
  "vpcInfo": [
    {
      "vpcNetworkId": "string",
      "azInfos": [
        {
          "manualInfo": {
            "azId": "string",
            "prefixes": [
              "string"
            ]
          }
        }
      ]
    }
  ],
  "cicPrivateConnectionInfo": [
    {
      "cicPrivateConnectionId": "string"
    }
  ],
  "labels": "object"
}
```

#|
||Field | Description ||
|| routingInstanceId | **string**

Required field. ID of the RoutingInstance resource to return. ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| name | **string**

Name of the RoutingInstance.
The name must be unique within the folder.
Value must match the regular expression ``\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``. ||
|| description | **string**

Optional description of the RoutingInstance. 0-256 characters long. ||
|| regionId | **string**

ID of the region that the routingInstance belongs to. ||
|| vpcInfo[] | **[VpcInfo](#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcInfo)**

List of the info about vpcNetworks which are attached to the RoutingInstance. ||
|| cicPrivateConnectionInfo[] | **[CicPrivateConnectionInfo](#yandex.cloud.cloudrouter.v1.RoutingInstance.CicPrivateConnectionInfo)**

List of the info about privateConnections which are attached to the RoutingInstance. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels, `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_0-9a-z]*`. ||
|#

## VpcInfo {#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcInfo}

#|
||Field | Description ||
|| vpcNetworkId | **string**

ID of the vpcNetwork that is attached to the routingInstance. ||
|| azInfos[] | **[VpcAzInfo](#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcAzInfo)**

List of the az-related info about vpcNetworks which are attached to routingInstance ||
|#

## VpcAzInfo {#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcAzInfo}

#|
||Field | Description ||
|| manualInfo | **[VpcManualInfo](#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcManualInfo)**

VpcInfo which is set by user ||
|#

## VpcManualInfo {#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcManualInfo}

#|
||Field | Description ||
|| azId | **string**

ID of the AZ ||
|| prefixes[] | **string**

List of prefixes to announce ||
|#

## CicPrivateConnectionInfo {#yandex.cloud.cloudrouter.v1.RoutingInstance.CicPrivateConnectionInfo}

#|
||Field | Description ||
|| cicPrivateConnectionId | **string**

ID of the cicPrivateConnection that is attached to the routingInstance. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "routingInstanceId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "name": "string",
    "description": "string",
    "folderId": "string",
    "regionId": "string",
    "vpcInfo": [
      {
        "vpcNetworkId": "string",
        "azInfos": [
          {
            "manualInfo": {
              "azId": "string",
              "prefixes": [
                "string"
              ]
            }
          }
        ]
      }
    ],
    "cicPrivateConnectionInfo": [
      {
        "cicPrivateConnectionId": "string"
      }
    ],
    "status": "string",
    "createdAt": "string",
    "labels": "object"
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateRoutingInstanceMetadata](#yandex.cloud.cloudrouter.v1.UpdateRoutingInstanceMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[RoutingInstance](#yandex.cloud.cloudrouter.v1.RoutingInstance)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## UpdateRoutingInstanceMetadata {#yandex.cloud.cloudrouter.v1.UpdateRoutingInstanceMetadata}

#|
||Field | Description ||
|| routingInstanceId | **string**

ID of the RoutingInstance resource. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## RoutingInstance {#yandex.cloud.cloudrouter.v1.RoutingInstance}

#|
||Field | Description ||
|| id | **string**

ID of the routingInstance. ||
|| name | **string**

Name of the routingInstance.
The name must be unique within the folder.
Value must match the regular expression ``\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``. ||
|| description | **string**

Optional description of the routingInstance. 0-256 characters long. ||
|| folderId | **string**

ID of the folder that the routingInstance belongs to. ||
|| regionId | **string**

ID of the region that the routingInstance belongs to. ||
|| vpcInfo[] | **[VpcInfo](#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcInfo2)**

List of the info about vpcNetworks which are attached to routingInstance. ||
|| cicPrivateConnectionInfo[] | **[CicPrivateConnectionInfo](#yandex.cloud.cloudrouter.v1.RoutingInstance.CicPrivateConnectionInfo2)**

List of the info about privateConnections which are attached to routingInstance. ||
|| status | **enum** (Status)

Status of the routingInstance.

- `STATUS_UNSPECIFIED`
- `CREATING`
- `UPDATING`
- `DELETING`
- `ACTIVE` ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| labels | **object** (map<**string**, **string**>)

Resource labels, `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_0-9a-z]*`. ||
|#

## VpcInfo {#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcInfo2}

#|
||Field | Description ||
|| vpcNetworkId | **string**

ID of the vpcNetwork that is attached to the routingInstance. ||
|| azInfos[] | **[VpcAzInfo](#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcAzInfo2)**

List of the az-related info about vpcNetworks which are attached to routingInstance ||
|#

## VpcAzInfo {#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcAzInfo2}

#|
||Field | Description ||
|| manualInfo | **[VpcManualInfo](#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcManualInfo2)**

VpcInfo which is set by user ||
|#

## VpcManualInfo {#yandex.cloud.cloudrouter.v1.RoutingInstance.VpcManualInfo2}

#|
||Field | Description ||
|| azId | **string**

ID of the AZ ||
|| prefixes[] | **string**

List of prefixes to announce ||
|#

## CicPrivateConnectionInfo {#yandex.cloud.cloudrouter.v1.RoutingInstance.CicPrivateConnectionInfo2}

#|
||Field | Description ||
|| cicPrivateConnectionId | **string**

ID of the cicPrivateConnection that is attached to the routingInstance. ||
|#