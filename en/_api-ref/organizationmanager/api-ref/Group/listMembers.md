---
editable: false
---

# Method listMembers
List group active members.
 

 
## HTTP request {#https-request}
```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/groups/{groupId}:listMembers
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
groupId | <p>Required. ID of the Group resource to list members for.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/organization/api-ref/Group/listMembers#query_params">pageSize</a>, the service returns a <a href="/docs/organization/api-ref/Group/listMembers#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive. Default value: 100.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. Set <a href="/docs/organization/api-ref/Group/listMembers#query_params">pageToken</a> to the <a href="/docs/organization/api-ref/Group/listMembers#responses">nextPageToken</a> returned by a previous list request to get the next page of results.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "members": [
    {
      "subjectId": "string",
      "subjectType": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
members[] | **object**<br><p>List of members for the specified group.</p> 
members[].<br>subjectId | **string**<br><p>ID of the subject.</p> 
members[].<br>subjectType | **string**<br><p>Type of the subject.</p> <p>It can contain one of the following values:</p> <ul> <li>``userAccount``: An account on Yandex, added to Yandex Cloud.</li> <li>``federatedUser``: A federated account. This type represents a user from an identity federation, like Active Directory.</li> </ul> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/organization/api-ref/Group/listMembers#query_params">pageSize</a>, use the <a href="/docs/organization/api-ref/Group/listMembers#responses">nextPageToken</a> as the value for the <a href="/docs/organization/api-ref/Group/listMembers#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/organization/api-ref/Group/listMembers#responses">nextPageToken</a> to continue paging through the results.</p> 