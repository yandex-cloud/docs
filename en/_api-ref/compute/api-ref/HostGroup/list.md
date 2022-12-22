---
editable: false
---

# Compute Cloud API, REST: HostGroup.list
Retrieves the list of host groups in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://compute.{{ api-host }}/compute/v1/hostGroups
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list host groups in. To get the folder ID, use <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/compute/api-ref/HostGroup/list#query_params">pageSize</a>, the service returns a <a href="/docs/compute/api-ref/HostGroup/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/compute/api-ref/HostGroup/list#query_params">pageToken</a> to the <a href="/docs/compute/api-ref/HostGroup/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters resources listed in the response. Currently you can use filtering only on the <a href="/docs/compute/api-ref/HostGroup#representation">HostGroup.name</a> field.</p> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "hostGroups": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "zoneId": "string",
      "status": "string",
      "typeId": "string",
      "maintenancePolicy": "string",
      "scalePolicy": {
        "fixedScale": {
          "size": "string"
        }
      }
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
hostGroups[] | **object**<br><p>Lists host groups for the specified folder.</p> 
hostGroups[].<br>id | **string**<br><p>ID of the group.</p> 
hostGroups[].<br>folderId | **string**<br><p>ID of the folder that the group belongs to.</p> 
hostGroups[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
hostGroups[].<br>name | **string**<br><p>Name of the group. The name is unique within the folder.</p> 
hostGroups[].<br>description | **string**<br><p>Description of the group.</p> 
hostGroups[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> 
hostGroups[].<br>zoneId | **string**<br><p>Availability zone where all dedicated hosts are allocated.</p> 
hostGroups[].<br>status | **string**<br><p>Status of the group.</p> 
hostGroups[].<br>typeId | **string**<br><p>ID of host type. Resources provided by each host of the group.</p> 
hostGroups[].<br>maintenancePolicy | **string**<br><p>Behaviour on maintenance events.</p> <ul> <li>RESTART: Restart instances on the same host after maintenance event.</li> <li>MIGRATE: Migrate instances to another host before maintenance event.</li> </ul> 
hostGroups[].<br>scalePolicy | **object**<br><p>Scale policy. Only fixed number of hosts are supported at this moment.</p> 
hostGroups[].<br>scalePolicy.<br>fixedScale | **object**
hostGroups[].<br>scalePolicy.<br>fixedScale.<br>size | **string** (int64)
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/compute/api-ref/HostGroup/list#query_params">pageSize</a>, use <a href="/docs/compute/api-ref/HostGroup/list#responses">nextPageToken</a> as the value for the <a href="/docs/compute/api-ref/HostGroup/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/compute/api-ref/HostGroup/list#responses">nextPageToken</a> to continue paging through the results.</p> 