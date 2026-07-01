---
editable: false
apiPlayground:
  - url: https://{{ api-host-iot-broker }}/iot-broker/v1/brokers
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to create a broker in.
            To get a folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
            The maximum string length in characters is 50.
          type: string
        name:
          description: |-
            **string**
            Name of the broker. The name must be unique within the folder.
            The maximum string length in characters is 50. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
          pattern: '[a-zA-Z0-9_-]*'
          type: string
        description:
          description: |-
            **string**
            Description of the broker.
            The maximum string length in characters is 256.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Resource labels as `key:value` pairs.
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
        certificates:
          description: |-
            **[Certificate](#yandex.cloud.iot.broker.v1.CreateBrokerRequest.Certificate)**
            Broker certificates.
          type: array
          items:
            $ref: '#/definitions/Certificate'
        password:
          description: |-
            **string**
            Broker passwords.
            The password must contain at least three character categories among the following: upper case latin, lower case latin, numbers and special symbols.
          type: string
        logOptions:
          description: |-
            **[LogOptions](#yandex.cloud.iot.broker.v1.LogOptions)**
            Options for logging broker events
          $ref: '#/definitions/LogOptions'
      required:
        - folderId
      additionalProperties: false
    definitions:
      Certificate:
        type: object
        properties:
          certificateData:
            description: |-
              **string**
              Public part of the broker certificate.
            type: string
      LogOptions:
        type: object
        properties:
          logGroupId:
            description: |-
              **string**
              Entry should be written to log group resolved by ID.
              Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
              Includes only one of the fields `logGroupId`, `folderId`.
              Log entries destination.
            pattern: ([a-zA-Z][-a-zA-Z0-9_.]{0,63})?
            type: string
          folderId:
            description: |-
              **string**
              Entry should be written to default log group for specified folder.
              Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
              Includes only one of the fields `logGroupId`, `folderId`.
              Log entries destination.
            pattern: ([a-zA-Z][-a-zA-Z0-9_.]{0,63})?
            type: string
          disabled:
            description: |-
              **boolean**
              Is logging from broker disabled.
            type: boolean
          minLevel:
            description: |-
              **enum** (Level)
              Minimum log entry level.
              See [LogLevel.Level](/docs/logging/api-ref/Export/get#yandex.cloud.logging.v1.LogLevel.Level) for details.
              - `TRACE`: Trace log level.
              Possible use case: verbose logging of some business logic.
              - `DEBUG`: Debug log level.
              Possible use case: debugging special cases in application logic.
              - `INFO`: Info log level.
              Mostly used for information messages.
              - `WARN`: Warn log level.
              May be used to alert about significant events.
              - `ERROR`: Error log level.
              May be used to alert about errors in infrastructure, logic, etc.
              - `FATAL`: Fatal log level.
              May be used to alert about unrecoverable failures and events.
            type: string
            enum:
              - LEVEL_UNSPECIFIED
              - TRACE
              - DEBUG
              - INFO
              - WARN
              - ERROR
              - FATAL
        oneOf:
          - required:
              - logGroupId
          - required:
              - folderId
---

# IoT Core Broker Service, REST: Broker.Create

Creates a broker in the specified folder.

## HTTP request

```
POST https://{{ api-host-iot-broker }}/iot-broker/v1/brokers
```

## Body parameters {#yandex.cloud.iot.broker.v1.CreateBrokerRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "certificates": [
    {
      "certificateData": "string"
    }
  ],
  "password": "string",
  "logOptions": {
    // Includes only one of the fields `logGroupId`, `folderId`
    "logGroupId": "string",
    "folderId": "string",
    // end of the list of possible fields
    "disabled": "boolean",
    "minLevel": "string"
  }
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create a broker in.
To get a folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.

The maximum string length in characters is 50. ||
|| name | **string**

Name of the broker. The name must be unique within the folder.

The maximum string length in characters is 50. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| description | **string**

Description of the broker.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| certificates[] | **[Certificate](#yandex.cloud.iot.broker.v1.CreateBrokerRequest.Certificate)**

Broker certificates. ||
|| password | **string**

Broker passwords.
The password must contain at least three character categories among the following: upper case latin, lower case latin, numbers and special symbols. ||
|| logOptions | **[LogOptions](#yandex.cloud.iot.broker.v1.LogOptions)**

Options for logging broker events ||
|#

## Certificate {#yandex.cloud.iot.broker.v1.CreateBrokerRequest.Certificate}

Specification of a broker certificate.

#|
||Field | Description ||
|| certificateData | **string**

Public part of the broker certificate. ||
|#

## LogOptions {#yandex.cloud.iot.broker.v1.LogOptions}

#|
||Field | Description ||
|| logGroupId | **string**

Entry should be written to log group resolved by ID.

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `logGroupId`, `folderId`.

Log entries destination. ||
|| folderId | **string**

Entry should be written to default log group for specified folder.

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `logGroupId`, `folderId`.

Log entries destination. ||
|| disabled | **boolean**

Is logging from broker disabled. ||
|| minLevel | **enum** (Level)

Minimum log entry level.
See [LogLevel.Level](/docs/logging/api-ref/Export/get#yandex.cloud.logging.v1.LogLevel.Level) for details.

- `TRACE`: Trace log level.
Possible use case: verbose logging of some business logic.
- `DEBUG`: Debug log level.
Possible use case: debugging special cases in application logic.
- `INFO`: Info log level.
Mostly used for information messages.
- `WARN`: Warn log level.
May be used to alert about significant events.
- `ERROR`: Error log level.
May be used to alert about errors in infrastructure, logic, etc.
- `FATAL`: Fatal log level.
May be used to alert about unrecoverable failures and events. ||
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