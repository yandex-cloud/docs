---
editable: false
---

# OriginGroup
Origin Groups management service.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "name": "string",
  "useNext": true,
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
id | **string** (int64)<br><p>ID of the origin group. Generated at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the origin group belongs to.</p> 
name | **string**<br><p>Name of the origin group.</p> 
useNext | **boolean** (boolean)<br><p>This option have two possible conditions: true - the option is active. In case the origin responds with 4XX or 5XX codes, use the next origin from the list. false - the option is disabled.</p> 
origins[] | **object**<br><p>List of origins.</p> 
origins[].<br>id | **string** (int64)<br><p>ID of the origin.</p> 
origins[].<br>originGroupId | **string** (int64)<br><p>ID of the parent origin group.</p> 
origins[].<br>source | **string**<br><p>IP address or Domain name of your origin and the port (if custom). Used if <a href="/docs/cdn/api-ref/Origin#representation">meta</a> variant is ``common``.</p> 
origins[].<br>enabled | **boolean** (boolean)<br><p>The setting allows to enable or disable an Origin source in the Origins group.</p> <p>It has two possible values:</p> <p>True - The origin is enabled and used as a source for the CDN. An origins group must contain at least one enabled origin. False - The origin is disabled and the CDN is not using it to pull content.</p> 
origins[].<br>backup | **boolean** (boolean)<br><p>Specifies whether the origin is used in its origin group as backup. A backup origin is used when one of active origins becomes unavailable.</p> 
origins[].<br>meta | **object**<br><p>Set up origin of the content.</p> <p>Origin type. For details about the concept, see <a href="/docs/cdn/concepts/origins">documentation</a>.</p> 
origins[].<br>meta.<br>common | **object** <br>`origins[].meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br><br><p>Origin info. For details about the concept, see <a href="/docs/cdn/concepts/origins">documentation</a>.</p> 
origins[].<br>meta.<br>common.<br>name | **string**<br><p>Name of the origin.</p> 
origins[].<br>meta.<br>bucket | **object**<br>A server with a domain name linked to it <br>`origins[].meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br>
origins[].<br>meta.<br>bucket.<br>name | **string**<br><p>Name of the origin.</p> 
origins[].<br>meta.<br>website | **object**<br>An Object Storage bucket not configured as a static site hosting. <br>`origins[].meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br>
origins[].<br>meta.<br>website.<br>name | **string**<br><p>Name of the origin.</p> 
origins[].<br>meta.<br>balancer | **object** <br>`origins[].meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br><br><p>Application Load Balancer origin info. For details about the concept, see <a href="/docs/cdn/concepts/origins">documentation</a>.</p> 
origins[].<br>meta.<br>balancer.<br>id | **string**<br><p>ID of the origin.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates origin group.
[delete](delete.md) | Deletes origin group with specified origin group id.
[get](get.md) | Gets origin group with specified origin group id.
[list](list.md) | Lists origins of origin group.
[update](update.md) | Updates the specified origin group.