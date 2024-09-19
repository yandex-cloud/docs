---
editable: false
sourcePath: en/_api-ref/cdn/v1/api-ref/OriginGroup/list.md
---

# Cloud CDN API, REST: OriginGroup.list
Lists origins of origin group.
 

 
## HTTP request {#https-request}
```
GET https://cdn.{{ api-host }}/cdn/v1/originGroups
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder that the origin group belongs to..</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/cdn/api-ref/OriginGroup/list#query_params">pageSize</a>, the service returns a <a href="/docs/cdn/api-ref/OriginGroup/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/cdn/api-ref/OriginGroup/list#query_params">pageToken</a> to the <a href="/docs/cdn/api-ref/OriginGroup/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "originGroups": [
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

            // `originGroups[].origins[].meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`
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
            // end of the list of possible fields`originGroups[].origins[].meta`

          }
        }
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
originGroups[] | **object**<br><p>List of all Origin Groups associated with folder.</p> 
originGroups[].<br>id | **string** (int64)<br><p>ID of the origin group. Generated at creation time.</p> 
originGroups[].<br>folderId | **string**<br><p>ID of the folder that the origin group belongs to.</p> 
originGroups[].<br>name | **string**<br><p>Name of the origin group.</p> 
originGroups[].<br>useNext | **boolean** (boolean)<br><p>This option have two possible conditions: true - the option is active. In case the origin responds with 4XX or 5XX codes, use the next origin from the list. false - the option is disabled.</p> 
originGroups[].<br>origins[] | **object**<br><p>List of origins.</p> 
originGroups[].<br>origins[].<br>id | **string** (int64)<br><p>ID of the origin.</p> 
originGroups[].<br>origins[].<br>originGroupId | **string** (int64)<br><p>ID of the parent origin group.</p> 
originGroups[].<br>origins[].<br>source | **string**<br><p>IP address or Domain name of your origin and the port (if custom). Used if <a href="/docs/cdn/api-ref/Origin#representation">meta</a> variant is ``common``.</p> 
originGroups[].<br>origins[].<br>enabled | **boolean** (boolean)<br><p>The setting allows to enable or disable an Origin source in the Origins group.</p> <p>It has two possible values:</p> <p>True - The origin is enabled and used as a source for the CDN. An origins group must contain at least one enabled origin. False - The origin is disabled and the CDN is not using it to pull content.</p> 
originGroups[].<br>origins[].<br>backup | **boolean** (boolean)<br><p>Specifies whether the origin is used in its origin group as backup. A backup origin is used when one of active origins becomes unavailable.</p> 
originGroups[].<br>origins[].<br>meta | **object**<br><p>Set up origin of the content.</p> <p>Origin type. For details about the concept, see <a href="/docs/cdn/concepts/origins">documentation</a>.</p> 
originGroups[].<br>origins[].<br>meta.<br>common | **object**<br>A server with a domain name linked to it <br>`originGroups[].origins[].meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br>
originGroups[].<br>origins[].<br>meta.<br>common.<br>name | **string**<br><p>Name of the origin.</p> 
originGroups[].<br>origins[].<br>meta.<br>bucket | **object**<br>An Object Storage bucket not configured as a static site hosting. <br>`originGroups[].origins[].meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br>
originGroups[].<br>origins[].<br>meta.<br>bucket.<br>name | **string**<br><p>Name of the origin.</p> 
originGroups[].<br>origins[].<br>meta.<br>website | **object**<br>An Object Storage bucket configured as a static site hosting. <br>`originGroups[].origins[].meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br>
originGroups[].<br>origins[].<br>meta.<br>website.<br>name | **string**<br><p>Name of the origin.</p> 
originGroups[].<br>origins[].<br>meta.<br>balancer | **object**<br>An L7 load balancer from Application Load Balancer. CDN servers will access the load balancer at one of its IP addresses that must be selected in the origin settings. <br>`originGroups[].origins[].meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br>
originGroups[].<br>origins[].<br>meta.<br>balancer.<br>id | **string**<br><p>ID of the origin.</p> 
nextPageToken | **string**<br><p><a href="/docs/cdn/api-ref/OriginGroup/list#responses">nextPageToken</a> token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/cdn/api-ref/OriginGroup/list#query_params">pageSize</a>, use the <a href="/docs/cdn/api-ref/OriginGroup/list#responses">nextPageToken</a> as the value for the <a href="/docs/cdn/api-ref/OriginGroup/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/cdn/api-ref/OriginGroup/list#responses">nextPageToken</a> to continue paging through the results.</p> 