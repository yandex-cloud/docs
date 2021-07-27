---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---


# Method list
Retrieves the list of availability zones.
 

 
## HTTP request {#https-request}
```
GET https://compute.api.cloud.yandex.net/compute/v1/zones
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/compute/api-ref/Zone/list#query_params), the service returns a [nextPageToken](/docs/compute/api-ref/Zone/list#responses) that can be used to get the next page of results in subsequent list requests.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/compute/api-ref/Zone/list#query_params) to the [nextPageToken](/docs/compute/api-ref/Zone/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "zones": [
    {
      "id": "string",
      "regionId": "string",
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
zones[] | **object**<br><p>Availability zone. For more information, see <a href="/docs/overview/concepts/geo-scope">Availability zones</a>.</p> 
zones[].<br>id | **string**<br><p>ID of the zone.</p> 
zones[].<br>regionId | **string**<br><p>ID of the region.</p> 
zones[].<br>status | **string**<br><p>Status of the zone.</p> <ul> <li>UP: Zone is available. You can access the resources allocated in this zone.</li> <li>DOWN: Zone is not available.</li> </ul> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/compute/api-ref/Zone/list#query_params">pageSize</a>, use the <a href="/docs/compute/api-ref/Zone/list#query_params">pageToken</a> as the value for the <a href="/docs/compute/api-ref/Zone/list#query_params">pageToken</a> query parameter in the next list request. Subsequent list requests will have their own <a href="/docs/compute/api-ref/Zone/list#query_params">pageToken</a> to continue paging through the results.</p> 