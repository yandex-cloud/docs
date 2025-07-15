When accessing {{ speechkit-name }} via the API, provide the received parameters in each request: 

* For API v1 and API v2:

   Specify the IAM token in the `Authorization` header as follows:

   ```
   Authorization: Bearer <IAM_token>
   ```
  
   Specify the folder ID in the request body in the `folderId` parameter.

* For API v3:

   * Specify the IAM token in the `Authorization` header.
   * Specify the folder ID in the `x-folder-id` header.

   ```
   Authorization: Bearer <IAM_token> 
   x-folder-id: <folder_ID>
   ```