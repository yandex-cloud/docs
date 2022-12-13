---
editable: false
---

# DataSphere API v1, gRPC: NodeService

A set of methods for managing Node resources.

| Call | Description |
| --- | --- |
| [Execute](#Execute) | Executes deployed Node. |
| [ExecuteAlias](#ExecuteAlias) | Executes NodeAlias requests. |

## Calls NodeService {#calls}

## Execute {#Execute}

Executes deployed Node.

**rpc Execute ([NodeExecutionRequest](#NodeExecutionRequest)) returns ([NodeExecutionResponse](#NodeExecutionResponse))**

### NodeExecutionRequest {#NodeExecutionRequest}

Field | Description
--- | ---
folder_id | **string**<br>ID of the folder that will be matched with Node ACL. 
node_id | **string**<br>ID of the Node to perform request on. 
input | **google.protobuf.Struct**<br>Input data for the execution. 


### NodeExecutionResponse {#NodeExecutionResponse}

Field | Description
--- | ---
output | **google.protobuf.Struct**<br>Result of the execution. 


## ExecuteAlias {#ExecuteAlias}

Executes NodeAlias requests.

**rpc ExecuteAlias ([AliasExecutionRequest](#AliasExecutionRequest)) returns ([AliasExecutionResponse](#AliasExecutionResponse))**

### AliasExecutionRequest {#AliasExecutionRequest}

Field | Description
--- | ---
folder_id | **string**<br>ID of the folder that will be matched with Alias ACL 
alias_name | **string**<br>Name of the Alias to perform request on 
input | **google.protobuf.Struct**<br>Input data for the execution 


### AliasExecutionResponse {#AliasExecutionResponse}

Field | Description
--- | ---
output | **google.protobuf.Struct**<br>Result of the execution 


