---
editable: false
---

# CertificateService



| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified certificate. |
| [List](#List) | Returns the list of certificates in the specified folder. |
| [Create](#Create) | Creates a certificate in the specified folder. |
| [Update](#Update) | Updates the specified certificate. |
| [Delete](#Delete) | Deletes the specified certificate. |
| [RequestNew](#RequestNew) | Request a certificate in the specified folder. |
| [ListOperations](#ListOperations) | Lists operations for the specified certificate. |
| [ListAccessBindings](#ListAccessBindings) | Lists existing access bindings for the specified certificate. |
| [SetAccessBindings](#SetAccessBindings) | Sets access bindings for the certificate. |
| [UpdateAccessBindings](#UpdateAccessBindings) | Updates access bindings for the specified certificate. |

## Calls CertificateService {#calls}

## Get {#Get}

Returns the specified certificate. <br>To get the list of available certificates, make a [CertificateService.List](#List) request.

**rpc Get ([GetCertificateRequest](#GetCertificateRequest)) returns ([Certificate](../certificate.proto#Certificate))**

### GetCertificateRequest {#GetCertificateRequest}

Field | Description
--- | ---
certificate_id | **string**<br>Required. ID of the certificate to return. To get the ID of a certificate use a [CertificateService.List](#List) request. false The maximum string length in characters is 50.
view | enum **CertificateView**<br> <ul><ul/>


### Certificate {#Certificate}

Field | Description
--- | ---
id | **string**<br>ID of the certificate. 
folder_id | **string**<br>ID of the folder that the certificate belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the certificate was created. 
name | **string**<br>Name of the certificate. 
description | **string**<br>Description of the certificate. 
labels | **map<string,string>**<br>Certificate labels as `key:value` pairs. Maximum 64 per certificate. 
type | enum **CertificateType**<br>Type of the certificate. <ul><li>`IMPORTED`: The certificate was imported by user</li><li>`MANAGED`: The certificate was created by service</li><ul/>
domains[] | **string**<br>Fully qualified domain names of the certificate. 
status | enum **Status**<br>Status of the certificate. <ul><li>`VALIDATING`: The certificate domains validation are required. Used only for MANAGED certificates.</li><li>`INVALID`: The certificate issuance was failed. Used only for MANAGED certificates.</li><li>`ISSUED`: The certificate was issued.</li><li>`REVOKED`: The certificate was revoked.</li><li>`RENEWING`: The certificate renewal was started. Used only for MANAGED certificates.</li><li>`RENEWAL_FAILED`: The certificate renewal was failed. Used only for MANAGED certificates.</li><ul/>
issuer | **string**<br>Name of the certificate authority that issued the certificate. 
subject | **string**<br>Name of the entity that is associated with the public key contained in the certificate. 
serial | **string**<br>Serial number of the certificate 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the certificate was updated 
issued_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the certificate was issued 
not_after | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time after which the certificate is not valid. 
not_before | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time before which the certificate is not valid. 
challenges[] | **[Challenge](../certificate.proto#Challenge)**<br>Domains validation challenges of the certificate. Used only for MANAGED certificates. 


### Challenge {#Challenge}

Field | Description
--- | ---
domain | **string**<br>Domain of the challenge. 
type | enum **ChallengeType**<br>Type of the challenge. <ul><li>`DNS`: Domain validation type that using DNS-records.</li><li>`HTTP`: Domain validation type that using HTTP-files.</li><ul/>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the challenge was created. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the challenge was updated. 
status | enum **Status**<br>Status of the challenge. <ul><ul/>
message | **string**<br>Description of the challenge. 
error | **string**<br>Error of the challenge. 
challenge | **oneof:** `dns_challenge` or `http_challenge`<br>Data of the challenge.
&nbsp;&nbsp;dns_challenge | **[DnsRecord](../certificate.proto#DnsRecord)**<br>DNS record. 
&nbsp;&nbsp;http_challenge | **[HttpFile](../certificate.proto#HttpFile)**<br>HTTP file. 


### DnsRecord {#DnsRecord}

Field | Description
--- | ---
name | **string**<br>Name of the DNS record. 
type | **string**<br>Type of the DNS record. 
value | **string**<br>Value of the DNS record. 


### HttpFile {#HttpFile}

Field | Description
--- | ---
url | **string**<br>Location of the HTTP file. 
content | **string**<br>Content of the HTTP file. 


## List {#List}

Returns the list of certificates in the specified folder.

**rpc List ([ListCertificatesRequest](#ListCertificatesRequest)) returns ([ListCertificatesResponse](#ListCertificatesResponse))**

### ListCertificatesRequest {#ListCertificatesRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list certificate in. false The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListCertificatesResponse.next_page_token](#ListCertificatesResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListCertificatesResponse.next_page_token](#ListCertificatesResponse) returned by a previous list request. The maximum string length in characters is 100.
view | enum **CertificateView**<br> <ul><ul/>


### ListCertificatesResponse {#ListCertificatesResponse}

Field | Description
--- | ---
certificates[] | **[Certificate](../certificate.proto#Certificate1)**<br>List of certificates in the specified folder. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is greater than the specified [ListCertificatesRequest.page_size](#ListCertificatesRequest1), use the `next_page_token` as the value for the [ListCertificatesRequest.page_token](#ListCertificatesRequest1) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Certificate {#Certificate}

Field | Description
--- | ---
id | **string**<br>ID of the certificate. 
folder_id | **string**<br>ID of the folder that the certificate belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the certificate was created. 
name | **string**<br>Name of the certificate. 
description | **string**<br>Description of the certificate. 
labels | **map<string,string>**<br>Certificate labels as `key:value` pairs. Maximum 64 per certificate. 
type | enum **CertificateType**<br>Type of the certificate. <ul><li>`IMPORTED`: The certificate was imported by user</li><li>`MANAGED`: The certificate was created by service</li><ul/>
domains[] | **string**<br>Fully qualified domain names of the certificate. 
status | enum **Status**<br>Status of the certificate. <ul><li>`VALIDATING`: The certificate domains validation are required. Used only for MANAGED certificates.</li><li>`INVALID`: The certificate issuance was failed. Used only for MANAGED certificates.</li><li>`ISSUED`: The certificate was issued.</li><li>`REVOKED`: The certificate was revoked.</li><li>`RENEWING`: The certificate renewal was started. Used only for MANAGED certificates.</li><li>`RENEWAL_FAILED`: The certificate renewal was failed. Used only for MANAGED certificates.</li><ul/>
issuer | **string**<br>Name of the certificate authority that issued the certificate. 
subject | **string**<br>Name of the entity that is associated with the public key contained in the certificate. 
serial | **string**<br>Serial number of the certificate 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the certificate was updated 
issued_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the certificate was issued 
not_after | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time after which the certificate is not valid. 
not_before | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time before which the certificate is not valid. 
challenges[] | **[Challenge](../certificate.proto#Challenge1)**<br>Domains validation challenges of the certificate. Used only for MANAGED certificates. 


### Challenge {#Challenge}

Field | Description
--- | ---
domain | **string**<br>Domain of the challenge. 
type | enum **ChallengeType**<br>Type of the challenge. <ul><li>`DNS`: Domain validation type that using DNS-records.</li><li>`HTTP`: Domain validation type that using HTTP-files.</li><ul/>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the challenge was created. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the challenge was updated. 
status | enum **Status**<br>Status of the challenge. <ul><ul/>
message | **string**<br>Description of the challenge. 
error | **string**<br>Error of the challenge. 
challenge | **oneof:** `dns_challenge` or `http_challenge`<br>Data of the challenge.
&nbsp;&nbsp;dns_challenge | **[DnsRecord](../certificate.proto#DnsRecord1)**<br>DNS record. 
&nbsp;&nbsp;http_challenge | **[HttpFile](../certificate.proto#HttpFile1)**<br>HTTP file. 


### DnsRecord {#DnsRecord}

Field | Description
--- | ---
name | **string**<br>Name of the DNS record. 
type | **string**<br>Type of the DNS record. 
value | **string**<br>Value of the DNS record. 


### HttpFile {#HttpFile}

Field | Description
--- | ---
url | **string**<br>Location of the HTTP file. 
content | **string**<br>Content of the HTTP file. 


## Create {#Create}

Creates a certificate in the specified folder.

**rpc Create ([CreateCertificateRequest](#CreateCertificateRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateCertificateMetadata](#CreateCertificateMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Certificate](../certificate.proto#Certificate2)<br>

### CreateCertificateRequest {#CreateCertificateRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a certificate in. false The maximum string length in characters is 50.
name | **string**<br>Name of the certificate. Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the certificate. The maximum string length in characters is 1024.
labels | **map<string,string>**<br>Labels for the certificate as `key:value` pairs. Maximum 64 per certificate. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
certificate | **string**<br>PEM-encoded certificate content of the certificate. The maximum string length in characters is 32768.
chain | **string**<br>PEM-encoded certificate chain content of the certificate. The maximum string length in characters is 2097152.
private_key | **string**<br>Required. PEM-encoded private key content of the certificate. false The string length in characters must be 1-524288.


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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Certificate](../certificate.proto#Certificate2)>**<br>if operation finished successfully. 


### CreateCertificateMetadata {#CreateCertificateMetadata}

Field | Description
--- | ---
certificate_id | **string**<br>ID of the certificate being created. 


### Certificate {#Certificate}

Field | Description
--- | ---
id | **string**<br>ID of the certificate. 
folder_id | **string**<br>ID of the folder that the certificate belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the certificate was created. 
name | **string**<br>Name of the certificate. 
description | **string**<br>Description of the certificate. 
labels | **map<string,string>**<br>Certificate labels as `key:value` pairs. Maximum 64 per certificate. 
type | enum **CertificateType**<br>Type of the certificate. <ul><li>`IMPORTED`: The certificate was imported by user</li><li>`MANAGED`: The certificate was created by service</li><ul/>
domains[] | **string**<br>Fully qualified domain names of the certificate. 
status | enum **Status**<br>Status of the certificate. <ul><li>`VALIDATING`: The certificate domains validation are required. Used only for MANAGED certificates.</li><li>`INVALID`: The certificate issuance was failed. Used only for MANAGED certificates.</li><li>`ISSUED`: The certificate was issued.</li><li>`REVOKED`: The certificate was revoked.</li><li>`RENEWING`: The certificate renewal was started. Used only for MANAGED certificates.</li><li>`RENEWAL_FAILED`: The certificate renewal was failed. Used only for MANAGED certificates.</li><ul/>
issuer | **string**<br>Name of the certificate authority that issued the certificate. 
subject | **string**<br>Name of the entity that is associated with the public key contained in the certificate. 
serial | **string**<br>Serial number of the certificate 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the certificate was updated 
issued_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the certificate was issued 
not_after | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time after which the certificate is not valid. 
not_before | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time before which the certificate is not valid. 
challenges[] | **[Challenge](../certificate.proto#Challenge2)**<br>Domains validation challenges of the certificate. Used only for MANAGED certificates. 


## Update {#Update}

Updates the specified certificate.

**rpc Update ([UpdateCertificateRequest](#UpdateCertificateRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateCertificateMetadata](#UpdateCertificateMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Certificate](../certificate.proto#Certificate3)<br>

### UpdateCertificateRequest {#UpdateCertificateRequest}

Field | Description
--- | ---
certificate_id | **string**<br>Required. ID of the certificate to update. To get the ID of a certificate use a [CertificateService.List](#List) request. false The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the certificate are going to be updated. 
name | **string**<br>New name for the certificate. Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>New description for the certificate. The maximum string length in characters is 1024.
labels | **map<string,string>**<br>New labels for the certificate as `key:value` pairs. Maximum 64 per certificate. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
certificate | **string**<br>New PEM-encoded certificate content for the certificate. Used only for IMPORTED certificates. The maximum string length in characters is 32768.
chain | **string**<br>New PEM-encoded certificate chain content for the certificate. Used only for IMPORTED certificates. The maximum string length in characters is 2097152.
private_key | **string**<br>New PEM-encoded private key content for the certificate. Used only for IMPORTED certificates. The maximum string length in characters is 524288.


### Operation {#Operation}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Certificate](../certificate.proto#Certificate3)>**<br>if operation finished successfully. 


### UpdateCertificateMetadata {#UpdateCertificateMetadata}

Field | Description
--- | ---
certificate_id | **string**<br>ID of the certificate being updated. 


### Certificate {#Certificate}

Field | Description
--- | ---
id | **string**<br>ID of the certificate. 
folder_id | **string**<br>ID of the folder that the certificate belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the certificate was created. 
name | **string**<br>Name of the certificate. 
description | **string**<br>Description of the certificate. 
labels | **map<string,string>**<br>Certificate labels as `key:value` pairs. Maximum 64 per certificate. 
type | enum **CertificateType**<br>Type of the certificate. <ul><li>`IMPORTED`: The certificate was imported by user</li><li>`MANAGED`: The certificate was created by service</li><ul/>
domains[] | **string**<br>Fully qualified domain names of the certificate. 
status | enum **Status**<br>Status of the certificate. <ul><li>`VALIDATING`: The certificate domains validation are required. Used only for MANAGED certificates.</li><li>`INVALID`: The certificate issuance was failed. Used only for MANAGED certificates.</li><li>`ISSUED`: The certificate was issued.</li><li>`REVOKED`: The certificate was revoked.</li><li>`RENEWING`: The certificate renewal was started. Used only for MANAGED certificates.</li><li>`RENEWAL_FAILED`: The certificate renewal was failed. Used only for MANAGED certificates.</li><ul/>
issuer | **string**<br>Name of the certificate authority that issued the certificate. 
subject | **string**<br>Name of the entity that is associated with the public key contained in the certificate. 
serial | **string**<br>Serial number of the certificate 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the certificate was updated 
issued_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the certificate was issued 
not_after | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time after which the certificate is not valid. 
not_before | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time before which the certificate is not valid. 
challenges[] | **[Challenge](../certificate.proto#Challenge2)**<br>Domains validation challenges of the certificate. Used only for MANAGED certificates. 


## Delete {#Delete}

Deletes the specified certificate.

**rpc Delete ([DeleteCertificateRequest](#DeleteCertificateRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteCertificateMetadata](#DeleteCertificateMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Certificate](../certificate.proto#Certificate4)<br>

### DeleteCertificateRequest {#DeleteCertificateRequest}

Field | Description
--- | ---
certificate_id | **string**<br>Required. ID of the certificate to be deleted. false The maximum string length in characters is 50.


### Operation {#Operation}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Certificate](../certificate.proto#Certificate4)>**<br>if operation finished successfully. 


### DeleteCertificateMetadata {#DeleteCertificateMetadata}

Field | Description
--- | ---
certificate_id | **string**<br>ID of the certificate being deleted. 


### Certificate {#Certificate}

Field | Description
--- | ---
id | **string**<br>ID of the certificate. 
folder_id | **string**<br>ID of the folder that the certificate belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the certificate was created. 
name | **string**<br>Name of the certificate. 
description | **string**<br>Description of the certificate. 
labels | **map<string,string>**<br>Certificate labels as `key:value` pairs. Maximum 64 per certificate. 
type | enum **CertificateType**<br>Type of the certificate. <ul><li>`IMPORTED`: The certificate was imported by user</li><li>`MANAGED`: The certificate was created by service</li><ul/>
domains[] | **string**<br>Fully qualified domain names of the certificate. 
status | enum **Status**<br>Status of the certificate. <ul><li>`VALIDATING`: The certificate domains validation are required. Used only for MANAGED certificates.</li><li>`INVALID`: The certificate issuance was failed. Used only for MANAGED certificates.</li><li>`ISSUED`: The certificate was issued.</li><li>`REVOKED`: The certificate was revoked.</li><li>`RENEWING`: The certificate renewal was started. Used only for MANAGED certificates.</li><li>`RENEWAL_FAILED`: The certificate renewal was failed. Used only for MANAGED certificates.</li><ul/>
issuer | **string**<br>Name of the certificate authority that issued the certificate. 
subject | **string**<br>Name of the entity that is associated with the public key contained in the certificate. 
serial | **string**<br>Serial number of the certificate 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the certificate was updated 
issued_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the certificate was issued 
not_after | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time after which the certificate is not valid. 
not_before | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time before which the certificate is not valid. 
challenges[] | **[Challenge](../certificate.proto#Challenge2)**<br>Domains validation challenges of the certificate. Used only for MANAGED certificates. 


## RequestNew {#RequestNew}

Request a certificate in the specified folder.

**rpc RequestNew ([RequestNewCertificateRequest](#RequestNewCertificateRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RequestNewCertificateMetadata](#RequestNewCertificateMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Certificate](../certificate.proto#Certificate5)<br>

### RequestNewCertificateRequest {#RequestNewCertificateRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a certificate in. false The maximum string length in characters is 50.
name | **string**<br>Name of the certificate. Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the certificate. The maximum string length in characters is 1024.
labels | **map<string,string>**<br>Labels for the certificate as `key:value` pairs. Maximum 64 per certificate. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
domains[] | **string**<br>Fully qualified domain names of the certificate. 
challenge_type | enum **ChallengeType**<br>Type of the domain validation challenge. <ul><li>`DNS`: Domain validation type that using DNS-records.</li><li>`HTTP`: Domain validation type that using HTTP-files.</li><ul/>


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RequestNewCertificateMetadata](#RequestNewCertificateMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Certificate](../certificate.proto#Certificate5)>**<br>if operation finished successfully. 


### RequestNewCertificateMetadata {#RequestNewCertificateMetadata}

Field | Description
--- | ---
certificate_id | **string**<br>ID of the certificate being requested. 


### Certificate {#Certificate}

Field | Description
--- | ---
id | **string**<br>ID of the certificate. 
folder_id | **string**<br>ID of the folder that the certificate belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the certificate was created. 
name | **string**<br>Name of the certificate. 
description | **string**<br>Description of the certificate. 
labels | **map<string,string>**<br>Certificate labels as `key:value` pairs. Maximum 64 per certificate. 
type | enum **CertificateType**<br>Type of the certificate. <ul><li>`IMPORTED`: The certificate was imported by user</li><li>`MANAGED`: The certificate was created by service</li><ul/>
domains[] | **string**<br>Fully qualified domain names of the certificate. 
status | enum **Status**<br>Status of the certificate. <ul><li>`VALIDATING`: The certificate domains validation are required. Used only for MANAGED certificates.</li><li>`INVALID`: The certificate issuance was failed. Used only for MANAGED certificates.</li><li>`ISSUED`: The certificate was issued.</li><li>`REVOKED`: The certificate was revoked.</li><li>`RENEWING`: The certificate renewal was started. Used only for MANAGED certificates.</li><li>`RENEWAL_FAILED`: The certificate renewal was failed. Used only for MANAGED certificates.</li><ul/>
issuer | **string**<br>Name of the certificate authority that issued the certificate. 
subject | **string**<br>Name of the entity that is associated with the public key contained in the certificate. 
serial | **string**<br>Serial number of the certificate 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the certificate was updated 
issued_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the certificate was issued 
not_after | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time after which the certificate is not valid. 
not_before | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time before which the certificate is not valid. 
challenges[] | **[Challenge](../certificate.proto#Challenge2)**<br>Domains validation challenges of the certificate. Used only for MANAGED certificates. 


## ListOperations {#ListOperations}

Lists operations for the specified certificate.

**rpc ListOperations ([ListCertificateOperationsRequest](#ListCertificateOperationsRequest)) returns ([ListCertificateOperationsResponse](#ListCertificateOperationsResponse))**

### ListCertificateOperationsRequest {#ListCertificateOperationsRequest}

Field | Description
--- | ---
certificate_id | **string**<br>Required. ID of the certificate to get operations for. <br>To get the certificate ID, use a [CertificateService.List](#List) request. false The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListCertificateOperationsResponse.next_page_token](#ListCertificateOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListCertificateOperationsResponse.next_page_token](#ListCertificateOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListCertificateOperationsResponse {#ListCertificateOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation4)**<br>List of operations for the specified certificate. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListCertificateOperationsRequest.page_size](#ListCertificateOperationsRequest1), use the `next_page_token` as the value for the [ListCertificateOperationsRequest.page_token](#ListCertificateOperationsRequest1) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation}

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

Lists existing access bindings for the specified certificate.

**rpc ListAccessBindings ([ListAccessBindingsRequest](#ListAccessBindingsRequest)) returns ([ListAccessBindingsResponse](#ListAccessBindingsResponse))**

### ListAccessBindingsRequest {#ListAccessBindingsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of the resource to list access bindings for. <br>To get the resource ID, use a corresponding List request. For example, use the [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/grpc/cloud_service#List) request to get the Cloud resource ID. false
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
role_id | **string**<br>ID of the `yandex.cloud.iam.v1.Role` that is assigned to the `subject`. The maximum string length in characters is 50.
subject | **[Subject](#Subject)**<br>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier. false


### Subject {#Subject}

Field | Description
--- | ---
id | **string**<br><ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul> The maximum string length in characters is 50.
type | **string**<br><ul><li>`userAccount`: An account on Yandex or [Yandex.Connect](./certificate#Connect)(https://connect.yandex.com), added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the `yandex.cloud.iam.v1.ServiceAccount` resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul> 


## SetAccessBindings {#SetAccessBindings}

Sets access bindings for the certificate.

**rpc SetAccessBindings ([SetAccessBindingsRequest](#SetAccessBindingsRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[SetAccessBindingsMetadata](#SetAccessBindingsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### SetAccessBindingsRequest {#SetAccessBindingsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of the resource for which access bindings are being set. <br>To get the resource ID, use a corresponding List request. false
access_bindings[] | **[AccessBinding](#AccessBinding)**<br>Required. Access bindings to be set. For more information, see [Access Bindings](/docs/iam/concepts/access-control/#access-bindings). false


### AccessBinding {#AccessBinding}

Field | Description
--- | ---
role_id | **string**<br>ID of the `yandex.cloud.iam.v1.Role` that is assigned to the `subject`. The maximum string length in characters is 50.
subject | **[Subject](#Subject)**<br>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier. false


### Subject {#Subject}

Field | Description
--- | ---
id | **string**<br><ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul> The maximum string length in characters is 50.
type | **string**<br><ul><li>`userAccount`: An account on Yandex or [Yandex.Connect](./certificate#Connect)(https://connect.yandex.com), added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the `yandex.cloud.iam.v1.ServiceAccount` resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul> 


### Operation {#Operation}

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

Updates access bindings for the specified certificate.

**rpc UpdateAccessBindings ([UpdateAccessBindingsRequest](#UpdateAccessBindingsRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateAccessBindingsMetadata](#UpdateAccessBindingsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### UpdateAccessBindingsRequest {#UpdateAccessBindingsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of the resource for which access bindings are being updated. false
access_binding_deltas[] | **[AccessBindingDelta](#AccessBindingDelta)**<br>Required. Updates to access bindings. false


### AccessBindingDelta {#AccessBindingDelta}

Field | Description
--- | ---
action | enum **AccessBindingAction**<br>Required. The action that is being performed on an access binding. false<ul><li>`ADD`: Addition of an access binding.</li><li>`REMOVE`: Removal of an access binding.</li><ul/>
access_binding | **[AccessBinding](#AccessBinding)**<br>Required. Access binding. For more information, see [Access Bindings](/docs/iam/concepts/access-control/#access-bindings). false


### AccessBinding {#AccessBinding}

Field | Description
--- | ---
role_id | **string**<br>ID of the `yandex.cloud.iam.v1.Role` that is assigned to the `subject`. The maximum string length in characters is 50.
subject | **[Subject](#Subject)**<br>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier. false


### Subject {#Subject}

Field | Description
--- | ---
id | **string**<br><ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul> The maximum string length in characters is 50.
type | **string**<br><ul><li>`userAccount`: An account on Yandex or [Yandex.Connect](./certificate#Connect)(https://connect.yandex.com), added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the `yandex.cloud.iam.v1.ServiceAccount` resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul> 


### Operation {#Operation}

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


