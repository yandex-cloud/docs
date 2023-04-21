---
editable: false
sourcePath: en/_api-ref/cdn/api-ref/RawLogs/get.md
---

# Cloud CDN API, REST: RawLogs.get

 

 
## HTTP request {#https-request}
```
GET https://cdn.{{ api-host }}/cdn/v1/rawLogs/{resourceId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
resourceId | <p>Required. ID of CDN resource to request status and settings.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "status": "string",
  "settings": {
    "bucketName": "string",
    "bucketRegion": "string",
    "filePrefix": "string"
  }
}
```

 
Field | Description
--- | ---
status | **string**<br><p>Raw logs status.</p> <p>Provider side statuses of Raw logs processing.</p> <ul> <li>RAW_LOGS_STATUS_NOT_ACTIVATED: Raw logs wasn't activated.</li> <li>RAW_LOGS_STATUS_OK: Raw logs was activated, and logs storing process works as expected.</li> <li>RAW_LOGS_STATUS_FAILED: Raw logs was activated, but CDN provider has been failed to store logs.</li> <li>RAW_LOGS_STATUS_PENDING: Raw logs was activated, but logs storing process is expected.</li> </ul> 
settings | **object**<br><p>Raw logs settings.</p> <p>User settings for Raw logs.</p> 
settings.<br>bucketName | **string**<br><p>Required. Destination S3 bucket name, note that the suer should be owner of the bucket.</p> <p>The maximum string length in characters is 1024.</p> 
settings.<br>bucketRegion | **string**<br><p>Bucket region, unused for now, could be blank.</p> <p>The maximum string length in characters is 50.</p> 
settings.<br>filePrefix | **string**<br><p>file_prefix: prefix each log object name with specified prefix.</p> <p>The prefix makes it simpler for you to locate the log objects. For example, if you specify the prefix value logs/, each log object that S3 creates begins with the logs/ prefix in its key, so pseudo S3 folders could be setup.</p> <p>The maximum string length in characters is 50.</p> 