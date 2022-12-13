---
editable: false
sourcePath: en/_api-ref-grpc/billing/api-ref/grpc/budget_service.md
---

# Billing API, gRPC: BudgetService

A set of methods for managing Budget resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified budget. |
| [List](#List) | Retrieves the list of budgets corresponding to the specified billing account. |
| [Create](#Create) | Creates a budget for the specified billing account. |

## Calls BudgetService {#calls}

## Get {#Get}

Returns the specified budget.

**rpc Get ([GetBudgetRequest](#GetBudgetRequest)) returns ([Budget](#Budget))**

### GetBudgetRequest {#GetBudgetRequest}

Field | Description
--- | ---
id | **string**<br>Required. ID of the budget to return. To get the budget ID, use [BudgetService.List](#List) request. The maximum string length in characters is 50.


### Budget {#Budget}

Field | Description
--- | ---
id | **string**<br>ID of the budget. 
name | **string**<br>Name of the budget. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
billing_account_id | **string**<br>ID of the billing account that the budget belongs to. 
status | enum **BudgetStatus**<br>Status of the budget. <ul><li>`CREATING`: The budget is being created.</li><li>`ACTIVE`: The budget is active.</li><li>`FINISHED`: The budget is finished.</li></ul>
budget_spec | **oneof:** `cost_budget`, `expense_budget` or `balance_budget`<br>Specification of the budget.
&nbsp;&nbsp;cost_budget | **[CostBudgetSpec](#CostBudgetSpec)**<br>Cost budget specification. 
&nbsp;&nbsp;expense_budget | **[ExpenseBudgetSpec](#ExpenseBudgetSpec)**<br>Expense budget specification. 
&nbsp;&nbsp;balance_budget | **[BalanceBudgetSpec](#BalanceBudgetSpec)**<br>Balance budget specification. 


### CostBudgetSpec {#CostBudgetSpec}

Field | Description
--- | ---
amount | **string**<br>Max cost threshold of the budget. Amount currency is the same as corresponding `yandex.cloud.billing.v1.BillingAccount.currency`. 
notification_user_account_ids[] | **string**<br>IDs of the `yandex.cloud.iam.v1.UserAccount`. Specified users will be be notified if the budget exceeds. 
threshold_rules[] | **[ThresholdRule](#ThresholdRule)**<br>List of the [ThresholdRule](#ThresholdRule). Rules define intermediate cost thresholds of the budget. 
filter | **[ConsumptionFilter](#ConsumptionFilter)**<br>Filter that can be used for specific resources selection. Only consumption cost of selected resources are used for the budget calculation. 
start_type | **oneof:** `reset_period` or `start_date`<br>Start type of the budget.
&nbsp;&nbsp;reset_period | enum **ResetPeriodType**<br>Periodic start type that resets budget after specified period is finished. First time budget is calculated in the current period, i.e. current month, quarter or year. <ul><li>`MONTHLY`: Reset budget every month.</li><li>`QUARTER`: Reset budget every quarter.</li><li>`ANNUALLY`: Reset budget every year.</li></ul>
&nbsp;&nbsp;start_date | **string**<br>Custom start date of the budget. Must be the first day of a month and must be formatted like YYYY-MM-DD. 
end_date | **string**<br>End date of the budget. Must be the last day of a month and must be formatted like YYYY-MM-DD. 


### ThresholdRule {#ThresholdRule}

Field | Description
--- | ---
type | enum **ThresholdType**<br>Type of the rule. <ul><li>`PERCENT`: Percent.</li><li>`AMOUNT`: The same as budget amount.</li></ul>
amount | **string**<br>Amount of the rule. <ul><li>Must be less than 100 if type is PERCENT. </li><li>Must be less than budget's amount if type is AMOUNT.</li></ul> 
notification_user_account_ids[] | **string**<br>IDs of the `yandex.cloud.iam.v1.UserAccount`. Specified users will be be notified if the threshold exceeds. 


### ConsumptionFilter {#ConsumptionFilter}

Field | Description
--- | ---
service_ids[] | **string**<br>IDs of the `yandex.cloud.billing.v1.Service`. Only consumption of resources corresponding to the given services is used for the budget calculation. Empty sequence means no services filters. 
cloud_folders_filters[] | **[CloudFoldersConsumptionFilter](#CloudFoldersConsumptionFilter)**<br>Cloud and folders consumption filter. Only consumption within specified clouds and folders is used for the budget calculation. Empty sequence means no cloud and folders filters. 


### CloudFoldersConsumptionFilter {#CloudFoldersConsumptionFilter}

Field | Description
--- | ---
cloud_id | **string**<br>ID of the `yandex.cloud.resourcemanager.v1.Cloud`. Only consumption within specified cloud is used for the budget calculation. 
folder_ids[] | **string**<br>IDs of the `yandex.cloud.resourcemanager.v1.Folder`. Only consumption within specified folders of the given cloud is used for the budget calculation. Empty sequence means no folders filters and the whole cloud consumption will be used. 


### ExpenseBudgetSpec {#ExpenseBudgetSpec}

Field | Description
--- | ---
amount | **string**<br>Max expense threshold of the budget. Amount currency is the same as corresponding `yandex.cloud.billing.v1.BillingAccount.currency`. 
notification_user_account_ids[] | **string**<br>IDs of the `yandex.cloud.iam.v1.UserAccount`. Specified users will be be notified if the budget exceeds. 
threshold_rules[] | **[ThresholdRule](#ThresholdRule1)**<br>List of the [ThresholdRule](#ThresholdRule1). Rules define intermediate expense thresholds of the budget. 
filter | **[ConsumptionFilter](#ConsumptionFilter1)**<br>Filter that can be used for specific resources selection. Only consumption expense of selected resources are used for the budget calculation. 
start_type | **oneof:** `reset_period` or `start_date`<br>Start type of the budget.
&nbsp;&nbsp;reset_period | enum **ResetPeriodType**<br>Periodic start type that resets budget after specified period is finished. First time budget is calculated in the current period, i.e. current month, quarter or year. <ul><li>`MONTHLY`: Reset budget every month.</li><li>`QUARTER`: Reset budget every quarter.</li><li>`ANNUALLY`: Reset budget every year.</li></ul>
&nbsp;&nbsp;start_date | **string**<br>Custom start date of the budget. Must be the first day of a month and must be formatted like YYYY-MM-DD. 
end_date | **string**<br>End date of the budget. Must be the last day of a month and must be formatted like YYYY-MM-DD. 


### BalanceBudgetSpec {#BalanceBudgetSpec}

Field | Description
--- | ---
amount | **string**<br>Max balance threshold of the budget. Amount currency is the same as corresponding `yandex.cloud.billing.v1.BillingAccount.currency`. 
notification_user_account_ids[] | **string**<br>IDs of the `yandex.cloud.iam.v1.UserAccount`. Specified users will be be notified if the budget exceeds. 
threshold_rules[] | **[ThresholdRule](#ThresholdRule1)**<br>List of the [ThresholdRule](#ThresholdRule1). Rules define intermediate balance thresholds of the budget. 
start_date | **string**<br>Start_date of the budget. Must be the first day of a month and must be formatted like YYYY-MM-DD. 
end_date | **string**<br>End date of the budget. Must be the last day of a month and must be formatted like YYYY-MM-DD. 


## List {#List}

Retrieves the list of budgets corresponding to the specified billing account.

**rpc List ([ListBudgetsRequest](#ListBudgetsRequest)) returns ([ListBudgetsResponse](#ListBudgetsResponse))**

### ListBudgetsRequest {#ListBudgetsRequest}

Field | Description
--- | ---
billing_account_id | **string**<br>Required. ID of the billing account to list budgets corresponding to. To get the billing account ID, use [BillingAccountService.List](./billing_account_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListBudgetsResponse.next_page_token](#ListBudgetsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListBudgetsResponse.next_page_token](#ListBudgetsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListBudgetsResponse {#ListBudgetsResponse}

Field | Description
--- | ---
budgets[] | **[Budget](#Budget1)**<br>List of budgets. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListBudgetsRequest.page_size](#ListBudgetsRequest), use `next_page_token` as the value for the [ListBudgetsRequest.page_token](#ListBudgetsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Budget {#Budget1}

Field | Description
--- | ---
id | **string**<br>ID of the budget. 
name | **string**<br>Name of the budget. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
billing_account_id | **string**<br>ID of the billing account that the budget belongs to. 
status | enum **BudgetStatus**<br>Status of the budget. <ul><li>`CREATING`: The budget is being created.</li><li>`ACTIVE`: The budget is active.</li><li>`FINISHED`: The budget is finished.</li></ul>
budget_spec | **oneof:** `cost_budget`, `expense_budget` or `balance_budget`<br>Specification of the budget.
&nbsp;&nbsp;cost_budget | **[CostBudgetSpec](#CostBudgetSpec1)**<br>Cost budget specification. 
&nbsp;&nbsp;expense_budget | **[ExpenseBudgetSpec](#ExpenseBudgetSpec1)**<br>Expense budget specification. 
&nbsp;&nbsp;balance_budget | **[BalanceBudgetSpec](#BalanceBudgetSpec1)**<br>Balance budget specification. 


### CostBudgetSpec {#CostBudgetSpec1}

Field | Description
--- | ---
amount | **string**<br>Max cost threshold of the budget. Amount currency is the same as corresponding `yandex.cloud.billing.v1.BillingAccount.currency`. 
notification_user_account_ids[] | **string**<br>IDs of the `yandex.cloud.iam.v1.UserAccount`. Specified users will be be notified if the budget exceeds. 
threshold_rules[] | **[ThresholdRule](#ThresholdRule1)**<br>List of the [ThresholdRule](#ThresholdRule1). Rules define intermediate cost thresholds of the budget. 
filter | **[ConsumptionFilter](#ConsumptionFilter1)**<br>Filter that can be used for specific resources selection. Only consumption cost of selected resources are used for the budget calculation. 
start_type | **oneof:** `reset_period` or `start_date`<br>Start type of the budget.
&nbsp;&nbsp;reset_period | enum **ResetPeriodType**<br>Periodic start type that resets budget after specified period is finished. First time budget is calculated in the current period, i.e. current month, quarter or year. <ul><li>`MONTHLY`: Reset budget every month.</li><li>`QUARTER`: Reset budget every quarter.</li><li>`ANNUALLY`: Reset budget every year.</li></ul>
&nbsp;&nbsp;start_date | **string**<br>Custom start date of the budget. Must be the first day of a month and must be formatted like YYYY-MM-DD. 
end_date | **string**<br>End date of the budget. Must be the last day of a month and must be formatted like YYYY-MM-DD. 


### ThresholdRule {#ThresholdRule1}

Field | Description
--- | ---
type | enum **ThresholdType**<br>Type of the rule. <ul><li>`PERCENT`: Percent.</li><li>`AMOUNT`: The same as budget amount.</li></ul>
amount | **string**<br>Amount of the rule. <ul><li>Must be less than 100 if type is PERCENT. </li><li>Must be less than budget's amount if type is AMOUNT.</li></ul> 
notification_user_account_ids[] | **string**<br>IDs of the `yandex.cloud.iam.v1.UserAccount`. Specified users will be be notified if the threshold exceeds. 


### ConsumptionFilter {#ConsumptionFilter1}

Field | Description
--- | ---
service_ids[] | **string**<br>IDs of the `yandex.cloud.billing.v1.Service`. Only consumption of resources corresponding to the given services is used for the budget calculation. Empty sequence means no services filters. 
cloud_folders_filters[] | **[CloudFoldersConsumptionFilter](#CloudFoldersConsumptionFilter1)**<br>Cloud and folders consumption filter. Only consumption within specified clouds and folders is used for the budget calculation. Empty sequence means no cloud and folders filters. 


### CloudFoldersConsumptionFilter {#CloudFoldersConsumptionFilter1}

Field | Description
--- | ---
cloud_id | **string**<br>ID of the `yandex.cloud.resourcemanager.v1.Cloud`. Only consumption within specified cloud is used for the budget calculation. 
folder_ids[] | **string**<br>IDs of the `yandex.cloud.resourcemanager.v1.Folder`. Only consumption within specified folders of the given cloud is used for the budget calculation. Empty sequence means no folders filters and the whole cloud consumption will be used. 


### ExpenseBudgetSpec {#ExpenseBudgetSpec1}

Field | Description
--- | ---
amount | **string**<br>Max expense threshold of the budget. Amount currency is the same as corresponding `yandex.cloud.billing.v1.BillingAccount.currency`. 
notification_user_account_ids[] | **string**<br>IDs of the `yandex.cloud.iam.v1.UserAccount`. Specified users will be be notified if the budget exceeds. 
threshold_rules[] | **[ThresholdRule](#ThresholdRule2)**<br>List of the [ThresholdRule](#ThresholdRule2). Rules define intermediate expense thresholds of the budget. 
filter | **[ConsumptionFilter](#ConsumptionFilter2)**<br>Filter that can be used for specific resources selection. Only consumption expense of selected resources are used for the budget calculation. 
start_type | **oneof:** `reset_period` or `start_date`<br>Start type of the budget.
&nbsp;&nbsp;reset_period | enum **ResetPeriodType**<br>Periodic start type that resets budget after specified period is finished. First time budget is calculated in the current period, i.e. current month, quarter or year. <ul><li>`MONTHLY`: Reset budget every month.</li><li>`QUARTER`: Reset budget every quarter.</li><li>`ANNUALLY`: Reset budget every year.</li></ul>
&nbsp;&nbsp;start_date | **string**<br>Custom start date of the budget. Must be the first day of a month and must be formatted like YYYY-MM-DD. 
end_date | **string**<br>End date of the budget. Must be the last day of a month and must be formatted like YYYY-MM-DD. 


### BalanceBudgetSpec {#BalanceBudgetSpec1}

Field | Description
--- | ---
amount | **string**<br>Max balance threshold of the budget. Amount currency is the same as corresponding `yandex.cloud.billing.v1.BillingAccount.currency`. 
notification_user_account_ids[] | **string**<br>IDs of the `yandex.cloud.iam.v1.UserAccount`. Specified users will be be notified if the budget exceeds. 
threshold_rules[] | **[ThresholdRule](#ThresholdRule2)**<br>List of the [ThresholdRule](#ThresholdRule2). Rules define intermediate balance thresholds of the budget. 
start_date | **string**<br>Start_date of the budget. Must be the first day of a month and must be formatted like YYYY-MM-DD. 
end_date | **string**<br>End date of the budget. Must be the last day of a month and must be formatted like YYYY-MM-DD. 


## Create {#Create}

Creates a budget for the specified billing account.

**rpc Create ([CreateBudgetRequest](#CreateBudgetRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateBudgetMetadata](#CreateBudgetMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Budget](#Budget2)<br>

### CreateBudgetRequest {#CreateBudgetRequest}

Field | Description
--- | ---
billing_account_id | **string**<br>Required. ID of the billing account to list budgets corresponding to. To get the billing account ID, use [yandex.cloud.billing.v1.BillingAccountService.List](/docs/billing/api-ref/grpc/billing_account_service#List) request. The maximum string length in characters is 50.
name | **string**<br>Required. Name of the budget. 
budget_spec | **oneof:** `cost_budget_spec`, `expense_budget_spec` or `balance_budget_spec`<br>Specification of the budget.
&nbsp;&nbsp;cost_budget_spec | **[CostBudgetSpec](#CostBudgetSpec2)**<br>Cost budget specification. 
&nbsp;&nbsp;expense_budget_spec | **[ExpenseBudgetSpec](#ExpenseBudgetSpec2)**<br>Expense budget specification. 
&nbsp;&nbsp;balance_budget_spec | **[BalanceBudgetSpec](#BalanceBudgetSpec2)**<br>Balance budget specification. 


### CostBudgetSpec {#CostBudgetSpec2}

Field | Description
--- | ---
amount | **string**<br>Max cost threshold of the budget. Amount currency is the same as corresponding `yandex.cloud.billing.v1.BillingAccount.currency`. 
notification_user_account_ids[] | **string**<br>IDs of the `yandex.cloud.iam.v1.UserAccount`. Specified users will be be notified if the budget exceeds. 
threshold_rules[] | **[ThresholdRule](#ThresholdRule2)**<br>List of the [ThresholdRule](#ThresholdRule2). Rules define intermediate cost thresholds of the budget. 
filter | **[ConsumptionFilter](#ConsumptionFilter2)**<br>Filter that can be used for specific resources selection. Only consumption cost of selected resources are used for the budget calculation. 
start_type | **oneof:** `reset_period` or `start_date`<br>Start type of the budget.
&nbsp;&nbsp;reset_period | enum **ResetPeriodType**<br>Periodic start type that resets budget after specified period is finished. First time budget is calculated in the current period, i.e. current month, quarter or year. <ul><li>`MONTHLY`: Reset budget every month.</li><li>`QUARTER`: Reset budget every quarter.</li><li>`ANNUALLY`: Reset budget every year.</li></ul>
&nbsp;&nbsp;start_date | **string**<br>Custom start date of the budget. Must be the first day of a month and must be formatted like YYYY-MM-DD. 
end_date | **string**<br>End date of the budget. Must be the last day of a month and must be formatted like YYYY-MM-DD. 


### ThresholdRule {#ThresholdRule2}

Field | Description
--- | ---
type | enum **ThresholdType**<br>Type of the rule. <ul><li>`PERCENT`: Percent.</li><li>`AMOUNT`: The same as budget amount.</li></ul>
amount | **string**<br>Amount of the rule. <ul><li>Must be less than 100 if type is PERCENT. </li><li>Must be less than budget's amount if type is AMOUNT.</li></ul> 
notification_user_account_ids[] | **string**<br>IDs of the `yandex.cloud.iam.v1.UserAccount`. Specified users will be be notified if the threshold exceeds. 


### ConsumptionFilter {#ConsumptionFilter2}

Field | Description
--- | ---
service_ids[] | **string**<br>IDs of the `yandex.cloud.billing.v1.Service`. Only consumption of resources corresponding to the given services is used for the budget calculation. Empty sequence means no services filters. 
cloud_folders_filters[] | **[CloudFoldersConsumptionFilter](#CloudFoldersConsumptionFilter2)**<br>Cloud and folders consumption filter. Only consumption within specified clouds and folders is used for the budget calculation. Empty sequence means no cloud and folders filters. 


### CloudFoldersConsumptionFilter {#CloudFoldersConsumptionFilter2}

Field | Description
--- | ---
cloud_id | **string**<br>ID of the `yandex.cloud.resourcemanager.v1.Cloud`. Only consumption within specified cloud is used for the budget calculation. 
folder_ids[] | **string**<br>IDs of the `yandex.cloud.resourcemanager.v1.Folder`. Only consumption within specified folders of the given cloud is used for the budget calculation. Empty sequence means no folders filters and the whole cloud consumption will be used. 


### ExpenseBudgetSpec {#ExpenseBudgetSpec2}

Field | Description
--- | ---
amount | **string**<br>Max expense threshold of the budget. Amount currency is the same as corresponding `yandex.cloud.billing.v1.BillingAccount.currency`. 
notification_user_account_ids[] | **string**<br>IDs of the `yandex.cloud.iam.v1.UserAccount`. Specified users will be be notified if the budget exceeds. 
threshold_rules[] | **[ThresholdRule](#ThresholdRule3)**<br>List of the [ThresholdRule](#ThresholdRule3). Rules define intermediate expense thresholds of the budget. 
filter | **[ConsumptionFilter](#ConsumptionFilter3)**<br>Filter that can be used for specific resources selection. Only consumption expense of selected resources are used for the budget calculation. 
start_type | **oneof:** `reset_period` or `start_date`<br>Start type of the budget.
&nbsp;&nbsp;reset_period | enum **ResetPeriodType**<br>Periodic start type that resets budget after specified period is finished. First time budget is calculated in the current period, i.e. current month, quarter or year. <ul><li>`MONTHLY`: Reset budget every month.</li><li>`QUARTER`: Reset budget every quarter.</li><li>`ANNUALLY`: Reset budget every year.</li></ul>
&nbsp;&nbsp;start_date | **string**<br>Custom start date of the budget. Must be the first day of a month and must be formatted like YYYY-MM-DD. 
end_date | **string**<br>End date of the budget. Must be the last day of a month and must be formatted like YYYY-MM-DD. 


### BalanceBudgetSpec {#BalanceBudgetSpec2}

Field | Description
--- | ---
amount | **string**<br>Max balance threshold of the budget. Amount currency is the same as corresponding `yandex.cloud.billing.v1.BillingAccount.currency`. 
notification_user_account_ids[] | **string**<br>IDs of the `yandex.cloud.iam.v1.UserAccount`. Specified users will be be notified if the budget exceeds. 
threshold_rules[] | **[ThresholdRule](#ThresholdRule3)**<br>List of the [ThresholdRule](#ThresholdRule3). Rules define intermediate balance thresholds of the budget. 
start_date | **string**<br>Start_date of the budget. Must be the first day of a month and must be formatted like YYYY-MM-DD. 
end_date | **string**<br>End date of the budget. Must be the last day of a month and must be formatted like YYYY-MM-DD. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateBudgetMetadata](#CreateBudgetMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Budget](#Budget2)>**<br>if operation finished successfully. 


### CreateBudgetMetadata {#CreateBudgetMetadata}

Field | Description
--- | ---
budget_id | **string**<br>ID of the budget. 


### Budget {#Budget2}

Field | Description
--- | ---
id | **string**<br>ID of the budget. 
name | **string**<br>Name of the budget. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
billing_account_id | **string**<br>ID of the billing account that the budget belongs to. 
status | enum **BudgetStatus**<br>Status of the budget. <ul><li>`CREATING`: The budget is being created.</li><li>`ACTIVE`: The budget is active.</li><li>`FINISHED`: The budget is finished.</li></ul>
budget_spec | **oneof:** `cost_budget`, `expense_budget` or `balance_budget`<br>Specification of the budget.
&nbsp;&nbsp;cost_budget | **[CostBudgetSpec](#CostBudgetSpec3)**<br>Cost budget specification. 
&nbsp;&nbsp;expense_budget | **[ExpenseBudgetSpec](#ExpenseBudgetSpec3)**<br>Expense budget specification. 
&nbsp;&nbsp;balance_budget | **[BalanceBudgetSpec](#BalanceBudgetSpec3)**<br>Balance budget specification. 


