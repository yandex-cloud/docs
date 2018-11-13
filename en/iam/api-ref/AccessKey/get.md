# Method get
Returns the specified AccessKey resource.
 
To get the list of available AccessKey resources, make a [list](/docs/iam/api-ref/AccessKey/list) request.
 
## HTTP request {#https-request}
```
GET https://iam.api.cloud.yandex.net/iam/aws-compatibility/v1/accessKeys/{accessKeyId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
accessKeyId | Required. ID of the AccessKey resource to return. To get the access key ID, use a [list](/docs/iam/api-ref/AccessKey/list) request.  The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

An AccessKey resource.
For more information, see [Access Keys](/docs/iam/concepts/users/service-accounts#access-keys).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the AccessKey resource. It is used to manage secret credentials: an access key ID and a secret access key.</p> 
serviceAccountId | **string**<br><p>ID of the service account that the access key belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
description | **string**<br><p>Description of the access key. 0-256 characters long.</p> 
keyId | **string**<br><p>ID of the access key. The key is AWS compatible.</p> 