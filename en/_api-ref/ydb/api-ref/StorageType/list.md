---
editable: false
---

# Method list
Returns the list of available storage types.
 

 
## HTTP request {#https-request}
```
GET https://ydb.api.cloud.yandex.net/ydb/v1/storageTypes
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a `next_page_token` that can be used to get the next page of results in subsequent ListStorageTypes requests. Acceptable values are 0 to 1000, inclusive. Default value: 100.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. Set `page_token` to the `next_page_token` returned by a previous ListStorageTypes request to get the next page of results.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "storageTypes": [
    {
      "id": "string",
      "deviceType": "string",
      "redundancyType": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
storageTypes[] | **object**<br><p>Requested list of storage types.</p> 
storageTypes[].<br>id | **string**<br>
storageTypes[].<br>deviceType | **string**<br>
storageTypes[].<br>redundancyType | **string**<br>
nextPageToken | **string**<br><p>This token allows you to get the next page of results for ListStorageTypes requests, if the number of results is larger than `page_size` specified in the request. To get the next page, specify the value of `next_page_token` as a value for the `page_token` parameter in the next ListStorageTypes request. Subsequent ListStorageTypes requests will have their own `next_page_token` to continue paging through the results.</p> 