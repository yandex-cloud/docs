---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---


# NodeService

A set of methods for managing Node resources.

| Call | Description |
| --- | --- |
| [Execute](#Execute) | Executes deployed Node. |

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


