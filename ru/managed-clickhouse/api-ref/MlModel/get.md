---
editable: false
sourcePath: en/_api-ref/mdb/clickhouse/v1/api-ref/MlModel/get.md
---

# Managed Service for ClickHouse API, REST: MlModel.Get {#Get}

Returns the specified machine learning model.

To get the list of all available models, make a [List](/docs/managed-clickhouse/api-ref/MlModel/list#List) request.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}/mlModels/{mlModelName}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster that the model belongs to. ||
|| mlModelName | **string**

Required field. Name of the model to return.

To get a model name make a [MlModelService.List](/docs/managed-clickhouse/api-ref/MlModel/list#List) request. ||
|#

## Response {#yandex.cloud.mdb.clickhouse.v1.MlModel}

**HTTP Code: 200 - OK**

```json
{
  "name": "string",
  "clusterId": "string",
  "type": "string",
  "uri": "string"
}
```

#|
||Field | Description ||
|| name | **string**

Name of the the model. ||
|| clusterId | **string**

ID of the ClickHouse cluster that the model belongs to. ||
|| type | **enum** (MlModelType)

Type of the model.

- `ML_MODEL_TYPE_UNSPECIFIED`
- `ML_MODEL_TYPE_CATBOOST`: CatBoost model. ||
|| uri | **string**

Model file URL. You can only use models stored in Object Storage. ||
|#