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
id | **string** (int64)<br><p>Origin Group ID.</p> 
folderId | **string**<br><p>Origin Folder ID.</p> 
name | **string**<br><p>Origin Group Name.</p> 
useNext | **boolean** (boolean)<br><p>use_next. This option have two possible conditions: true - the option is active. In case the origin responds with 4XX or 5XX codes, use the next origin from the list. false - the option is disabled.</p> 
origins[] | **object**<br><p>Origin object definition.</p> 
origins[].<br>id | **string** (int64)<br><p>Origin unique ID.</p> 
origins[].<br>originGroupId | **string** (int64)<br><p>Parent origin group ID.</p> 
origins[].<br>source | **string**<br><p>Source: IP address or Domain name of your origin and the port (if custom).</p> 
origins[].<br>enabled | **boolean** (boolean)<br><p>The setting allows to enable or disable an Origin source in the Origins group.</p> <p>It has two possible values:</p> <p>True - The origin is enabled and used as a source for the CDN. An origins group must contain at least one enabled origins. False - The origin is disabled and the CDN is not using it to pull content.</p> 
origins[].<br>backup | **boolean** (boolean)<br><p>backup option has two possible values:</p> <p>True - The option is active. The origin will not be used until one of active origins become unavailable. False - The option is disabled.</p> 
origins[].<br>meta | **object**<br>
origins[].<br>meta.<br>common | **object** <br>`origins[].meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br><br>
origins[].<br>meta.<br>common.<br>name | **string**<br>
origins[].<br>meta.<br>bucket | **object** <br>`origins[].meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br><br>
origins[].<br>meta.<br>bucket.<br>name | **string**<br>
origins[].<br>meta.<br>website | **object** <br>`origins[].meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br><br>
origins[].<br>meta.<br>website.<br>name | **string**<br>
origins[].<br>meta.<br>balancer | **object** <br>`origins[].meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br><br>
origins[].<br>meta.<br>balancer.<br>id | **string**<br>

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Create clients origin group.
[delete](delete.md) | Delete origin group with specified origin group id.
[get](get.md) | Get origin group with specified origin group id.
[list](list.md) | List clients origin groups.
[update](update.md) | Update clients origin group.