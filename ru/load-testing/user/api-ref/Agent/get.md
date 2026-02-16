---
editable: false
apiPlayground:
  - url: https://loadtesting.{{ api-host }}/loadtesting/api/v1/agent/{agentId}
    method: get
    path:
      type: object
      properties:
        agentId:
          description: |-
            **string**
            ID of the agent to return.
          type: string
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/loadtesting/api/v1/user/api-ref/Agent/get.md
---

# Load Testing API, REST: Agent.Get

Returns the specified agent.

To get the list of all available agents, make a [List](/docs/load-testing/user/api-ref/Agent/list#List) request.

## HTTP request

```
GET https://loadtesting.{{ api-host }}/loadtesting/api/v1/agent/{agentId}
```

## Path parameters

#|
||Field | Description ||
|| agentId | **string**

Required field. ID of the agent to return. ||
|#

## Response {#yandex.cloud.loadtesting.api.v1.agent.Agent}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "name": "string",
  "description": "string",
  "computeInstanceId": "string",
  "status": "string",
  "errors": [
    "string"
  ],
  "currentJobId": "string",
  "agentVersionId": "string",
  "labels": "object",
  "logSettings": {
    "cloudLogGroupId": "string"
  }
}
```

Load testing agent on which tests are executed.

#|
||Field | Description ||
|| id | **string**

ID of the agent. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the agent belongs to. ||
|| name | **string**

Name of the agent. ||
|| description | **string**

Description of the agent. ||
|| computeInstanceId | **string**

ID of the compute instance managed by the agent.

Empty if there is no such instance (i.e. the case of external agent). ||
|| status | **enum** (Status)

Status of the agent.

- `STATUS_UNSPECIFIED`: Status is not specified.
- `PREPARING_TEST`: Agent is preparing a test to be executed.
- `READY_FOR_TEST`: Agent is ready to take a test.
- `TESTING`: Agent is executing a test.
- `TANK_FAILED`: Agent application encountered an error and cannot operate normally.
- `PROVISIONING`: Agent is waiting for resources to be allocated.
- `STOPPING`: Agent is being stopped.
- `STOPPED`: Agent is stopped.
- `STARTING`: Agent is being started.
- `RESTARTING`: Agent is being restarted.
- `UPDATING`: Agent is being updated.
- `ERROR`: Agent encountered an error and cannot operate.
- `CRASHED`: Agent is crashed and will be restarted automatically.
- `DELETING`: Agent is being deleted.
- `INITIALIZING_CONNECTION`: Service is waiting for connection with agent to be established.
- `LOST_CONNECTION_WITH_AGENT`: Service has lost connection with agent.
- `UPLOADING_ARTIFACTS`: Agent is uploading test artifacts. ||
|| errors[] | **string**

List of errors reported by the agent. ||
|| currentJobId | **string**

ID of the test that is currently being executed by the agent. ||
|| agentVersionId | **string**

Version of the agent. ||
|| labels | **object** (map<**string**, **string**>)

Agent labels as `key:value` pairs. ||
|| logSettings | **[LogSettings](#yandex.cloud.loadtesting.api.v1.agent.LogSettings)**

Agent log settings ||
|#

## LogSettings {#yandex.cloud.loadtesting.api.v1.agent.LogSettings}

#|
||Field | Description ||
|| cloudLogGroupId | **string**

Id of Yandex Cloud log group to upload agent logs to ||
|#