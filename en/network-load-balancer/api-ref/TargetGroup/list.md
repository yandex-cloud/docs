---
editable: false
sourcePath: en/_api-ref/loadbalancer/v1/api-ref/TargetGroup/list.md
---

# Network Load Balancer API, REST: TargetGroup.list
Retrieves the list of TargetGroup resources in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://load-balancer.{{ api-host }}/load-balancer/v1/targetGroups
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list target groups in. To get the folder ID, use a <a href="/docs/network-load-balancer/api-ref/TargetGroup/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/network-load-balancer/api-ref/TargetGroup/list#query_params">pageSize</a>, the service returns a <a href="/docs/network-load-balancer/api-ref/TargetGroup/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/network-load-balancer/api-ref/TargetGroup/list#query_params">pageToken</a> to the <a href="/docs/network-load-balancer/api-ref/TargetGroup/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters resources listed in the response. The expression must specify:</p> <ol> <li>The field name. Currently you can only filter by the <a href="/docs/network-load-balancer/api-ref/TargetGroup#representation">TargetGroup.name</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "targetGroups": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "regionId": "string",
      "targets": [
        {
          "subnetId": "string",
          "address": "string"
        }
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
targetGroups[] | **object**<br><p>List of TargetGroup resources.</p> 
targetGroups[].<br>id | **string**<br><p>Output only. ID of the target group.</p> 
targetGroups[].<br>folderId | **string**<br><p>ID of the folder that the target group belongs to.</p> 
targetGroups[].<br>createdAt | **string** (date-time)<br><p>Output only. Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
targetGroups[].<br>name | **string**<br><p>Name of the target group. The name is unique within the folder. 3-63 characters long.</p> 
targetGroups[].<br>description | **string**<br><p>Description of the target group. 0-256 characters long.</p> 
targetGroups[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
targetGroups[].<br>regionId | **string**<br><p>ID of the region where the target group resides.</p> 
targetGroups[].<br>targets[] | **object**<br><p>A list of targets in the target group.</p> 
targetGroups[].<br>targets[].<br>subnetId | **string**<br><p>ID of the subnet that targets are connected to. All targets in the target group must be connected to the same subnet within a single availability zone.</p> <p>The maximum string length in characters is 50.</p> 
targetGroups[].<br>targets[].<br>address | **string**<br><p>IP address of the target.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/network-load-balancer/api-ref/TargetGroup/list#query_params">pageSize</a>, use the <a href="/docs/network-load-balancer/api-ref/TargetGroup/list#responses">nextPageToken</a> as the value for the <a href="/docs/network-load-balancer/api-ref/TargetGroup/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/network-load-balancer/api-ref/TargetGroup/list#responses">nextPageToken</a> to continue paging through the results.</p> 