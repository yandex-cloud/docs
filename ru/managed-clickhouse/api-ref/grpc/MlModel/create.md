---
editable: false
sourcePath: en/_api-ref-grpc/mdb/clickhouse/v1/api-ref/grpc/MlModel/create.md
---

# Managed Service for ClickHouse API, gRPC: MlModelService.Create {#Create}

Creates a machine learning model in the specified cluster.

## gRPC request

**rpc Create ([CreateMlModelRequest](#yandex.cloud.mdb.clickhouse.v1.CreateMlModelRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateMlModelRequest {#yandex.cloud.mdb.clickhouse.v1.CreateMlModelRequest}

```json
{
  "clusterId": "string",
  "mlModelName": "string",
  "type": "MlModelType",
  "uri": "string"
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster to create a model in.

To get a cluster ID make a [ClusterService.List](/docs/managed-clickhouse/api-ref/grpc/Cluster/list#List) request. ||
|| mlModelName | **string**

Required field. Model name. The model name is one of the arguments of the modelEvaluate() function, which is used to call the model in ClickHouse. ||
|| type | enum **MlModelType**

Required field. Type of the model.

- `ML_MODEL_TYPE_UNSPECIFIED`
- `ML_MODEL_TYPE_CATBOOST`: CatBoost model. ||
|| uri | **string**

Required field. Model file URL. You can only use models stored in Object Storage. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "clusterId": "string",
    "mlModelName": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "name": "string",
    "clusterId": "string",
    "type": "MlModelType",
    "uri": "string"
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateMlModelMetadata](#yandex.cloud.mdb.clickhouse.v1.CreateMlModelMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[MlModel](#yandex.cloud.mdb.clickhouse.v1.MlModel)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## CreateMlModelMetadata {#yandex.cloud.mdb.clickhouse.v1.CreateMlModelMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the cluster that a model is being added to. ||
|| mlModelName | **string**

Name of the the model that is being created. ||
|#

## MlModel {#yandex.cloud.mdb.clickhouse.v1.MlModel}

#|
||Field | Description ||
|| name | **string**

Name of the the model. ||
|| clusterId | **string**

ID of the ClickHouse cluster that the model belongs to. ||
|| type | enum **MlModelType**

Type of the model.

- `ML_MODEL_TYPE_UNSPECIFIED`
- `ML_MODEL_TYPE_CATBOOST`: CatBoost model. ||
|| uri | **string**

Model file URL. You can only use models stored in Object Storage. ||
|#