---
editable: false
---

# Method get
Returns the specified machine learning model.
 
To get the list of all available models, make a [list](/docs/managed-clickhouse/api-ref/MlModel/list) request.
 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}/mlModels/{mlModelName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the cluster that the model belongs to.  The maximum string length in characters is 50.
mlModelName | Required. Name of the model to return.  To get a model name make a [list](/docs/managed-clickhouse/api-ref/MlModel/list) request.  The maximum string length in characters is 63. Value must match the regular expression `` [a-zA-Z0-9_-]* ``.
 
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
uri | **string**<br><p>Model file URL. You can only use models stored in Yandex Object Storage.</p> 