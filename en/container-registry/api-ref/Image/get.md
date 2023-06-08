---
editable: false
sourcePath: en/_api-ref/containerregistry/v1/api-ref/Image/get.md
---

# Container Registry API, REST: Image.get
Returns the specified Image resource.
 
To get the list of available Image resources, make a [list](/docs/container-registry/api-ref/Image/list) request.
 
## HTTP request {#https-request}
```
GET https://container-registry.{{ api-host }}/container-registry/v1/images/{imageId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
imageId | <p>Required. ID of the Docker image resource to return.</p> <p>To get the Docker image ID use a <a href="/docs/container-registry/api-ref/Image/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
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
An Image resource. For more information, see [Docker image](/docs/container-registry/concepts/docker-image).
 
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
config.<br>urls[] | **string**<br><p>List of blob urls.</p> 
layers[] | **object**<br><p>Layers of the Docker image.</p> 
layers[].<br>id | **string**<br><p>Output only. ID of the blob.</p> 
layers[].<br>digest | **string**<br><p>Content-addressable identifier of the blob.</p> 
layers[].<br>size | **string** (int64)<br><p>Size of the blob, specified in bytes.</p> 
layers[].<br>urls[] | **string**<br><p>List of blob urls.</p> 
tags[] | **string**<br><p>Tags of the Docker image.</p> <p>Each tag is unique within the repository.</p> 
createdAt | **string** (date-time)<br><p>Output only. Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 