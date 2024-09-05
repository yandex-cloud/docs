---
editable: false
sourcePath: en/_api-ref/iam/v1/api-ref/FederatedCredential/index.md
---

# Identity and Access Management Workload Identity API, REST: FederatedCredential methods
A set of methods for managing federated credentials.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "serviceAccountId": "string",
  "federationId": "string",
  "externalSubjectId": "string",
  "createdAt": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>Id of the federated credential.</p> 
serviceAccountId | **string**<br><p>Id of the service account that the federated credential belongs to.</p> 
federationId | **string**<br><p>ID of the workload identity federation which is used for authentication.</p> 
externalSubjectId | **string**<br><p>Id of the external subject.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a federated credential for the specified service account.
[delete](delete.md) | Deletes the specified federated credential.
[get](get.md) | Returns the specified federated credential.
[list](list.md) | Retrieves the list of federated credentials for the specified service account.