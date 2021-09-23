---
editable: false
---

# OriginService

Origin management service. 
Origin is not a standalone entity. It can live only within origin group.

| Call | Description |
| --- | --- |
| [Get](#Get) | Get origin in origin group. |
| [List](#List) | List origins of origin group. |
| [Create](#Create) | Create origin inside origin group. |
| [Update](#Update) | Update origin from origin group. |
| [Delete](#Delete) | Delete origin from origin group |

## Calls OriginService {#calls}

## Get {#Get}

Get origin in origin group.

**rpc Get ([GetOriginRequest](#GetOriginRequest)) returns ([Origin](#Origin))**

### GetOriginRequest {#GetOriginRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. Origin's owner Folder ID. The maximum string length in characters is 50.
origin_id | **int64**<br>`origin_id` group ID to request origin from. Value must be greater than 0.


### Origin {#Origin}

Field | Description
--- | ---
id | **int64**<br>Origin unique ID. 
origin_group_id | **int64**<br>Parent origin group ID. 
source | **string**<br>Source: IP address or Domain name of your origin and the port (if custom). 
enabled | **bool**<br>The setting allows to enable or disable an Origin source in the Origins group. <br>It has two possible values: <br>True - The origin is enabled and used as a source for the CDN. An origins group must contain at least one enabled origins. False - The origin is disabled and the CDN is not using it to pull content. 
backup | **bool**<br>backup option has two possible values: <br>True - The option is active. The origin will not be used until one of active origins become unavailable. False - The option is disabled. 
meta | **[OriginMeta](#OriginMeta)**<br> 


### OriginMeta {#OriginMeta}

Field | Description
--- | ---
origin_meta_variant | **oneof:** `common`, `bucket`, `website` or `balancer`<br>
&nbsp;&nbsp;common | **[OriginNamedMeta](#OriginNamedMeta)**<br> 
&nbsp;&nbsp;bucket | **[OriginNamedMeta](#OriginNamedMeta)**<br> 
&nbsp;&nbsp;website | **[OriginNamedMeta](#OriginNamedMeta)**<br> 
&nbsp;&nbsp;balancer | **[OriginBalancerMeta](#OriginBalancerMeta)**<br> 


### OriginNamedMeta {#OriginNamedMeta}

Field | Description
--- | ---
name | **string**<br> 


### OriginBalancerMeta {#OriginBalancerMeta}

Field | Description
--- | ---
id | **string**<br> 


## List {#List}

List origins of origin group.

**rpc List ([ListOriginsRequest](#ListOriginsRequest)) returns ([ListOriginsResponse](#ListOriginsResponse))**

### ListOriginsRequest {#ListOriginsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. Origin's owner Folder ID. The maximum string length in characters is 50.
origin_group_id | **int64**<br>`origin_group_id` group ID to request origins from. Value must be greater than 0.


### ListOriginsResponse {#ListOriginsResponse}

Field | Description
--- | ---
origins[] | **[Origin](#Origin1)**<br> 


### Origin {#Origin1}

Field | Description
--- | ---
id | **int64**<br>Origin unique ID. 
origin_group_id | **int64**<br>Parent origin group ID. 
source | **string**<br>Source: IP address or Domain name of your origin and the port (if custom). 
enabled | **bool**<br>The setting allows to enable or disable an Origin source in the Origins group. <br>It has two possible values: <br>True - The origin is enabled and used as a source for the CDN. An origins group must contain at least one enabled origins. False - The origin is disabled and the CDN is not using it to pull content. 
backup | **bool**<br>backup option has two possible values: <br>True - The option is active. The origin will not be used until one of active origins become unavailable. False - The option is disabled. 
meta | **[OriginMeta](#OriginMeta1)**<br> 


### OriginMeta {#OriginMeta1}

Field | Description
--- | ---
origin_meta_variant | **oneof:** `common`, `bucket`, `website` or `balancer`<br>
&nbsp;&nbsp;common | **[OriginNamedMeta](#OriginNamedMeta1)**<br> 
&nbsp;&nbsp;bucket | **[OriginNamedMeta](#OriginNamedMeta1)**<br> 
&nbsp;&nbsp;website | **[OriginNamedMeta](#OriginNamedMeta1)**<br> 
&nbsp;&nbsp;balancer | **[OriginBalancerMeta](#OriginBalancerMeta1)**<br> 


### OriginNamedMeta {#OriginNamedMeta1}

Field | Description
--- | ---
name | **string**<br> 


### OriginBalancerMeta {#OriginBalancerMeta1}

Field | Description
--- | ---
id | **string**<br> 


## Create {#Create}

Create origin inside origin group.

**rpc Create ([CreateOriginRequest](#CreateOriginRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateOriginMetadata](#CreateOriginMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Origin](#Origin2)<br>

### CreateOriginRequest {#CreateOriginRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. Origin's owner Folder ID. The maximum string length in characters is 50.
origin_group_id | **int64**<br>`origin_group_id` group ID to request origins from. Value must be greater than 0.
source | **string**<br>Required. IP address or Domain name of your origin and the port (if custom). The maximum string length in characters is 50.
enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Default value true. 
backup | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Default value: false. 
meta | **[OriginMeta](#OriginMeta2)**<br> 


### OriginMeta {#OriginMeta2}

Field | Description
--- | ---
origin_meta_variant | **oneof:** `common`, `bucket`, `website` or `balancer`<br>
&nbsp;&nbsp;common | **[OriginNamedMeta](#OriginNamedMeta2)**<br> 
&nbsp;&nbsp;bucket | **[OriginNamedMeta](#OriginNamedMeta2)**<br> 
&nbsp;&nbsp;website | **[OriginNamedMeta](#OriginNamedMeta2)**<br> 
&nbsp;&nbsp;balancer | **[OriginBalancerMeta](#OriginBalancerMeta2)**<br> 


### OriginNamedMeta {#OriginNamedMeta2}

Field | Description
--- | ---
name | **string**<br> 


### OriginBalancerMeta {#OriginBalancerMeta2}

Field | Description
--- | ---
id | **string**<br> 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateOriginMetadata](#CreateOriginMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Origin](#Origin2)>**<br>if operation finished successfully. 


### CreateOriginMetadata {#CreateOriginMetadata}

Field | Description
--- | ---
origin_id | **int64**<br>Origin ID. Value must be greater than 0.
origin_group_id | **int64**<br>Parent origins group ID. Value must be greater than 0.


### Origin {#Origin2}

Field | Description
--- | ---
id | **int64**<br>Origin unique ID. 
origin_group_id | **int64**<br>Parent origin group ID. 
source | **string**<br>Source: IP address or Domain name of your origin and the port (if custom). 
enabled | **bool**<br>The setting allows to enable or disable an Origin source in the Origins group. <br>It has two possible values: <br>True - The origin is enabled and used as a source for the CDN. An origins group must contain at least one enabled origins. False - The origin is disabled and the CDN is not using it to pull content. 
backup | **bool**<br>backup option has two possible values: <br>True - The option is active. The origin will not be used until one of active origins become unavailable. False - The option is disabled. 
meta | **[OriginMeta](#OriginMeta3)**<br> 


### OriginMeta {#OriginMeta3}

Field | Description
--- | ---
origin_meta_variant | **oneof:** `common`, `bucket`, `website` or `balancer`<br>
&nbsp;&nbsp;common | **[OriginNamedMeta](#OriginNamedMeta3)**<br> 
&nbsp;&nbsp;bucket | **[OriginNamedMeta](#OriginNamedMeta3)**<br> 
&nbsp;&nbsp;website | **[OriginNamedMeta](#OriginNamedMeta3)**<br> 
&nbsp;&nbsp;balancer | **[OriginBalancerMeta](#OriginBalancerMeta3)**<br> 


### OriginNamedMeta {#OriginNamedMeta3}

Field | Description
--- | ---
name | **string**<br> 


### OriginBalancerMeta {#OriginBalancerMeta3}

Field | Description
--- | ---
id | **string**<br> 


## Update {#Update}

Update origin from origin group.

**rpc Update ([UpdateOriginRequest](#UpdateOriginRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateOriginMetadata](#UpdateOriginMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Origin](#Origin3)<br>

### UpdateOriginRequest {#UpdateOriginRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. Origin's owner Folder ID. The maximum string length in characters is 50.
origin_id | **int64**<br>Origin ID. Value must be greater than 0.
source | **string**<br>PUT behavior, parameter below will be fully rewritten IP address or Domain name of your origin and the port (if custom). Required. 
enabled | **bool**<br>Required 
backup | **bool**<br>Required 
meta | **[OriginMeta](#OriginMeta4)**<br> 


### OriginMeta {#OriginMeta4}

Field | Description
--- | ---
origin_meta_variant | **oneof:** `common`, `bucket`, `website` or `balancer`<br>
&nbsp;&nbsp;common | **[OriginNamedMeta](#OriginNamedMeta4)**<br> 
&nbsp;&nbsp;bucket | **[OriginNamedMeta](#OriginNamedMeta4)**<br> 
&nbsp;&nbsp;website | **[OriginNamedMeta](#OriginNamedMeta4)**<br> 
&nbsp;&nbsp;balancer | **[OriginBalancerMeta](#OriginBalancerMeta4)**<br> 


### OriginNamedMeta {#OriginNamedMeta4}

Field | Description
--- | ---
name | **string**<br> 


### OriginBalancerMeta {#OriginBalancerMeta4}

Field | Description
--- | ---
id | **string**<br> 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateOriginMetadata](#UpdateOriginMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Origin](#Origin3)>**<br>if operation finished successfully. 


### UpdateOriginMetadata {#UpdateOriginMetadata}

Field | Description
--- | ---
origin_id | **int64**<br>Origin ID. Value must be greater than 0.
origin_group_id | **int64**<br>Parent origins group ID. Value must be greater than 0.


### Origin {#Origin3}

Field | Description
--- | ---
id | **int64**<br>Origin unique ID. 
origin_group_id | **int64**<br>Parent origin group ID. 
source | **string**<br>Source: IP address or Domain name of your origin and the port (if custom). 
enabled | **bool**<br>The setting allows to enable or disable an Origin source in the Origins group. <br>It has two possible values: <br>True - The origin is enabled and used as a source for the CDN. An origins group must contain at least one enabled origins. False - The origin is disabled and the CDN is not using it to pull content. 
backup | **bool**<br>backup option has two possible values: <br>True - The option is active. The origin will not be used until one of active origins become unavailable. False - The option is disabled. 
meta | **[OriginMeta](#OriginMeta5)**<br> 


### OriginMeta {#OriginMeta5}

Field | Description
--- | ---
origin_meta_variant | **oneof:** `common`, `bucket`, `website` or `balancer`<br>
&nbsp;&nbsp;common | **[OriginNamedMeta](#OriginNamedMeta5)**<br> 
&nbsp;&nbsp;bucket | **[OriginNamedMeta](#OriginNamedMeta5)**<br> 
&nbsp;&nbsp;website | **[OriginNamedMeta](#OriginNamedMeta5)**<br> 
&nbsp;&nbsp;balancer | **[OriginBalancerMeta](#OriginBalancerMeta5)**<br> 


### OriginNamedMeta {#OriginNamedMeta5}

Field | Description
--- | ---
name | **string**<br> 


### OriginBalancerMeta {#OriginBalancerMeta5}

Field | Description
--- | ---
id | **string**<br> 


## Delete {#Delete}

Delete origin from origin group

**rpc Delete ([DeleteOriginRequest](#DeleteOriginRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteOriginMetadata](#DeleteOriginMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteOriginRequest {#DeleteOriginRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. Origin's owner Folder ID. The maximum string length in characters is 50.
origin_id | **int64**<br>Origin ID. Value must be greater than 0.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteOriginMetadata](#DeleteOriginMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteOriginMetadata {#DeleteOriginMetadata}

Field | Description
--- | ---
origin_id | **int64**<br>Origin ID. Value must be greater than 0.


