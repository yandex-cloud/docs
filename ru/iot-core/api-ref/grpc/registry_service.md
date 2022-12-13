---
editable: false
sourcePath: en/_api-ref-grpc/iot-core/api-ref/grpc/registry_service.md
---

# IoT Core Service, gRPC: RegistryService

A set of methods for managing registry.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified registry. |
| [GetByName](#GetByName) |  |
| [List](#List) | Retrieves the list of registries in the specified folder. |
| [Create](#Create) | Creates a registry in the specified folder. |
| [Update](#Update) | Updates the specified registry. |
| [Delete](#Delete) | Deletes the specified registry. |
| [ListCertificates](#ListCertificates) | Retrieves the list of registry certificates for the specified registry. |
| [AddCertificate](#AddCertificate) | Adds a certificate. |
| [DeleteCertificate](#DeleteCertificate) | Deletes the specified registry certificate. |
| [ListPasswords](#ListPasswords) | Retrieves the list of passwords for the specified registry. |
| [AddPassword](#AddPassword) | Adds password for the specified registry. |
| [DeletePassword](#DeletePassword) | Deletes the specified password. |
| [ListDeviceTopicAliases](#ListDeviceTopicAliases) | Retrieves the list of device topic aliases for the specified registry. |
| [ListOperations](#ListOperations) | Lists operations for the specified registry. |

## Calls RegistryService {#calls}

## Get {#Get}

Returns the specified registry. <br>To get the list of available registries, make a [List](#List) request.

**rpc Get ([GetRegistryRequest](#GetRegistryRequest)) returns ([Registry](#Registry))**

### GetRegistryRequest {#GetRegistryRequest}

Field | Description
--- | ---
registry_id | **string**<br>Required. ID of the registry to return. <br>To get a registry ID make a [RegistryService.List](#List) request. The maximum string length in characters is 50.


### Registry {#Registry}

Field | Description
--- | ---
id | **string**<br>ID of the registry. 
folder_id | **string**<br>ID of the folder that the registry belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the registry. The name is unique within the folder. 
description | **string**<br>Description of the registry. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
status | enum **Status**<br>Status of the registry. <ul><li>`CREATING`: Registry is being created.</li><li>`ACTIVE`: Registry is ready to use.</li><li>`DELETING`: Registry is being deleted.</li></ul>
log_group_id | **string**<br>ID of the logs group for the specified registry. 


## GetByName {#GetByName}



**rpc GetByName ([GetByNameRegistryRequest](#GetByNameRegistryRequest)) returns ([Registry](#Registry1))**

### GetByNameRegistryRequest {#GetByNameRegistryRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list registries in. <br>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
registry_name | **string**<br>Required. Name of the registry to return. <br>To get a registry Name make a [RegistryService.List](#List) request. The maximum string length in characters is 50. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Registry {#Registry1}

Field | Description
--- | ---
id | **string**<br>ID of the registry. 
folder_id | **string**<br>ID of the folder that the registry belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the registry. The name is unique within the folder. 
description | **string**<br>Description of the registry. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
status | enum **Status**<br>Status of the registry. <ul><li>`CREATING`: Registry is being created.</li><li>`ACTIVE`: Registry is ready to use.</li><li>`DELETING`: Registry is being deleted.</li></ul>
log_group_id | **string**<br>ID of the logs group for the specified registry. 


## List {#List}

Retrieves the list of registries in the specified folder.

**rpc List ([ListRegistriesRequest](#ListRegistriesRequest)) returns ([ListRegistriesResponse](#ListRegistriesResponse))**

### ListRegistriesRequest {#ListRegistriesRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list registries in. <br>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListRegistriesResponse.next_page_token](#ListRegistriesResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListRegistriesResponse.next_page_token](#ListRegistriesResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListRegistriesResponse {#ListRegistriesResponse}

Field | Description
--- | ---
registries[] | **[Registry](#Registry2)**<br>List of registries. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListRegistriesRequest.page_size](#ListRegistriesRequest), use `next_page_token` as the value for the [ListRegistriesRequest.page_token](#ListRegistriesRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### Registry {#Registry2}

Field | Description
--- | ---
id | **string**<br>ID of the registry. 
folder_id | **string**<br>ID of the folder that the registry belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the registry. The name is unique within the folder. 
description | **string**<br>Description of the registry. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
status | enum **Status**<br>Status of the registry. <ul><li>`CREATING`: Registry is being created.</li><li>`ACTIVE`: Registry is ready to use.</li><li>`DELETING`: Registry is being deleted.</li></ul>
log_group_id | **string**<br>ID of the logs group for the specified registry. 


## Create {#Create}

Creates a registry in the specified folder.

**rpc Create ([CreateRegistryRequest](#CreateRegistryRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateRegistryMetadata](#CreateRegistryMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Registry](#Registry3)<br>

### CreateRegistryRequest {#CreateRegistryRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a registry in. <br>To get a folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
name | **string**<br>Required. Name of the registry. The name must be unique within the folder. The maximum string length in characters is 50. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the registry. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
certificates[] | **[Certificate](#Certificate)**<br>Registry certificates. 
password | **string**<br>Registry passwords. <br>The password must contain at least three character categories among the following: upper case latin, lower case latin, numbers and special symbols. 


### Certificate {#Certificate}

Field | Description
--- | ---
certificate_data | **string**<br>Public part of the registry certificate. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateRegistryMetadata](#CreateRegistryMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Registry](#Registry3)>**<br>if operation finished successfully. 


### CreateRegistryMetadata {#CreateRegistryMetadata}

Field | Description
--- | ---
registry_id | **string**<br>ID of the registry that is being created. 


### Registry {#Registry3}

Field | Description
--- | ---
id | **string**<br>ID of the registry. 
folder_id | **string**<br>ID of the folder that the registry belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the registry. The name is unique within the folder. 
description | **string**<br>Description of the registry. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
status | enum **Status**<br>Status of the registry. <ul><li>`CREATING`: Registry is being created.</li><li>`ACTIVE`: Registry is ready to use.</li><li>`DELETING`: Registry is being deleted.</li></ul>
log_group_id | **string**<br>ID of the logs group for the specified registry. 


## Update {#Update}

Updates the specified registry.

**rpc Update ([UpdateRegistryRequest](#UpdateRegistryRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateRegistryMetadata](#UpdateRegistryMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Registry](#Registry4)<br>

### UpdateRegistryRequest {#UpdateRegistryRequest}

Field | Description
--- | ---
registry_id | **string**<br>Required. ID of the registry to update. <br>To get a registry ID make a [RegistryService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the registry are going to be updated. 
name | **string**<br>Name of the registry. The name must be unique within the folder. The maximum string length in characters is 50. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the registry. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. <br>Existing set of `labels` is completely replaced by the provided set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateRegistryMetadata](#UpdateRegistryMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Registry](#Registry4)>**<br>if operation finished successfully. 


### UpdateRegistryMetadata {#UpdateRegistryMetadata}

Field | Description
--- | ---
registry_id | **string**<br>ID of the registry that is being updated. 


### Registry {#Registry4}

Field | Description
--- | ---
id | **string**<br>ID of the registry. 
folder_id | **string**<br>ID of the folder that the registry belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the registry. The name is unique within the folder. 
description | **string**<br>Description of the registry. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
status | enum **Status**<br>Status of the registry. <ul><li>`CREATING`: Registry is being created.</li><li>`ACTIVE`: Registry is ready to use.</li><li>`DELETING`: Registry is being deleted.</li></ul>
log_group_id | **string**<br>ID of the logs group for the specified registry. 


## Delete {#Delete}

Deletes the specified registry.

**rpc Delete ([DeleteRegistryRequest](#DeleteRegistryRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteRegistryMetadata](#DeleteRegistryMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteRegistryRequest {#DeleteRegistryRequest}

Field | Description
--- | ---
registry_id | **string**<br>Required. ID of the registry to delete. <br>To get a registry ID make a [RegistryService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteRegistryMetadata](#DeleteRegistryMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteRegistryMetadata {#DeleteRegistryMetadata}

Field | Description
--- | ---
registry_id | **string**<br>ID of the registry that is being deleted. 


## ListCertificates {#ListCertificates}

Retrieves the list of registry certificates for the specified registry.

**rpc ListCertificates ([ListRegistryCertificatesRequest](#ListRegistryCertificatesRequest)) returns ([ListRegistryCertificatesResponse](#ListRegistryCertificatesResponse))**

### ListRegistryCertificatesRequest {#ListRegistryCertificatesRequest}

Field | Description
--- | ---
registry_id | **string**<br>Required. ID of the registry to list certificates for. The maximum string length in characters is 50.


### ListRegistryCertificatesResponse {#ListRegistryCertificatesResponse}

Field | Description
--- | ---
certificates[] | **[RegistryCertificate](#RegistryCertificate)**<br>List of certificates for the specified registry. 


### RegistryCertificate {#RegistryCertificate}

Field | Description
--- | ---
registry_id | **string**<br>ID of the registry that the certificate belongs to. 
fingerprint | **string**<br>SHA256 hash of the certificates. 
certificate_data | **string**<br>Public part of the certificate. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


## AddCertificate {#AddCertificate}

Adds a certificate.

**rpc AddCertificate ([AddRegistryCertificateRequest](#AddRegistryCertificateRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddRegistryCertificateMetadata](#AddRegistryCertificateMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[RegistryCertificate](#RegistryCertificate1)<br>

### AddRegistryCertificateRequest {#AddRegistryCertificateRequest}

Field | Description
--- | ---
registry_id | **string**<br>Required. ID of the registry for which the certificate is being added. <br>To get a registry ID make a [RegistryService.List](#List) request. The maximum string length in characters is 50.
certificate_data | **string**<br>Public part of the certificate that is being added. 


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddRegistryCertificateMetadata](#AddRegistryCertificateMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RegistryCertificate](#RegistryCertificate1)>**<br>if operation finished successfully. 


### AddRegistryCertificateMetadata {#AddRegistryCertificateMetadata}

Field | Description
--- | ---
registry_id | **string**<br>ID of the registry certificate that is being added. 
fingerprint | **string**<br>Fingerprint of the certificate that is being added. 


### RegistryCertificate {#RegistryCertificate1}

Field | Description
--- | ---
registry_id | **string**<br>ID of the registry that the certificate belongs to. 
fingerprint | **string**<br>SHA256 hash of the certificates. 
certificate_data | **string**<br>Public part of the certificate. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


## DeleteCertificate {#DeleteCertificate}

Deletes the specified registry certificate.

**rpc DeleteCertificate ([DeleteRegistryCertificateRequest](#DeleteRegistryCertificateRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteRegistryCertificateMetadata](#DeleteRegistryCertificateMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteRegistryCertificateRequest {#DeleteRegistryCertificateRequest}

Field | Description
--- | ---
registry_id | **string**<br>Required. ID of the registry to delete a certificate for. <br>To get a registry ID make a [RegistryService.List](#List) request. The maximum string length in characters is 50.
fingerprint | **string**<br>Required. Fingerprint of the certificate that is being deleted. The maximum string length in characters is 50.


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteRegistryCertificateMetadata](#DeleteRegistryCertificateMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteRegistryCertificateMetadata {#DeleteRegistryCertificateMetadata}

Field | Description
--- | ---
registry_id | **string**<br>Required. ID of a registry for which the certificate is being delete. The maximum string length in characters is 50.
fingerprint | **string**<br>Required. Fingerprint of the certificate to deleted. The maximum string length in characters is 50.


## ListPasswords {#ListPasswords}

Retrieves the list of passwords for the specified registry.

**rpc ListPasswords ([ListRegistryPasswordsRequest](#ListRegistryPasswordsRequest)) returns ([ListRegistryPasswordsResponse](#ListRegistryPasswordsResponse))**

### ListRegistryPasswordsRequest {#ListRegistryPasswordsRequest}

Field | Description
--- | ---
registry_id | **string**<br>Required. ID of the registry to list passwords in. <br>To get a registry ID make a [RegistryService.List](#List) request. The maximum string length in characters is 50.


### ListRegistryPasswordsResponse {#ListRegistryPasswordsResponse}

Field | Description
--- | ---
passwords[] | **[RegistryPassword](#RegistryPassword)**<br>List of passwords for the specified registry. 


### RegistryPassword {#RegistryPassword}

Field | Description
--- | ---
registry_id | **string**<br>ID of the registry that the password belongs to. 
id | **string**<br>ID of the password. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


## AddPassword {#AddPassword}

Adds password for the specified registry.

**rpc AddPassword ([AddRegistryPasswordRequest](#AddRegistryPasswordRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddRegistryPasswordMetadata](#AddRegistryPasswordMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[RegistryPassword](#RegistryPassword1)<br>

### AddRegistryPasswordRequest {#AddRegistryPasswordRequest}

Field | Description
--- | ---
registry_id | **string**<br>Required. ID of the registry to add a password for. <br>To get a registry ID make a [RegistryService.List](#List) request. The maximum string length in characters is 50.
password | **string**<br>Passwords for the registry. <br>The password must contain at least three character categories among the following: upper case latin, lower case latin, numbers and special symbols. The minimum string length in characters is 14.


### Operation {#Operation5}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddRegistryPasswordMetadata](#AddRegistryPasswordMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RegistryPassword](#RegistryPassword1)>**<br>if operation finished successfully. 


### AddRegistryPasswordMetadata {#AddRegistryPasswordMetadata}

Field | Description
--- | ---
registry_id | **string**<br>ID of the registry for which the password is being added. 
password_id | **string**<br>ID of a password that is being added. 


### RegistryPassword {#RegistryPassword1}

Field | Description
--- | ---
registry_id | **string**<br>ID of the registry that the password belongs to. 
id | **string**<br>ID of the password. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


## DeletePassword {#DeletePassword}

Deletes the specified password.

**rpc DeletePassword ([DeleteRegistryPasswordRequest](#DeleteRegistryPasswordRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteRegistryPasswordMetadata](#DeleteRegistryPasswordMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteRegistryPasswordRequest {#DeleteRegistryPasswordRequest}

Field | Description
--- | ---
registry_id | **string**<br>Required. ID of the registry to delete a password for. <br>To get a registry ID make a [DeviceService.List](./device_service#List) request. The maximum string length in characters is 50.
password_id | **string**<br>Required. ID of the password to delete. <br>To get a password ID make a [RegistryService.ListPasswords](#ListPasswords) request. The maximum string length in characters is 50.


### Operation {#Operation6}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteRegistryPasswordMetadata](#DeleteRegistryPasswordMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteRegistryPasswordMetadata {#DeleteRegistryPasswordMetadata}

Field | Description
--- | ---
registry_id | **string**<br>Required. ID of a registry for which the password is being delete. The maximum string length in characters is 50.
password_id | **string**<br>Required. ID of the password to delete. <br>To get a password ID make a [RegistryService.ListPasswords](#ListPasswords) request. The maximum string length in characters is 50.


## ListDeviceTopicAliases {#ListDeviceTopicAliases}

Retrieves the list of device topic aliases for the specified registry.

**rpc ListDeviceTopicAliases ([ListDeviceTopicAliasesRequest](#ListDeviceTopicAliasesRequest)) returns ([ListDeviceTopicAliasesResponse](#ListDeviceTopicAliasesResponse))**

### ListDeviceTopicAliasesRequest {#ListDeviceTopicAliasesRequest}

Field | Description
--- | ---
registry_id | **string**<br>Required. ID of the registry to list aliases for device topic. <br>To get a registry ID make a [RegistryService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListDeviceTopicAliasesResponse.next_page_token](#ListDeviceTopicAliasesResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListDeviceTopicAliasesResponse.next_page_token](#ListDeviceTopicAliasesResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListDeviceTopicAliasesResponse {#ListDeviceTopicAliasesResponse}

Field | Description
--- | ---
aliases[] | **[DeviceAlias](#DeviceAlias)**<br>List of device aliases for the specified registry. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListDeviceTopicAliasesRequest.page_size](#ListDeviceTopicAliasesRequest), use `next_page_token` as the value for the [ListDeviceTopicAliasesRequest.page_token](#ListDeviceTopicAliasesRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### DeviceAlias {#DeviceAlias}

Field | Description
--- | ---
device_id | **string**<br>ID of the device that the alias belongs to. 
topic_prefix | **string**<br>Prefix of a canonical topic name to be aliased, e.g. `$devices/abcdef`. 
alias | **string**<br>Alias of a device topic. 


## ListOperations {#ListOperations}

Lists operations for the specified registry.

**rpc ListOperations ([ListRegistryOperationsRequest](#ListRegistryOperationsRequest)) returns ([ListRegistryOperationsResponse](#ListRegistryOperationsResponse))**

### ListRegistryOperationsRequest {#ListRegistryOperationsRequest}

Field | Description
--- | ---
registry_id | **string**<br>Required. ID of the registry to list operations for. 
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListRegistryOperationsResponse.next_page_token](#ListRegistryOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListRegistryOperationsResponse.next_page_token](#ListRegistryOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. Currently you can use filtering only on [Registry.name](#Registry5) field. The maximum string length in characters is 1000.


### ListRegistryOperationsResponse {#ListRegistryOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation7)**<br>List of operations for the specified registry. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListRegistryOperationsRequest.page_size](#ListRegistryOperationsRequest), use `next_page_token` as the value for the [ListRegistryOperationsRequest.page_token](#ListRegistryOperationsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation7}

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


