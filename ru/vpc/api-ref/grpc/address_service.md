---
editable: false
sourcePath: en/_api-ref-grpc/vpc/api-ref/grpc/address_service.md
---

# Virtual Private Cloud API, gRPC: AddressService

A set of methods for managing Address resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified Address resource. |
| [GetByValue](#GetByValue) | Returns the specified Address resource by a given value. |
| [List](#List) | Retrieves the list of Address resources in the specified folder. |
| [Create](#Create) | Creates an address in the specified folder and network. |
| [Update](#Update) | Updates the specified address. |
| [Delete](#Delete) | Deletes the specified address. |
| [ListOperations](#ListOperations) | List operations for the specified address. |
| [Move](#Move) | Move an address to another folder |

## Calls AddressService {#calls}

## Get {#Get}

Returns the specified Address resource. <br>To get the list of all available Address resources, make a [List](#List) request.

**rpc Get ([GetAddressRequest](#GetAddressRequest)) returns ([Address](#Address))**

### GetAddressRequest {#GetAddressRequest}

Field | Description
--- | ---
address_id | **string**<br>Required. ID of the Address resource to return. <br>To get Address resource ID make a [AddressService.List](#List) request. The maximum string length in characters is 50.


### Address {#Address}

Field | Description
--- | ---
id | **string**<br>ID of the address. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the address belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the address. The name is unique within the folder. 
description | **string**<br>Description of the address. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
address | **oneof:** `external_ipv4_address`<br>External ipv4 address specification.
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address)**<br>External ipv4 address specification. 
reserved | **bool**<br>Specifies if address is reserved or not. 
used | **bool**<br>Specifies if address is used or not. 
type | enum **Type**<br>Type of the IP address. <ul><li>`INTERNAL`: Internal IP address.</li><li>`EXTERNAL`: Public IP address.</li></ul>
ip_version | enum **IpVersion**<br>Version of the IP address. <ul><li>`IPV4`: IPv4 address.</li><li>`IPV6`: IPv6 address.</li></ul>
deletion_protection | **bool**<br>Specifies if address protected from deletion. 
dns_records[] | **[DnsRecord](#DnsRecord)**<br>Optional DNS record specifications 


### ExternalIpv4Address {#ExternalIpv4Address}

Field | Description
--- | ---
address | **string**<br>Value of address. 
zone_id | **string**<br>Availability zone from which the address will be allocated. 
requirements | **[AddressRequirements](#AddressRequirements)**<br>Parameters of the allocated address, for example DDoS Protection. 


### AddressRequirements {#AddressRequirements}

Field | Description
--- | ---
ddos_protection_provider | **string**<br>DDoS protection provider ID. 
outgoing_smtp_capability | **string**<br>Capability to send SMTP traffic. 


### DnsRecord {#DnsRecord}

Field | Description
--- | ---
fqdn | **string**<br>DNS record name (absolute or relative to the DNS zone in use). 
dns_zone_id | **string**<br>ID of the public DNS zone. 
ttl | **int64**<br>TTL of record. 
ptr | **bool**<br>If the PTR record is required, this parameter must be set to "true". 


## GetByValue {#GetByValue}

Returns the specified Address resource by a given value. <br>To get the list of all available Address resources, make a [List](#List) request.

**rpc GetByValue ([GetAddressByValueRequest](#GetAddressByValueRequest)) returns ([Address](#Address1))**

### GetAddressByValueRequest {#GetAddressByValueRequest}

Field | Description
--- | ---
address | **oneof:** `external_ipv4_address`<br>External ipv4 address specification.
&nbsp;&nbsp;external_ipv4_address | **string**<br>External ipv4 address specification. 


### Address {#Address1}

Field | Description
--- | ---
id | **string**<br>ID of the address. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the address belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the address. The name is unique within the folder. 
description | **string**<br>Description of the address. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
address | **oneof:** `external_ipv4_address`<br>External ipv4 address specification.
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address1)**<br>External ipv4 address specification. 
reserved | **bool**<br>Specifies if address is reserved or not. 
used | **bool**<br>Specifies if address is used or not. 
type | enum **Type**<br>Type of the IP address. <ul><li>`INTERNAL`: Internal IP address.</li><li>`EXTERNAL`: Public IP address.</li></ul>
ip_version | enum **IpVersion**<br>Version of the IP address. <ul><li>`IPV4`: IPv4 address.</li><li>`IPV6`: IPv6 address.</li></ul>
deletion_protection | **bool**<br>Specifies if address protected from deletion. 
dns_records[] | **[DnsRecord](#DnsRecord1)**<br>Optional DNS record specifications 


### ExternalIpv4Address {#ExternalIpv4Address1}

Field | Description
--- | ---
address | **string**<br>Value of address. 
zone_id | **string**<br>Availability zone from which the address will be allocated. 
requirements | **[AddressRequirements](#AddressRequirements1)**<br>Parameters of the allocated address, for example DDoS Protection. 


### AddressRequirements {#AddressRequirements1}

Field | Description
--- | ---
ddos_protection_provider | **string**<br>DDoS protection provider ID. 
outgoing_smtp_capability | **string**<br>Capability to send SMTP traffic. 


### DnsRecord {#DnsRecord1}

Field | Description
--- | ---
fqdn | **string**<br>DNS record name (absolute or relative to the DNS zone in use). 
dns_zone_id | **string**<br>ID of the public DNS zone. 
ttl | **int64**<br>TTL of record. 
ptr | **bool**<br>If the PTR record is required, this parameter must be set to "true". 


## List {#List}

Retrieves the list of Address resources in the specified folder.

**rpc List ([ListAddressesRequest](#ListAddressesRequest)) returns ([ListAddressesResponse](#ListAddressesResponse))**

### ListAddressesRequest {#ListAddressesRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list addresses in. <br>To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListAddressesResponse.next_page_token](#ListAddressesResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListAddressesResponse.next_page_token](#ListAddressesResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters Address listed in the response. <br>The expression must specify: <ol><li>The field name. Currently you can use filtering only on [Address.name](#Address2) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Example of a filter: `name=my-address`. 


### ListAddressesResponse {#ListAddressesResponse}

Field | Description
--- | ---
addresses[] | **[Address](#Address2)**<br>List of addresses. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListAddressesRequest.page_size](#ListAddressesRequest), use `next_page_token` as the value for the [ListAddressesRequest.page_token](#ListAddressesRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### Address {#Address2}

Field | Description
--- | ---
id | **string**<br>ID of the address. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the address belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the address. The name is unique within the folder. 
description | **string**<br>Description of the address. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
address | **oneof:** `external_ipv4_address`<br>External ipv4 address specification.
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address2)**<br>External ipv4 address specification. 
reserved | **bool**<br>Specifies if address is reserved or not. 
used | **bool**<br>Specifies if address is used or not. 
type | enum **Type**<br>Type of the IP address. <ul><li>`INTERNAL`: Internal IP address.</li><li>`EXTERNAL`: Public IP address.</li></ul>
ip_version | enum **IpVersion**<br>Version of the IP address. <ul><li>`IPV4`: IPv4 address.</li><li>`IPV6`: IPv6 address.</li></ul>
deletion_protection | **bool**<br>Specifies if address protected from deletion. 
dns_records[] | **[DnsRecord](#DnsRecord2)**<br>Optional DNS record specifications 


### ExternalIpv4Address {#ExternalIpv4Address2}

Field | Description
--- | ---
address | **string**<br>Value of address. 
zone_id | **string**<br>Availability zone from which the address will be allocated. 
requirements | **[AddressRequirements](#AddressRequirements2)**<br>Parameters of the allocated address, for example DDoS Protection. 


### AddressRequirements {#AddressRequirements2}

Field | Description
--- | ---
ddos_protection_provider | **string**<br>DDoS protection provider ID. 
outgoing_smtp_capability | **string**<br>Capability to send SMTP traffic. 


### DnsRecord {#DnsRecord2}

Field | Description
--- | ---
fqdn | **string**<br>DNS record name (absolute or relative to the DNS zone in use). 
dns_zone_id | **string**<br>ID of the public DNS zone. 
ttl | **int64**<br>TTL of record. 
ptr | **bool**<br>If the PTR record is required, this parameter must be set to "true". 


## Create {#Create}

Creates an address in the specified folder and network.

**rpc Create ([CreateAddressRequest](#CreateAddressRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateAddressMetadata](#CreateAddressMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Address](#Address3)<br>

### CreateAddressRequest {#CreateAddressRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a address in. <br>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
name | **string**<br>Name of the address. The name must be unique within the folder. Value must match the regular expression ` \|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])? `.
description | **string**<br>Description of the address. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Address labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
address_spec | **oneof:** `external_ipv4_address_spec`<br>External ipv4 address specification.
&nbsp;&nbsp;external_ipv4_address_spec | **[ExternalIpv4AddressSpec](#ExternalIpv4AddressSpec)**<br>External ipv4 address specification. 
deletion_protection | **bool**<br>Specifies if address protected from deletion. 
dns_record_specs[] | **[DnsRecordSpec](#DnsRecordSpec)**<br>Optional DNS record specifications 


### ExternalIpv4AddressSpec {#ExternalIpv4AddressSpec}

Field | Description
--- | ---
address | **string**<br>Value of address. 
zone_id | **string**<br>Availability zone from which the address will be allocated. 
requirements | **[AddressRequirements](#AddressRequirements3)**<br>Parameters of the allocated address, for example DDoS Protection. 


### AddressRequirements {#AddressRequirements3}

Field | Description
--- | ---
ddos_protection_provider | **string**<br>DDoS protection provider ID. 
outgoing_smtp_capability | **string**<br>Capability to send SMTP traffic. 


### DnsRecordSpec {#DnsRecordSpec}

Field | Description
--- | ---
fqdn | **string**<br>Required. Required. DNS record name (absolute or relative to the DNS zone in use). 
dns_zone_id | **string**<br>Required. Required. ID of the public DNS zone. The maximum string length in characters is 20. The string length in characters must be equal to 20.
ttl | **int64**<br>TTL of record. Acceptable values are 0 to 86400, inclusive. Acceptable values are 0 to 86400, inclusive.
ptr | **bool**<br>Optional. If the PTR record is required, this parameter must be set to "true". 


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
address_id | **string**<br>ID of the address that is being created. 


### Address {#Address3}

Field | Description
--- | ---
id | **string**<br>ID of the address. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the address belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the address. The name is unique within the folder. 
description | **string**<br>Description of the address. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
address | **oneof:** `external_ipv4_address`<br>External ipv4 address specification.
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address3)**<br>External ipv4 address specification. 
reserved | **bool**<br>Specifies if address is reserved or not. 
used | **bool**<br>Specifies if address is used or not. 
type | enum **Type**<br>Type of the IP address. <ul><li>`INTERNAL`: Internal IP address.</li><li>`EXTERNAL`: Public IP address.</li></ul>
ip_version | enum **IpVersion**<br>Version of the IP address. <ul><li>`IPV4`: IPv4 address.</li><li>`IPV6`: IPv6 address.</li></ul>
deletion_protection | **bool**<br>Specifies if address protected from deletion. 
dns_records[] | **[DnsRecord](#DnsRecord3)**<br>Optional DNS record specifications 


### ExternalIpv4Address {#ExternalIpv4Address3}

Field | Description
--- | ---
address | **string**<br>Value of address. 
zone_id | **string**<br>Availability zone from which the address will be allocated. 
requirements | **[AddressRequirements](#AddressRequirements4)**<br>Parameters of the allocated address, for example DDoS Protection. 


### DnsRecord {#DnsRecord3}

Field | Description
--- | ---
fqdn | **string**<br>DNS record name (absolute or relative to the DNS zone in use). 
dns_zone_id | **string**<br>ID of the public DNS zone. 
ttl | **int64**<br>TTL of record. 
ptr | **bool**<br>If the PTR record is required, this parameter must be set to "true". 


## Update {#Update}

Updates the specified address.

**rpc Update ([UpdateAddressRequest](#UpdateAddressRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateAddressMetadata](#UpdateAddressMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Address](#Address4)<br>

### UpdateAddressRequest {#UpdateAddressRequest}

Field | Description
--- | ---
address_id | **string**<br>Required. ID of the address to update. <br>To get the address ID make a [AddressService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the Address should be updated. 
name | **string**<br>New name for the address. The name must be unique within the folder. Value must match the regular expression ` \|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])? `.
description | **string**<br>New description of the address. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Address labels as `key:value` pairs. <br>Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label: <ol><li>Get the current set of labels with a [AddressService.Get](#Get) request. </li><li>Add or remove a label in this set. </li><li>Send the new set in this field.</li></ol> No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
reserved | **bool**<br>Specifies if address is reserved or not. 
deletion_protection | **bool**<br>Specifies if address protected from deletion. 
dns_record_specs[] | **[DnsRecordSpec](#DnsRecordSpec)**<br>Optional DNS record specifications 


### DnsRecordSpec {#DnsRecordSpec1}

Field | Description
--- | ---
fqdn | **string**<br>Required. Required. DNS record name (absolute or relative to the DNS zone in use). 
dns_zone_id | **string**<br>Required. Required. ID of the public DNS zone. The maximum string length in characters is 20. The string length in characters must be equal to 20.
ttl | **int64**<br>TTL of record. Acceptable values are 0 to 86400, inclusive. Acceptable values are 0 to 86400, inclusive.
ptr | **bool**<br>Optional. If the PTR record is required, this parameter must be set to "true". 


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
address_id | **string**<br>ID of the Address that is being updated. 


### Address {#Address4}

Field | Description
--- | ---
id | **string**<br>ID of the address. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the address belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the address. The name is unique within the folder. 
description | **string**<br>Description of the address. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
address | **oneof:** `external_ipv4_address`<br>External ipv4 address specification.
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address4)**<br>External ipv4 address specification. 
reserved | **bool**<br>Specifies if address is reserved or not. 
used | **bool**<br>Specifies if address is used or not. 
type | enum **Type**<br>Type of the IP address. <ul><li>`INTERNAL`: Internal IP address.</li><li>`EXTERNAL`: Public IP address.</li></ul>
ip_version | enum **IpVersion**<br>Version of the IP address. <ul><li>`IPV4`: IPv4 address.</li><li>`IPV6`: IPv6 address.</li></ul>
deletion_protection | **bool**<br>Specifies if address protected from deletion. 
dns_records[] | **[DnsRecord](#DnsRecord4)**<br>Optional DNS record specifications 


### ExternalIpv4Address {#ExternalIpv4Address4}

Field | Description
--- | ---
address | **string**<br>Value of address. 
zone_id | **string**<br>Availability zone from which the address will be allocated. 
requirements | **[AddressRequirements](#AddressRequirements4)**<br>Parameters of the allocated address, for example DDoS Protection. 


### AddressRequirements {#AddressRequirements4}

Field | Description
--- | ---
ddos_protection_provider | **string**<br>DDoS protection provider ID. 
outgoing_smtp_capability | **string**<br>Capability to send SMTP traffic. 


### DnsRecord {#DnsRecord4}

Field | Description
--- | ---
fqdn | **string**<br>DNS record name (absolute or relative to the DNS zone in use). 
dns_zone_id | **string**<br>ID of the public DNS zone. 
ttl | **int64**<br>TTL of record. 
ptr | **bool**<br>If the PTR record is required, this parameter must be set to "true". 


## Delete {#Delete}

Deletes the specified address.

**rpc Delete ([DeleteAddressRequest](#DeleteAddressRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteAddressMetadata](#DeleteAddressMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteAddressRequest {#DeleteAddressRequest}

Field | Description
--- | ---
address_id | **string**<br>Required. ID of the address to delete. <br>To get a address ID make a [AddressService.List](#List) request. The maximum string length in characters is 50.


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
address_id | **string**<br>ID of the address that is being deleted. 


## ListOperations {#ListOperations}

List operations for the specified address.

**rpc ListOperations ([ListAddressOperationsRequest](#ListAddressOperationsRequest)) returns ([ListAddressOperationsResponse](#ListAddressOperationsResponse))**

### ListAddressOperationsRequest {#ListAddressOperationsRequest}

Field | Description
--- | ---
address_id | **string**<br>Required. ID of the address to list operations for. <br>To get a address ID make a [AddressService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListAddressOperationsResponse.next_page_token](#ListAddressOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListAddressOperationsResponse.next_page_token](#ListAddressOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListAddressOperationsResponse {#ListAddressOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>List of operations for the specified address. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListAddressOperationsRequest.page_size](#ListAddressOperationsRequest), use `next_page_token` as the value for the [ListAddressOperationsRequest.page_token](#ListAddressOperationsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


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


## Move {#Move}

Move an address to another folder

**rpc Move ([MoveAddressRequest](#MoveAddressRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[MoveAddressMetadata](#MoveAddressMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Address](#Address5)<br>

### MoveAddressRequest {#MoveAddressRequest}

Field | Description
--- | ---
address_id | **string**<br>Required. ID of the address that is being moved. The maximum string length in characters is 50.
destination_folder_id | **string**<br>Required. ID of the folder to move address to. The maximum string length in characters is 50.


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[MoveAddressMetadata](#MoveAddressMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Address](#Address5)>**<br>if operation finished successfully. 


### MoveAddressMetadata {#MoveAddressMetadata}

Field | Description
--- | ---
address_id | **string**<br>ID of the address that is being moved. 


### Address {#Address5}

Field | Description
--- | ---
id | **string**<br>ID of the address. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the address belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the address. The name is unique within the folder. 
description | **string**<br>Description of the address. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
address | **oneof:** `external_ipv4_address`<br>External ipv4 address specification.
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address5)**<br>External ipv4 address specification. 
reserved | **bool**<br>Specifies if address is reserved or not. 
used | **bool**<br>Specifies if address is used or not. 
type | enum **Type**<br>Type of the IP address. <ul><li>`INTERNAL`: Internal IP address.</li><li>`EXTERNAL`: Public IP address.</li></ul>
ip_version | enum **IpVersion**<br>Version of the IP address. <ul><li>`IPV4`: IPv4 address.</li><li>`IPV6`: IPv6 address.</li></ul>
deletion_protection | **bool**<br>Specifies if address protected from deletion. 
dns_records[] | **[DnsRecord](#DnsRecord5)**<br>Optional DNS record specifications 


### ExternalIpv4Address {#ExternalIpv4Address5}

Field | Description
--- | ---
address | **string**<br>Value of address. 
zone_id | **string**<br>Availability zone from which the address will be allocated. 
requirements | **[AddressRequirements](#AddressRequirements5)**<br>Parameters of the allocated address, for example DDoS Protection. 


### AddressRequirements {#AddressRequirements5}

Field | Description
--- | ---
ddos_protection_provider | **string**<br>DDoS protection provider ID. 
outgoing_smtp_capability | **string**<br>Capability to send SMTP traffic. 


### DnsRecord {#DnsRecord5}

Field | Description
--- | ---
fqdn | **string**<br>DNS record name (absolute or relative to the DNS zone in use). 
dns_zone_id | **string**<br>ID of the public DNS zone. 
ttl | **int64**<br>TTL of record. 
ptr | **bool**<br>If the PTR record is required, this parameter must be set to "true". 


