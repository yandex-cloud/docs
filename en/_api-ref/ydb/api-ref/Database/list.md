---
editable: false
---

# Method list
Retrieves a list of databases.
 

 
## HTTP request {#https-request}
```
GET https://ydb.api.cloud.yandex.net/ydb/v1/databases
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | 
pageSize | The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a `next_page_token` that can be used to get the next page of results in subsequent ListDatabases requests. Acceptable values are 0 to 1000, inclusive. Default value: 100.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. Set `page_token` to the `next_page_token` returned by a previous ListDatabases request to get the next page of results.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "databases": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "status": "string",
      "endpoint": "string",
      "resourcePresetId": "string",
      "storageConfig": {
        "storageOptions": [
          {
            "storageTypeId": "string",
            "groupCount": "string"
          }
        ]
      },
      "scalePolicy": {
        "fixedScale": {
          "size": "string"
        }
      },
      "networkId": "string",
      "subnetIds": [
        "string"
      ],

      // `databases[]` includes only one of the fields `zonalDatabase`, `regionalDatabase`
      "zonalDatabase": {
        "zoneId": "string"
      },
      "regionalDatabase": {
        "regionId": "string"
      },
      // end of the list of possible fields`databases[]`

    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
databases[] | **object**<br><p>YDB database.</p> 
databases[].<br>id | **string**<br>
databases[].<br>folderId | **string**<br>
databases[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
databases[].<br>name | **string**<br>
databases[].<br>description | **string**<br>
databases[].<br>status | **string**<br>
databases[].<br>endpoint | **string**<br>
databases[].<br>resourcePresetId | **string**<br>
databases[].<br>storageConfig | **object**<br>Required.<br>
databases[].<br>storageConfig.<br>storageOptions[] | **object**<br><p>Required. The minimum number of elements is 1.</p> 
databases[].<br>storageConfig.<br>storageOptions[].<br>storageTypeId | **string**<br>
databases[].<br>storageConfig.<br>storageOptions[].<br>groupCount | **string** (int64)<br>
databases[].<br>scalePolicy | **object**<br>Required.<br>
databases[].<br>scalePolicy.<br>fixedScale | **object**<br>
databases[].<br>scalePolicy.<br>fixedScale.<br>size | **string** (int64)<br><p>The minimum value is 1.</p> 
databases[].<br>networkId | **string**<br>
databases[].<br>subnetIds[] | **string**<br>
databases[].<br>zonalDatabase | **object** <br>`databases[]` includes only one of the fields `zonalDatabase`, `regionalDatabase`<br><br>
databases[].<br>zonalDatabase.<br>zoneId | **string**<br><p>Required.</p> 
databases[].<br>regionalDatabase | **object** <br>`databases[]` includes only one of the fields `zonalDatabase`, `regionalDatabase`<br><br>
databases[].<br>regionalDatabase.<br>regionId | **string**<br><p>Required.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for ListDatabases requests, if the number of results is larger than <code>page_size</code> specified in the request. To get the next page, specify the value of <code>next_page_token</code> as a value for the <code>page_token</code> parameter in the next ListDatabases request. Subsequent ListDatabases requests will have their own <code>next_page_token</code> to continue paging through the results.</p> 