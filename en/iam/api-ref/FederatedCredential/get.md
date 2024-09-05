---
editable: false
sourcePath: en/_api-ref/iam/v1/api-ref/FederatedCredential/get.md
---

# Identity and Access Management Workload Identity API, REST: FederatedCredential.get
Returns the specified federated credential.
 
To get the list of available federated credentials, make a [list](/docs/iam/api-ref/FederatedCredential/list) request.
 
## HTTP request {#https-request}
```
GET https://iam.{{ api-host }}/iam/v1/workload/federatedCredentials/{federatedCredentialId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
federatedCredentialId | <p>Required. ID of the federated credential to return. To get the federated credential ID, make a <a href="/docs/iam/api-ref/FederatedCredential/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "serviceAccountId": "string",
  "federationId": "string",
  "externalSubjectId": "string",
  "createdAt": "string"
}
```
A federated credential.
 
Field | Description
--- | ---
id | **string**<br><p>Id of the federated credential.</p> 
serviceAccountId | **string**<br><p>Id of the service account that the federated credential belongs to.</p> 
federationId | **string**<br><p>ID of the workload identity federation which is used for authentication.</p> 
externalSubjectId | **string**<br><p>Id of the external subject.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 