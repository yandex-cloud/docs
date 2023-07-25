---
editable: false
sourcePath: en/_api-ref/compute/v1/api-ref/DiskPlacementGroup/list.md
---

# Compute Cloud API, REST: DiskPlacementGroup.list
Retrieves the list of placement groups in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://compute.{{ api-host }}/compute/v1/diskPlacementGroups
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list placement groups in. To get the folder ID, use <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/compute/api-ref/DiskPlacementGroup/list#query_params">pageSize</a>, the service returns a <a href="/docs/compute/api-ref/DiskPlacementGroup/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/compute/api-ref/DiskPlacementGroup/list#query_params">pageToken</a> to the <a href="/docs/compute/api-ref/DiskPlacementGroup/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters resources listed in the response. The expression consists of one or more conditions united by ``AND`` operator: ``<condition1> [AND <condition2> [<...> AND <conditionN>]]``.</p> <p>Each condition has the form ``<field> <operator> <value>``, where:</p> <ol> <li>``<field>`` is the field name. Currently you can use filtering only on the limited number of fields.</li> <li>``<operator>`` is a logical operator, one of ``=``, ``!=``, ``IN``, ``NOT IN``.</li> <li>``<value>`` represents a value. String values should be written in double (``"``) or single (``'``) quotes. C-style escape sequences are supported (``\"`` turns to ``"``, ``\'`` to ``'``, ``\\`` to backslash).</li> </ol> <p>The maximum string length in characters is 1000.</p> 
orderBy | <p>By which column the listing should be ordered and in which direction, format is "createdAt desc". "id asc" if omitted. The default sorting order is ascending</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "diskPlacementGroups": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "zoneId": "string",
      "status": "string",

      // `diskPlacementGroups[]` includes only one of the fields `spreadPlacementStrategy`, `partitionPlacementStrategy`
      "spreadPlacementStrategy": {},
      "partitionPlacementStrategy": {
        "partitions": "string"
      },
      // end of the list of possible fields`diskPlacementGroups[]`

    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
diskPlacementGroups[] | **object**<br><p>Lists placement groups for the specified folder.</p> 
diskPlacementGroups[].<br>id | **string**<br><p>ID of the placement group.</p> 
diskPlacementGroups[].<br>folderId | **string**<br><p>ID of the folder that the placement group belongs to.</p> 
diskPlacementGroups[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
diskPlacementGroups[].<br>name | **string**<br><p>Name of the placement group. The name is unique within the folder.</p> 
diskPlacementGroups[].<br>description | **string**<br><p>Description of the placement group.</p> 
diskPlacementGroups[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> 
diskPlacementGroups[].<br>zoneId | **string**<br><p>ID of the availability zone where the placement group resides.</p> 
diskPlacementGroups[].<br>status | **string**<br>Current status of the placement group
diskPlacementGroups[].<br>spreadPlacementStrategy | **object**<br>Distribute disks over distinct failure domains. <br>`diskPlacementGroups[]` includes only one of the fields `spreadPlacementStrategy`, `partitionPlacementStrategy`<br>
diskPlacementGroups[].<br>partitionPlacementStrategy | **object**<br>Distribute disks over partitions. <br>`diskPlacementGroups[]` includes only one of the fields `spreadPlacementStrategy`, `partitionPlacementStrategy`<br>
diskPlacementGroups[].<br>partitionPlacementStrategy.<br>partitions | **string** (int64)
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/compute/api-ref/DiskPlacementGroup/list#query_params">pageSize</a>, use <a href="/docs/compute/api-ref/DiskPlacementGroup/list#responses">nextPageToken</a> as the value for the <a href="/docs/compute/api-ref/DiskPlacementGroup/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/compute/api-ref/DiskPlacementGroup/list#responses">nextPageToken</a> to continue paging through the results.</p> 