---
editable: false
---

# Method get
Returns the specified Image resource.
 
To get the list of available Image resources, make a [list](/docs/container-registry/api-ref/Image/list) request.
 
## HTTP request {#https-request}
```
GET https://container-registry.api.cloud.yandex.net/container-registry/v1/images/{imageId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
imageId | Required. ID of the Docker image resource to return.  To get the Docker image ID use a [list](/docs/container-registry/api-ref/Image/list) request.  The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "name": "string",
  "digest": "string",
  "compressedSize": "string",
  "config": {
    "id": "string",
    "digest": "string",
    "size": "string",
    "urls": [
      "string"
    ]
  },
  "layers": [
    {
      "id": "string",
      "digest": "string",
      "size": "string",
      "urls": [
        "string"
      ]
    }
  ],
  "tags": [
    "string"
  ],
  "createdAt": "string"
}
```
An Image resource. For more information, see [Docker image](/docs/cloud/container-registry/docker-image).
 
Field | Description
--- | ---
id | **string**<br><p>Output only. ID of the Docker image.</p> 
name | **string**<br><p>Name of the Docker image. The name is unique within the registry.</p> 
digest | **string**<br><p>Content-addressable identifier of the Docker image.</p> 
compressedSize | **string** (int64)<br><p>Compressed size of the Docker image, specified in bytes.</p> 
config | **object**<br><p>Configuration of the Docker image.</p> <p>A Blob resource.</p> 
config.<br>id | **string**<br><p>Output only. ID of the blob.</p> 
config.<br>digest | **string**<br><p>Content-addressable identifier of the blob.</p> 
config.<br>size | **string** (int64)<br><p>Size of the blob, specified in bytes.</p> 
config.<br>urls[] | **string**<br>
layers[] | **object**<br><p>A Blob resource.</p> 
layers[].<br>id | **string**<br><p>Output only. ID of the blob.</p> 
layers[].<br>digest | **string**<br><p>Content-addressable identifier of the blob.</p> 
layers[].<br>size | **string** (int64)<br><p>Size of the blob, specified in bytes.</p> 
layers[].<br>urls[] | **string**<br>
tags[] | **string**<br><p>Tags of the Docker image.</p> <p>Each tag is unique within the repository.</p> 
createdAt | **string** (date-time)<br><p>Output only. Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 