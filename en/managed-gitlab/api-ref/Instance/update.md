---
editable: false
apiPlayground:
  - url: https://gitlab.{{ api-host }}/gitlab/v1/instances/{instanceId}
    method: patch
    path:
      type: object
      properties:
        instanceId:
          description: |-
            **string**
            Required field. ID of the GitLab instance to update.
            The maximum string length in characters is 50.
          type: string
      required:
        - instanceId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        name:
          description: |-
            **string**
            Name of the instance (must be unique within the folder).
            Value must match the regular expression ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
          pattern: '|[a-z][-a-z0-9]{1,61}[a-z0-9]'
          type: string
        description:
          description: |-
            **string**
            Description of the instance.
            The maximum string length in characters is 256.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Custom labels for the instance as `` key:value `` pairs. For example, "env": "prod"
            The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource.
          type: object
          additionalProperties:
            type: string
            pattern: '[-_0-9a-z]*'
            maxLength: 63
          propertyNames:
            type: string
            pattern: '[a-z][-_0-9a-z]*'
            maxLength: 63
            minLength: 1
          maxProperties: 64
        backupRetainPeriodDays:
          description: |-
            **string** (int64)
            Number of days to retain backups.
          type: string
          format: int64
        resourcePresetId:
          description: |-
            **string**
            ID of the resource preset for computational resources.
          type: string
        maintenanceDeleteUntagged:
          description: |-
            **boolean**
            Whether to delete untagged resources during maintenance.
          type: boolean
        deletionProtection:
          description: |-
            **boolean**
            Whether deletion protection is enabled.
          type: boolean
        approvalRulesId:
          description: |-
            **string**
            ID of approval rules for the instance.
            The maximum string length in characters is 30.
          type: string
        approvalRulesToken:
          description: |-
            **string**
            Token of approval rules for the instance.
            The maximum string length in characters is 100.
          type: string
        diskSize:
          description: |-
            **string** (int64)
            Disk size in bytes.
          type: string
          format: int64
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
      additionalProperties: false
    definitions: null
---

# Managed Service for Gitlab API, REST: Instance.Update

Updates GitLab instance.

## HTTP request

```
PATCH https://gitlab.{{ api-host }}/gitlab/v1/instances/{instanceId}
```

## Path parameters

Request message for InstanceService.Update.

#|
||Field | Description ||
|| instanceId | **string**

Required field. ID of the GitLab instance to update.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.gitlab.v1.UpdateInstanceRequest}

```json
{
  "name": "string",
  "description": "string",
  "labels": "object",
  "backupRetainPeriodDays": "string",
  "resourcePresetId": "string",
  "maintenanceDeleteUntagged": "boolean",
  "deletionProtection": "boolean",
  "approvalRulesId": "string",
  "approvalRulesToken": "string",
  "diskSize": "string",
  "updateMask": "string"
}
```

Request message for InstanceService.Update.

#|
||Field | Description ||
|| name | **string**

Name of the instance (must be unique within the folder).

Value must match the regular expression ``` |[a-z][-a-z0-9]{1,61}[a-z0-9] ```. ||
|| description | **string**

Description of the instance.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the instance as `` key:value `` pairs. For example, "env": "prod"

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| backupRetainPeriodDays | **string** (int64)

Number of days to retain backups. ||
|| resourcePresetId | **string**

ID of the resource preset for computational resources. ||
|| maintenanceDeleteUntagged | **boolean**

Whether to delete untagged resources during maintenance. ||
|| deletionProtection | **boolean**

Whether deletion protection is enabled. ||
|| approvalRulesId | **string**

ID of approval rules for the instance.

The maximum string length in characters is 30. ||
|| approvalRulesToken | **string**

Token of approval rules for the instance.

The maximum string length in characters is 100. ||
|| diskSize | **string** (int64)

Disk size in bytes. ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
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
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
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
|| metadata | **object**

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
|| response | **object**

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