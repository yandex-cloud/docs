---
editable: false
sourcePath: en/_api-ref/loadtesting/api/v1/user/api-ref/Agent/get.md
---

# Load Testing API, REST: Agent.get
Returns the specified agent.
 
To get the list of all available agents, make a [list](/docs/load-testing/user/api-ref/Agent/list) request.
 
## HTTP request {#https-request}
```
GET https://loadtesting.{{ api-host }}/loadtesting/api/v1/agent/{agentId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
agentId | <p>ID of the agent to return.</p> 
 
## Response {#responses}
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
  "agentVersionId": "string"
}
```
Load testing agent on which tests are executed.
 
Field | Description
--- | ---
id | **string**<br><p>ID of the agent. Generated at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the agent belongs to.</p> 
name | **string**<br><p>Name of the agent.</p> 
description | **string**<br><p>Description of the agent.</p> 
computeInstanceId | **string**<br><p>ID of the compute instance managed by the agent.</p> <p>Empty if there is no such instance (i.e. the case of external agent).</p> 
status | **string**<br><p>Status of the agent.</p> <p>Agent status.</p> <ul> <li>STATUS_UNSPECIFIED: Status is not specified. - PREPARING_TEST: Agent is preparing a test to be executed.</li> <li>READY_FOR_TEST: Agent is ready to take a test.</li> <li>TESTING: Agent is executing a test.</li> <li>TANK_FAILED: Agent application encountered an error and cannot operate normally.</li> <li>PROVISIONING: Agent is waiting for resources to be allocated.</li> <li>STOPPING: Agent is being stopped.</li> <li>STOPPED: Agent is stopped.</li> <li>STARTING: Agent is being started.</li> <li>RESTARTING: Agent is being restarted.</li> <li>UPDATING: Agent is being updated.</li> <li>ERROR: Agent encountered an error and cannot operate.</li> <li>CRASHED: Agent is crashed and will be restarted automatically.</li> <li>DELETING: Agent is being deleted.</li> <li>INITIALIZING_CONNECTION: Service is waiting for connection with agent to be established.</li> <li>LOST_CONNECTION_WITH_AGENT: Service has lost connection with agent.</li> <li>UPLOADING_ARTIFACTS: Agent is uploading test artifacts.</li> </ul> 
errors[] | **string**<br><p>List of errors reported by the agent.</p> 
currentJobId | **string**<br><p>ID of the test that is currently being executed by the agent.</p> 
agentVersionId | **string**<br><p>Version of the agent.</p> 