---
editable: false
---

# Cloud Functions Audit Trails Events: CreateTrigger

## Event JSON schema {#yandex.cloud.audit.serverless.triggers.CreateTrigger2-schema}

```json
{
  "eventId": "string",
  "eventSource": "string",
  "eventType": "string",
  "eventTime": "string",
  "authentication": {
    "authenticated": "boolean",
    // Includes only one of the fields `subjectType`
    "subjectType": "string",
    // end of the list of possible fields
    // Includes only one of the fields `subjectId`
    "subjectId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `subjectName`
    "subjectName": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationId`
    "federationId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationName`
    "federationName": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationType`
    "federationType": "string",
    // end of the list of possible fields
    "tokenInfo": {
      "maskedIamToken": "string",
      // Includes only one of the fields `iamTokenId`
      "iamTokenId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorId`
      "impersonatorId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorType`
      "impersonatorType": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorName`
      "impersonatorName": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationId`
      "impersonatorFederationId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationName`
      "impersonatorFederationName": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationType`
      "impersonatorFederationType": "string"
      // end of the list of possible fields
    }
  },
  "authorization": {
    "authorized": "boolean"
  },
  "resourceMetadata": {
    "path": [
      {
        "resourceType": "string",
        "resourceId": "string",
        // Includes only one of the fields `resourceName`
        "resourceName": "string"
        // end of the list of possible fields
      }
    ]
  },
  "requestMetadata": {
    "remoteAddress": "string",
    "userAgent": "string",
    "requestId": "string",
    // Includes only one of the fields `remotePort`
    "remotePort": "string"
    // end of the list of possible fields
  },
  "eventStatus": "string",
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "details": {
    "triggerName": "string",
    "triggerId": "string",
    "triggerRule": {
      // Includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`
      "timer": {
        "cronExpression": "string",
        "payload": "string",
        // Includes only one of the fields `invokeFunction`, `invokeFunctionWithRetry`, `invokeContainerWithRetry`, `gatewayWebsocketBroadcast`, `startWorkflow`
        "invokeFunction": {
          "functionId": "string",
          "functionTag": "string",
          "serviceAccountId": "string"
        },
        "invokeFunctionWithRetry": {
          "functionId": "string",
          "functionTag": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "invokeContainerWithRetry": {
          "containerId": "string",
          "path": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "gatewayWebsocketBroadcast": {
          "gatewayId": "string",
          "path": "string",
          "serviceAccountId": "string"
        },
        "startWorkflow": {
          "workflowId": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        }
        // end of the list of possible fields
      },
      "messageQueue": {
        "queueId": "string",
        "serviceAccountId": "string",
        "batchSettings": {
          "size": "string",
          "cutoff": "string"
        },
        "visibilityTimeout": "string",
        // Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`
        "invokeFunction": {
          "functionId": "string",
          "functionTag": "string",
          "serviceAccountId": "string"
        },
        "invokeContainer": {
          "containerId": "string",
          "path": "string",
          "serviceAccountId": "string"
        },
        "gatewayWebsocketBroadcast": {
          "gatewayId": "string",
          "path": "string",
          "serviceAccountId": "string"
        },
        "startWorkflow": {
          "workflowId": "string",
          "serviceAccountId": "string"
        }
        // end of the list of possible fields
      },
      "iotMessage": {
        "registryId": "string",
        "deviceId": "string",
        "mqttTopic": "string",
        "batchSettings": {
          "size": "string",
          "cutoff": "string"
        },
        // Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`
        "invokeFunction": {
          "functionId": "string",
          "functionTag": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "invokeContainer": {
          "containerId": "string",
          "path": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "gatewayWebsocketBroadcast": {
          "gatewayId": "string",
          "path": "string",
          "serviceAccountId": "string"
        }
        // end of the list of possible fields
      },
      "iotBrokerMessage": {
        "brokerId": "string",
        "mqttTopic": "string",
        "batchSettings": {
          "size": "string",
          "cutoff": "string"
        },
        // Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`
        "invokeFunction": {
          "functionId": "string",
          "functionTag": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "invokeContainer": {
          "containerId": "string",
          "path": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "gatewayWebsocketBroadcast": {
          "gatewayId": "string",
          "path": "string",
          "serviceAccountId": "string"
        }
        // end of the list of possible fields
      },
      "objectStorage": {
        "eventType": [
          "string"
        ],
        "bucketId": "string",
        "prefix": "string",
        "suffix": "string",
        "batchSettings": {
          "size": "string",
          "cutoff": "string"
        },
        // Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`
        "invokeFunction": {
          "functionId": "string",
          "functionTag": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "invokeContainer": {
          "containerId": "string",
          "path": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "gatewayWebsocketBroadcast": {
          "gatewayId": "string",
          "path": "string",
          "serviceAccountId": "string"
        },
        "startWorkflow": {
          "workflowId": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        }
        // end of the list of possible fields
      },
      "containerRegistry": {
        "eventType": [
          "string"
        ],
        "registryId": "string",
        "imageName": "string",
        "tag": "string",
        "batchSettings": {
          "size": "string",
          "cutoff": "string"
        },
        // Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`
        "invokeFunction": {
          "functionId": "string",
          "functionTag": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "invokeContainer": {
          "containerId": "string",
          "path": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "gatewayWebsocketBroadcast": {
          "gatewayId": "string",
          "path": "string",
          "serviceAccountId": "string"
        },
        "startWorkflow": {
          "workflowId": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        }
        // end of the list of possible fields
      },
      "cloudLogs": {
        "logGroupId": [
          "string"
        ],
        "batchSettings": {
          "size": "string",
          "cutoff": "string"
        },
        // Includes only one of the fields `invokeFunction`, `invokeContainer`
        "invokeFunction": {
          "functionId": "string",
          "functionTag": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "invokeContainer": {
          "containerId": "string",
          "path": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        }
        // end of the list of possible fields
      },
      "logging": {
        "logGroupId": "string",
        "resourceType": [
          "string"
        ],
        "resourceId": [
          "string"
        ],
        "streamName": [
          "string"
        ],
        "levels": [
          "string"
        ],
        "batchSettings": {
          "size": "string",
          "cutoff": "string"
        },
        // Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`
        "invokeFunction": {
          "functionId": "string",
          "functionTag": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "invokeContainer": {
          "containerId": "string",
          "path": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "gatewayWebsocketBroadcast": {
          "gatewayId": "string",
          "path": "string",
          "serviceAccountId": "string"
        },
        "startWorkflow": {
          "workflowId": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        }
        // end of the list of possible fields
      },
      "billingBudget": {
        "billingAccountId": "string",
        "budgetId": "string",
        // Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`
        "invokeFunction": {
          "functionId": "string",
          "functionTag": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "invokeContainer": {
          "containerId": "string",
          "path": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "gatewayWebsocketBroadcast": {
          "gatewayId": "string",
          "path": "string",
          "serviceAccountId": "string"
        },
        "startWorkflow": {
          "workflowId": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        }
        // end of the list of possible fields
      },
      "dataStream": {
        "endpoint": "string",
        "database": "string",
        "stream": "string",
        "serviceAccountId": "string",
        "batchSettings": {
          "size": "string",
          "cutoff": "string"
        },
        // Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`
        "invokeFunction": {
          "functionId": "string",
          "functionTag": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "invokeContainer": {
          "containerId": "string",
          "path": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "gatewayWebsocketBroadcast": {
          "gatewayId": "string",
          "path": "string",
          "serviceAccountId": "string"
        },
        "startWorkflow": {
          "workflowId": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        }
        // end of the list of possible fields
      },
      "mail": {
        "email": "string",
        "batchSettings": {
          "size": "string",
          "cutoff": "string"
        },
        "attachmentsBucket": {
          "bucketId": "string",
          "serviceAccountId": "string"
        },
        // Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`
        "invokeFunction": {
          "functionId": "string",
          "functionTag": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "invokeContainer": {
          "containerId": "string",
          "path": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        },
        "gatewayWebsocketBroadcast": {
          "gatewayId": "string",
          "path": "string",
          "serviceAccountId": "string"
        },
        "startWorkflow": {
          "workflowId": "string",
          "serviceAccountId": "string",
          "retrySettings": {
            "retryAttempts": "string",
            "interval": "string"
          },
          "deadLetterQueue": {
            "queueId": "string",
            "serviceAccountId": "string"
          }
        }
        // end of the list of possible fields
      }
      // end of the list of possible fields
    },
    "labels": "object",
    "description": "string"
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.serverless.triggers.CreateTrigger2}

#|
||Field | Description ||
|| eventId | **string** ||
|| eventSource | **string** ||
|| eventType | **string** ||
|| eventTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| authentication | **[IamAuthentication](#yandex.cloud.audit.IamAuthentication)** ||
|| authorization | **[Authorization](#yandex.cloud.audit.Authorization)** ||
|| resourceMetadata | **[ResourceMetadata](#yandex.cloud.audit.ResourceMetadata)** ||
|| requestMetadata | **[RequestMetadata](#yandex.cloud.audit.RequestMetadata)** ||
|| eventStatus | **enum** (EventStatus)

- `STARTED`
- `ERROR`
- `DONE`
- `CANCELLED`
- `RUNNING` ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation. ||
|| details | **[TriggerEventDetails](#yandex.cloud.audit.serverless.triggers.TriggerEventDetails)** ||
|| requestParameters | **object** ||
|| response | **object** ||
|#

## IamAuthentication {#yandex.cloud.audit.IamAuthentication}

#|
||Field | Description ||
|| authenticated | **boolean** ||
|| subjectType | **enum** (IamSubjectType)

Includes only one of the fields `subjectType`.

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| subjectId | **string**

Includes only one of the fields `subjectId`. ||
|| subjectName | **string**

Includes only one of the fields `subjectName`. ||
|| federationId | **string**

Includes only one of the fields `federationId`. ||
|| federationName | **string**

Includes only one of the fields `federationName`. ||
|| federationType | **enum** (FederationType)

Includes only one of the fields `federationType`.

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|| tokenInfo | **[IamTokenInfo](#yandex.cloud.audit.IamAuthentication.IamTokenInfo)** ||
|#

## IamTokenInfo {#yandex.cloud.audit.IamAuthentication.IamTokenInfo}

#|
||Field | Description ||
|| maskedIamToken | **string** ||
|| iamTokenId | **string**

Includes only one of the fields `iamTokenId`. ||
|| impersonatorId | **string**

Includes only one of the fields `impersonatorId`. ||
|| impersonatorType | **enum** (IamSubjectType)

Includes only one of the fields `impersonatorType`.

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| impersonatorName | **string**

Includes only one of the fields `impersonatorName`. ||
|| impersonatorFederationId | **string**

Includes only one of the fields `impersonatorFederationId`. ||
|| impersonatorFederationName | **string**

Includes only one of the fields `impersonatorFederationName`. ||
|| impersonatorFederationType | **enum** (FederationType)

Includes only one of the fields `impersonatorFederationType`.

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|#

## Authorization {#yandex.cloud.audit.Authorization}

#|
||Field | Description ||
|| authorized | **boolean** ||
|#

## ResourceMetadata {#yandex.cloud.audit.ResourceMetadata}

#|
||Field | Description ||
|| path[] | **[Resource](#yandex.cloud.audit.Resource)** ||
|#

## Resource {#yandex.cloud.audit.Resource}

#|
||Field | Description ||
|| resourceType | **string** ||
|| resourceId | **string** ||
|| resourceName | **string**

Includes only one of the fields `resourceName`. ||
|#

## RequestMetadata {#yandex.cloud.audit.RequestMetadata}

#|
||Field | Description ||
|| remoteAddress | **string** ||
|| userAgent | **string** ||
|| requestId | **string** ||
|| remotePort | **string** (int64)

Includes only one of the fields `remotePort`. ||
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

## TriggerEventDetails {#yandex.cloud.audit.serverless.triggers.TriggerEventDetails}

#|
||Field | Description ||
|| triggerName | **string** ||
|| triggerId | **string** ||
|| triggerRule | **[Rule](#yandex.cloud.serverless.triggers.v1.Trigger.Rule)** ||
|| labels | **object** (map<**string**, **string**>) ||
|| description | **string** ||
|#

## Rule {#yandex.cloud.serverless.triggers.v1.Trigger.Rule}

#|
||Field | Description ||
|| timer | **[Timer](#yandex.cloud.serverless.triggers.v1.Trigger.Timer)**

Includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`. ||
|| messageQueue | **[MessageQueue](#yandex.cloud.serverless.triggers.v1.Trigger.MessageQueue)**

Includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`. ||
|| iotMessage | **[IoTMessage](#yandex.cloud.serverless.triggers.v1.Trigger.IoTMessage)**

Includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`. ||
|| iotBrokerMessage | **[IoTBrokerMessage](#yandex.cloud.serverless.triggers.v1.Trigger.IoTBrokerMessage)**

Includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`. ||
|| objectStorage | **[ObjectStorage](#yandex.cloud.serverless.triggers.v1.Trigger.ObjectStorage)**

Includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`. ||
|| containerRegistry | **[ContainerRegistry](#yandex.cloud.serverless.triggers.v1.Trigger.ContainerRegistry)**

Includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`. ||
|| cloudLogs | **[CloudLogs](#yandex.cloud.serverless.triggers.v1.Trigger.CloudLogs)**

Includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`. ||
|| logging | **[Logging](#yandex.cloud.serverless.triggers.v1.Trigger.Logging)**

Includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`. ||
|| billingBudget | **[BillingBudget](#yandex.cloud.serverless.triggers.v1.BillingBudget)**

Includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`. ||
|| dataStream | **[DataStream](#yandex.cloud.serverless.triggers.v1.DataStream)**

Includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`. ||
|| mail | **[Mail](#yandex.cloud.serverless.triggers.v1.Mail)**

Includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`. ||
|#

## Timer {#yandex.cloud.serverless.triggers.v1.Trigger.Timer}

#|
||Field | Description ||
|| cronExpression | **string**

The maximum string length in characters is 100. ||
|| payload | **string**

The maximum string length in characters is 4096. ||
|| invokeFunction | **[InvokeFunctionOnce](#yandex.cloud.serverless.triggers.v1.InvokeFunctionOnce)**

Includes only one of the fields `invokeFunction`, `invokeFunctionWithRetry`, `invokeContainerWithRetry`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|| invokeFunctionWithRetry | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeFunctionWithRetry`, `invokeContainerWithRetry`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|| invokeContainerWithRetry | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeFunctionWithRetry`, `invokeContainerWithRetry`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|| gatewayWebsocketBroadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast)**

Includes only one of the fields `invokeFunction`, `invokeFunctionWithRetry`, `invokeContainerWithRetry`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|| startWorkflow | **[StartWorkflowWithRetry](#yandex.cloud.serverless.triggers.v1.StartWorkflowWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeFunctionWithRetry`, `invokeContainerWithRetry`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|#

## InvokeFunctionOnce {#yandex.cloud.serverless.triggers.v1.InvokeFunctionOnce}

#|
||Field | Description ||
|| functionId | **string**

The maximum string length in characters is 50. ||
|| functionTag | **string** ||
|| serviceAccountId | **string** ||
|#

## InvokeFunctionWithRetry {#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry}

#|
||Field | Description ||
|| functionId | **string**

The maximum string length in characters is 50. ||
|| functionTag | **string** ||
|| serviceAccountId | **string** ||
|| retrySettings | **[RetrySettings](#yandex.cloud.serverless.triggers.v1.RetrySettings)** ||
|| deadLetterQueue | **[PutQueueMessage](#yandex.cloud.serverless.triggers.v1.PutQueueMessage)** ||
|#

## RetrySettings {#yandex.cloud.serverless.triggers.v1.RetrySettings}

#|
||Field | Description ||
|| retryAttempts | **string** (int64)

Acceptable values are 1 to 5, inclusive. ||
|| interval | **string** (duration) ||
|#

## PutQueueMessage {#yandex.cloud.serverless.triggers.v1.PutQueueMessage}

#|
||Field | Description ||
|| queueId | **string** ||
|| serviceAccountId | **string**

The maximum string length in characters is 50. ||
|#

## InvokeContainerWithRetry {#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry}

#|
||Field | Description ||
|| containerId | **string**

The maximum string length in characters is 50. ||
|| path | **string** ||
|| serviceAccountId | **string** ||
|| retrySettings | **[RetrySettings](#yandex.cloud.serverless.triggers.v1.RetrySettings)** ||
|| deadLetterQueue | **[PutQueueMessage](#yandex.cloud.serverless.triggers.v1.PutQueueMessage)** ||
|#

## GatewayWebsocketBroadcast {#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast}

#|
||Field | Description ||
|| gatewayId | **string**

The maximum string length in characters is 50. ||
|| path | **string** ||
|| serviceAccountId | **string**

The maximum string length in characters is 50. ||
|#

## StartWorkflowWithRetry {#yandex.cloud.serverless.triggers.v1.StartWorkflowWithRetry}

#|
||Field | Description ||
|| workflowId | **string**

The maximum string length in characters is 50. ||
|| serviceAccountId | **string** ||
|| retrySettings | **[RetrySettings](#yandex.cloud.serverless.triggers.v1.RetrySettings)** ||
|| deadLetterQueue | **[PutQueueMessage](#yandex.cloud.serverless.triggers.v1.PutQueueMessage)** ||
|#

## MessageQueue {#yandex.cloud.serverless.triggers.v1.Trigger.MessageQueue}

#|
||Field | Description ||
|| queueId | **string** ||
|| serviceAccountId | **string**

The maximum string length in characters is 50. ||
|| batchSettings | **[BatchSettings](#yandex.cloud.serverless.triggers.v1.BatchSettings)** ||
|| visibilityTimeout | **string** (duration) ||
|| invokeFunction | **[InvokeFunctionOnce](#yandex.cloud.serverless.triggers.v1.InvokeFunctionOnce)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|| invokeContainer | **[InvokeContainerOnce](#yandex.cloud.serverless.triggers.v1.InvokeContainerOnce)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|| gatewayWebsocketBroadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|| startWorkflow | **[StartWorkflowOnce](#yandex.cloud.serverless.triggers.v1.StartWorkflowOnce)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|#

## BatchSettings {#yandex.cloud.serverless.triggers.v1.BatchSettings}

#|
||Field | Description ||
|| size | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| cutoff | **string** (duration) ||
|#

## InvokeContainerOnce {#yandex.cloud.serverless.triggers.v1.InvokeContainerOnce}

#|
||Field | Description ||
|| containerId | **string**

The maximum string length in characters is 50. ||
|| path | **string** ||
|| serviceAccountId | **string** ||
|#

## StartWorkflowOnce {#yandex.cloud.serverless.triggers.v1.StartWorkflowOnce}

#|
||Field | Description ||
|| workflowId | **string**

The maximum string length in characters is 50. ||
|| serviceAccountId | **string** ||
|#

## IoTMessage {#yandex.cloud.serverless.triggers.v1.Trigger.IoTMessage}

#|
||Field | Description ||
|| registryId | **string** ||
|| deviceId | **string** ||
|| mqttTopic | **string** ||
|| batchSettings | **[BatchSettings](#yandex.cloud.serverless.triggers.v1.BatchSettings)** ||
|| invokeFunction | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`. ||
|| invokeContainer | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`. ||
|| gatewayWebsocketBroadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`. ||
|#

## IoTBrokerMessage {#yandex.cloud.serverless.triggers.v1.Trigger.IoTBrokerMessage}

#|
||Field | Description ||
|| brokerId | **string** ||
|| mqttTopic | **string** ||
|| batchSettings | **[BatchSettings](#yandex.cloud.serverless.triggers.v1.BatchSettings)** ||
|| invokeFunction | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`. ||
|| invokeContainer | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`. ||
|| gatewayWebsocketBroadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`. ||
|#

## ObjectStorage {#yandex.cloud.serverless.triggers.v1.Trigger.ObjectStorage}

#|
||Field | Description ||
|| eventType[] | **enum** (ObjectStorageEventType)

The number of elements must be greater than 0.

- `OBJECT_STORAGE_EVENT_TYPE_CREATE_OBJECT`
- `OBJECT_STORAGE_EVENT_TYPE_UPDATE_OBJECT`
- `OBJECT_STORAGE_EVENT_TYPE_DELETE_OBJECT` ||
|| bucketId | **string** ||
|| prefix | **string** ||
|| suffix | **string** ||
|| batchSettings | **[BatchSettings](#yandex.cloud.serverless.triggers.v1.BatchSettings)** ||
|| invokeFunction | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|| invokeContainer | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|| gatewayWebsocketBroadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|| startWorkflow | **[StartWorkflowWithRetry](#yandex.cloud.serverless.triggers.v1.StartWorkflowWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|#

## ContainerRegistry {#yandex.cloud.serverless.triggers.v1.Trigger.ContainerRegistry}

#|
||Field | Description ||
|| eventType[] | **enum** (ContainerRegistryEventType)

The number of elements must be greater than 0.

- `CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE`
- `CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE`
- `CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE_TAG`
- `CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE_TAG` ||
|| registryId | **string** ||
|| imageName | **string** ||
|| tag | **string** ||
|| batchSettings | **[BatchSettings](#yandex.cloud.serverless.triggers.v1.BatchSettings)** ||
|| invokeFunction | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|| invokeContainer | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|| gatewayWebsocketBroadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|| startWorkflow | **[StartWorkflowWithRetry](#yandex.cloud.serverless.triggers.v1.StartWorkflowWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|#

## CloudLogs {#yandex.cloud.serverless.triggers.v1.Trigger.CloudLogs}

#|
||Field | Description ||
|| logGroupId[] | **string** ||
|| batchSettings | **[CloudLogsBatchSettings](#yandex.cloud.serverless.triggers.v1.CloudLogsBatchSettings)** ||
|| invokeFunction | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeContainer`. ||
|| invokeContainer | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeContainer`. ||
|#

## CloudLogsBatchSettings {#yandex.cloud.serverless.triggers.v1.CloudLogsBatchSettings}

#|
||Field | Description ||
|| size | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|| cutoff | **string** (duration) ||
|#

## Logging {#yandex.cloud.serverless.triggers.v1.Trigger.Logging}

#|
||Field | Description ||
|| logGroupId | **string**

The maximum string length in characters is 50. ||
|| resourceType[] | **string**

Each value must match the regular expression ` [a-zA-Z][-a-zA-Z0-9_.]{1,62} `. The maximum number of elements is 100. ||
|| resourceId[] | **string**

Each value must match the regular expression ` [a-zA-Z][-a-zA-Z0-9_.]{1,62} `. The maximum number of elements is 100. ||
|| streamName[] | **string**

Each value must match the regular expression ``` |[a-z][-a-z0-9]{1,61}[a-z0-9] ```. The maximum number of elements is 100. ||
|| levels[] | **enum** (Level)

The maximum number of elements is 10.

- `TRACE`
- `DEBUG`
- `INFO`
- `WARN`
- `ERROR`
- `FATAL` ||
|| batchSettings | **[LoggingBatchSettings](#yandex.cloud.serverless.triggers.v1.LoggingBatchSettings)** ||
|| invokeFunction | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|| invokeContainer | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|| gatewayWebsocketBroadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|| startWorkflow | **[StartWorkflowWithRetry](#yandex.cloud.serverless.triggers.v1.StartWorkflowWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|#

## LoggingBatchSettings {#yandex.cloud.serverless.triggers.v1.LoggingBatchSettings}

#|
||Field | Description ||
|| size | **string** (int64)

Acceptable values are 1 to 1000, inclusive. ||
|| cutoff | **string** (duration) ||
|#

## BillingBudget {#yandex.cloud.serverless.triggers.v1.BillingBudget}

#|
||Field | Description ||
|| billingAccountId | **string**

The maximum string length in characters is 50. ||
|| budgetId | **string**

The maximum string length in characters is 50. ||
|| invokeFunction | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|| invokeContainer | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|| gatewayWebsocketBroadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|| startWorkflow | **[StartWorkflowWithRetry](#yandex.cloud.serverless.triggers.v1.StartWorkflowWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|#

## DataStream {#yandex.cloud.serverless.triggers.v1.DataStream}

#|
||Field | Description ||
|| endpoint | **string** ||
|| database | **string** ||
|| stream | **string** ||
|| serviceAccountId | **string** ||
|| batchSettings | **[DataStreamBatchSettings](#yandex.cloud.serverless.triggers.v1.DataStreamBatchSettings)** ||
|| invokeFunction | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|| invokeContainer | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|| gatewayWebsocketBroadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|| startWorkflow | **[StartWorkflowWithRetry](#yandex.cloud.serverless.triggers.v1.StartWorkflowWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|#

## DataStreamBatchSettings {#yandex.cloud.serverless.triggers.v1.DataStreamBatchSettings}

#|
||Field | Description ||
|| size | **string** (int64)

Acceptable values are 1 to 65536, inclusive. ||
|| cutoff | **string** (duration) ||
|#

## Mail {#yandex.cloud.serverless.triggers.v1.Mail}

#|
||Field | Description ||
|| email | **string** ||
|| batchSettings | **[BatchSettings](#yandex.cloud.serverless.triggers.v1.BatchSettings)** ||
|| attachmentsBucket | **[ObjectStorageBucketSettings](#yandex.cloud.serverless.triggers.v1.ObjectStorageBucketSettings)** ||
|| invokeFunction | **[InvokeFunctionWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeFunctionWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|| invokeContainer | **[InvokeContainerWithRetry](#yandex.cloud.serverless.triggers.v1.InvokeContainerWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|| gatewayWebsocketBroadcast | **[GatewayWebsocketBroadcast](#yandex.cloud.serverless.triggers.v1.GatewayWebsocketBroadcast)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|| startWorkflow | **[StartWorkflowWithRetry](#yandex.cloud.serverless.triggers.v1.StartWorkflowWithRetry)**

Includes only one of the fields `invokeFunction`, `invokeContainer`, `gatewayWebsocketBroadcast`, `startWorkflow`. ||
|#

## ObjectStorageBucketSettings {#yandex.cloud.serverless.triggers.v1.ObjectStorageBucketSettings}

#|
||Field | Description ||
|| bucketId | **string**

The string length in characters must be 3-63. Value must match the regular expression ` [-.0-9a-zA-Z]* `. ||
|| serviceAccountId | **string**

The maximum string length in characters is 50. ||
|#