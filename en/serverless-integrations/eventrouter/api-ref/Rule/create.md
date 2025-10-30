---
editable: false
apiPlayground:
  - url: https://serverless-eventrouter.{{ api-host }}/eventrouter/v1/rules
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        busId:
          description: |-
            **string**
            Required field. ID of the bus to create a rule for.
          type: string
        name:
          description: |-
            **string**
            Name of the rule.
          pattern: '|[a-z][-a-z0-9]{1,61}[a-z0-9]'
          type: string
        description:
          description: |-
            **string**
            Description of the rule.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Labels for the rule.
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
        filter:
          description: |-
            **[Filter](#yandex.cloud.serverless.eventrouter.v1.Filter)**
            Filter for the rule.
          $ref: '#/definitions/Filter'
        targets:
          description: |-
            **[Target](#yandex.cloud.serverless.eventrouter.v1.Target)**
            Targets for the rule.
          type: array
          items:
            $ref: '#/definitions/Target'
        deletionProtection:
          description: |-
            **boolean**
            Flag that disallow deletion of the rule.
          type: boolean
      required:
        - busId
      additionalProperties: false
    definitions:
      Filter:
        type: object
        properties:
          jqFilter:
            description: |-
              **string**
              JQ filter for matching events.
              Includes only one of the fields `jqFilter`.
            type: string
        oneOf:
          - required:
              - jqFilter
      YdsTarget:
        type: object
        properties:
          database:
            description: |-
              **string**
              Required field. Stream database.
            type: string
          streamName:
            description: |-
              **string**
              Required field. Full stream name, like /ru-central1/aoegtvhtp8ob********/cc8004q4lbo6********/test.
            type: string
          serviceAccountId:
            description: |-
              **string**
              Required field. Service account, which has write permission on the stream.
            type: string
        required:
          - database
          - streamName
          - serviceAccountId
      YmqTarget:
        type: object
        properties:
          queueArn:
            description: |-
              **string**
              Required field. Queue ARN.
              Example: yrn:yc:ymq:ru-central1:aoe***:test
            type: string
          serviceAccountId:
            description: |-
              **string**
              Required field. Service account which has write access to the queue.
            type: string
        required:
          - queueArn
          - serviceAccountId
      BatchSettings:
        type: object
        properties:
          maxCount:
            description: |-
              **string** (int64)
              Maximum batch size: trigger will send a batch if number of events exceeds this value.
            type: string
            format: int64
          maxBytes:
            description: |-
              **string** (int64)
              Maximum batch size: trigger will send a batch if total size of events exceeds this value.
            type: string
            format: int64
          cutoff:
            description: |-
              **string** (duration)
              Required field. Maximum batch size: trigger will send a batch if its lifetime exceeds this value.
            type: string
            format: duration
        required:
          - cutoff
      FunctionTarget:
        type: object
        properties:
          functionId:
            description: |-
              **string**
              Required field. Function ID.
            type: string
          functionTag:
            description: |-
              **string**
              Function tag, optional.
            type: string
          serviceAccountId:
            description: |-
              **string**
              Service account which has call permission on the function, optional.
            type: string
          batchSettings:
            description: |-
              **[BatchSettings](#yandex.cloud.serverless.eventrouter.v1.BatchSettings)**
              Batch settings.
            $ref: '#/definitions/BatchSettings'
        required:
          - functionId
      ContainerTarget:
        type: object
        properties:
          containerId:
            description: |-
              **string**
              Required field. Container ID.
            type: string
          containerRevisionId:
            description: |-
              **string**
              Container revision ID.
            type: string
          path:
            description: |-
              **string**
              Endpoint HTTP path to invoke.
            type: string
          serviceAccountId:
            description: |-
              **string**
              Service account which should be used to call a container, optional.
            type: string
          batchSettings:
            description: |-
              **[BatchSettings](#yandex.cloud.serverless.eventrouter.v1.BatchSettings)**
              Batch settings.
            $ref: '#/definitions/BatchSettings'
        required:
          - containerId
      GatewayWebsocketBroadcastTarget:
        type: object
        properties:
          gatewayId:
            description: |-
              **string**
              Required field. Gateway ID.
            type: string
          path:
            description: |-
              **string**
              Required field. Path.
            type: string
          serviceAccountId:
            description: |-
              **string**
              Required field. Service account which has permission for writing to websockets.
            type: string
          batchSettings:
            description: |-
              **[BatchSettings](#yandex.cloud.serverless.eventrouter.v1.BatchSettings)**
              Batch settings.
            $ref: '#/definitions/BatchSettings'
        required:
          - gatewayId
          - path
          - serviceAccountId
      LoggingTarget:
        type: object
        properties:
          logGroupId:
            description: |-
              **string**
              Includes only one of the fields `logGroupId`, `folderId`.
              Log group ID or folder ID.
            type: string
          folderId:
            description: |-
              **string**
              Includes only one of the fields `logGroupId`, `folderId`.
              Log group ID or folder ID.
            type: string
          serviceAccountId:
            description: |-
              **string**
              Required field. Service account which has permission for writing logs.
            type: string
        required:
          - serviceAccountId
        oneOf:
          - required:
              - logGroupId
          - required:
              - folderId
      WorkflowTarget:
        type: object
        properties:
          workflowId:
            description: |-
              **string**
              Required field. Workflow ID.
            type: string
          serviceAccountId:
            description: |-
              **string**
              Required field. SA which should be used to start workflow.
            type: string
          batchSettings:
            description: |-
              **[BatchSettings](#yandex.cloud.serverless.eventrouter.v1.BatchSettings)**
              Batch settings.
            $ref: '#/definitions/BatchSettings'
        required:
          - workflowId
          - serviceAccountId
      Transformer:
        type: object
        properties:
          jqTransformer:
            description: |-
              **string**
              JQ string inrerpolation expression for changing event format.
              Includes only one of the fields `jqTransformer`.
            type: string
        oneOf:
          - required:
              - jqTransformer
      RetrySettings:
        type: object
        properties:
          retryAttempts:
            description: |-
              **string** (int64)
              Maximum number of retries (extra calls) before an action fails.
            type: string
            format: int64
          maximumAge:
            description: |-
              **string** (duration)
              Event goes to dlq when its age exceeds this value. Default is 24h.
            type: string
            format: duration
      PutQueueMessage:
        type: object
        properties:
          queueArn:
            description: |-
              **string**
              ID of the queue.
            type: string
          serviceAccountId:
            description: |-
              **string**
              Required field. Service account which has write permission on the queue.
            type: string
        required:
          - serviceAccountId
      Target:
        type: object
        properties:
          yds:
            description: |-
              **[YdsTarget](#yandex.cloud.serverless.eventrouter.v1.YdsTarget)**
              Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`.
            $ref: '#/definitions/YdsTarget'
          ymq:
            description: |-
              **[YmqTarget](#yandex.cloud.serverless.eventrouter.v1.YmqTarget)**
              Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`.
            $ref: '#/definitions/YmqTarget'
          function:
            description: |-
              **[FunctionTarget](#yandex.cloud.serverless.eventrouter.v1.FunctionTarget)**
              Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`.
            $ref: '#/definitions/FunctionTarget'
          container:
            description: |-
              **[ContainerTarget](#yandex.cloud.serverless.eventrouter.v1.ContainerTarget)**
              Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`.
            $ref: '#/definitions/ContainerTarget'
          gatewayWsBroadcast:
            description: |-
              **[GatewayWebsocketBroadcastTarget](#yandex.cloud.serverless.eventrouter.v1.GatewayWebsocketBroadcastTarget)**
              Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`.
            $ref: '#/definitions/GatewayWebsocketBroadcastTarget'
          logging:
            description: |-
              **[LoggingTarget](#yandex.cloud.serverless.eventrouter.v1.LoggingTarget)**
              Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`.
            $ref: '#/definitions/LoggingTarget'
          workflow:
            description: |-
              **[WorkflowTarget](#yandex.cloud.serverless.eventrouter.v1.WorkflowTarget)**
              Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`.
            $ref: '#/definitions/WorkflowTarget'
          transformer:
            description: |-
              **[Transformer](#yandex.cloud.serverless.eventrouter.v1.Transformer)**
              Transformer of the target.
            $ref: '#/definitions/Transformer'
          retrySettings:
            description: |-
              **[RetrySettings](#yandex.cloud.serverless.eventrouter.v1.RetrySettings)**
              Retry settings of the target.
            $ref: '#/definitions/RetrySettings'
          deadLetterQueue:
            description: |-
              **[PutQueueMessage](#yandex.cloud.serverless.eventrouter.v1.PutQueueMessage)**
              Dead letter queue.
              Includes only one of the fields `deadLetterQueue`.
              Dead letter settings of the target.
            $ref: '#/definitions/PutQueueMessage'
          status:
            description: |-
              **enum** (Status)
              Status of the target.
              - `STATUS_UNSPECIFIED`
              - `CREATING`
              - `ACTIVE`
              - `DELETING`
            type: string
            enum:
              - STATUS_UNSPECIFIED
              - CREATING
              - ACTIVE
              - DELETING
        allOf:
          - oneOf:
              - required:
                  - yds
              - required:
                  - ymq
              - required:
                  - function
              - required:
                  - container
              - required:
                  - gatewayWsBroadcast
              - required:
                  - logging
              - required:
                  - workflow
          - oneOf:
              - required:
                  - deadLetterQueue
sourcePath: en/_api-ref/serverless/eventrouter/v1/eventrouter/api-ref/Rule/create.md
---

# EventRouter Service, REST: Rule.Create

Creates a rule in the specified folder.

## HTTP request

```
POST https://serverless-eventrouter.{{ api-host }}/eventrouter/v1/rules
```

## Body parameters {#yandex.cloud.serverless.eventrouter.v1.CreateRuleRequest}

```json
{
  "busId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "filter": {
    // Includes only one of the fields `jqFilter`
    "jqFilter": "string"
    // end of the list of possible fields
  },
  "targets": [
    {
      // Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`
      "yds": {
        "database": "string",
        "streamName": "string",
        "serviceAccountId": "string"
      },
      "ymq": {
        "queueArn": "string",
        "serviceAccountId": "string"
      },
      "function": {
        "functionId": "string",
        "functionTag": "string",
        "serviceAccountId": "string",
        "batchSettings": {
          "maxCount": "string",
          "maxBytes": "string",
          "cutoff": "string"
        }
      },
      "container": {
        "containerId": "string",
        "containerRevisionId": "string",
        "path": "string",
        "serviceAccountId": "string",
        "batchSettings": {
          "maxCount": "string",
          "maxBytes": "string",
          "cutoff": "string"
        }
      },
      "gatewayWsBroadcast": {
        "gatewayId": "string",
        "path": "string",
        "serviceAccountId": "string",
        "batchSettings": {
          "maxCount": "string",
          "maxBytes": "string",
          "cutoff": "string"
        }
      },
      "logging": {
        // Includes only one of the fields `logGroupId`, `folderId`
        "logGroupId": "string",
        "folderId": "string",
        // end of the list of possible fields
        "serviceAccountId": "string"
      },
      "workflow": {
        "workflowId": "string",
        "serviceAccountId": "string",
        "batchSettings": {
          "maxCount": "string",
          "maxBytes": "string",
          "cutoff": "string"
        }
      },
      // end of the list of possible fields
      "transformer": {
        // Includes only one of the fields `jqTransformer`
        "jqTransformer": "string"
        // end of the list of possible fields
      },
      "retrySettings": {
        "retryAttempts": "string",
        "maximumAge": "string"
      },
      // Includes only one of the fields `deadLetterQueue`
      "deadLetterQueue": {
        "queueArn": "string",
        "serviceAccountId": "string"
      },
      // end of the list of possible fields
      "status": "string"
    }
  ],
  "deletionProtection": "boolean"
}
```

#|
||Field | Description ||
|| busId | **string**

Required field. ID of the bus to create a rule for. ||
|| name | **string**

Name of the rule. ||
|| description | **string**

Description of the rule. ||
|| labels | **object** (map<**string**, **string**>)

Labels for the rule. ||
|| filter | **[Filter](#yandex.cloud.serverless.eventrouter.v1.Filter)**

Filter for the rule. ||
|| targets[] | **[Target](#yandex.cloud.serverless.eventrouter.v1.Target)**

Targets for the rule. ||
|| deletionProtection | **boolean**

Flag that disallow deletion of the rule. ||
|#

## Filter {#yandex.cloud.serverless.eventrouter.v1.Filter}

#|
||Field | Description ||
|| jqFilter | **string**

JQ filter for matching events.

Includes only one of the fields `jqFilter`. ||
|#

## Target {#yandex.cloud.serverless.eventrouter.v1.Target}

#|
||Field | Description ||
|| yds | **[YdsTarget](#yandex.cloud.serverless.eventrouter.v1.YdsTarget)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`. ||
|| ymq | **[YmqTarget](#yandex.cloud.serverless.eventrouter.v1.YmqTarget)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`. ||
|| function | **[FunctionTarget](#yandex.cloud.serverless.eventrouter.v1.FunctionTarget)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`. ||
|| container | **[ContainerTarget](#yandex.cloud.serverless.eventrouter.v1.ContainerTarget)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`. ||
|| gatewayWsBroadcast | **[GatewayWebsocketBroadcastTarget](#yandex.cloud.serverless.eventrouter.v1.GatewayWebsocketBroadcastTarget)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`. ||
|| logging | **[LoggingTarget](#yandex.cloud.serverless.eventrouter.v1.LoggingTarget)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`. ||
|| workflow | **[WorkflowTarget](#yandex.cloud.serverless.eventrouter.v1.WorkflowTarget)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`. ||
|| transformer | **[Transformer](#yandex.cloud.serverless.eventrouter.v1.Transformer)**

Transformer of the target. ||
|| retrySettings | **[RetrySettings](#yandex.cloud.serverless.eventrouter.v1.RetrySettings)**

Retry settings of the target. ||
|| deadLetterQueue | **[PutQueueMessage](#yandex.cloud.serverless.eventrouter.v1.PutQueueMessage)**

Dead letter queue.

Includes only one of the fields `deadLetterQueue`.

Dead letter settings of the target. ||
|| status | **enum** (Status)

Status of the target.

- `STATUS_UNSPECIFIED`
- `ENABLED`: Target is enabled.
- `DISABLED`: Target is disabled.
- `RESOURCE_NOT_FOUND`: Target does not exist.
- `PERMISSION_DENIED`: Service account does not have read permission on source.
- `SUBJECT_NOT_FOUND`: Service account not found. ||
|#

## YdsTarget {#yandex.cloud.serverless.eventrouter.v1.YdsTarget}

#|
||Field | Description ||
|| database | **string**

Required field. Stream database. ||
|| streamName | **string**

Required field. Full stream name, like /ru-central1/aoegtvhtp8ob********/cc8004q4lbo6********/test. ||
|| serviceAccountId | **string**

Required field. Service account, which has write permission on the stream. ||
|#

## YmqTarget {#yandex.cloud.serverless.eventrouter.v1.YmqTarget}

#|
||Field | Description ||
|| queueArn | **string**

Required field. Queue ARN.
Example: yrn:yc:ymq:ru-central1:aoe***:test ||
|| serviceAccountId | **string**

Required field. Service account which has write access to the queue. ||
|#

## FunctionTarget {#yandex.cloud.serverless.eventrouter.v1.FunctionTarget}

#|
||Field | Description ||
|| functionId | **string**

Required field. Function ID. ||
|| functionTag | **string**

Function tag, optional. ||
|| serviceAccountId | **string**

Service account which has call permission on the function, optional. ||
|| batchSettings | **[BatchSettings](#yandex.cloud.serverless.eventrouter.v1.BatchSettings)**

Batch settings. ||
|#

## BatchSettings {#yandex.cloud.serverless.eventrouter.v1.BatchSettings}

#|
||Field | Description ||
|| maxCount | **string** (int64)

Maximum batch size: trigger will send a batch if number of events exceeds this value. ||
|| maxBytes | **string** (int64)

Maximum batch size: trigger will send a batch if total size of events exceeds this value. ||
|| cutoff | **string** (duration)

Required field. Maximum batch size: trigger will send a batch if its lifetime exceeds this value. ||
|#

## ContainerTarget {#yandex.cloud.serverless.eventrouter.v1.ContainerTarget}

#|
||Field | Description ||
|| containerId | **string**

Required field. Container ID. ||
|| containerRevisionId | **string**

Container revision ID. ||
|| path | **string**

Endpoint HTTP path to invoke. ||
|| serviceAccountId | **string**

Service account which should be used to call a container, optional. ||
|| batchSettings | **[BatchSettings](#yandex.cloud.serverless.eventrouter.v1.BatchSettings)**

Batch settings. ||
|#

## GatewayWebsocketBroadcastTarget {#yandex.cloud.serverless.eventrouter.v1.GatewayWebsocketBroadcastTarget}

#|
||Field | Description ||
|| gatewayId | **string**

Required field. Gateway ID. ||
|| path | **string**

Required field. Path. ||
|| serviceAccountId | **string**

Required field. Service account which has permission for writing to websockets. ||
|| batchSettings | **[BatchSettings](#yandex.cloud.serverless.eventrouter.v1.BatchSettings)**

Batch settings. ||
|#

## LoggingTarget {#yandex.cloud.serverless.eventrouter.v1.LoggingTarget}

#|
||Field | Description ||
|| logGroupId | **string**

Includes only one of the fields `logGroupId`, `folderId`.

Log group ID or folder ID. ||
|| folderId | **string**

Includes only one of the fields `logGroupId`, `folderId`.

Log group ID or folder ID. ||
|| serviceAccountId | **string**

Required field. Service account which has permission for writing logs. ||
|#

## WorkflowTarget {#yandex.cloud.serverless.eventrouter.v1.WorkflowTarget}

#|
||Field | Description ||
|| workflowId | **string**

Required field. Workflow ID. ||
|| serviceAccountId | **string**

Required field. SA which should be used to start workflow. ||
|| batchSettings | **[BatchSettings](#yandex.cloud.serverless.eventrouter.v1.BatchSettings)**

Batch settings. ||
|#

## Transformer {#yandex.cloud.serverless.eventrouter.v1.Transformer}

#|
||Field | Description ||
|| jqTransformer | **string**

JQ string inrerpolation expression for changing event format.

Includes only one of the fields `jqTransformer`. ||
|#

## RetrySettings {#yandex.cloud.serverless.eventrouter.v1.RetrySettings}

#|
||Field | Description ||
|| retryAttempts | **string** (int64)

Maximum number of retries (extra calls) before an action fails. ||
|| maximumAge | **string** (duration)

Event goes to dlq when its age exceeds this value. Default is 24h. ||
|#

## PutQueueMessage {#yandex.cloud.serverless.eventrouter.v1.PutQueueMessage}

#|
||Field | Description ||
|| queueArn | **string**

ID of the queue. ||
|| serviceAccountId | **string**

Required field. Service account which has write permission on the queue. ||
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
    "ruleId": "string",
    "busId": "string"
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
    "busId": "string",
    "folderId": "string",
    "cloudId": "string",
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "filter": {
      // Includes only one of the fields `jqFilter`
      "jqFilter": "string"
      // end of the list of possible fields
    },
    "targets": [
      {
        // Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`
        "yds": {
          "database": "string",
          "streamName": "string",
          "serviceAccountId": "string"
        },
        "ymq": {
          "queueArn": "string",
          "serviceAccountId": "string"
        },
        "function": {
          "functionId": "string",
          "functionTag": "string",
          "serviceAccountId": "string",
          "batchSettings": {
            "maxCount": "string",
            "maxBytes": "string",
            "cutoff": "string"
          }
        },
        "container": {
          "containerId": "string",
          "containerRevisionId": "string",
          "path": "string",
          "serviceAccountId": "string",
          "batchSettings": {
            "maxCount": "string",
            "maxBytes": "string",
            "cutoff": "string"
          }
        },
        "gatewayWsBroadcast": {
          "gatewayId": "string",
          "path": "string",
          "serviceAccountId": "string",
          "batchSettings": {
            "maxCount": "string",
            "maxBytes": "string",
            "cutoff": "string"
          }
        },
        "logging": {
          // Includes only one of the fields `logGroupId`, `folderId`
          "logGroupId": "string",
          "folderId": "string",
          // end of the list of possible fields
          "serviceAccountId": "string"
        },
        "workflow": {
          "workflowId": "string",
          "serviceAccountId": "string",
          "batchSettings": {
            "maxCount": "string",
            "maxBytes": "string",
            "cutoff": "string"
          }
        },
        // end of the list of possible fields
        "transformer": {
          // Includes only one of the fields `jqTransformer`
          "jqTransformer": "string"
          // end of the list of possible fields
        },
        "retrySettings": {
          "retryAttempts": "string",
          "maximumAge": "string"
        },
        // Includes only one of the fields `deadLetterQueue`
        "deadLetterQueue": {
          "queueArn": "string",
          "serviceAccountId": "string"
        },
        // end of the list of possible fields
        "status": "string"
      }
    ],
    "deletionProtection": "boolean",
    "status": "string"
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
|| metadata | **[CreateRuleMetadata](#yandex.cloud.serverless.eventrouter.v1.CreateRuleMetadata)**

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
|| response | **[Rule](#yandex.cloud.serverless.eventrouter.v1.Rule)**

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

## CreateRuleMetadata {#yandex.cloud.serverless.eventrouter.v1.CreateRuleMetadata}

#|
||Field | Description ||
|| ruleId | **string**

ID of the rule that is being created. ||
|| busId | **string**

ID of the bus that the rule belongs to. ||
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

## Rule {#yandex.cloud.serverless.eventrouter.v1.Rule}

#|
||Field | Description ||
|| id | **string**

ID of the rule. ||
|| busId | **string**

ID of the bus that the rule belongs to. ||
|| folderId | **string**

ID of the folder that the rule resides in. ||
|| cloudId | **string**

ID of the cloud that the rule resides in. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the rule. ||
|| description | **string**

Description of the rule. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| filter | **[Filter](#yandex.cloud.serverless.eventrouter.v1.Filter2)**

Filter for the rule. ||
|| targets[] | **[Target](#yandex.cloud.serverless.eventrouter.v1.Target2)**

Targets of the rule. ||
|| deletionProtection | **boolean**

Flag that disallow deletion of the rule. ||
|| status | **enum** (Status)

Rule status

- `STATUS_UNSPECIFIED`
- `CREATING`: Rule creation in progress, rule is not enabled yet
- `ENABLED`: Rule is operating
- `UPDATING`: Rule update in progress, rule is disabled during update
- `DISABLED`: Rule is explicitly disabled by the user
- `DELETING`: Rule deletion in progress ||
|#

## Filter {#yandex.cloud.serverless.eventrouter.v1.Filter2}

#|
||Field | Description ||
|| jqFilter | **string**

JQ filter for matching events.

Includes only one of the fields `jqFilter`. ||
|#

## Target {#yandex.cloud.serverless.eventrouter.v1.Target2}

#|
||Field | Description ||
|| yds | **[YdsTarget](#yandex.cloud.serverless.eventrouter.v1.YdsTarget2)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`. ||
|| ymq | **[YmqTarget](#yandex.cloud.serverless.eventrouter.v1.YmqTarget2)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`. ||
|| function | **[FunctionTarget](#yandex.cloud.serverless.eventrouter.v1.FunctionTarget2)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`. ||
|| container | **[ContainerTarget](#yandex.cloud.serverless.eventrouter.v1.ContainerTarget2)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`. ||
|| gatewayWsBroadcast | **[GatewayWebsocketBroadcastTarget](#yandex.cloud.serverless.eventrouter.v1.GatewayWebsocketBroadcastTarget2)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`. ||
|| logging | **[LoggingTarget](#yandex.cloud.serverless.eventrouter.v1.LoggingTarget2)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`. ||
|| workflow | **[WorkflowTarget](#yandex.cloud.serverless.eventrouter.v1.WorkflowTarget2)**

Includes only one of the fields `yds`, `ymq`, `function`, `container`, `gatewayWsBroadcast`, `logging`, `workflow`. ||
|| transformer | **[Transformer](#yandex.cloud.serverless.eventrouter.v1.Transformer2)**

Transformer of the target. ||
|| retrySettings | **[RetrySettings](#yandex.cloud.serverless.eventrouter.v1.RetrySettings2)**

Retry settings of the target. ||
|| deadLetterQueue | **[PutQueueMessage](#yandex.cloud.serverless.eventrouter.v1.PutQueueMessage2)**

Dead letter queue.

Includes only one of the fields `deadLetterQueue`.

Dead letter settings of the target. ||
|| status | **enum** (Status)

Status of the target.

- `STATUS_UNSPECIFIED`
- `ENABLED`: Target is enabled.
- `DISABLED`: Target is disabled.
- `RESOURCE_NOT_FOUND`: Target does not exist.
- `PERMISSION_DENIED`: Service account does not have read permission on source.
- `SUBJECT_NOT_FOUND`: Service account not found. ||
|#

## YdsTarget {#yandex.cloud.serverless.eventrouter.v1.YdsTarget2}

#|
||Field | Description ||
|| database | **string**

Required field. Stream database. ||
|| streamName | **string**

Required field. Full stream name, like /ru-central1/aoegtvhtp8ob********/cc8004q4lbo6********/test. ||
|| serviceAccountId | **string**

Required field. Service account, which has write permission on the stream. ||
|#

## YmqTarget {#yandex.cloud.serverless.eventrouter.v1.YmqTarget2}

#|
||Field | Description ||
|| queueArn | **string**

Required field. Queue ARN.
Example: yrn:yc:ymq:ru-central1:aoe***:test ||
|| serviceAccountId | **string**

Required field. Service account which has write access to the queue. ||
|#

## FunctionTarget {#yandex.cloud.serverless.eventrouter.v1.FunctionTarget2}

#|
||Field | Description ||
|| functionId | **string**

Required field. Function ID. ||
|| functionTag | **string**

Function tag, optional. ||
|| serviceAccountId | **string**

Service account which has call permission on the function, optional. ||
|| batchSettings | **[BatchSettings](#yandex.cloud.serverless.eventrouter.v1.BatchSettings2)**

Batch settings. ||
|#

## BatchSettings {#yandex.cloud.serverless.eventrouter.v1.BatchSettings2}

#|
||Field | Description ||
|| maxCount | **string** (int64)

Maximum batch size: trigger will send a batch if number of events exceeds this value. ||
|| maxBytes | **string** (int64)

Maximum batch size: trigger will send a batch if total size of events exceeds this value. ||
|| cutoff | **string** (duration)

Required field. Maximum batch size: trigger will send a batch if its lifetime exceeds this value. ||
|#

## ContainerTarget {#yandex.cloud.serverless.eventrouter.v1.ContainerTarget2}

#|
||Field | Description ||
|| containerId | **string**

Required field. Container ID. ||
|| containerRevisionId | **string**

Container revision ID. ||
|| path | **string**

Endpoint HTTP path to invoke. ||
|| serviceAccountId | **string**

Service account which should be used to call a container, optional. ||
|| batchSettings | **[BatchSettings](#yandex.cloud.serverless.eventrouter.v1.BatchSettings2)**

Batch settings. ||
|#

## GatewayWebsocketBroadcastTarget {#yandex.cloud.serverless.eventrouter.v1.GatewayWebsocketBroadcastTarget2}

#|
||Field | Description ||
|| gatewayId | **string**

Required field. Gateway ID. ||
|| path | **string**

Required field. Path. ||
|| serviceAccountId | **string**

Required field. Service account which has permission for writing to websockets. ||
|| batchSettings | **[BatchSettings](#yandex.cloud.serverless.eventrouter.v1.BatchSettings2)**

Batch settings. ||
|#

## LoggingTarget {#yandex.cloud.serverless.eventrouter.v1.LoggingTarget2}

#|
||Field | Description ||
|| logGroupId | **string**

Includes only one of the fields `logGroupId`, `folderId`.

Log group ID or folder ID. ||
|| folderId | **string**

Includes only one of the fields `logGroupId`, `folderId`.

Log group ID or folder ID. ||
|| serviceAccountId | **string**

Required field. Service account which has permission for writing logs. ||
|#

## WorkflowTarget {#yandex.cloud.serverless.eventrouter.v1.WorkflowTarget2}

#|
||Field | Description ||
|| workflowId | **string**

Required field. Workflow ID. ||
|| serviceAccountId | **string**

Required field. SA which should be used to start workflow. ||
|| batchSettings | **[BatchSettings](#yandex.cloud.serverless.eventrouter.v1.BatchSettings2)**

Batch settings. ||
|#

## Transformer {#yandex.cloud.serverless.eventrouter.v1.Transformer2}

#|
||Field | Description ||
|| jqTransformer | **string**

JQ string inrerpolation expression for changing event format.

Includes only one of the fields `jqTransformer`. ||
|#

## RetrySettings {#yandex.cloud.serverless.eventrouter.v1.RetrySettings2}

#|
||Field | Description ||
|| retryAttempts | **string** (int64)

Maximum number of retries (extra calls) before an action fails. ||
|| maximumAge | **string** (duration)

Event goes to dlq when its age exceeds this value. Default is 24h. ||
|#

## PutQueueMessage {#yandex.cloud.serverless.eventrouter.v1.PutQueueMessage2}

#|
||Field | Description ||
|| queueArn | **string**

ID of the queue. ||
|| serviceAccountId | **string**

Required field. Service account which has write permission on the queue. ||
|#