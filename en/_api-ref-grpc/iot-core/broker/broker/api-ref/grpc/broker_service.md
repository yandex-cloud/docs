---
editable: false
---

# BrokerService

A set of methods for managing broker.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified broker. |
| [List](#List) | Retrieves the list of brokers in the specified folder. |
| [Create](#Create) | Creates a broker in the specified folder. |
| [Update](#Update) | Updates the specified broker. |
| [Delete](#Delete) | Deletes the specified broker. |
| [ListCertificates](#ListCertificates) | Retrieves the list of broker certificates for the specified broker. |
| [AddCertificate](#AddCertificate) | Adds a certificate. |
| [DeleteCertificate](#DeleteCertificate) | Deletes the specified broker certificate. |
| [ListPasswords](#ListPasswords) | Retrieves the list of passwords for the specified broker. |
| [AddPassword](#AddPassword) | Adds password for the specified broker. |
| [DeletePassword](#DeletePassword) | Deletes the specified password. |
| [ListOperations](#ListOperations) | Lists operations for the specified broker. |

## Calls BrokerService {#calls}

## Get {#Get}

Returns the specified broker. <br>To get the list of available brokers, make a [List](#List) request.

**rpc Get ([GetBrokerRequest](#GetBrokerRequest)) returns ([Broker](#Broker))**

### GetBrokerRequest {#GetBrokerRequest}

Field | Description
--- | ---
broker_id | **string**<br>Required. ID of the broker to return. <br>To get a broker ID make a [BrokerService.List](#List) request. The maximum string length in characters is 50.


### Broker {#Broker}

Field | Description
--- | ---
id | **string**<br>ID of the broker. 
folder_id | **string**<br>ID of the folder that the broker belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the broker. The name is unique within the folder. 
description | **string**<br>Description of the broker. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
status | enum **Status**<br>Status of the broker. <ul><li>`CREATING`: Broker is being created.</li><li>`ACTIVE`: Broker is ready to use.</li><li>`DELETING`: Broker is being deleted.</li></ul>


## List {#List}

Retrieves the list of brokers in the specified folder.

**rpc List ([ListBrokersRequest](#ListBrokersRequest)) returns ([ListBrokersResponse](#ListBrokersResponse))**

### ListBrokersRequest {#ListBrokersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list brokers in. <br>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListBrokersResponse.next_page_token](#ListBrokersResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListBrokersResponse.next_page_token](#ListBrokersResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListBrokersResponse {#ListBrokersResponse}

Field | Description
--- | ---
brokers[] | **[Broker](#Broker1)**<br>List of brokers. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListBrokersRequest.page_size](#ListBrokersRequest), use `next_page_token` as the value for the [ListBrokersRequest.page_token](#ListBrokersRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### Broker {#Broker1}

Field | Description
--- | ---
id | **string**<br>ID of the broker. 
folder_id | **string**<br>ID of the folder that the broker belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the broker. The name is unique within the folder. 
description | **string**<br>Description of the broker. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
status | enum **Status**<br>Status of the broker. <ul><li>`CREATING`: Broker is being created.</li><li>`ACTIVE`: Broker is ready to use.</li><li>`DELETING`: Broker is being deleted.</li></ul>


## Create {#Create}

Creates a broker in the specified folder.

**rpc Create ([CreateBrokerRequest](#CreateBrokerRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateBrokerMetadata](#CreateBrokerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Broker](#Broker2)<br>

### CreateBrokerRequest {#CreateBrokerRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a broker in. <br>To get a folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
name | **string**<br>Required. Name of the broker. The name must be unique within the folder. The maximum string length in characters is 50. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the broker. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
certificates[] | **Certificate**<br>Broker certificates. 
password | **string**<br>Broker passwords. <br>The password must contain at least three character categories among the following: upper case latin, lower case latin, numbers and special symbols. 


### Certificate {#Certificate}

Field | Description
--- | ---
certificate_data | **string**<br>Public part of the broker certificate. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateBrokerMetadata](#CreateBrokerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Broker](#Broker2)>**<br>if operation finished successfully. 


### CreateBrokerMetadata {#CreateBrokerMetadata}

Field | Description
--- | ---
broker_id | **string**<br>ID of the broker that is being created. 


### Broker {#Broker2}

Field | Description
--- | ---
id | **string**<br>ID of the broker. 
folder_id | **string**<br>ID of the folder that the broker belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the broker. The name is unique within the folder. 
description | **string**<br>Description of the broker. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
status | enum **Status**<br>Status of the broker. <ul><li>`CREATING`: Broker is being created.</li><li>`ACTIVE`: Broker is ready to use.</li><li>`DELETING`: Broker is being deleted.</li></ul>


## Update {#Update}

Updates the specified broker.

**rpc Update ([UpdateBrokerRequest](#UpdateBrokerRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateBrokerMetadata](#UpdateBrokerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Broker](#Broker3)<br>

### UpdateBrokerRequest {#UpdateBrokerRequest}

Field | Description
--- | ---
broker_id | **string**<br>Required. ID of the broker to update. <br>To get a broker ID make a [BrokerService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the broker are going to be updated. 
name | **string**<br>Name of the broker. The name must be unique within the folder. The maximum string length in characters is 50. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the broker. The maximum string length in characters is 256.
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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateBrokerMetadata](#UpdateBrokerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Broker](#Broker3)>**<br>if operation finished successfully. 


### UpdateBrokerMetadata {#UpdateBrokerMetadata}

Field | Description
--- | ---
broker_id | **string**<br>ID of the broker that is being updated. 


### Broker {#Broker3}

Field | Description
--- | ---
id | **string**<br>ID of the broker. 
folder_id | **string**<br>ID of the folder that the broker belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the broker. The name is unique within the folder. 
description | **string**<br>Description of the broker. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
status | enum **Status**<br>Status of the broker. <ul><li>`CREATING`: Broker is being created.</li><li>`ACTIVE`: Broker is ready to use.</li><li>`DELETING`: Broker is being deleted.</li></ul>


## Delete {#Delete}

Deletes the specified broker.

**rpc Delete ([DeleteBrokerRequest](#DeleteBrokerRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteBrokerMetadata](#DeleteBrokerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteBrokerRequest {#DeleteBrokerRequest}

Field | Description
--- | ---
broker_id | **string**<br>Required. ID of the broker to delete. <br>To get a broker ID make a [BrokerService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteBrokerMetadata](#DeleteBrokerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteBrokerMetadata {#DeleteBrokerMetadata}

Field | Description
--- | ---
broker_id | **string**<br>ID of the broker that is being deleted. 


## ListCertificates {#ListCertificates}

Retrieves the list of broker certificates for the specified broker.

**rpc ListCertificates ([ListBrokerCertificatesRequest](#ListBrokerCertificatesRequest)) returns ([ListBrokerCertificatesResponse](#ListBrokerCertificatesResponse))**

### ListBrokerCertificatesRequest {#ListBrokerCertificatesRequest}

Field | Description
--- | ---
broker_id | **string**<br>Required. ID of the broker to list certificates for. The maximum string length in characters is 50.


### ListBrokerCertificatesResponse {#ListBrokerCertificatesResponse}

Field | Description
--- | ---
certificates[] | **[BrokerCertificate](#BrokerCertificate)**<br>List of certificates for the specified broker. 


### BrokerCertificate {#BrokerCertificate}

Field | Description
--- | ---
broker_id | **string**<br>ID of the broker that the certificate belongs to. 
fingerprint | **string**<br>SHA256 hash of the certificates. 
certificate_data | **string**<br>Public part of the certificate. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


## AddCertificate {#AddCertificate}

Adds a certificate.

**rpc AddCertificate ([AddBrokerCertificateRequest](#AddBrokerCertificateRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddBrokerCertificateMetadata](#AddBrokerCertificateMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[BrokerCertificate](#BrokerCertificate1)<br>

### AddBrokerCertificateRequest {#AddBrokerCertificateRequest}

Field | Description
--- | ---
broker_id | **string**<br>Required. ID of the broker for which the certificate is being added. <br>To get a broker ID make a [BrokerService.List](#List) request. The maximum string length in characters is 50.
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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddBrokerCertificateMetadata](#AddBrokerCertificateMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[BrokerCertificate](#BrokerCertificate1)>**<br>if operation finished successfully. 


### AddBrokerCertificateMetadata {#AddBrokerCertificateMetadata}

Field | Description
--- | ---
broker_id | **string**<br>ID of the broker certificate that is being added. 
fingerprint | **string**<br>Fingerprint of the certificate that is being added. 


### BrokerCertificate {#BrokerCertificate1}

Field | Description
--- | ---
broker_id | **string**<br>ID of the broker that the certificate belongs to. 
fingerprint | **string**<br>SHA256 hash of the certificates. 
certificate_data | **string**<br>Public part of the certificate. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


## DeleteCertificate {#DeleteCertificate}

Deletes the specified broker certificate.

**rpc DeleteCertificate ([DeleteBrokerCertificateRequest](#DeleteBrokerCertificateRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteBrokerCertificateMetadata](#DeleteBrokerCertificateMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteBrokerCertificateRequest {#DeleteBrokerCertificateRequest}

Field | Description
--- | ---
broker_id | **string**<br>Required. ID of the broker to delete a certificate for. <br>To get a broker ID make a [BrokerService.List](#List) request. The maximum string length in characters is 50.
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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteBrokerCertificateMetadata](#DeleteBrokerCertificateMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteBrokerCertificateMetadata {#DeleteBrokerCertificateMetadata}

Field | Description
--- | ---
broker_id | **string**<br>Required. ID of a broker for which the certificate is being delete. The maximum string length in characters is 50.
fingerprint | **string**<br>Required. Fingerprint of the certificate to deleted. The maximum string length in characters is 50.


## ListPasswords {#ListPasswords}

Retrieves the list of passwords for the specified broker.

**rpc ListPasswords ([ListBrokerPasswordsRequest](#ListBrokerPasswordsRequest)) returns ([ListBrokerPasswordsResponse](#ListBrokerPasswordsResponse))**

### ListBrokerPasswordsRequest {#ListBrokerPasswordsRequest}

Field | Description
--- | ---
broker_id | **string**<br>Required. ID of the broker to list passwords in. <br>To get a broker ID make a [BrokerService.List](#List) request. The maximum string length in characters is 50.


### ListBrokerPasswordsResponse {#ListBrokerPasswordsResponse}

Field | Description
--- | ---
passwords[] | **[BrokerPassword](#BrokerPassword)**<br>List of passwords for the specified broker. 


### BrokerPassword {#BrokerPassword}

Field | Description
--- | ---
broker_id | **string**<br>ID of the broker that the password belongs to. 
id | **string**<br>ID of the password. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


## AddPassword {#AddPassword}

Adds password for the specified broker.

**rpc AddPassword ([AddBrokerPasswordRequest](#AddBrokerPasswordRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddBrokerPasswordMetadata](#AddBrokerPasswordMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[BrokerPassword](#BrokerPassword1)<br>

### AddBrokerPasswordRequest {#AddBrokerPasswordRequest}

Field | Description
--- | ---
broker_id | **string**<br>Required. ID of the broker to add a password for. <br>To get a broker ID make a [BrokerService.List](#List) request. The maximum string length in characters is 50.
password | **string**<br>Passwords for the broker. <br>The password must contain at least three character categories among the following: upper case latin, lower case latin, numbers and special symbols. The minimum string length in characters is 14.


### Operation {#Operation5}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddBrokerPasswordMetadata](#AddBrokerPasswordMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[BrokerPassword](#BrokerPassword1)>**<br>if operation finished successfully. 


### AddBrokerPasswordMetadata {#AddBrokerPasswordMetadata}

Field | Description
--- | ---
broker_id | **string**<br>ID of the broker for which the password is being added. 
password_id | **string**<br>ID of a password that is being added. 


### BrokerPassword {#BrokerPassword1}

Field | Description
--- | ---
broker_id | **string**<br>ID of the broker that the password belongs to. 
id | **string**<br>ID of the password. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


## DeletePassword {#DeletePassword}

Deletes the specified password.

**rpc DeletePassword ([DeleteBrokerPasswordRequest](#DeleteBrokerPasswordRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteBrokerPasswordMetadata](#DeleteBrokerPasswordMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteBrokerPasswordRequest {#DeleteBrokerPasswordRequest}

Field | Description
--- | ---
broker_id | **string**<br>Required. ID of the broker to delete a password for. <br>To get a broker ID make a [BrokerService.List](#List) request. The maximum string length in characters is 50.
password_id | **string**<br>Required. ID of the password to delete. <br>To get a password ID make a [BrokerService.ListPasswords](#ListPasswords) request. The maximum string length in characters is 50.


### Operation {#Operation6}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteBrokerPasswordMetadata](#DeleteBrokerPasswordMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteBrokerPasswordMetadata {#DeleteBrokerPasswordMetadata}

Field | Description
--- | ---
broker_id | **string**<br>Required. ID of a broker for which the password is being delete. The maximum string length in characters is 50.
password_id | **string**<br>Required. ID of the password to delete. <br>To get a password ID make a [BrokerService.ListPasswords](#ListPasswords) request. The maximum string length in characters is 50.


## ListOperations {#ListOperations}

Lists operations for the specified broker.

**rpc ListOperations ([ListBrokerOperationsRequest](#ListBrokerOperationsRequest)) returns ([ListBrokerOperationsResponse](#ListBrokerOperationsResponse))**

### ListBrokerOperationsRequest {#ListBrokerOperationsRequest}

Field | Description
--- | ---
broker_id | **string**<br>Required. ID of the broker to list operations for. 
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListBrokerOperationsResponse.next_page_token](#ListBrokerOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListBrokerOperationsResponse.next_page_token](#ListBrokerOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. Currently you can use filtering only on [Broker.name](#Broker4) field. The maximum string length in characters is 1000.


### ListBrokerOperationsResponse {#ListBrokerOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation7)**<br>List of operations for the specified broker. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListBrokerOperationsRequest.page_size](#ListBrokerOperationsRequest), use `next_page_token` as the value for the [ListBrokerOperationsRequest.page_token](#ListBrokerOperationsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


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


