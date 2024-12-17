---
editable: false
sourcePath: en/_api-ref-grpc/loadtesting/api/v1/user/api-ref/grpc/Agent/list.md
---

# Load Testing API, gRPC: AgentService.List

Retrieves the list of agents in the specified folder.

## gRPC request

**rpc List ([ListAgentsRequest](#yandex.cloud.loadtesting.api.v1.ListAgentsRequest)) returns ([ListAgentsResponse](#yandex.cloud.loadtesting.api.v1.ListAgentsResponse))**

## ListAgentsRequest {#yandex.cloud.loadtesting.api.v1.ListAgentsRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list agents in. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListAgentsResponse.next_page_token](#yandex.cloud.loadtesting.api.v1.ListAgentsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListAgentsResponse.next_page_token](#yandex.cloud.loadtesting.api.v1.ListAgentsResponse) returned by a previous list request. ||
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

## ListAgentsResponse {#yandex.cloud.loadtesting.api.v1.ListAgentsResponse}

```json
{
  "agents": [
    {
      "id": "string",
      "folder_id": "string",
      "name": "string",
      "description": "string",
      "compute_instance_id": "string",
      "status": "Status",
      "errors": [
        "string"
      ],
      "current_job_id": "string",
      "agent_version_id": "string",
      "labels": "map<string, string>",
      "log_settings": {
        "cloud_log_group_id": "string"
      }
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| agents[] | **[Agent](#yandex.cloud.loadtesting.api.v1.agent.Agent)**

List of agents in the specified folder. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListAgentsRequest.page_size](#yandex.cloud.loadtesting.api.v1.ListAgentsRequest), use `next_page_token` as the value
for the [ListAgentsRequest.page_token](#yandex.cloud.loadtesting.api.v1.ListAgentsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Agent {#yandex.cloud.loadtesting.api.v1.agent.Agent}

Load testing agent on which tests are executed.

#|
||Field | Description ||
|| id | **string**

ID of the agent. Generated at creation time. ||
|| folder_id | **string**

ID of the folder that the agent belongs to. ||
|| name | **string**

Name of the agent. ||
|| description | **string**

Description of the agent. ||
|| compute_instance_id | **string**

ID of the compute instance managed by the agent.

Empty if there is no such instance (i.e. the case of external agent). ||
|| status | enum **Status**

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
|| current_job_id | **string**

ID of the test that is currently being executed by the agent. ||
|| agent_version_id | **string**

Version of the agent. ||
|| labels | **object** (map<**string**, **string**>)

Agent labels as `key:value` pairs. ||
|| log_settings | **[LogSettings](#yandex.cloud.loadtesting.api.v1.agent.LogSettings)**

Agent log settings ||
|#

## LogSettings {#yandex.cloud.loadtesting.api.v1.agent.LogSettings}

#|
||Field | Description ||
|| cloud_log_group_id | **string**

Id of Yandex Cloud log group to upload agent logs to ||
|#