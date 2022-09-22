---
editable: false
---

# OriginGroupService

Origin Groups management service.

| Call | Description |
| --- | --- |
| [Get](#Get) | Gets origin group with specified origin group id. |
| [List](#List) | Lists origins of origin group. |
| [Create](#Create) | Creates origin group. |
| [Update](#Update) | Updates the specified origin group. |
| [Delete](#Delete) | Deletes origin group with specified origin group id. |

## Calls OriginGroupService {#calls}

## Get {#Get}

Gets origin group with specified origin group id.

**rpc Get ([GetOriginGroupRequest](#GetOriginGroupRequest)) returns ([OriginGroup](#OriginGroup))**

### GetOriginGroupRequest {#GetOriginGroupRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder that the origin group belongs to. The maximum string length in characters is 50.
origin_group_id | **int64**<br>ID of the origin group to return. <br>To get a origin group ID, make a [OriginGroupService.List](#List) request. Value must be greater than 0.


### OriginGroup {#OriginGroup}

Field | Description
--- | ---
id | **int64**<br>ID of the origin group. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the origin group belongs to. 
name | **string**<br>Name of the origin group. 
use_next | **bool**<br>This option have two possible conditions: true - the option is active. In case the origin responds with 4XX or 5XX codes, use the next origin from the list. false - the option is disabled. 
origins[] | **[Origin](#Origin)**<br>List of origins. 


### Origin {#Origin}

Field | Description
--- | ---
id | **int64**<br>ID of the origin. 
origin_group_id | **int64**<br>ID of the parent origin group. 
source | **string**<br>IP address or Domain name of your origin and the port (if custom). Used if `meta` variant is `common`. 
enabled | **bool**<br>The setting allows to enable or disable an Origin source in the Origins group. <br>It has two possible values: <br>True - The origin is enabled and used as a source for the CDN. An origins group must contain at least one enabled origin. False - The origin is disabled and the CDN is not using it to pull content. 
backup | **bool**<br>Specifies whether the origin is used in its origin group as backup. A backup origin is used when one of active origins becomes unavailable. 
meta | **[OriginMeta](#OriginMeta)**<br>Set up origin of the content. 


### OriginMeta {#OriginMeta}

Field | Description
--- | ---
origin_meta_variant | **oneof:** `common`, `bucket`, `website` or `balancer`<br>Type of the origin.
&nbsp;&nbsp;common | **[OriginNamedMeta](#OriginNamedMeta)**<br>A server with a domain name linked to it 
&nbsp;&nbsp;bucket | **[OriginNamedMeta](#OriginNamedMeta)**<br>An Object Storage bucket not configured as a static site hosting. 
&nbsp;&nbsp;website | **[OriginNamedMeta](#OriginNamedMeta)**<br>An Object Storage bucket configured as a static site hosting. 
&nbsp;&nbsp;balancer | **[OriginBalancerMeta](#OriginBalancerMeta)**<br>An L7 load balancer from Application Load Balancer. CDN servers will access the load balancer at one of its IP addresses that must be selected in the origin settings. 


### OriginNamedMeta {#OriginNamedMeta}

Field | Description
--- | ---
name | **string**<br>Name of the origin. 


### OriginBalancerMeta {#OriginBalancerMeta}

Field | Description
--- | ---
id | **string**<br>ID of the origin. 


## List {#List}

Lists origins of origin group.

**rpc List ([ListOriginGroupsRequest](#ListOriginGroupsRequest)) returns ([ListOriginGroupsResponse](#ListOriginGroupsResponse))**

### ListOriginGroupsRequest {#ListOriginGroupsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder that the origin group belongs to.. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListOriginGroupsResponse.next_page_token](#ListOriginGroupsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListOriginGroupsResponse.next_page_token](#ListOriginGroupsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListOriginGroupsResponse {#ListOriginGroupsResponse}

Field | Description
--- | ---
origin_groups[] | **[OriginGroup](#OriginGroup1)**<br>List of all Origin Groups associated with folder. 
next_page_token | **string**<br>`next_page_token` token allows you to get the next page of results for list requests. If the number of results is larger than [ListOriginGroupsRequest.page_size](#ListOriginGroupsRequest), use the `next_page_token` as the value for the [ListOriginGroupsRequest.page_token](#ListOriginGroupsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### OriginGroup {#OriginGroup1}

Field | Description
--- | ---
id | **int64**<br>ID of the origin group. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the origin group belongs to. 
name | **string**<br>Name of the origin group. 
use_next | **bool**<br>This option have two possible conditions: true - the option is active. In case the origin responds with 4XX or 5XX codes, use the next origin from the list. false - the option is disabled. 
origins[] | **[Origin](#Origin1)**<br>List of origins. 


### Origin {#Origin1}

Field | Description
--- | ---
id | **int64**<br>ID of the origin. 
origin_group_id | **int64**<br>ID of the parent origin group. 
source | **string**<br>IP address or Domain name of your origin and the port (if custom). Used if `meta` variant is `common`. 
enabled | **bool**<br>The setting allows to enable or disable an Origin source in the Origins group. <br>It has two possible values: <br>True - The origin is enabled and used as a source for the CDN. An origins group must contain at least one enabled origin. False - The origin is disabled and the CDN is not using it to pull content. 
backup | **bool**<br>Specifies whether the origin is used in its origin group as backup. A backup origin is used when one of active origins becomes unavailable. 
meta | **[OriginMeta](#OriginMeta1)**<br>Set up origin of the content. 


### OriginMeta {#OriginMeta1}

Field | Description
--- | ---
origin_meta_variant | **oneof:** `common`, `bucket`, `website` or `balancer`<br>Type of the origin.
&nbsp;&nbsp;common | **[OriginNamedMeta](#OriginNamedMeta1)**<br>A server with a domain name linked to it 
&nbsp;&nbsp;bucket | **[OriginNamedMeta](#OriginNamedMeta1)**<br>An Object Storage bucket not configured as a static site hosting. 
&nbsp;&nbsp;website | **[OriginNamedMeta](#OriginNamedMeta1)**<br>An Object Storage bucket configured as a static site hosting. 
&nbsp;&nbsp;balancer | **[OriginBalancerMeta](#OriginBalancerMeta1)**<br>An L7 load balancer from Application Load Balancer. CDN servers will access the load balancer at one of its IP addresses that must be selected in the origin settings. 


### OriginNamedMeta {#OriginNamedMeta1}

Field | Description
--- | ---
name | **string**<br>Name of the origin. 


### OriginBalancerMeta {#OriginBalancerMeta1}

Field | Description
--- | ---
id | **string**<br>ID of the origin. 


## Create {#Create}

Creates origin group.

**rpc Create ([CreateOriginGroupRequest](#CreateOriginGroupRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateOriginGroupMetadata](#CreateOriginGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[OriginGroup](#OriginGroup2)<br>

### CreateOriginGroupRequest {#CreateOriginGroupRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder that the origin group belongs to. The maximum string length in characters is 50.
name | **string**<br>Name of the origin group. 
use_next | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>This option have two possible conditions: true - The option is active. In case the origin responds with 4XX or 5XX codes, use the next origin from the list. false - The option is disabled. <br>default value is true 
origins[] | **[OriginParams](#OriginParams)**<br>List of origins: IP addresses or Domain names of your origins and the port (if custom). 


### OriginParams {#OriginParams}

Field | Description
--- | ---
source | **string**<br>Source: IP address or Domain name of your origin and the port (if custom). 
enabled | **bool**<br>The setting allows to enable or disable an Origin source in the Origins group. <br>It has two possible values: <br>True - The origin is enabled and used as a source for the CDN. An origins group must contain at least one enabled origins. False - The origin is disabled and the CDN is not using it to pull content. 
backup | **bool**<br>backup option has two possible values: <br>True - The option is active. The origin will not be used until one of active origins become unavailable. False - The option is disabled. 
meta | **[OriginMeta](#OriginMeta2)**<br>Set up origin of the content. 


### OriginMeta {#OriginMeta2}

Field | Description
--- | ---
origin_meta_variant | **oneof:** `common`, `bucket`, `website` or `balancer`<br>Type of the origin.
&nbsp;&nbsp;common | **[OriginNamedMeta](#OriginNamedMeta2)**<br>A server with a domain name linked to it 
&nbsp;&nbsp;bucket | **[OriginNamedMeta](#OriginNamedMeta2)**<br>An Object Storage bucket not configured as a static site hosting. 
&nbsp;&nbsp;website | **[OriginNamedMeta](#OriginNamedMeta2)**<br>An Object Storage bucket configured as a static site hosting. 
&nbsp;&nbsp;balancer | **[OriginBalancerMeta](#OriginBalancerMeta2)**<br>An L7 load balancer from Application Load Balancer. CDN servers will access the load balancer at one of its IP addresses that must be selected in the origin settings. 


### OriginNamedMeta {#OriginNamedMeta2}

Field | Description
--- | ---
name | **string**<br>Name of the origin. 


### OriginBalancerMeta {#OriginBalancerMeta2}

Field | Description
--- | ---
id | **string**<br>ID of the origin. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateOriginGroupMetadata](#CreateOriginGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[OriginGroup](#OriginGroup2)>**<br>if operation finished successfully. 


### CreateOriginGroupMetadata {#CreateOriginGroupMetadata}

Field | Description
--- | ---
origin_group_id | **int64**<br>ID of created origin group. Value must be greater than 0.


### OriginGroup {#OriginGroup2}

Field | Description
--- | ---
id | **int64**<br>ID of the origin group. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the origin group belongs to. 
name | **string**<br>Name of the origin group. 
use_next | **bool**<br>This option have two possible conditions: true - the option is active. In case the origin responds with 4XX or 5XX codes, use the next origin from the list. false - the option is disabled. 
origins[] | **[Origin](#Origin2)**<br>List of origins. 


### Origin {#Origin2}

Field | Description
--- | ---
id | **int64**<br>ID of the origin. 
origin_group_id | **int64**<br>ID of the parent origin group. 
source | **string**<br>IP address or Domain name of your origin and the port (if custom). Used if `meta` variant is `common`. 
enabled | **bool**<br>The setting allows to enable or disable an Origin source in the Origins group. <br>It has two possible values: <br>True - The origin is enabled and used as a source for the CDN. An origins group must contain at least one enabled origin. False - The origin is disabled and the CDN is not using it to pull content. 
backup | **bool**<br>Specifies whether the origin is used in its origin group as backup. A backup origin is used when one of active origins becomes unavailable. 
meta | **[OriginMeta](#OriginMeta3)**<br>Set up origin of the content. 


## Update {#Update}

Updates the specified origin group. <br>Changes may take up to 15 minutes to apply. Afterwards, it is recommended to purge cache of the resources that use the origin group via a [CacheService.Purge](./cache_service#Purge) request.

**rpc Update ([UpdateOriginGroupRequest](#UpdateOriginGroupRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateOriginGroupMetadata](#UpdateOriginGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[OriginGroup](#OriginGroup3)<br>

### UpdateOriginGroupRequest {#UpdateOriginGroupRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder that the origin group belongs to. The maximum string length in characters is 50.
origin_group_id | **int64**<br>ID of the origin group. Value must be greater than 0.
group_name | **google.protobuf.StringValue**<br>Name of the origin group. 
use_next | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>This option have two possible values: <br>True - The option is active. In case the origin responds with 4XX or 5XX codes, use the next origin from the list. False - The option is disabled. 
origins[] | **[OriginParams](#OriginParams1)**<br>List of origins: IP addresses or Domain names of your origins and the port (if custom). 


### OriginParams {#OriginParams1}

Field | Description
--- | ---
source | **string**<br>Source: IP address or Domain name of your origin and the port (if custom). 
enabled | **bool**<br>The setting allows to enable or disable an Origin source in the Origins group. <br>It has two possible values: <br>True - The origin is enabled and used as a source for the CDN. An origins group must contain at least one enabled origins. False - The origin is disabled and the CDN is not using it to pull content. 
backup | **bool**<br>backup option has two possible values: <br>True - The option is active. The origin will not be used until one of active origins become unavailable. False - The option is disabled. 
meta | **[OriginMeta](#OriginMeta3)**<br>Set up origin of the content. 


### OriginMeta {#OriginMeta3}

Field | Description
--- | ---
origin_meta_variant | **oneof:** `common`, `bucket`, `website` or `balancer`<br>Type of the origin.
&nbsp;&nbsp;common | **[OriginNamedMeta](#OriginNamedMeta3)**<br>A server with a domain name linked to it 
&nbsp;&nbsp;bucket | **[OriginNamedMeta](#OriginNamedMeta3)**<br>An Object Storage bucket not configured as a static site hosting. 
&nbsp;&nbsp;website | **[OriginNamedMeta](#OriginNamedMeta3)**<br>An Object Storage bucket configured as a static site hosting. 
&nbsp;&nbsp;balancer | **[OriginBalancerMeta](#OriginBalancerMeta3)**<br>An L7 load balancer from Application Load Balancer. CDN servers will access the load balancer at one of its IP addresses that must be selected in the origin settings. 


### OriginNamedMeta {#OriginNamedMeta3}

Field | Description
--- | ---
name | **string**<br>Name of the origin. 


### OriginBalancerMeta {#OriginBalancerMeta3}

Field | Description
--- | ---
id | **string**<br>ID of the origin. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateOriginGroupMetadata](#UpdateOriginGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[OriginGroup](#OriginGroup3)>**<br>if operation finished successfully. 


### UpdateOriginGroupMetadata {#UpdateOriginGroupMetadata}

Field | Description
--- | ---
origin_group_id | **int64**<br>ID of the origin group. Value must be greater than 0.


### OriginGroup {#OriginGroup3}

Field | Description
--- | ---
id | **int64**<br>ID of the origin group. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the origin group belongs to. 
name | **string**<br>Name of the origin group. 
use_next | **bool**<br>This option have two possible conditions: true - the option is active. In case the origin responds with 4XX or 5XX codes, use the next origin from the list. false - the option is disabled. 
origins[] | **[Origin](#Origin3)**<br>List of origins. 


### Origin {#Origin3}

Field | Description
--- | ---
id | **int64**<br>ID of the origin. 
origin_group_id | **int64**<br>ID of the parent origin group. 
source | **string**<br>IP address or Domain name of your origin and the port (if custom). Used if `meta` variant is `common`. 
enabled | **bool**<br>The setting allows to enable or disable an Origin source in the Origins group. <br>It has two possible values: <br>True - The origin is enabled and used as a source for the CDN. An origins group must contain at least one enabled origin. False - The origin is disabled and the CDN is not using it to pull content. 
backup | **bool**<br>Specifies whether the origin is used in its origin group as backup. A backup origin is used when one of active origins becomes unavailable. 
meta | **[OriginMeta](#OriginMeta4)**<br>Set up origin of the content. 


## Delete {#Delete}

Deletes origin group with specified origin group id.

**rpc Delete ([DeleteOriginGroupRequest](#DeleteOriginGroupRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteOriginGroupMetadata](#DeleteOriginGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteOriginGroupRequest {#DeleteOriginGroupRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder that the origin group belongs to. The maximum string length in characters is 50.
origin_group_id | **int64**<br>ID of the origin group. Value must be greater than 0.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteOriginGroupMetadata](#DeleteOriginGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteOriginGroupMetadata {#DeleteOriginGroupMetadata}

Field | Description
--- | ---
origin_group_id | **int64**<br>ID of the origin group. Value must be greater than 0.


