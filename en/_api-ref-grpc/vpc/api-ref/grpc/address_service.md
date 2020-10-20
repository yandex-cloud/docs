---
editable: false
---

# AddressService



| Call | Description |
| --- | --- |
| [Get](#Get) |  |
| [GetByValue](#GetByValue) |  |
| [List](#List) |  |
| [Create](#Create) |  |
| [Update](#Update) |  |
| [Delete](#Delete) |  |
| [ListOperations](#ListOperations) |  |

## Calls AddressService {#calls}

## Get {#Get}



**rpc Get ([GetAddressRequest](#GetAddressRequest)) returns ([Address](#Address))**

### GetAddressRequest {#GetAddressRequest}

Field | Description
--- | ---
address_id | **string**<br> 


### Address {#Address}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
address | **oneof:** `external_ipv4_address`<br>
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address)**<br> 
reserved | **bool**<br> 
used | **bool**<br> 


### ExternalIpv4Address {#ExternalIpv4Address}

Field | Description
--- | ---
address | **string**<br> 
zone_id | **string**<br> 
requirements | **[AddressRequirements](#AddressRequirements)**<br> 


### AddressRequirements {#AddressRequirements}

Field | Description
--- | ---
ddos_protection_provider | **string**<br> 
outgoing_smtp_capability | **string**<br> 


## GetByValue {#GetByValue}



**rpc GetByValue ([GetAddressByValueRequest](#GetAddressByValueRequest)) returns ([Address](#Address1))**

### GetAddressByValueRequest {#GetAddressByValueRequest}

Field | Description
--- | ---
address | **oneof:** `external_ipv4_address`<br>
&nbsp;&nbsp;external_ipv4_address | **string**<br> 


### Address {#Address1}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
address | **oneof:** `external_ipv4_address`<br>
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address1)**<br> 
reserved | **bool**<br> 
used | **bool**<br> 


### ExternalIpv4Address {#ExternalIpv4Address1}

Field | Description
--- | ---
address | **string**<br> 
zone_id | **string**<br> 
requirements | **[AddressRequirements](#AddressRequirements1)**<br> 


### AddressRequirements {#AddressRequirements1}

Field | Description
--- | ---
ddos_protection_provider | **string**<br> 
outgoing_smtp_capability | **string**<br> 


## List {#List}



**rpc List ([ListAddressesRequest](#ListAddressesRequest)) returns ([ListAddressesResponse](#ListAddressesResponse))**

### ListAddressesRequest {#ListAddressesRequest}

Field | Description
--- | ---
folder_id | **string**<br> 
page_size | **int64**<br> 
page_token | **string**<br> 
filter | **string**<br> 


### ListAddressesResponse {#ListAddressesResponse}

Field | Description
--- | ---
addresses[] | **[Address](#Address2)**<br> 
next_page_token | **string**<br> 


### Address {#Address2}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
address | **oneof:** `external_ipv4_address`<br>
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address2)**<br> 
reserved | **bool**<br> 
used | **bool**<br> 


### ExternalIpv4Address {#ExternalIpv4Address2}

Field | Description
--- | ---
address | **string**<br> 
zone_id | **string**<br> 
requirements | **[AddressRequirements](#AddressRequirements2)**<br> 


### AddressRequirements {#AddressRequirements2}

Field | Description
--- | ---
ddos_protection_provider | **string**<br> 
outgoing_smtp_capability | **string**<br> 


## Create {#Create}



**rpc Create ([CreateAddressRequest](#CreateAddressRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateAddressMetadata](#CreateAddressMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Address](#Address3)<br>

### CreateAddressRequest {#CreateAddressRequest}

Field | Description
--- | ---
folder_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
address_spec | **oneof:** `external_ipv4_address_spec`<br>
&nbsp;&nbsp;external_ipv4_address_spec | **[ExternalIpv4AddressSpec](#ExternalIpv4AddressSpec)**<br> 


### ExternalIpv4AddressSpec {#ExternalIpv4AddressSpec}

Field | Description
--- | ---
address | **string**<br> 
zone_id | **string**<br> 
requirements | **[AddressRequirements](#AddressRequirements3)**<br> 


### AddressRequirements {#AddressRequirements3}

Field | Description
--- | ---
ddos_protection_provider | **string**<br> 
outgoing_smtp_capability | **string**<br> 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateAddressMetadata](#CreateAddressMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Address](#Address3)>**<br>if operation finished successfully. 


### CreateAddressMetadata {#CreateAddressMetadata}

Field | Description
--- | ---
address_id | **string**<br> 


### Address {#Address3}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
address | **oneof:** `external_ipv4_address`<br>
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address3)**<br> 
reserved | **bool**<br> 
used | **bool**<br> 


### ExternalIpv4Address {#ExternalIpv4Address3}

Field | Description
--- | ---
address | **string**<br> 
zone_id | **string**<br> 
requirements | **[AddressRequirements](#AddressRequirements4)**<br> 


### AddressRequirements {#AddressRequirements4}

Field | Description
--- | ---
ddos_protection_provider | **string**<br> 
outgoing_smtp_capability | **string**<br> 


## Update {#Update}



**rpc Update ([UpdateAddressRequest](#UpdateAddressRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateAddressMetadata](#UpdateAddressMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Address](#Address4)<br>

### UpdateAddressRequest {#UpdateAddressRequest}

Field | Description
--- | ---
address_id | **string**<br> 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
reserved | **bool**<br> 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateAddressMetadata](#UpdateAddressMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Address](#Address4)>**<br>if operation finished successfully. 


### UpdateAddressMetadata {#UpdateAddressMetadata}

Field | Description
--- | ---
address_id | **string**<br> 


### Address {#Address4}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
address | **oneof:** `external_ipv4_address`<br>
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address4)**<br> 
reserved | **bool**<br> 
used | **bool**<br> 


### ExternalIpv4Address {#ExternalIpv4Address4}

Field | Description
--- | ---
address | **string**<br> 
zone_id | **string**<br> 
requirements | **[AddressRequirements](#AddressRequirements5)**<br> 


### AddressRequirements {#AddressRequirements5}

Field | Description
--- | ---
ddos_protection_provider | **string**<br> 
outgoing_smtp_capability | **string**<br> 


## Delete {#Delete}



**rpc Delete ([DeleteAddressRequest](#DeleteAddressRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteAddressMetadata](#DeleteAddressMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteAddressRequest {#DeleteAddressRequest}

Field | Description
--- | ---
address_id | **string**<br> 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteAddressMetadata](#DeleteAddressMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteAddressMetadata {#DeleteAddressMetadata}

Field | Description
--- | ---
address_id | **string**<br> 


## ListOperations {#ListOperations}



**rpc ListOperations ([ListAddressOperationsRequest](#ListAddressOperationsRequest)) returns ([ListAddressOperationsResponse](#ListAddressOperationsResponse))**

### ListAddressOperationsRequest {#ListAddressOperationsRequest}

Field | Description
--- | ---
address_id | **string**<br> 
page_size | **int64**<br> 
page_token | **string**<br> 


### ListAddressOperationsResponse {#ListAddressOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br> 
next_page_token | **string**<br> 


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty). If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any. 


