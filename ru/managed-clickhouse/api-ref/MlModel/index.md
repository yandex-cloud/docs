---
editable: false
sourcePath: en/_api-ref/mdb/clickhouse/v1/api-ref/MlModel/index.md
---

# Managed Service for ClickHouse API, REST: MlModel methods
A set of methods for managing machine learning models.
## JSON Representation {#representation}
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

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a machine learning model in the specified cluster.
[delete](delete.md) | Deletes the specified machine learning model.
[get](get.md) | Returns the specified machine learning model.
[list](list.md) | Retrieves the list of machine learning models in the specified cluster.
[update](update.md) | Updates the specified machine learning model.