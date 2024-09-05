---
editable: false
sourcePath: en/_api-ref/iam/v1/api-ref/FederatedCredential/list.md
---

# Identity and Access Management Workload Identity API, REST: FederatedCredential.list
Retrieves the list of federated credentials for the specified service account.
 

 
## HTTP request {#https-request}
```
GET https://iam.{{ api-host }}/iam/v1/workload/federatedCredentials
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
serviceAccountId | <p>Required. ID of the service account to list federated credentials for. To get the the service account ID make a <a href="/docs/iam/api-ref/ServiceAccount/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/iam/api-ref/FederatedCredential/list#query_params">pageSize</a>, the service returns a <a href="/docs/iam/api-ref/FederatedCredential/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/iam/api-ref/FederatedCredential/list#query_params">pageToken</a> to the <a href="/docs/iam/api-ref/FederatedCredential/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 2000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "federatedCredentials": [
    {
      "id": "string",
      "serviceAccountId": "string",
      "federationId": "string",
      "externalSubjectId": "string",
      "createdAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
federatedCredentials[] | **object**<br><p>List of federated credentials.</p> 
federatedCredentials[].<br>id | **string**<br><p>Id of the federated credential.</p> 
federatedCredentials[].<br>serviceAccountId | **string**<br><p>Id of the service account that the federated credential belongs to.</p> 
federatedCredentials[].<br>federationId | **string**<br><p>ID of the workload identity federation which is used for authentication.</p> 
federatedCredentials[].<br>externalSubjectId | **string**<br><p>Id of the external subject.</p> 
federatedCredentials[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/iam/api-ref/FederatedCredential/list#query_params">pageSize</a>, use the <a href="/docs/iam/api-ref/FederatedCredential/list#responses">nextPageToken</a> as the value for the <a href="/docs/iam/api-ref/FederatedCredential/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/iam/api-ref/FederatedCredential/list#responses">nextPageToken</a> to continue paging through the results.</p> 