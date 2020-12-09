---
editable: false
---

# Method list
Retrieves the list of certificates in the specified federation.
 

 
## HTTP request {#https-request}
```
GET https://iam.api.cloud.yandex.net/iam/v1/saml/certificates
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
federationId | Required. ID of the federation to list certificates in. To get the federation ID make a [list](/docs/iam/api-ref/Federation/list) request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/iam/api-ref/Certificate/list#query_params), the service returns a [nextPageToken](/docs/iam/api-ref/Certificate/list#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/iam/api-ref/Certificate/list#query_params) to the [nextPageToken](/docs/iam/api-ref/Certificate/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently you can use filtering only on [Certificate.name](/docs/iam/api-ref/Certificate#representation) field. 2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`.  The maximum string length in characters is 1000.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "certificates": [
    {
      "id": "string",
      "federationId": "string",
      "name": "string",
      "description": "string",
      "createdAt": "string",
      "data": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
certificates[] | **object**<br><p>A certificate.</p> 
certificates[].<br>id | **string**<br><p>Required. ID of the certificate.</p> <p>The maximum string length in characters is 50.</p> 
certificates[].<br>federationId | **string**<br><p>Required. ID of the federation that the certificate belongs to.</p> <p>The maximum string length in characters is 50.</p> 
certificates[].<br>name | **string**<br><p>Name of the certificate.</p> <p>Value must match the regular expression `` \|[a-z][-a-z0-9]{1,61}[a-z0-9] ``.</p> 
certificates[].<br>description | **string**<br><p>Description of the certificate.</p> <p>The maximum string length in characters is 256.</p> 
certificates[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
certificates[].<br>data | **string**<br><p>Required. Certificate data in PEM format.</p> <p>The maximum string length in characters is 32000.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/iam/api-ref/Certificate/list#query_params">pageSize</a>, use the <a href="/docs/iam/api-ref/Certificate/list#responses">nextPageToken</a> as the value for the <a href="/docs/iam/api-ref/Certificate/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/iam/api-ref/Certificate/list#responses">nextPageToken</a> to continue paging through the results.</p> 