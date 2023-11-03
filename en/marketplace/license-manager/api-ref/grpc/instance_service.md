---
editable: false
sourcePath: en/_api-ref-grpc/marketplace/license-manager/license-manager/api-ref/grpc/instance_service.md
---

# Yandex Cloud Marketplace License Manager, gRPC: InstanceService

A set of methods for managing subscription instances.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified subscription instance. |
| [List](#List) | Retrieves the list of subscription instances in the specified folder. |

## Calls InstanceService {#calls}

## Get {#Get}

Returns the specified subscription instance. <br>To get the list of all available subscription instances, make a [List](#List) request.

**rpc Get ([GetInstanceRequest](#GetInstanceRequest)) returns ([Instance](#Instance))**

### GetInstanceRequest {#GetInstanceRequest}

Field | Description
--- | ---
instance_id | **string**<br>Required. ID of the subscription instance. 


### Instance {#Instance}

Field | Description
--- | ---
id | **string**<br>ID of the subscription instance. 
cloud_id | **string**<br>ID of the cloud that the subscription instance belongs to. 
folder_id | **string**<br>ID of the folder that the subscription instance belongs to. 
template_id | **string**<br>ID of the subscription template that was used to create subscription instance. 
template_version_id | **string**<br>ID of the version of subscription template. 
description | **string**<br>Description of the subscription instance. 
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp of the start of the subscription. 
end_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp of the end of the subscription. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Update timestamp. 
state | enum **State**<br>Subscription state. <ul><li>`PENDING`: Subscription created but not active yet.</li><li>`ACTIVE`: Subscription is active.</li><li>`CANCELLED`: Subscription canceled. It is still active, but won't be automatically renewed after the end of the current period.</li><li>`EXPIRED`: Subscription expired.</li><li>`DEPRECATED`: Subscription deprecated.</li><li>`DELETED`: Subscription deleted.</li></ul>
locks[] | **[Lock](#Lock)**<br>List of subscription locks. 
license_template | **[Template](#Template)**<br>Subscription template. 


### Lock {#Lock}

Field | Description
--- | ---
id | **string**<br>ID of the subscription lock. 
instance_id | **string**<br>ID of the subscription instance. 
resource_id | **string**<br>ID of the resource. 
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp of the start of the subscription lock. 
end_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp of the end of the subscription lock. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Update timestamp. 
state | enum **State**<br>Subscription lock state. <ul><li>`UNLOCKED`: Subscription unlocked.</li><li>`LOCKED`: Subscription locked to the resource.</li><li>`DELETED`: Subscription lock deleted.</li></ul>
template_id | **string**<br>ID of the subscription template. 


### Template {#Template}

Field | Description
--- | ---
id | **string**<br>ID of the subscription template. 
version_id | **string**<br>Version of the subscription template. 
name | **string**<br>Name of the subscription template. 
publisher_id | **string**<br>ID of publisher. 
product_id | **string**<br>ID of product. 
tariff_id | **string**<br>ID of tariff. 
license_sku_id | **string**<br>ID of subscription SKU. 
period | **string**<br>Subscription period. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Update timestamp. 
state | enum **State**<br>Subscription template state. <ul><li>`PENDING`: Subscription template created but not active yet.</li><li>`ACTIVE`: Subscription template is active.</li><li>`DEPRECATED`: Subscription template deprecated.</li><li>`DELETED`: Subscription template deleted.</li></ul>


## List {#List}

Retrieves the list of subscription instances in the specified folder.

**rpc List ([ListInstancesRequest](#ListInstancesRequest)) returns ([ListInstancesResponse](#ListInstancesResponse))**

### ListInstancesRequest {#ListInstancesRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder that the subscription instance belongs to. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListInstancesResponse.next_page_token](#ListInstancesResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListInstancesResponse.next_page_token](#ListInstancesResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters subscription instances listed in the response. <br>The expression must specify: <ol><li>The field name. Currently you can use filtering only on [Instance.name](#Instance1) field. </li><li>An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Example of a filter: `name=my-subscription-instance`. The maximum string length in characters is 1000.
order_by | **string**<br>Sorting order for the list of subscription instances. The maximum string length in characters is 100.


### ListInstancesResponse {#ListInstancesResponse}

Field | Description
--- | ---
instances[] | **[Instance](#Instance1)**<br>List of subscription instances. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListInstancesRequest.page_size](#ListInstancesRequest), use `next_page_token` as the value for the [ListInstancesRequest.page_token](#ListInstancesRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### Instance {#Instance1}

Field | Description
--- | ---
id | **string**<br>ID of the subscription instance. 
cloud_id | **string**<br>ID of the cloud that the subscription instance belongs to. 
folder_id | **string**<br>ID of the folder that the subscription instance belongs to. 
template_id | **string**<br>ID of the subscription template that was used to create subscription instance. 
template_version_id | **string**<br>ID of the version of subscription template. 
description | **string**<br>Description of the subscription instance. 
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp of the start of the subscription. 
end_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp of the end of the subscription. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Update timestamp. 
state | enum **State**<br>Subscription state. <ul><li>`PENDING`: Subscription created but not active yet.</li><li>`ACTIVE`: Subscription is active.</li><li>`CANCELLED`: Subscription canceled. It is still active, but won't be automatically renewed after the end of the current period.</li><li>`EXPIRED`: Subscription expired.</li><li>`DEPRECATED`: Subscription deprecated.</li><li>`DELETED`: Subscription deleted.</li></ul>
locks[] | **[Lock](#Lock1)**<br>List of subscription locks. 
license_template | **[Template](#Template1)**<br>Subscription template. 


### Lock {#Lock1}

Field | Description
--- | ---
id | **string**<br>ID of the subscription lock. 
instance_id | **string**<br>ID of the subscription instance. 
resource_id | **string**<br>ID of the resource. 
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp of the start of the subscription lock. 
end_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp of the end of the subscription lock. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Update timestamp. 
state | enum **State**<br>Subscription lock state. <ul><li>`UNLOCKED`: Subscription unlocked.</li><li>`LOCKED`: Subscription locked to the resource.</li><li>`DELETED`: Subscription lock deleted.</li></ul>
template_id | **string**<br>ID of the subscription template. 


### Template {#Template1}

Field | Description
--- | ---
id | **string**<br>ID of the subscription template. 
version_id | **string**<br>Version of the subscription template. 
name | **string**<br>Name of the subscription template. 
publisher_id | **string**<br>ID of publisher. 
product_id | **string**<br>ID of product. 
tariff_id | **string**<br>ID of tariff. 
license_sku_id | **string**<br>ID of subscription SKU. 
period | **string**<br>Subscription period. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Update timestamp. 
state | enum **State**<br>Subscription template state. <ul><li>`PENDING`: Subscription template created but not active yet.</li><li>`ACTIVE`: Subscription template is active.</li><li>`DEPRECATED`: Subscription template deprecated.</li><li>`DELETED`: Subscription template deleted.</li></ul>


