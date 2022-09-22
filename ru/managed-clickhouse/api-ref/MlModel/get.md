---
editable: false
sourcePath: en/_api-ref/mdb/clickhouse/api-ref/MlModel/get.md
---

# Method get
Returns the specified machine learning model.
 
To get the list of all available models, make a [list](/docs/managed-clickhouse/api-ref/MlModel/list) request.
 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}/mlModels/{mlModelName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the cluster that the model belongs to.</p> <p>The maximum string length in characters is 50.</p> 
mlModelName | <p>Required. Name of the model to return.</p> <p>To get a model name make a <a href="/docs/managed-clickhouse/api-ref/MlModel/list">list</a> request.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
  "clusterId": "string",
  "type": "string",
  "uri": "string"
}
```

 
Field | Description
--- | ---
name | **string**<br><p>Name of the the model.</p> 
clusterId | **string**<br><p>ID of the ClickHouse cluster that the model belongs to.</p> 
type | **string**<br><p>Type of the model.</p> <ul> <li>ML_MODEL_TYPE_CATBOOST: CatBoost model.</li> </ul> 
uri | **string**<br><p>Model file URL. You can only use models stored in Object Storage.</p> 