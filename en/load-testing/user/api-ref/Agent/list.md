---
editable: false
sourcePath: en/_api-ref/loadtesting/api/v1/user/api-ref/Agent/list.md
---

# Load Testing API, REST: Agent.List {#List}

Retrieves the list of agents in the specified folder.

## HTTP request

```
GET https://loadtesting.{{ api-host }}/loadtesting/api/v1/agent
```

## Query parameters {#yandex.cloud.loadtesting.api.v1.ListAgentsRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list agents in. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListAgentsResponse.nextPageToken](#yandex.cloud.loadtesting.api.v1.ListAgentsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListAgentsResponse.nextPageToken](#yandex.cloud.loadtesting.api.v1.ListAgentsResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters agents listed in the response.

The filter expression may contain multiple field expressions joined by `AND`.
The field expression must specify:
1. The field name.
2. An operator:
- `=`, `!=`, `CONTAINS`, for single values.
- `IN` or `NOT IN` for lists of values.
3. The value. String values must be encosed in `"`, boolean values are {`true`, `false`}, timestamp values in ISO-8601.

Currently supported fields:
- `id` [yandex.cloud.loadtesting.api.v1.agent.Agent.id](#yandex.cloud.loadtesting.api.v1.agent.Agent)
- operators: `=`, `!=`, `IN`, `NOT IN`
- `name` [yandex.cloud.loadtesting.api.v1.agent.Agent.name](#yandex.cloud.loadtesting.api.v1.agent.Agent)
- operators: `=`, `!=`, `IN`, `NOT IN`, `CONTAINS`

Examples:
- `id IN ("1", "2", "3")`
- `name CONTAINS "compute-agent-large" AND id NOT IN ("4", "5")` ||
|#

## Response {#yandex.cloud.loadtesting.api.v1.ListAgentsResponse}

**HTTP Code: 200 - OK**

```json
{
  "agents": [
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
      "labels": "string",
      "logSettings": {
        "cloudLogGroupId": "string"
      }
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| agents[] | **[Agent](#yandex.cloud.loadtesting.api.v1.agent.Agent)**

List of agents in the specified folder. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListAgentsRequest.pageSize](#yandex.cloud.loadtesting.api.v1.ListAgentsRequest), use `next_page_token` as the value
for the [ListAgentsRequest.pageToken](#yandex.cloud.loadtesting.api.v1.ListAgentsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Agent {#yandex.cloud.loadtesting.api.v1.agent.Agent}

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
|| labels | **string**

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