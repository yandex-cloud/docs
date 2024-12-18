---
editable: false
sourcePath: en/_api-ref/mdb/clickhouse/v1/api-ref/MlModel/list.md
---

# Managed Service for ClickHouse API, REST: MlModel.List

Retrieves the list of machine learning models in the specified cluster.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}/mlModels
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster that models belongs to. ||
|#

## Query parameters {#yandex.cloud.mdb.clickhouse.v1.ListMlModelsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListMlModelsResponse.nextPageToken](#yandex.cloud.mdb.clickhouse.v1.ListMlModelsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListMlModelsResponse.nextPageToken](#yandex.cloud.mdb.clickhouse.v1.ListMlModelsResponse) returned by the previous list request. ||
|#

## Response {#yandex.cloud.mdb.clickhouse.v1.ListMlModelsResponse}

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

#|
||Field | Description ||
|| mlModels[] | **[MlModel](#yandex.cloud.mdb.clickhouse.v1.MlModel)**

List of models in the specified cluster. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListMlModelsRequest.pageSize](#yandex.cloud.mdb.clickhouse.v1.ListMlModelsRequest), use `next_page_token` as the value
for the [ListMlModelsRequest.pageToken](#yandex.cloud.mdb.clickhouse.v1.ListMlModelsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## MlModel {#yandex.cloud.mdb.clickhouse.v1.MlModel}

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