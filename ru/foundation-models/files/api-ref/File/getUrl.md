---
editable: false
sourcePath: en/_api-ref/ai/files/v1/files/api-ref/File/getUrl.md
---

# Files API, REST: File.GetUrl

Retrieve a URL for accessing or downloading a specific file.

## HTTP request

```
GET https://rest-assistant.{{ api-host }}/files/v1/files:getUrl
```

## Query parameters {#yandex.cloud.ai.files.v1.GetFileUrlRequest}

Request message for retrieving the URL of a specific file.

#|
||Field | Description ||
|| fileId | **string**

Required field. ID of the file which the URL is requested. ||
|#

## Response {#yandex.cloud.ai.files.v1.GetFileUrlResponse}

**HTTP Code: 200 - OK**

```json
{
  "url": "string"
}
```

Response message containing the URL to access the requested file.

#|
||Field | Description ||
|| url | **string**

URL that can be used to access or download the file. ||
|#