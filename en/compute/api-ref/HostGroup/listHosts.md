---
editable: false
sourcePath: en/_api-ref/compute/v1/api-ref/HostGroup/listHosts.md
---

# Compute Cloud API, REST: HostGroup.listHosts
Lists hosts that belongs to the specified host group.
 

 
## HTTP request {#https-request}
```
GET https://compute.{{ api-host }}/compute/v1/hostGroups/{hostGroupId}/hosts
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
hostGroupId | <p>Required. ID of the host group to list hosts for. To get the host group ID, use <a href="/docs/compute/api-ref/HostGroup/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/compute/api-ref/HostGroup/listHosts#query_params">pageSize</a>, the service returns a <a href="/docs/compute/api-ref/HostGroup/listHosts#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/compute/api-ref/HostGroup/listHosts#query_params">pageToken</a> to the <a href="/docs/compute/api-ref/HostGroup/listHosts#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "hosts": [
    {
      "id": "string",
      "status": "string",
      "serverId": "string",
      "replacement": {
        "hostId": "string",
        "deadlineAt": "string"
      }
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
hosts[] | **object**<br><p>Lists hosts for the specified host group.</p> 
hosts[].<br>id | **string**<br><p>ID of the host.</p> 
hosts[].<br>status | **string**<br><p>Current status of the host. New instances are unable to start on host in DOWN status.</p> 
hosts[].<br>serverId | **string**<br><p>ID of the physical server that the host belongs to.</p> 
hosts[].<br>replacement | **object**<br><p>Set temporarily if maintenance is planned for this host, and a new host was provided as a replacement.</p> 
hosts[].<br>replacement.<br>hostId | **string**<br><p>ID of the host which replaces this one.</p> 
hosts[].<br>replacement.<br>deadlineAt | **string** (date-time)<br><p>The date and time when this host will be automatically freed of instances.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is more than <a href="/docs/compute/api-ref/HostGroup/listHosts#query_params">pageSize</a>, use <a href="/docs/compute/api-ref/HostGroup/listHosts#responses">nextPageToken</a> as the value for the <a href="/docs/compute/api-ref/HostGroup/listHosts#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/compute/api-ref/HostGroup/listHosts#responses">nextPageToken</a> to continue paging through the results.</p> 