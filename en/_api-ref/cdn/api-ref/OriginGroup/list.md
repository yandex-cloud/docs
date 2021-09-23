---
editable: false
---

# Method list
List clients origin groups.
 

 
## HTTP request {#https-request}
```
GET https://cdn.api.cloud.yandex.net/cdn/v1/origin_groups
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. Origin group owner's Folder ID.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/cdn/api-ref/OriginGroup/list#query_params), the service returns a [nextPageToken](/docs/cdn/api-ref/OriginGroup/list#responses) that can be used to get the next page of results in subsequent list requests.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/cdn/api-ref/OriginGroup/list#query_params) to the [nextPageToken](/docs/cdn/api-ref/OriginGroup/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
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
originGroups[].<br>id | **string** (int64)<br><p>Origin Group ID.</p> 
originGroups[].<br>folderId | **string**<br><p>Origin Folder ID.</p> 
originGroups[].<br>name | **string**<br><p>Origin Group Name.</p> 
originGroups[].<br>useNext | **boolean** (boolean)<br><p>use_next. This option have two possible conditions: true - the option is active. In case the origin responds with 4XX or 5XX codes, use the next origin from the list. false - the option is disabled.</p> 
originGroups[].<br>origins[] | **object**<br><p>Origin object definition.</p> 
originGroups[].<br>origins[].<br>id | **string** (int64)<br><p>Origin unique ID.</p> 
originGroups[].<br>origins[].<br>originGroupId | **string** (int64)<br><p>Parent origin group ID.</p> 
originGroups[].<br>origins[].<br>source | **string**<br><p>Source: IP address or Domain name of your origin and the port (if custom).</p> 
originGroups[].<br>origins[].<br>enabled | **boolean** (boolean)<br><p>The setting allows to enable or disable an Origin source in the Origins group.</p> <p>It has two possible values:</p> <p>True - The origin is enabled and used as a source for the CDN. An origins group must contain at least one enabled origins. False - The origin is disabled and the CDN is not using it to pull content.</p> 
originGroups[].<br>origins[].<br>backup | **boolean** (boolean)<br><p>backup option has two possible values:</p> <p>True - The option is active. The origin will not be used until one of active origins become unavailable. False - The option is disabled.</p> 
originGroups[].<br>origins[].<br>meta | **object**<br>
originGroups[].<br>origins[].<br>meta.<br>common | **object** <br>`originGroups[].origins[].meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br><br>
originGroups[].<br>origins[].<br>meta.<br>common.<br>name | **string**<br>
originGroups[].<br>origins[].<br>meta.<br>bucket | **object** <br>`originGroups[].origins[].meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br><br>
originGroups[].<br>origins[].<br>meta.<br>bucket.<br>name | **string**<br>
originGroups[].<br>origins[].<br>meta.<br>website | **object** <br>`originGroups[].origins[].meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br><br>
originGroups[].<br>origins[].<br>meta.<br>website.<br>name | **string**<br>
originGroups[].<br>origins[].<br>meta.<br>balancer | **object** <br>`originGroups[].origins[].meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br><br>
originGroups[].<br>origins[].<br>meta.<br>balancer.<br>id | **string**<br>
nextPageToken | **string**<br><p><a href="/docs/cdn/api-ref/OriginGroup/list#responses">nextPageToken</a> token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/cdn/api-ref/OriginGroup/list#query_params">pageSize</a>, use the <a href="/docs/cdn/api-ref/OriginGroup/list#responses">nextPageToken</a> as the value for the <a href="/docs/cdn/api-ref/OriginGroup/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/cdn/api-ref/OriginGroup/list#responses">nextPageToken</a> to continue paging through the results.</p> 