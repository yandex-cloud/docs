---
editable: false
sourcePath: en/_api-ref/mdb/clickhouse/api-ref/MlModel/list.md
---

# Method list
Retrieves the list of machine learning models in the specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}/mlModels
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the cluster that models belongs to.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``page_size``, the service returns a <a href="/docs/managed-clickhouse/api-ref/MlModel/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/managed-clickhouse/api-ref/MlModel/list#responses">nextPageToken</a> returned by the previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "mlModels": [
    {
      "name": "string",
      "clusterId": "string",
      "type": "string",
      "uri": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
mlModels[] | **object**<br><p>List of models in the specified cluster.</p> 
mlModels[].<br>name | **string**<br><p>Name of the the model.</p> 
mlModels[].<br>clusterId | **string**<br><p>ID of the ClickHouse cluster that the model belongs to.</p> 
mlModels[].<br>type | **string**<br><p>Type of the model.</p> <ul> <li>ML_MODEL_TYPE_CATBOOST: CatBoost model.</li> </ul> 
mlModels[].<br>uri | **string**<br><p>Model file URL. You can only use models stored in Object Storage.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/managed-clickhouse/api-ref/MlModel/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/managed-clickhouse/api-ref/MlModel/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 