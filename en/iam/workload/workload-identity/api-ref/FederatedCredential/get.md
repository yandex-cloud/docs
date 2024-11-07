---
editable: false
sourcePath: en/_api-ref/iam/v1/workload/workload-identity/api-ref/FederatedCredential/get.md
---

# Workload Identity, REST: FederatedCredential.Get {#Get}

Returns the specified federated credential.

To get the list of available federated credentials, make a [List](/docs/iam/workload-identity/api-ref/FederatedCredential/list#List) request.

## HTTP request

```
GET https://iam.{{ api-host }}/iam/v1/workload/federatedCredentials/{federatedCredentialId}
```

## Path parameters

#|
||Field | Description ||
|| federatedCredentialId | **string**

Required field. ID of the federated credential to return.
To get the federated credential ID, make a [FederatedCredentialService.List](/docs/iam/workload-identity/api-ref/FederatedCredential/list#List) request. ||
|#

## Response {#yandex.cloud.iam.v1.workload.FederatedCredential}

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

#|
||Field | Description ||
|| id | **string**

Id of the federated credential. ||
|| serviceAccountId | **string**

Id of the service account that the federated credential belongs to. ||
|| federationId | **string**

ID of the workload identity federation which is used for authentication. ||
|| externalSubjectId | **string**

Id of the external subject. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#