---
editable: false
---

# Managed Service for Elasticsearch API, REST: Cluster.listBackups
Returns the list of available backups for the specified Elasticsearch cluster.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-elasticsearch/v1/clusters/{clusterId}/backups
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. Required. ID of the Elasticsearch cluster.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page that should be returned. If the number of available results is larger than ``page_size``, the service returns a ``next_page_token`` that can be used to get the next page of results in subsequent ListClusterBackups requests. Acceptable values are 0 to 1000, inclusive. Default value: 100.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. Set ``page_token`` to the ``next_page_token`` returned by a previous ListClusterBackups request to get the next page of results.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "backups": [
    {
      "id": "string",
      "folderId": "string",
      "sourceClusterId": "string",
      "startedAt": "string",
      "createdAt": "string",
      "indices": [
        "string"
      ],
      "elasticsearchVersion": "string",
      "sizeBytes": "string",
      "indicesTotal": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
backups[] | **object**<br><p>Requested list of backups.</p> 
backups[].<br>id | **string**<br><p>Required. ID of the backup.</p> 
backups[].<br>folderId | **string**<br><p>ID of the folder that the backup belongs to.</p> 
backups[].<br>sourceClusterId | **string**<br><p>ID of the associated Elasticsearch cluster.</p> 
backups[].<br>startedAt | **string** (date-time)<br><p>The time when the backup operation was started.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
backups[].<br>createdAt | **string** (date-time)<br><p>The time when the backup was created (i.e. when the backup operation completed).</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
backups[].<br>indices[] | **string**<br><p>Indices names. (max 100)</p> <p>The maximum number of elements is 100.</p> 
backups[].<br>elasticsearchVersion | **string**<br><p>Elasticsearch version used to create the snapshot</p> 
backups[].<br>sizeBytes | **string** (int64)<br><p>Total size of all indices in backup. in bytes</p> 
backups[].<br>indicesTotal | **string** (int64)<br><p>Total count of indices in backup</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for ListClusterBackups requests, if the number of results is larger than ``page_size`` specified in the request. To get the next page, specify the value of ``next_page_token`` as a value for the ``page_token`` parameter in the next ListClusterBackups request. Subsequent ListClusterBackups requests will have their own ``next_page_token`` to continue paging through the results.</p> 