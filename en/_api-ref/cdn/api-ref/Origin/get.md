---
editable: false
---

# Method get
Get origin in origin group.
 

 
## HTTP request {#https-request}
```
GET https://cdn.api.cloud.yandex.net/cdn/v1/origins/{originId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
originId | [originId](/docs/cdn/api-ref/Origin/get#path_params) group ID to request origin from.  Value must be greater than 0.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. Origin's owner Folder ID.  The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "originGroupId": "string",
  "source": "string",
  "enabled": true,
  "backup": true,
  "meta": {

    // `meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`
    "common": {
      "name": "string"
    },
    "bucket": {
      "name": "string"
    },
    "website": {
      "name": "string"
    },
    "balancer": {
      "id": "string"
    },
    // end of the list of possible fields`meta`

  }
}
```
Origin object definition.
 
Field | Description
--- | ---
id | **string** (int64)<br><p>Origin unique ID.</p> 
originGroupId | **string** (int64)<br><p>Parent origin group ID.</p> 
source | **string**<br><p>Source: IP address or Domain name of your origin and the port (if custom).</p> 
enabled | **boolean** (boolean)<br><p>The setting allows to enable or disable an Origin source in the Origins group.</p> <p>It has two possible values:</p> <p>True - The origin is enabled and used as a source for the CDN. An origins group must contain at least one enabled origins. False - The origin is disabled and the CDN is not using it to pull content.</p> 
backup | **boolean** (boolean)<br><p>backup option has two possible values:</p> <p>True - The option is active. The origin will not be used until one of active origins become unavailable. False - The option is disabled.</p> 
meta | **object**<br>
meta.<br>common | **object** <br>`meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br><br>
meta.<br>common.<br>name | **string**<br>
meta.<br>bucket | **object** <br>`meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br><br>
meta.<br>bucket.<br>name | **string**<br>
meta.<br>website | **object** <br>`meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br><br>
meta.<br>website.<br>name | **string**<br>
meta.<br>balancer | **object** <br>`meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br><br>
meta.<br>balancer.<br>id | **string**<br>