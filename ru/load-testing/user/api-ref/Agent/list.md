---
editable: false
sourcePath: en/_api-ref/loadtesting/api/v1/user/api-ref/Agent/list.md
---

# Load Testing API, REST: Agent.list
Retrieves the list of agents in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://loadtesting.{{ api-host }}/loadtesting/api/v1/agent
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list agents in.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``page_size``, the service returns a <a href="/docs/load-testing/user/api-ref/Agent/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/load-testing/user/api-ref/Agent/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters agents listed in the response.</p> <p>The filter expression may contain multiple field expressions joined by ``AND``. The field expression must specify:</p> <ol> <li>The field name.</li> <li>An operator: <ul> <li>``=``, ``!=``, ``CONTAINS``, for single values.</li> <li>``IN`` or ``NOT IN`` for lists of values.</li> </ul> </li> <li>The value. String values must be encosed in ``"``, boolean values are {``true``, ``false``}, timestamp values in ISO-8601.</li> </ol> <p>Currently supported fields:</p> <ul> <li>``id`` ``id`` <ul> <li>operators: ``=``, ``!=``, ``IN``, ``NOT IN``</li> </ul> </li> <li>``name`` ``name`` <ul> <li>operators: ``=``, ``!=``, ``IN``, ``NOT IN``, ``CONTAINS``</li> </ul> </li> </ul> <p>Examples:</p> <ul> <li>``id IN ("1", "2", "3")``</li> <li>``name CONTAINS "compute-agent-large" AND id NOT IN ("4", "5")``</li> </ul> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
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
      "agentVersionId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
agents[] | **object**<br><p>List of agents in the specified folder.</p> 
agents[].<br>id | **string**<br><p>ID of the agent. Generated at creation time.</p> 
agents[].<br>folderId | **string**<br><p>ID of the folder that the agent belongs to.</p> 
agents[].<br>name | **string**<br><p>Name of the agent.</p> 
agents[].<br>description | **string**<br><p>Description of the agent.</p> 
agents[].<br>computeInstanceId | **string**<br><p>ID of the compute instance managed by the agent.</p> <p>Empty if there is no such instance (i.e. the case of external agent).</p> 
agents[].<br>status | **string**<br><p>Status of the agent.</p> <p>Agent status.</p> <ul> <li>STATUS_UNSPECIFIED: Status is not specified. - PREPARING_TEST: Agent is preparing a test to be executed.</li> <li>READY_FOR_TEST: Agent is ready to take a test.</li> <li>TESTING: Agent is executing a test.</li> <li>TANK_FAILED: Agent application encountered an error and cannot operate normally.</li> <li>PROVISIONING: Agent is waiting for resources to be allocated.</li> <li>STOPPING: Agent is being stopped.</li> <li>STOPPED: Agent is stopped.</li> <li>STARTING: Agent is being started.</li> <li>RESTARTING: Agent is being restarted.</li> <li>UPDATING: Agent is being updated.</li> <li>ERROR: Agent encountered an error and cannot operate.</li> <li>CRASHED: Agent is crashed and will be restarted automatically.</li> <li>DELETING: Agent is being deleted.</li> <li>INITIALIZING_CONNECTION: Service is waiting for connection with agent to be established.</li> <li>LOST_CONNECTION_WITH_AGENT: Service has lost connection with agent.</li> <li>UPLOADING_ARTIFACTS: Agent is uploading test artifacts.</li> </ul> 
agents[].<br>errors[] | **string**<br><p>List of errors reported by the agent.</p> 
agents[].<br>currentJobId | **string**<br><p>ID of the test that is currently being executed by the agent.</p> 
agents[].<br>agentVersionId | **string**<br><p>Version of the agent.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/load-testing/user/api-ref/Agent/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/load-testing/user/api-ref/Agent/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> <p>The maximum string length in characters is 100.</p> 