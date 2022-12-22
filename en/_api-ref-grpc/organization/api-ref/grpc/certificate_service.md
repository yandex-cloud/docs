---
editable: false
---

# Cloud Organization API, gRPC: CertificateService

A set of methods for managing certificates.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified certificate. |
| [List](#List) | Retrieves the list of certificates in the specified federation. |
| [Create](#Create) | Creates a certificate in the specified federation. |
| [Update](#Update) | Updates the specified certificate. |
| [Delete](#Delete) | Deletes the specified certificate. |
| [ListOperations](#ListOperations) | Lists operations for the specified certificate. |

## Calls CertificateService {#calls}

## Get {#Get}

Returns the specified certificate. <br>To get the list of available certificates, make a [List](#List) request.

**rpc Get ([GetCertificateRequest](#GetCertificateRequest)) returns ([Certificate](#Certificate))**

### GetCertificateRequest {#GetCertificateRequest}

Field | Description
--- | ---
certificate_id | **string**<br>ID of the certificate to return. To get the certificate ID, make a [CertificateService.List](#List) request. The maximum string length in characters is 50.


### Certificate {#Certificate}

Field | Description
--- | ---
id | **string**<br>Required. ID of the certificate. The maximum string length in characters is 50.
federation_id | **string**<br>Required. ID of the federation that the certificate belongs to. The maximum string length in characters is 50.
name | **string**<br>Name of the certificate. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the certificate. The maximum string length in characters is 256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
data | **string**<br>Required. Certificate data in PEM format. The maximum string length in characters is 32000.


## List {#List}

Retrieves the list of certificates in the specified federation.

**rpc List ([ListCertificatesRequest](#ListCertificatesRequest)) returns ([ListCertificatesResponse](#ListCertificatesResponse))**

### ListCertificatesRequest {#ListCertificatesRequest}

Field | Description
--- | ---
federation_id | **string**<br>Required. ID of the federation to list certificates in. To get the federation ID make a [yandex.cloud.organizationmanager.v1.saml.FederationService.List](/docs/organization/api-ref/grpc/federation_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListCertificatesResponse.next_page_token](#ListCertificatesResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListCertificatesResponse.next_page_token](#ListCertificatesResponse) returned by a previous list request. The maximum string length in characters is 2000.
filter | **string**<br>A filter expression that filters resources listed in the response. The expression must specify: <ol><li>The field name. Currently you can use filtering only on [Certificate.name](#Certificate1) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.</li></ol> The maximum string length in characters is 1000.


### ListCertificatesResponse {#ListCertificatesResponse}

Field | Description
--- | ---
certificates[] | **[Certificate](#Certificate1)**<br>List of certificates. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListCertificatesRequest.page_size](#ListCertificatesRequest), use the `next_page_token` as the value for the [ListCertificatesRequest.page_token](#ListCertificatesRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Certificate {#Certificate1}

Field | Description
--- | ---
id | **string**<br>Required. ID of the certificate. The maximum string length in characters is 50.
federation_id | **string**<br>Required. ID of the federation that the certificate belongs to. The maximum string length in characters is 50.
name | **string**<br>Name of the certificate. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the certificate. The maximum string length in characters is 256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
data | **string**<br>Required. Certificate data in PEM format. The maximum string length in characters is 32000.


## Create {#Create}

Creates a certificate in the specified federation.

**rpc Create ([CreateCertificateRequest](#CreateCertificateRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateCertificateMetadata](#CreateCertificateMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Certificate](#Certificate2)<br>

### CreateCertificateRequest {#CreateCertificateRequest}

Field | Description
--- | ---
federation_id | **string**<br>ID of the federation to add new certificate. To get the federation ID make a [yandex.cloud.organizationmanager.v1.saml.FederationService.List](/docs/organization/api-ref/grpc/federation_service#List) request. The maximum string length in characters is 50.
name | **string**<br>Name of the certificate. The name must be unique within the federation. Value must match the regular expression ` [a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the certificate. The maximum string length in characters is 256.
data | **string**<br>Certificate data in PEM format. The maximum string length in characters is 32000.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateCertificateMetadata](#CreateCertificateMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Certificate](#Certificate2)>**<br>if operation finished successfully. 


### CreateCertificateMetadata {#CreateCertificateMetadata}

Field | Description
--- | ---
certificate_id | **string**<br>ID of the certificate that is being created. 


### Certificate {#Certificate2}

Field | Description
--- | ---
id | **string**<br>Required. ID of the certificate. The maximum string length in characters is 50.
federation_id | **string**<br>Required. ID of the federation that the certificate belongs to. The maximum string length in characters is 50.
name | **string**<br>Name of the certificate. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the certificate. The maximum string length in characters is 256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
data | **string**<br>Required. Certificate data in PEM format. The maximum string length in characters is 32000.


## Update {#Update}

Updates the specified certificate.

**rpc Update ([UpdateCertificateRequest](#UpdateCertificateRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateCertificateMetadata](#UpdateCertificateMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Certificate](#Certificate3)<br>

### UpdateCertificateRequest {#UpdateCertificateRequest}

Field | Description
--- | ---
certificate_id | **string**<br>ID of the certificate to update. To get the certificate ID, make a [CertificateService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the certificate are going to be updated. 
name | **string**<br>Name of the certificate. The name must be unique within the federation. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the certificate. The maximum string length in characters is 256.
data | **string**<br>Certificate data in PEM format. The maximum string length in characters is 32000.


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateCertificateMetadata](#UpdateCertificateMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Certificate](#Certificate3)>**<br>if operation finished successfully. 


### UpdateCertificateMetadata {#UpdateCertificateMetadata}

Field | Description
--- | ---
certificate_id | **string**<br>ID of the certificate that is being updated. 


### Certificate {#Certificate3}

Field | Description
--- | ---
id | **string**<br>Required. ID of the certificate. The maximum string length in characters is 50.
federation_id | **string**<br>Required. ID of the federation that the certificate belongs to. The maximum string length in characters is 50.
name | **string**<br>Name of the certificate. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the certificate. The maximum string length in characters is 256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
data | **string**<br>Required. Certificate data in PEM format. The maximum string length in characters is 32000.


## Delete {#Delete}

Deletes the specified certificate.

**rpc Delete ([DeleteCertificateRequest](#DeleteCertificateRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteCertificateMetadata](#DeleteCertificateMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteCertificateRequest {#DeleteCertificateRequest}

Field | Description
--- | ---
certificate_id | **string**<br>ID of the certificate to delete. To get the certificate ID, make a [CertificateService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteCertificateMetadata](#DeleteCertificateMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteCertificateMetadata {#DeleteCertificateMetadata}

Field | Description
--- | ---
certificate_id | **string**<br>ID of the certificate that is being deleted. 


## ListOperations {#ListOperations}

Lists operations for the specified certificate.

**rpc ListOperations ([ListCertificateOperationsRequest](#ListCertificateOperationsRequest)) returns ([ListCertificateOperationsResponse](#ListCertificateOperationsResponse))**

### ListCertificateOperationsRequest {#ListCertificateOperationsRequest}

Field | Description
--- | ---
certificate_id | **string**<br>ID of the certificate to list operations for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListCertificateOperationsResponse.next_page_token](#ListCertificateOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListCertificateOperationsResponse.next_page_token](#ListCertificateOperationsResponse) returned by a previous list request. The maximum string length in characters is 2000.


### ListCertificateOperationsResponse {#ListCertificateOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>List of operations for the specified certificate. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListCertificateOperationsRequest.page_size](#ListCertificateOperationsRequest), use the `next_page_token` as the value for the [ListCertificateOperationsRequest.page_token](#ListCertificateOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


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


