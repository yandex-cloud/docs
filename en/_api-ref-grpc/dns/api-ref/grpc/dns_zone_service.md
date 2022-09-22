---
editable: false
---

# DnsZoneService

A set of methods for managing DNS zones.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified DNS zone. |
| [List](#List) | Retrieves the list of DNS zones in the specified folder. |
| [Create](#Create) | Creates a DNS zone in the specified folder. |
| [Update](#Update) | Updates the specified DNS zone. |
| [Delete](#Delete) | Deletes the specified DNS zone. |
| [GetRecordSet](#GetRecordSet) | Returns the specified record set. |
| [ListRecordSets](#ListRecordSets) | Retrieves the list of record sets in the specified folder. |
| [UpdateRecordSets](#UpdateRecordSets) | Method with strict control for changing zone state. |
| [UpsertRecordSets](#UpsertRecordSets) | Method without strict control for changing zone state. |
| [ListOperations](#ListOperations) | Lists operations for the specified DNS zone. |
| [ListAccessBindings](#ListAccessBindings) | Lists existing access bindings for the specified DNS zone. |
| [SetAccessBindings](#SetAccessBindings) | Sets access bindings for the specified DNS zone. |
| [UpdateAccessBindings](#UpdateAccessBindings) | Updates access bindings for the specified DNS zone. |

## Calls DnsZoneService {#calls}

## Get {#Get}

Returns the specified DNS zone. <br>To get the list of all available DNS zones, make a [List](#List) request.

**rpc Get ([GetDnsZoneRequest](#GetDnsZoneRequest)) returns ([DnsZone](#DnsZone))**

### GetDnsZoneRequest {#GetDnsZoneRequest}

Field | Description
--- | ---
dns_zone_id | **string**<br>Required. ID of the DNS zone to return. <br>To get a DNS zone ID, make a [DnsZoneService.List](#List) request. 


### DnsZone {#DnsZone}

Field | Description
--- | ---
id | **string**<br>ID of the DNS zone. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the DNS zone belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the DNS zone. The name is unique within the folder. 
description | **string**<br>Description of the DNS zone. 
labels | **map<string,string>**<br>DNS zone labels as `key:value` pairs. 
zone | **string**<br>DNS zone suffix. 
private_visibility | **[PrivateVisibility](#PrivateVisibility)**<br>Privately visible zone settings. Specifies whether records within the zone are visible from a VPC networks only. 
public_visibility | **[PublicVisibility](#PublicVisibility)**<br>Publicly visible zone settings. Indicates whether records within the zone are publicly visible. 


### PrivateVisibility {#PrivateVisibility}

Field | Description
--- | ---
network_ids[] | **string**<br>Network IDs. The number of elements must be in the range 0-10. The string length in characters for each value must be equal to 20.


### PublicVisibility {#PublicVisibility}



## List {#List}

Retrieves the list of DNS zones in the specified folder.

**rpc List ([ListDnsZonesRequest](#ListDnsZonesRequest)) returns ([ListDnsZonesResponse](#ListDnsZonesResponse))**

### ListDnsZonesRequest {#ListDnsZonesRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list DNS zones in. <br>To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListDnsZonesResponse.next_page_token](#ListDnsZonesResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListDnsZonesResponse.next_page_token](#ListDnsZonesResponse) returned by a previous list request. The maximum string length in characters is 1000.
filter | **string**<br>A filter expression that filters DNS zones listed in the response. <br>The expression must specify: <ol><li>The field name. Currently you can use filtering only on the [DnsZone.name](#DnsZone1) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Example of a filter: `name=my-dns-zone`. The maximum string length in characters is 1000.


### ListDnsZonesResponse {#ListDnsZonesResponse}

Field | Description
--- | ---
dns_zones[] | **[DnsZone](#DnsZone1)**<br>List of DNS zones in the specified folder. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListDnsZonesRequest.page_size](#ListDnsZonesRequest), use `next_page_token` as the value for the [ListDnsZonesRequest.page_token](#ListDnsZonesRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### DnsZone {#DnsZone1}

Field | Description
--- | ---
id | **string**<br>ID of the DNS zone. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the DNS zone belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the DNS zone. The name is unique within the folder. 
description | **string**<br>Description of the DNS zone. 
labels | **map<string,string>**<br>DNS zone labels as `key:value` pairs. 
zone | **string**<br>DNS zone suffix. 
private_visibility | **[PrivateVisibility](#PrivateVisibility1)**<br>Privately visible zone settings. Specifies whether records within the zone are visible from a VPC networks only. 
public_visibility | **[PublicVisibility](#PublicVisibility1)**<br>Publicly visible zone settings. Indicates whether records within the zone are publicly visible. 


### PrivateVisibility {#PrivateVisibility1}

Field | Description
--- | ---
network_ids[] | **string**<br>Network IDs. The number of elements must be in the range 0-10. The string length in characters for each value must be equal to 20.


### PublicVisibility {#PublicVisibility1}



## Create {#Create}

Creates a DNS zone in the specified folder.

**rpc Create ([CreateDnsZoneRequest](#CreateDnsZoneRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateDnsZoneMetadata](#CreateDnsZoneMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[DnsZone](#DnsZone2)<br>

### CreateDnsZoneRequest {#CreateDnsZoneRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create DNS zones in. <br>To get a folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
name | **string**<br>Name of the DNS zone. The name must be unique within the folder. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the DNS zone. The maximum string length in characters is 256.
labels | **map<string,string>**<br>DNS zone labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
zone | **string**<br>Required. DNS zone suffix. The maximum string length in characters is 255. Value must match the regular expression ` [.]\|[a-z0-9][-a-z0-9.]*\\. `.
private_visibility | **[PrivateVisibility](#PrivateVisibility2)**<br>Privately visible zone settings. At least one of two visibility fields must be set. 
public_visibility | **[PublicVisibility](#PublicVisibility2)**<br>Publicly visible zone settings. At least one of two visibility fields must be set. 


### PrivateVisibility {#PrivateVisibility2}

Field | Description
--- | ---
network_ids[] | **string**<br>Network IDs. The number of elements must be in the range 0-10. The string length in characters for each value must be equal to 20.


### PublicVisibility {#PublicVisibility2}



### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateDnsZoneMetadata](#CreateDnsZoneMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DnsZone](#DnsZone2)>**<br>if operation finished successfully. 


### CreateDnsZoneMetadata {#CreateDnsZoneMetadata}

Field | Description
--- | ---
dns_zone_id | **string**<br>ID of the DNS zone that is being created. 


### DnsZone {#DnsZone2}

Field | Description
--- | ---
id | **string**<br>ID of the DNS zone. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the DNS zone belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the DNS zone. The name is unique within the folder. 
description | **string**<br>Description of the DNS zone. 
labels | **map<string,string>**<br>DNS zone labels as `key:value` pairs. 
zone | **string**<br>DNS zone suffix. 
private_visibility | **[PrivateVisibility](#PrivateVisibility3)**<br>Privately visible zone settings. Specifies whether records within the zone are visible from a VPC networks only. 
public_visibility | **[PublicVisibility](#PublicVisibility3)**<br>Publicly visible zone settings. Indicates whether records within the zone are publicly visible. 


## Update {#Update}

Updates the specified DNS zone.

**rpc Update ([UpdateDnsZoneRequest](#UpdateDnsZoneRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateDnsZoneMetadata](#UpdateDnsZoneMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[DnsZone](#DnsZone3)<br>

### UpdateDnsZoneRequest {#UpdateDnsZoneRequest}

Field | Description
--- | ---
dns_zone_id | **string**<br>ID of the DNS zone to update. <br>To get the DNS zone ID, make a [DnsZoneService.List](#List) request. The string length in characters must be equal to 20.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask specifying which fields of the DNS zone resource are going to be updated. 
name | **string**<br>New name for the DNS zone. The name must be unique within the folder. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>New description of the DNS zone. The maximum string length in characters is 256.
labels | **map<string,string>**<br>DNS zone labels as `key:value` pairs. <br>Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label: <ol><li>Get the current set of labels with a [DnsZoneService.Get](#Get) request. </li><li>Add or remove a label in this set. </li><li>Send the new set in this field.</li></ol> No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
private_visibility | **[PrivateVisibility](#PrivateVisibility3)**<br>Change network IDs for private visibility. 
public_visibility | **[PublicVisibility](#PublicVisibility3)**<br>Public visibility configuration. 


### PrivateVisibility {#PrivateVisibility3}

Field | Description
--- | ---
network_ids[] | **string**<br>Network IDs. The number of elements must be in the range 0-10. The string length in characters for each value must be equal to 20.


### PublicVisibility {#PublicVisibility3}



### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateDnsZoneMetadata](#UpdateDnsZoneMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DnsZone](#DnsZone3)>**<br>if operation finished successfully. 


### UpdateDnsZoneMetadata {#UpdateDnsZoneMetadata}

Field | Description
--- | ---
dns_zone_id | **string**<br>ID of the DNS zone that is being updated. 


### DnsZone {#DnsZone3}

Field | Description
--- | ---
id | **string**<br>ID of the DNS zone. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the DNS zone belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the DNS zone. The name is unique within the folder. 
description | **string**<br>Description of the DNS zone. 
labels | **map<string,string>**<br>DNS zone labels as `key:value` pairs. 
zone | **string**<br>DNS zone suffix. 
private_visibility | **[PrivateVisibility](#PrivateVisibility4)**<br>Privately visible zone settings. Specifies whether records within the zone are visible from a VPC networks only. 
public_visibility | **[PublicVisibility](#PublicVisibility4)**<br>Publicly visible zone settings. Indicates whether records within the zone are publicly visible. 


## Delete {#Delete}

Deletes the specified DNS zone.

**rpc Delete ([DeleteDnsZoneRequest](#DeleteDnsZoneRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteDnsZoneMetadata](#DeleteDnsZoneMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteDnsZoneRequest {#DeleteDnsZoneRequest}

Field | Description
--- | ---
dns_zone_id | **string**<br>ID of the DNS zone to delete. <br>To get a DNS zone ID, make a [DnsZoneService.List](#List) request. The string length in characters must be equal to 20.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteDnsZoneMetadata](#DeleteDnsZoneMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteDnsZoneMetadata {#DeleteDnsZoneMetadata}

Field | Description
--- | ---
dns_zone_id | **string**<br>ID of the DNS zone that is being deleted. 


## GetRecordSet {#GetRecordSet}

Returns the specified record set.

**rpc GetRecordSet ([GetDnsZoneRecordSetRequest](#GetDnsZoneRecordSetRequest)) returns ([RecordSet](#RecordSet))**

### GetDnsZoneRecordSetRequest {#GetDnsZoneRecordSetRequest}

Field | Description
--- | ---
dns_zone_id | **string**<br>ID of the DNS zone to get record set from. <br>To get a DNS zone ID, make a [DnsZoneService.List](#List) request. The string length in characters must be equal to 20.
name | **string**<br>Required. Name of the record set. The maximum string length in characters is 255.
type | **string**<br>Required. Type of the record set. The maximum string length in characters is 10.


### RecordSet {#RecordSet}

Field | Description
--- | ---
name | **string**<br>Domain name. The string length in characters must be 1-254.
type | **string**<br>Record type. The string length in characters must be 1-20.
ttl | **int64**<br>Time to live in seconds. Acceptable values are 0 to 2147483647, inclusive.
data[] | **string**<br>Data of the record set. The number of elements must be in the range 1-100. The string length in characters for each value must be 1-255.


## ListRecordSets {#ListRecordSets}

Retrieves the list of record sets in the specified folder.

**rpc ListRecordSets ([ListDnsZoneRecordSetsRequest](#ListDnsZoneRecordSetsRequest)) returns ([ListDnsZoneRecordSetsResponse](#ListDnsZoneRecordSetsResponse))**

### ListDnsZoneRecordSetsRequest {#ListDnsZoneRecordSetsRequest}

Field | Description
--- | ---
dns_zone_id | **string**<br>ID of the DNS zone to list record sets in. <br>To get a DNS zone ID, make a [DnsZoneService.List](#List) request. The string length in characters must be equal to 20.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListDnsZoneRecordSetsResponse.next_page_token](#ListDnsZoneRecordSetsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListDnsZoneRecordSetsResponse.next_page_token](#ListDnsZoneRecordSetsResponse) returned by a previous list request. The maximum string length in characters is 1000.
filter | **string**<br>A filter expression that filters record sets listed in the response. The expression consists of one or more conditions united by `AND` operator: `<condition1> [AND <condition2> [<...> AND <conditionN>]]`. <br>Each condition has the form `<field> <operator> <value>`, where: <ol><li>`<field>` is the field name. Currently you can use filtering only on the [RecordSet.name](#RecordSet1) and [RecordSet.type](#RecordSet1) fields. </li><li>`<operator>` is a logical operator, one of `=`, `!=`, `IN`, `NOT IN`. </li><li>`<value>` represents a value. </li></ol>3.1. In case of single value condition (`=` or `!=`), the value is a string in double (`"`) or single (`'`) quotes. C-style escape sequences are supported (`\"` turns to `"`, `\'` to `'`, `\\` to backslash). 3.2. In case of a list of values condition (`IN` or `NOT IN`), the value is `(<string1>, <string2>, .., <stringN>)`, where `<string>` is a string in double (`"`) or single (`'`) quotes. <br>Examples of a filter: `name="my-record-set"`, `type IN ("MX","A") AND name="works.on.my.machine."`. The maximum string length in characters is 1000.


### ListDnsZoneRecordSetsResponse {#ListDnsZoneRecordSetsResponse}

Field | Description
--- | ---
record_sets[] | **[RecordSet](#RecordSet1)**<br>List of record sets in the specified DNS zone. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListDnsZoneRecordSetsRequest.page_size](#ListDnsZoneRecordSetsRequest), use `next_page_token` as the value for the [ListDnsZoneRecordSetsRequest.page_token](#ListDnsZoneRecordSetsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### RecordSet {#RecordSet1}

Field | Description
--- | ---
name | **string**<br>Domain name. The string length in characters must be 1-254.
type | **string**<br>Record type. The string length in characters must be 1-20.
ttl | **int64**<br>Time to live in seconds. Acceptable values are 0 to 2147483647, inclusive.
data[] | **string**<br>Data of the record set. The number of elements must be in the range 1-100. The string length in characters for each value must be 1-255.


## UpdateRecordSets {#UpdateRecordSets}

Method with strict control for changing zone state. Returns error when: <ol><li>Deleted record is not found. </li><li>Found record with matched type and name but different TTL or value. </li><li>Attempted to add record with existing name and type. </li></ol>Deletions happen first. If a record with the same name and type exists in both lists, then the existing record will be deleted, and a new one added.

**rpc UpdateRecordSets ([UpdateRecordSetsRequest](#UpdateRecordSetsRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateRecordSetsMetadata](#UpdateRecordSetsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[RecordSetDiff](#RecordSetDiff)<br>

### UpdateRecordSetsRequest {#UpdateRecordSetsRequest}

Field | Description
--- | ---
dns_zone_id | **string**<br>ID of the DNS zone to update record sets in. <br>To get a DNS zone ID, make a [DnsZoneService.List](#List) request. The string length in characters must be equal to 20.
deletions[] | **[RecordSet](#RecordSet2)**<br>List of record sets to delete. The maximum number of elements is 1000.
additions[] | **[RecordSet](#RecordSet2)**<br>List of record sets to add. The maximum number of elements is 1000.


### RecordSet {#RecordSet2}

Field | Description
--- | ---
name | **string**<br>Domain name. The string length in characters must be 1-254.
type | **string**<br>Record type. The string length in characters must be 1-20.
ttl | **int64**<br>Time to live in seconds. Acceptable values are 0 to 2147483647, inclusive.
data[] | **string**<br>Data of the record set. The number of elements must be in the range 1-100. The string length in characters for each value must be 1-255.


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateRecordSetsMetadata](#UpdateRecordSetsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RecordSetDiff](#RecordSetDiff)>**<br>if operation finished successfully. 


### UpdateRecordSetsMetadata {#UpdateRecordSetsMetadata}



### RecordSetDiff {#RecordSetDiff}

Field | Description
--- | ---
additions[] | **[RecordSet](#RecordSet3)**<br>List of record sets that were added 
deletions[] | **[RecordSet](#RecordSet3)**<br>List of record sets that were deleted 


## UpsertRecordSets {#UpsertRecordSets}

Method without strict control for changing zone state. Nothing happens if deleted record doesn't exist. Deletes records that match all specified fields which allows to delete only specified records from a record set.

**rpc UpsertRecordSets ([UpsertRecordSetsRequest](#UpsertRecordSetsRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpsertRecordSetsMetadata](#UpsertRecordSetsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[RecordSetDiff](#RecordSetDiff)<br>

### UpsertRecordSetsRequest {#UpsertRecordSetsRequest}

Field | Description
--- | ---
dns_zone_id | **string**<br>ID of the DNS zone to upsert record sets to. <br>To get a DNS zone ID, make a [DnsZoneService.List](#List) request. The string length in characters must be equal to 20.
deletions[] | **[RecordSet](#RecordSet3)**<br>Delete only specified records from corresponding record sets. The maximum number of elements is 1000.
replacements[] | **[RecordSet](#RecordSet3)**<br>Entirely replace specified record sets. The maximum number of elements is 1000.
merges[] | **[RecordSet](#RecordSet3)**<br>Replace specified records or add new ones if no such record sets exists. The maximum number of elements is 1000.


### RecordSet {#RecordSet3}

Field | Description
--- | ---
name | **string**<br>Domain name. The string length in characters must be 1-254.
type | **string**<br>Record type. The string length in characters must be 1-20.
ttl | **int64**<br>Time to live in seconds. Acceptable values are 0 to 2147483647, inclusive.
data[] | **string**<br>Data of the record set. The number of elements must be in the range 1-100. The string length in characters for each value must be 1-255.


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpsertRecordSetsMetadata](#UpsertRecordSetsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RecordSetDiff](#RecordSetDiff)>**<br>if operation finished successfully. 


### UpsertRecordSetsMetadata {#UpsertRecordSetsMetadata}



### RecordSetDiff {#RecordSetDiff1}

Field | Description
--- | ---
additions[] | **[RecordSet](#RecordSet4)**<br>List of record sets that were added 
deletions[] | **[RecordSet](#RecordSet4)**<br>List of record sets that were deleted 


## ListOperations {#ListOperations}

Lists operations for the specified DNS zone.

**rpc ListOperations ([ListDnsZoneOperationsRequest](#ListDnsZoneOperationsRequest)) returns ([ListDnsZoneOperationsResponse](#ListDnsZoneOperationsResponse))**

### ListDnsZoneOperationsRequest {#ListDnsZoneOperationsRequest}

Field | Description
--- | ---
dns_zone_id | **string**<br>ID of the DNS zone to list operations for. <br>To get a DNS zone ID, make a [DnsZoneService.List](#List) request. The string length in characters must be equal to 20.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListDnsZoneOperationsResponse.next_page_token](#ListDnsZoneOperationsResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListDnsZoneOperationsResponse.next_page_token](#ListDnsZoneOperationsResponse) returned by a previous list request. The maximum string length in characters is 1000.
filter | **string**<br>A filter expression that filters DNS zones listed in the response. <br>The expression must specify: <ol><li>The field name. Currently you can use filtering only on the [DnsZone.name](#DnsZone4) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Example of a filter: `name=my-dns-zone`. The maximum string length in characters is 1000.


### ListDnsZoneOperationsResponse {#ListDnsZoneOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation5)**<br>List of operations for the specified DNS zone. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListDnsZoneOperationsRequest.page_size](#ListDnsZoneOperationsRequest), use `next_page_token` as the value for the [ListDnsZoneOperationsRequest.page_token](#ListDnsZoneOperationsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation5}

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


## ListAccessBindings {#ListAccessBindings}

Lists existing access bindings for the specified DNS zone.

**rpc ListAccessBindings ([ListAccessBindingsRequest](#ListAccessBindingsRequest)) returns ([ListAccessBindingsResponse](#ListAccessBindingsResponse))**

### ListAccessBindingsRequest {#ListAccessBindingsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of the resource to list access bindings for. <br>To get the resource ID, use a corresponding List request. For example, use the [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/grpc/cloud_service#List) request to get the Cloud resource ID. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListAccessBindingsResponse.next_page_token](#ListAccessBindingsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. Set `page_token` to the [ListAccessBindingsResponse.next_page_token](#ListAccessBindingsResponse) returned by a previous list request to get the next page of results. The maximum string length in characters is 100.


### ListAccessBindingsResponse {#ListAccessBindingsResponse}

Field | Description
--- | ---
access_bindings[] | **[AccessBinding](#AccessBinding)**<br>List of access bindings for the specified resource. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListAccessBindingsRequest.page_size](#ListAccessBindingsRequest), use the `next_page_token` as the value for the [ListAccessBindingsRequest.page_token](#ListAccessBindingsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### AccessBinding {#AccessBinding}

Field | Description
--- | ---
role_id | **string**<br>Required. ID of the `yandex.cloud.iam.v1.Role` that is assigned to the `subject`. The maximum string length in characters is 50.
subject | **[Subject](#Subject)**<br>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier. 


### Subject {#Subject}

Field | Description
--- | ---
id | **string**<br>Required. ID of the subject. <br>It can contain one of the following values: <ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li></ul>who is authenticated. It can be used only if the `type` is `system`. <ul><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li></ul>For example, you don't need to specify the IAM token in an API query. <ul><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul>It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`. The maximum string length in characters is 50.
type | **string**<br>Required. Type of the subject. <br>It can contain one of the following values: <ul><li>`userAccount`: An account on Yandex or Yandex.Connect, added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the `yandex.cloud.iam.v1.ServiceAccount` resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul><br>For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject). The maximum string length in characters is 100.


## SetAccessBindings {#SetAccessBindings}

Sets access bindings for the specified DNS zone.

**rpc SetAccessBindings ([SetAccessBindingsRequest](#SetAccessBindingsRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[SetAccessBindingsMetadata](#SetAccessBindingsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### SetAccessBindingsRequest {#SetAccessBindingsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of the resource for which access bindings are being set. <br>To get the resource ID, use a corresponding List request. The maximum string length in characters is 50.
access_bindings[] | **[AccessBinding](#AccessBinding)**<br>Required. Access bindings to be set. For more information, see [Access Bindings](/docs/iam/concepts/access-control/#access-bindings). 


### AccessBinding {#AccessBinding1}

Field | Description
--- | ---
role_id | **string**<br>Required. ID of the `yandex.cloud.iam.v1.Role` that is assigned to the `subject`. The maximum string length in characters is 50.
subject | **[Subject](#Subject)**<br>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier. 


### Subject {#Subject1}

Field | Description
--- | ---
id | **string**<br>Required. ID of the subject. <br>It can contain one of the following values: <ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li></ul>who is authenticated. It can be used only if the `type` is `system`. <ul><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li></ul>For example, you don't need to specify the IAM token in an API query. <ul><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul>It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`. The maximum string length in characters is 50.
type | **string**<br>Required. Type of the subject. <br>It can contain one of the following values: <ul><li>`userAccount`: An account on Yandex or Yandex.Connect, added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the `yandex.cloud.iam.v1.ServiceAccount` resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul><br>For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject). The maximum string length in characters is 100.


### Operation {#Operation6}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SetAccessBindingsMetadata](#SetAccessBindingsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### SetAccessBindingsMetadata {#SetAccessBindingsMetadata}

Field | Description
--- | ---
resource_id | **string**<br>ID of the resource for which access bindings are being set. 


## UpdateAccessBindings {#UpdateAccessBindings}

Updates access bindings for the specified DNS zone.

**rpc UpdateAccessBindings ([UpdateAccessBindingsRequest](#UpdateAccessBindingsRequest)) returns ([operation.Operation](#Operation7))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateAccessBindingsMetadata](#UpdateAccessBindingsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### UpdateAccessBindingsRequest {#UpdateAccessBindingsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of the resource for which access bindings are being updated. The maximum string length in characters is 50.
access_binding_deltas[] | **[AccessBindingDelta](#AccessBindingDelta)**<br>Required. Updates to access bindings. The number of elements must be greater than 0.


### AccessBindingDelta {#AccessBindingDelta}

Field | Description
--- | ---
action | enum **AccessBindingAction**<br>Required. The action that is being performed on an access binding. <ul><li>`ADD`: Addition of an access binding.</li><li>`REMOVE`: Removal of an access binding.</li></ul>
access_binding | **[AccessBinding](#AccessBinding)**<br>Required. Access binding. For more information, see [Access Bindings](/docs/iam/concepts/access-control/#access-bindings). 


### AccessBinding {#AccessBinding2}

Field | Description
--- | ---
role_id | **string**<br>Required. ID of the `yandex.cloud.iam.v1.Role` that is assigned to the `subject`. The maximum string length in characters is 50.
subject | **[Subject](#Subject)**<br>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier. 


### Subject {#Subject2}

Field | Description
--- | ---
id | **string**<br>Required. ID of the subject. <br>It can contain one of the following values: <ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li></ul>who is authenticated. It can be used only if the `type` is `system`. <ul><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li></ul>For example, you don't need to specify the IAM token in an API query. <ul><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul>It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`. The maximum string length in characters is 50.
type | **string**<br>Required. Type of the subject. <br>It can contain one of the following values: <ul><li>`userAccount`: An account on Yandex or Yandex.Connect, added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the `yandex.cloud.iam.v1.ServiceAccount` resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul><br>For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject). The maximum string length in characters is 100.


### Operation {#Operation7}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateAccessBindingsMetadata](#UpdateAccessBindingsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### UpdateAccessBindingsMetadata {#UpdateAccessBindingsMetadata}

Field | Description
--- | ---
resource_id | **string**<br>ID of the resource for which access bindings are being updated. 


