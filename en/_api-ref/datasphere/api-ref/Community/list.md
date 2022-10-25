---
editable: false
---

# Method list
List communities in specified organization.
 

 
## HTTP request {#https-request}
```
GET https://datasphere.{{ api-host }}/datasphere/v2/communities
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/datasphere/api-ref/Community/list#query_params">pageSize</a>, the service returns a <a href="/docs/datasphere/api-ref/Community/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/datasphere/api-ref/Community/list#query_params">pageToken</a> to the <a href="/docs/datasphere/api-ref/Community/list#responses">nextPageToken</a> returned by a previous list request.</p> 
nameOrDescriptionPattern | <p>Community name or description pattern. Only communities with names or descriptions matching specified pattern will be returned.</p> 
ownedById | <p>ID of the user. Only communities owned by specified user will be returned.</p> 
listPublic | <p>If set to true, only public communities will be returned.</p> 
organizationId | <p>Required. ID of the organization to list communities in.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "communities": [
    {
      "id": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "createdById": "string",
      "accessType": "string",
      "isPersonal": true,
      "channel": {
        "link": "string",
        "type": "string"
      },
      "organizationId": "string",
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
communities[] | **object**<br><p>List of communities matching filters in list communities request.</p> 
communities[].<br>id | **string**<br><p>ID of the community.</p> 
communities[].<br>createdAt | **string** (date-time)<br><p>Time when community was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
communities[].<br>name | **string**<br><p>Name of the community.</p> 
communities[].<br>description | **string**<br><p>Description of the comminuty.</p> 
communities[].<br>labels | **object**<br><p>Labels of the community.</p> 
communities[].<br>createdById | **string**<br><p>ID of the user who created the community.</p> 
communities[].<br>accessType | **string**<br><p>Community access type.</p> <p>Community access type.</p> <ul> <li>PUBLIC: Public community.</li> <li>PRIVATE: Private community.</li> </ul> 
communities[].<br>isPersonal | **boolean** (boolean)
communities[].<br>channel | **object**<br><p>Communication channel for the community.</p> 
communities[].<br>channel.<br>link | **string**<br><p>Link to communication channel.</p> 
communities[].<br>channel.<br>type | **string**<br><p>Type of communication channel.</p> 
communities[].<br>organizationId | **string**<br><p>ID of the organization to which community belongs.</p> 
communities[].<br>status | **string**<br><p>Community status.</p> <ul> <li>ACTIVE: Active community.</li> <li>BLOCKED_BY_BILLING: Community blocked by billing.</li> </ul> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/datasphere/api-ref/Community/list#query_params">pageSize</a>, use the <a href="/docs/datasphere/api-ref/Community/list#responses">nextPageToken</a> as the value for the <a href="/docs/datasphere/api-ref/Community/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/datasphere/api-ref/Community/list#responses">nextPageToken</a> to continue paging through the results.</p> 