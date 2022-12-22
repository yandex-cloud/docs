---
editable: false
---

# DataSphere API v1, gRPC: FolderBudgetService

A set of methods for managing Datasphere folder budgets.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified folder budget. |
| [Set](#Set) | Sets the unit balance and the limits of the specified folder budget. |

## Calls FolderBudgetService {#calls}

## Get {#Get}

Returns the specified folder budget.

**rpc Get ([GetFolderBudgetRequest](#GetFolderBudgetRequest)) returns ([GetFolderBudgetResponse](#GetFolderBudgetResponse))**

### GetFolderBudgetRequest {#GetFolderBudgetRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to get a budget for. The maximum string length in characters is 50.


### GetFolderBudgetResponse {#GetFolderBudgetResponse}

Field | Description
--- | ---
unit_balance | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of units available in the folder. 
max_units_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of units that can be spent per hour. 
max_units_per_execution | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of units that can be spent on one execution. 


## Set {#Set}

Sets the unit balance and the limits of the specified folder budget.

**rpc Set ([SetFolderBudgetRequest](#SetFolderBudgetRequest)) returns ([google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty))**

### SetFolderBudgetRequest {#SetFolderBudgetRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to set a budget for. The maximum string length in characters is 50.
set_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the budget are going to be set. 
unit_balance | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of units available in the folder. 
max_units_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of units that can be spent per hour. 
max_units_per_execution | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The number of units that can be spent on one execution. 


