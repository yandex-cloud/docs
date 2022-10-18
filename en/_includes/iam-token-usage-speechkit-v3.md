When accessing {{ speechkit-name }} via the API, pass the received parameters in each request:


* For API v1 and API v2:

   Specify the IAM token in the `Authorization` header in the following format:

   ```
   Authorization: Bearer <IAM token>
   ```

   Specify the folder ID in the request body in the `folderId` parameter.

* For API v3:

   * Specify the IAM token in the `Authorization` header.
   * Specify the folder ID in the `x-folder-id` header.

   ```
   Authorization: Bearer <IAM token> 
   x-folder-id <folder ID>
   ```
