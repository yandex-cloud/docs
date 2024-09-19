---
editable: false
sourcePath: en/_api-ref/cdn/v1/api-ref/Origin/list.md
---

# Cloud CDN API, REST: Origin.list
Lists origins of origin group.
 

 
## HTTP request {#https-request}
```
GET https://cdn.{{ api-host }}/cdn/v1/origins
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder that the origin belongs to.</p> <p>The maximum string length in characters is 50.</p> 
originGroupId | <p>ID of the group to request origins from.</p> <p>Value must be greater than 0.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "origins": [
    {
      "id": "string",
      "originGroupId": "string",
      "source": "string",
      "enabled": true,
      "backup": true,
      "meta": {

        // `origins[].meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`
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
        // end of the list of possible fields`origins[].meta`

      }
    }
  ]
}
```

 
Field | Description
--- | ---
origins[] | **object**<br><p>Origin from response.</p> 
origins[].<br>id | **string** (int64)<br><p>ID of the origin.</p> 
origins[].<br>originGroupId | **string** (int64)<br><p>ID of the parent origin group.</p> 
origins[].<br>source | **string**<br><p>IP address or Domain name of your origin and the port (if custom). Used if <a href="/docs/cdn/api-ref/Origin#representation">meta</a> variant is ``common``.</p> 
origins[].<br>enabled | **boolean** (boolean)<br><p>The setting allows to enable or disable an Origin source in the Origins group.</p> <p>It has two possible values:</p> <p>True - The origin is enabled and used as a source for the CDN. An origins group must contain at least one enabled origin. False - The origin is disabled and the CDN is not using it to pull content.</p> 
origins[].<br>backup | **boolean** (boolean)<br><p>Specifies whether the origin is used in its origin group as backup. A backup origin is used when one of active origins becomes unavailable.</p> 
origins[].<br>meta | **object**<br><p>Set up origin of the content.</p> <p>Origin type. For details about the concept, see <a href="/docs/cdn/concepts/origins">documentation</a>.</p> 
origins[].<br>meta.<br>common | **object**<br>A server with a domain name linked to it <br>`origins[].meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br>
origins[].<br>meta.<br>common.<br>name | **string**<br><p>Name of the origin.</p> 
origins[].<br>meta.<br>bucket | **object**<br>An Object Storage bucket not configured as a static site hosting. <br>`origins[].meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br>
origins[].<br>meta.<br>bucket.<br>name | **string**<br><p>Name of the origin.</p> 
origins[].<br>meta.<br>website | **object**<br>An Object Storage bucket configured as a static site hosting. <br>`origins[].meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br>
origins[].<br>meta.<br>website.<br>name | **string**<br><p>Name of the origin.</p> 
origins[].<br>meta.<br>balancer | **object**<br>An L7 load balancer from Application Load Balancer. CDN servers will access the load balancer at one of its IP addresses that must be selected in the origin settings. <br>`origins[].meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br>
origins[].<br>meta.<br>balancer.<br>id | **string**<br><p>ID of the origin.</p> 