# Method delete
Deletes the specified access key.
 

 
## HTTP request {#https-request}
`DELETE https://iam.api.cloud.yandex.net/iam/aws-compatibility/v1/accessKeys/{accessKeyId}`
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
accessKeyId | Required. ID of the access key to delete. To get the access key ID, use a [list](/docs/iam/api-ref/AccessKey/list) request.  The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

Empty JSON object `` {} ``.
 
Field | Description
--- | ---
 | **object**<br><p>Empty JSON object <code>{}</code>.</p> 