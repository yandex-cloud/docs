---
editable: false
sourcePath: en/_api-ref/apploadbalancer/api-ref/TargetGroup/list.md
---

# Method list
Lists target groups in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://alb.{{ api-host }}/apploadbalancer/v1/targetGroups
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list target groups in.</p> <p>To get the folder ID, make a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``page_size``, the service returns a <a href="/docs/application-load-balancer/api-ref/TargetGroup/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/application-load-balancer/api-ref/TargetGroup/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters target groups listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering only on <a href="/docs/application-load-balancer/api-ref/TargetGroup#representation">TargetGroup.name</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``. Example of a filter: ``name=my-target-group``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "targetGroups": [
    {
      "id": "string",
      "name": "string",
      "description": "string",
      "folderId": "string",
      "labels": "object",
      "targets": [
        {
          "subnetId": "string",
          "privateIpv4Address": true,
          "ipAddress": "string"
        }
      ],
      "createdAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
targetGroups[] | **object**<br><p>List of target groups in the specified folder.</p> 
targetGroups[].<br>id | **string**<br><p>ID of the target group. Generated at creation time.</p> 
targetGroups[].<br>name | **string**<br><p>Name of the target group. The name is unique within the folder.</p> 
targetGroups[].<br>description | **string**<br><p>Description of the target group.</p> 
targetGroups[].<br>folderId | **string**<br><p>ID of the folder that the target group belongs to.</p> 
targetGroups[].<br>labels | **object**<br><p>Target group labels as ``key:value`` pairs. For details about the concept, see <a href="/docs/overview/concepts/services#labels">documentation</a>.</p> 
targetGroups[].<br>targets[] | **object**<br><p>List of targets in the target group.</p> 
targetGroups[].<br>targets[].<br>subnetId | **string**<br><p>ID of the subnet that the target is connected to.</p> 
targetGroups[].<br>targets[].<br>privateIpv4Address | **boolean** (boolean)<br><p>If set, will not require ``subnet_id`` to validate the target. Instead, the address should belong to one of the following ranges: 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 Only one of ``subnet_id`` or ``private_ipv4_address`` should be set.</p> 
targetGroups[].<br>targets[].<br>ipAddress | **string**<br><p>IP address of the target.</p> 
targetGroups[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/application-load-balancer/api-ref/TargetGroup/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/application-load-balancer/api-ref/TargetGroup/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 