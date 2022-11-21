---
editable: false
sourcePath: en/_api-ref/serverless/triggers/triggers/api-ref/Trigger/list.md
---

# Method list
Retrieves the list of triggers in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://serverless-triggers.{{ api-host }}/triggers/v1/triggers
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list triggers in.</p> <p>To get a folder ID use a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``pageSize``, the service returns a <a href="/docs/functions/triggers/api-ref/Trigger/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>Default value: 100.</p> 
pageToken | <p>Page token. To get the next page of results, set ``pageToken`` to the <a href="/docs/functions/triggers/api-ref/Trigger/list#responses">nextPageToken</a> returned by a previous list request.</p> 
filter | <p>A filter expression that filters triggers listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name. Currently filtering can only be applied to the <a href="/docs/functions/triggers/api-ref/Trigger#representation">Trigger.name</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``. Example of a filter: ``name=my-trigger``.</li> </ol> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "triggers": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "rule": {

        // `triggers[].rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`
        "timer": {
          "cronExpression": "string",

          // `triggers[].rule.timer` includes only one of the fields `invokeFunction`, `invokeFunctionWithRetry`, `invokeContainerWithRetry`
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
          // end of the list of possible fields`triggers[].rule.timer`

        },
        "messageQueue": {
          "queueId": "string",
          "serviceAccountId": "string",
          "batchSettings": {
            "size": "string",
            "cutoff": "string"
          },
          "visibilityTimeout": "string",

          // `triggers[].rule.messageQueue` includes only one of the fields `invokeFunction`, `invokeContainer`
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
          // end of the list of possible fields`triggers[].rule.messageQueue`

        },
        "iotMessage": {
          "registryId": "string",
          "deviceId": "string",
          "mqttTopic": "string",

          // `triggers[].rule.iotMessage` includes only one of the fields `invokeFunction`, `invokeContainer`
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
          // end of the list of possible fields`triggers[].rule.iotMessage`

        },
        "iotBrokerMessage": {
          "brokerId": "string",
          "mqttTopic": "string",

          // `triggers[].rule.iotBrokerMessage` includes only one of the fields `invokeFunction`, `invokeContainer`
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
          // end of the list of possible fields`triggers[].rule.iotBrokerMessage`

        },
        "objectStorage": {
          "eventType": [
            "string"
          ],
          "bucketId": "string",
          "prefix": "string",
          "suffix": "string",

          // `triggers[].rule.objectStorage` includes only one of the fields `invokeFunction`, `invokeContainer`
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
          // end of the list of possible fields`triggers[].rule.objectStorage`

        },
        "containerRegistry": {
          "eventType": [
            "string"
          ],
          "registryId": "string",
          "imageName": "string",
          "tag": "string",

          // `triggers[].rule.containerRegistry` includes only one of the fields `invokeFunction`, `invokeContainer`
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
          // end of the list of possible fields`triggers[].rule.containerRegistry`

        },
        "cloudLogs": {
          "logGroupId": [
            "string"
          ],
          "batchSettings": {
            "size": "string",
            "cutoff": "string"
          },

          // `triggers[].rule.cloudLogs` includes only one of the fields `invokeFunction`, `invokeContainer`
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
          // end of the list of possible fields`triggers[].rule.cloudLogs`

        },
        "logging": {
          "logGroupId": "string",
          "resourceType": [
            "string"
          ],
          "resourceId": [
            "string"
          ],
          "levels": [
            "string"
          ],
          "batchSettings": {
            "size": "string",
            "cutoff": "string"
          },

          // `triggers[].rule.logging` includes only one of the fields `invokeFunction`, `invokeContainer`
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
          // end of the list of possible fields`triggers[].rule.logging`

        },
        "billingBudget": {
          "billingAccountId": "string",
          "budgetId": "string",

          // `triggers[].rule.billingBudget` includes only one of the fields `invokeFunction`, `invokeContainer`
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
          // end of the list of possible fields`triggers[].rule.billingBudget`

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

          // `triggers[].rule.dataStream` includes only one of the fields `invokeFunction`, `invokeContainer`
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
          // end of the list of possible fields`triggers[].rule.dataStream`

        },
        "mail": {
          "email": "string",

          // `triggers[].rule.mail` includes only one of the fields `invokeFunction`, `invokeContainer`
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
          // end of the list of possible fields`triggers[].rule.mail`

        },
        // end of the list of possible fields`triggers[].rule`

      },
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
triggers[] | **object**<br><p>List of triggers in the specified folder.</p> 
triggers[].<br>id | **string**<br><p>ID of the trigger. Generated at creation time.</p> 
triggers[].<br>folderId | **string**<br><p>Required. ID of the folder that the trigger belongs to.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp for the trigger.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
triggers[].<br>name | **string**<br><p>Name of the trigger.</p> <p>The string length in characters must be 3-63.</p> 
triggers[].<br>description | **string**<br><p>Description of the trigger.</p> <p>The string length in characters must be 0-256.</p> 
triggers[].<br>labels | **object**<br><p>Trigger labels as ``key:value`` pairs.</p> 
triggers[].<br>rule | **object**<br><p>Required. Rule for trigger activation (always consistent with the trigger type).</p> <p>Description of a rule for trigger activation.</p> 
triggers[].<br>rule.<br>timer | **object**<br>Rule for a timed trigger. <br>`triggers[].rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`<br>
triggers[].<br>rule.<br>timer.<br>cronExpression | **string**<br><p>Required. Description of a schedule as a <a href="/docs/functions/concepts/trigger/timer">cron expression</a>.</p> <p>The maximum string length in characters is 100.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunction | **object**<br>Instructions for invoking a function once. <br>`triggers[].rule.timer` includes only one of the fields `invokeFunction`, `invokeFunctionWithRetry`, `invokeContainerWithRetry`<br>
triggers[].<br>rule.<br>timer.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account that should be used to invoke the function.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunctionWithRetry | **object**<br>Instructions for invoking a function with retries as needed. <br>`triggers[].rule.timer` includes only one of the fields `invokeFunction`, `invokeFunctionWithRetry`, `invokeContainerWithRetry`<br>
triggers[].<br>rule.<br>timer.<br>invokeFunctionWithRetry.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunctionWithRetry.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunctionWithRetry.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunctionWithRetry.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunctionWithRetry.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunctionWithRetry.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunctionWithRetry.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunctionWithRetry.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
triggers[].<br>rule.<br>timer.<br>invokeFunctionWithRetry.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>timer.<br>invokeContainerWithRetry | **object**<br>Instructions for invoking a container with retries as needed. <br>`triggers[].rule.timer` includes only one of the fields `invokeFunction`, `invokeFunctionWithRetry`, `invokeContainerWithRetry`<br>
triggers[].<br>rule.<br>timer.<br>invokeContainerWithRetry.<br>containerId | **string**<br><p>Required. ID of the container to invoke.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>timer.<br>invokeContainerWithRetry.<br>path | **string**<br><p>Endpoint HTTP path to invoke.</p> 
triggers[].<br>rule.<br>timer.<br>invokeContainerWithRetry.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the container.</p> 
triggers[].<br>rule.<br>timer.<br>invokeContainerWithRetry.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
triggers[].<br>rule.<br>timer.<br>invokeContainerWithRetry.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
triggers[].<br>rule.<br>timer.<br>invokeContainerWithRetry.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
triggers[].<br>rule.<br>timer.<br>invokeContainerWithRetry.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
triggers[].<br>rule.<br>timer.<br>invokeContainerWithRetry.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
triggers[].<br>rule.<br>timer.<br>invokeContainerWithRetry.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>messageQueue | **object**<br>Rule for a message queue trigger. <br>`triggers[].rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`<br>
triggers[].<br>rule.<br>messageQueue.<br>queueId | **string**<br><p>Required. ID of the message queue in Message Queue.</p> 
triggers[].<br>rule.<br>messageQueue.<br>serviceAccountId | **string**<br><p>Required. ID of the service account which has read access to the message queue.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>messageQueue.<br>batchSettings | **object**<br>Required. Batch settings for processing messages in the queue.
triggers[].<br>rule.<br>messageQueue.<br>batchSettings.<br>size | **string** (int64)<br><p>Batch size. Trigger will send the batch of messages to the function when the number of messages in the queue reaches ``size``, or the ``cutoff`` time has passed.</p> <p>Acceptable values are 0 to 10, inclusive.</p> 
triggers[].<br>rule.<br>messageQueue.<br>batchSettings.<br>cutoff | **string**<br><p>Required. Maximum wait time. Trigger will send the batch of messages to the function when the number of messages in the queue reaches ``size``, or the ``cutoff`` time has passed.</p> 
triggers[].<br>rule.<br>messageQueue.<br>visibilityTimeout | **string**<br><p>Queue visibility timeout override.</p> <p>The maximum value is 43200 seconds.</p> 
triggers[].<br>rule.<br>messageQueue.<br>invokeFunction | **object**<br>Instructions for invoking a function once. <br>`triggers[].rule.messageQueue` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
triggers[].<br>rule.<br>messageQueue.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>messageQueue.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
triggers[].<br>rule.<br>messageQueue.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account that should be used to invoke the function.</p> 
triggers[].<br>rule.<br>messageQueue.<br>invokeContainer | **object**<br>Instructions for invoking a container once. <br>`triggers[].rule.messageQueue` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
triggers[].<br>rule.<br>messageQueue.<br>invokeContainer.<br>containerId | **string**<br><p>Required. ID of the container to invoke.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>messageQueue.<br>invokeContainer.<br>path | **string**<br><p>Endpoint HTTP path to invoke.</p> 
triggers[].<br>rule.<br>messageQueue.<br>invokeContainer.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the container.</p> 
triggers[].<br>rule.<br>iotMessage | **object**<br>Rule for a IoT Core trigger. <br>`triggers[].rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`<br>
triggers[].<br>rule.<br>iotMessage.<br>registryId | **string**<br><p>Required. ID of the IoT Core registry.</p> 
triggers[].<br>rule.<br>iotMessage.<br>deviceId | **string**<br><p>ID of the IoT Core device in the registry.</p> 
triggers[].<br>rule.<br>iotMessage.<br>mqttTopic | **string**<br><p>MQTT topic whose messages activate the trigger.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeFunction | **object**<br>Instructions for invoking a function with retry. <br>`triggers[].rule.iotMessage` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
triggers[].<br>rule.<br>iotMessage.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeContainer | **object**<br>Instructions for invoking a container with retry. <br>`triggers[].rule.iotMessage` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
triggers[].<br>rule.<br>iotMessage.<br>invokeContainer.<br>containerId | **string**<br><p>Required. ID of the container to invoke.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeContainer.<br>path | **string**<br><p>Endpoint HTTP path to invoke.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeContainer.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the container.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeContainer.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeContainer.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeContainer.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeContainer.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeContainer.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
triggers[].<br>rule.<br>iotMessage.<br>invokeContainer.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>iotBrokerMessage | **object** <br>`triggers[].rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`<br><br><p>Rule for activating a IoT Core Broker trigger.</p> 
triggers[].<br>rule.<br>iotBrokerMessage.<br>brokerId | **string**<br><p>Required. ID of the IoT Core broker.</p> 
triggers[].<br>rule.<br>iotBrokerMessage.<br>mqttTopic | **string**<br><p>MQTT topic whose messages activate the trigger.</p> 
triggers[].<br>rule.<br>iotBrokerMessage.<br>invokeFunction | **object**<br>Instructions for invoking a function with retries as needed. <br>`triggers[].rule.iotBrokerMessage` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
triggers[].<br>rule.<br>iotBrokerMessage.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>iotBrokerMessage.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
triggers[].<br>rule.<br>iotBrokerMessage.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
triggers[].<br>rule.<br>iotBrokerMessage.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
triggers[].<br>rule.<br>iotBrokerMessage.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
triggers[].<br>rule.<br>iotBrokerMessage.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
triggers[].<br>rule.<br>iotBrokerMessage.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
triggers[].<br>rule.<br>iotBrokerMessage.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
triggers[].<br>rule.<br>iotBrokerMessage.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>iotBrokerMessage.<br>invokeContainer | **object**<br>Instructions for invoking a container with retries as needed. <br>`triggers[].rule.iotBrokerMessage` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
triggers[].<br>rule.<br>iotBrokerMessage.<br>invokeContainer.<br>containerId | **string**<br><p>Required. ID of the container to invoke.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>iotBrokerMessage.<br>invokeContainer.<br>path | **string**<br><p>Endpoint HTTP path to invoke.</p> 
triggers[].<br>rule.<br>iotBrokerMessage.<br>invokeContainer.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the container.</p> 
triggers[].<br>rule.<br>iotBrokerMessage.<br>invokeContainer.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
triggers[].<br>rule.<br>iotBrokerMessage.<br>invokeContainer.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
triggers[].<br>rule.<br>iotBrokerMessage.<br>invokeContainer.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
triggers[].<br>rule.<br>iotBrokerMessage.<br>invokeContainer.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
triggers[].<br>rule.<br>iotBrokerMessage.<br>invokeContainer.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
triggers[].<br>rule.<br>iotBrokerMessage.<br>invokeContainer.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>objectStorage | **object** <br>`triggers[].rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`<br>
triggers[].<br>rule.<br>objectStorage.<br>eventType[] | **string**<br><p>Required. Type (name) of events, at least one value is required.</p> <p>Must contain at least one element.</p> 
triggers[].<br>rule.<br>objectStorage.<br>bucketId | **string**<br><p>ID of the bucket.</p> 
triggers[].<br>rule.<br>objectStorage.<br>prefix | **string**<br><p>Prefix of the object key. Filter, optional.</p> 
triggers[].<br>rule.<br>objectStorage.<br>suffix | **string**<br><p>Suffix of the object key. Filter, optional.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeFunction | **object**<br>Instructions for invoking a function with retries as needed. <br>`triggers[].rule.objectStorage` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
triggers[].<br>rule.<br>objectStorage.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeContainer | **object**<br>Instructions for invoking a container with retries as needed. <br>`triggers[].rule.objectStorage` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
triggers[].<br>rule.<br>objectStorage.<br>invokeContainer.<br>containerId | **string**<br><p>Required. ID of the container to invoke.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeContainer.<br>path | **string**<br><p>Endpoint HTTP path to invoke.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeContainer.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the container.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeContainer.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeContainer.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeContainer.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeContainer.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeContainer.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
triggers[].<br>rule.<br>objectStorage.<br>invokeContainer.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>containerRegistry | **object** <br>`triggers[].rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`<br>
triggers[].<br>rule.<br>containerRegistry.<br>eventType[] | **string**<br><p>Required. Type (name) of events, at least one value is required.</p> <p>Must contain at least one element.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>registryId | **string**<br><p>ID of the registry.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>imageName | **string**<br><p>Docker-image name. Filter, optional.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>tag | **string**<br><p>Docker-image tag. Filter, optional.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeFunction | **object**<br>Instructions for invoking a function with retries as needed. <br>`triggers[].rule.containerRegistry` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
triggers[].<br>rule.<br>containerRegistry.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeContainer | **object**<br>Instructions for invoking a container with retries as needed. <br>`triggers[].rule.containerRegistry` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
triggers[].<br>rule.<br>containerRegistry.<br>invokeContainer.<br>containerId | **string**<br><p>Required. ID of the container to invoke.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeContainer.<br>path | **string**<br><p>Endpoint HTTP path to invoke.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeContainer.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the container.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeContainer.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeContainer.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeContainer.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeContainer.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeContainer.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
triggers[].<br>rule.<br>containerRegistry.<br>invokeContainer.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>cloudLogs | **object** <br>`triggers[].rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`<br>
triggers[].<br>rule.<br>cloudLogs.<br>logGroupId[] | **string**<br><p>Log group identifiers, at least one value is required.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>batchSettings | **object**<br>Required. Batch settings for processing log events.
triggers[].<br>rule.<br>cloudLogs.<br>batchSettings.<br>size | **string** (int64)<br><p>Batch size. Trigger will send the batch of messages to the function when the number of messages in the log group reaches ``size``, or the ``cutoff`` time has passed.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>batchSettings.<br>cutoff | **string**<br><p>Maximum wait time. Trigger will send the batch of messages to the function when the number of messages in the log group reaches ``size``, or the ``cutoff`` time has passed.</p> <p>Acceptable values are 1 seconds to 60 seconds, inclusive.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeFunction | **object**<br>Instructions for invoking a function with retries as needed. <br>`triggers[].rule.cloudLogs` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
triggers[].<br>rule.<br>cloudLogs.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeContainer | **object**<br>Instructions for invoking a container with retries as needed. <br>`triggers[].rule.cloudLogs` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
triggers[].<br>rule.<br>cloudLogs.<br>invokeContainer.<br>containerId | **string**<br><p>Required. ID of the container to invoke.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeContainer.<br>path | **string**<br><p>Endpoint HTTP path to invoke.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeContainer.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the container.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeContainer.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeContainer.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeContainer.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeContainer.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeContainer.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
triggers[].<br>rule.<br>cloudLogs.<br>invokeContainer.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>logging | **object** <br>`triggers[].rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`<br>
triggers[].<br>rule.<br>logging.<br>logGroupId | **string**<br><p>Log events filter settings.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>logging.<br>resourceType[] | **string**<br><p>The maximum number of elements is 100. Each value must match the regular expression ``[a-zA-Z][-a-zA-Z0-9_.]{1,62}``.</p> 
triggers[].<br>rule.<br>logging.<br>resourceId[] | **string**<br><p>The maximum number of elements is 100. Each value must match the regular expression ``[a-zA-Z][-a-zA-Z0-9_.]{1,62}``.</p> 
triggers[].<br>rule.<br>logging.<br>levels[] | **string**<br><p>The maximum number of elements is 10.</p> <ul> <li> <p>TRACE: Trace log level.</p> <p>Possible use case: verbose logging of some business logic.</p> </li> <li> <p>DEBUG: Debug log level.</p> <p>Possible use case: debugging special cases in application logic.</p> </li> <li> <p>INFO: Info log level.</p> <p>Mostly used for information messages.</p> </li> <li> <p>WARN: Warn log level.</p> <p>May be used to alert about significant events.</p> </li> <li> <p>ERROR: Error log level.</p> <p>May be used to alert about errors in infrastructure, logic, etc.</p> </li> <li> <p>FATAL: Fatal log level.</p> <p>May be used to alert about unrecoverable failures and events.</p> </li> </ul> 
triggers[].<br>rule.<br>logging.<br>batchSettings | **object**<br>Required. Batch settings for processing log events.
triggers[].<br>rule.<br>logging.<br>batchSettings.<br>size | **string** (int64)<br><p>Batch size. Trigger will send the batch of messages to the associated function when the number of log events reaches this value, or the ``cutoff`` time has passed.</p> <p>Acceptable values are 1 to 100, inclusive.</p> 
triggers[].<br>rule.<br>logging.<br>batchSettings.<br>cutoff | **string**<br><p>Maximum wait time. Trigger will send the batch of messages the time since the last batch exceeds the ``cutoff`` value, regardless of the amount of log events.</p> <p>Acceptable values are 1 seconds to 60 seconds, inclusive.</p> 
triggers[].<br>rule.<br>logging.<br>invokeFunction | **object**<br>Instructions for invoking a function with retries as needed. <br>`triggers[].rule.logging` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
triggers[].<br>rule.<br>logging.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>logging.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
triggers[].<br>rule.<br>logging.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
triggers[].<br>rule.<br>logging.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
triggers[].<br>rule.<br>logging.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
triggers[].<br>rule.<br>logging.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
triggers[].<br>rule.<br>logging.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
triggers[].<br>rule.<br>logging.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
triggers[].<br>rule.<br>logging.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>logging.<br>invokeContainer | **object**<br>Instructions for invoking a container with retries as needed. <br>`triggers[].rule.logging` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
triggers[].<br>rule.<br>logging.<br>invokeContainer.<br>containerId | **string**<br><p>Required. ID of the container to invoke.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>logging.<br>invokeContainer.<br>path | **string**<br><p>Endpoint HTTP path to invoke.</p> 
triggers[].<br>rule.<br>logging.<br>invokeContainer.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the container.</p> 
triggers[].<br>rule.<br>logging.<br>invokeContainer.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
triggers[].<br>rule.<br>logging.<br>invokeContainer.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
triggers[].<br>rule.<br>logging.<br>invokeContainer.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
triggers[].<br>rule.<br>logging.<br>invokeContainer.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
triggers[].<br>rule.<br>logging.<br>invokeContainer.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
triggers[].<br>rule.<br>logging.<br>invokeContainer.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>billingBudget | **object** <br>`triggers[].rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`<br>
triggers[].<br>rule.<br>billingBudget.<br>billingAccountId | **string**<br><p>Required. The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>billingBudget.<br>budgetId | **string**<br><p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>billingBudget.<br>invokeFunction | **object**<br>Instructions for invoking a function with retries as needed. <br>`triggers[].rule.billingBudget` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
triggers[].<br>rule.<br>billingBudget.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>billingBudget.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
triggers[].<br>rule.<br>billingBudget.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
triggers[].<br>rule.<br>billingBudget.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
triggers[].<br>rule.<br>billingBudget.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
triggers[].<br>rule.<br>billingBudget.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
triggers[].<br>rule.<br>billingBudget.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
triggers[].<br>rule.<br>billingBudget.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
triggers[].<br>rule.<br>billingBudget.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>billingBudget.<br>invokeContainer | **object**<br>Instructions for invoking a container with retries as needed. <br>`triggers[].rule.billingBudget` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
triggers[].<br>rule.<br>billingBudget.<br>invokeContainer.<br>containerId | **string**<br><p>Required. ID of the container to invoke.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>billingBudget.<br>invokeContainer.<br>path | **string**<br><p>Endpoint HTTP path to invoke.</p> 
triggers[].<br>rule.<br>billingBudget.<br>invokeContainer.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the container.</p> 
triggers[].<br>rule.<br>billingBudget.<br>invokeContainer.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
triggers[].<br>rule.<br>billingBudget.<br>invokeContainer.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
triggers[].<br>rule.<br>billingBudget.<br>invokeContainer.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
triggers[].<br>rule.<br>billingBudget.<br>invokeContainer.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
triggers[].<br>rule.<br>billingBudget.<br>invokeContainer.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
triggers[].<br>rule.<br>billingBudget.<br>invokeContainer.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>dataStream | **object** <br>`triggers[].rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`<br>
triggers[].<br>rule.<br>dataStream.<br>endpoint | **string**<br><p>Data stream endpoint.</p> 
triggers[].<br>rule.<br>dataStream.<br>database | **string**<br><p>Data stream database.</p> 
triggers[].<br>rule.<br>dataStream.<br>stream | **string**<br><p>Stream name.</p> 
triggers[].<br>rule.<br>dataStream.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to read data stream.</p> 
triggers[].<br>rule.<br>dataStream.<br>batchSettings | **object**<br>Batch settings for processing events.
triggers[].<br>rule.<br>dataStream.<br>batchSettings.<br>size | **string** (int64)<br><p>Batch size in bytes. Trigger will send the batch of messages to the associated function when size of log events reaches this value, or the ``cutoff`` time has passed.</p> <p>Acceptable values are 1 to 65536, inclusive.</p> 
triggers[].<br>rule.<br>dataStream.<br>batchSettings.<br>cutoff | **string**<br><p>Maximum wait time. Trigger will send the batch of messages the time since the last batch exceeds the ``cutoff`` value, regardless of the amount of log events.</p> <p>Acceptable values are 1 seconds to 60 seconds, inclusive.</p> 
triggers[].<br>rule.<br>dataStream.<br>invokeFunction | **object**<br>Instructions for invoking a function with retries as needed. <br>`triggers[].rule.dataStream` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
triggers[].<br>rule.<br>dataStream.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>dataStream.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
triggers[].<br>rule.<br>dataStream.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
triggers[].<br>rule.<br>dataStream.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
triggers[].<br>rule.<br>dataStream.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
triggers[].<br>rule.<br>dataStream.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
triggers[].<br>rule.<br>dataStream.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
triggers[].<br>rule.<br>dataStream.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
triggers[].<br>rule.<br>dataStream.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>dataStream.<br>invokeContainer | **object**<br>Instructions for invoking a container with retries as needed. <br>`triggers[].rule.dataStream` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
triggers[].<br>rule.<br>dataStream.<br>invokeContainer.<br>containerId | **string**<br><p>Required. ID of the container to invoke.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>dataStream.<br>invokeContainer.<br>path | **string**<br><p>Endpoint HTTP path to invoke.</p> 
triggers[].<br>rule.<br>dataStream.<br>invokeContainer.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the container.</p> 
triggers[].<br>rule.<br>dataStream.<br>invokeContainer.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
triggers[].<br>rule.<br>dataStream.<br>invokeContainer.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
triggers[].<br>rule.<br>dataStream.<br>invokeContainer.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
triggers[].<br>rule.<br>dataStream.<br>invokeContainer.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
triggers[].<br>rule.<br>dataStream.<br>invokeContainer.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
triggers[].<br>rule.<br>dataStream.<br>invokeContainer.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>mail | **object** <br>`triggers[].rule` includes only one of the fields `timer`, `messageQueue`, `iotMessage`, `iotBrokerMessage`, `objectStorage`, `containerRegistry`, `cloudLogs`, `logging`, `billingBudget`, `dataStream`, `mail`<br>
triggers[].<br>rule.<br>mail.<br>email | **string**<br><p>Address to receive emails for trigger activation. Field is ignored for write requests and populated on trigger creation.</p> 
triggers[].<br>rule.<br>mail.<br>invokeFunction | **object**<br>Instructions for invoking a function with retries as needed. <br>`triggers[].rule.mail` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
triggers[].<br>rule.<br>mail.<br>invokeFunction.<br>functionId | **string**<br><p>Required. ID of the function to invoke.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>mail.<br>invokeFunction.<br>functionTag | **string**<br><p>Version tag of the function to execute.</p> 
triggers[].<br>rule.<br>mail.<br>invokeFunction.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the function.</p> 
triggers[].<br>rule.<br>mail.<br>invokeFunction.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
triggers[].<br>rule.<br>mail.<br>invokeFunction.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
triggers[].<br>rule.<br>mail.<br>invokeFunction.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
triggers[].<br>rule.<br>mail.<br>invokeFunction.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
triggers[].<br>rule.<br>mail.<br>invokeFunction.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
triggers[].<br>rule.<br>mail.<br>invokeFunction.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>mail.<br>invokeContainer | **object**<br>Instructions for invoking a container with retries as needed. <br>`triggers[].rule.mail` includes only one of the fields `invokeFunction`, `invokeContainer`<br>
triggers[].<br>rule.<br>mail.<br>invokeContainer.<br>containerId | **string**<br><p>Required. ID of the container to invoke.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>rule.<br>mail.<br>invokeContainer.<br>path | **string**<br><p>Endpoint HTTP path to invoke.</p> 
triggers[].<br>rule.<br>mail.<br>invokeContainer.<br>serviceAccountId | **string**<br><p>ID of the service account which has permission to invoke the container.</p> 
triggers[].<br>rule.<br>mail.<br>invokeContainer.<br>retrySettings | **object**<br><p>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted.</p> <p>Settings for retrying to invoke a function.</p> 
triggers[].<br>rule.<br>mail.<br>invokeContainer.<br>retrySettings.<br>retryAttempts | **string** (int64)<br><p>Maximum number of retries (extra invokes) before the action is considered failed.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
triggers[].<br>rule.<br>mail.<br>invokeContainer.<br>retrySettings.<br>interval | **string**<br><p>Required. Time in seconds to wait between individual retries.</p> 
triggers[].<br>rule.<br>mail.<br>invokeContainer.<br>deadLetterQueue | **object**<br><p>DLQ policy (no value means discarding a message).</p> 
triggers[].<br>rule.<br>mail.<br>invokeContainer.<br>deadLetterQueue.<br>queueId | **string**<br><p>ID of the queue.</p> 
triggers[].<br>rule.<br>mail.<br>invokeContainer.<br>deadLetterQueue.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
triggers[].<br>status | **string**<br><p>Trigger status.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/functions/triggers/api-ref/Trigger/list#query_params">pageSize</a>, use ``nextPageToken`` as the value for the <a href="/docs/functions/triggers/api-ref/Trigger/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``nextPageToken`` to continue paging through the results.</p> 