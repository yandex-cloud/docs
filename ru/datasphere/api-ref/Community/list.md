---
editable: false
sourcePath: en/_api-ref/datasphere/v2/api-ref/Community/list.md
---

# DataSphere API v2, REST: Community.list
List communities in specified organization.
 

 
## HTTP request {#https-request}
```
GET https://datasphere.{{ api-host }}/datasphere/v2/communities
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/datasphere/api-ref/v2/Community/list#query_params">pageSize</a>, the service returns a <a href="/docs/datasphere/api-ref/v2/Community/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/datasphere/api-ref/v2/Community/list#query_params">pageToken</a> to the <a href="/docs/datasphere/api-ref/v2/Community/list#responses">nextPageToken</a> returned by a previous list request.</p> 
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
      "organizationId": "string",
      "zoneId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
communities[] | **object**<br><p>List of communities matching filters in list communities request.</p> 
communities[].<br>id | **string**<br><p>ID of the community.</p> 
communities[].<br>createdAt | **string** (date-time)<br><p>Time when community was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
communities[].<br>name | **string**<br><p>Name of the community.</p> 
communities[].<br>description | **string**<br><p>Description of the comminuty.</p> 
communities[].<br>labels | **object**<br><p>Labels of the community.</p> 
communities[].<br>createdById | **string**<br><p>ID of the user who created the community.</p> 
communities[].<br>organizationId | **string**<br><p>ID of the organization to which community belongs.</p> 
communities[].<br>zoneId | **string**<br><p>ID of the zone where this community was created</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/datasphere/api-ref/v2/Community/list#query_params">pageSize</a>, use the <a href="/docs/datasphere/api-ref/v2/Community/list#responses">nextPageToken</a> as the value for the <a href="/docs/datasphere/api-ref/v2/Community/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/datasphere/api-ref/v2/Community/list#responses">nextPageToken</a> to continue paging through the results.</p> 