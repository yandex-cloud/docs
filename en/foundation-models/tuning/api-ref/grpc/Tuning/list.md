---
editable: false
sourcePath: en/_api-ref-grpc/ai/tuning/v1/tuning/api-ref/grpc/Tuning/list.md
---

# Foundation Models Tuning Service API, gRPC: TuningService.List

## gRPC request

**rpc List ([ListTuningsRequest](#yandex.cloud.ai.tuning.v1.ListTuningsRequest)) returns ([ListTuningsResponse](#yandex.cloud.ai.tuning.v1.ListTuningsResponse))**

## ListTuningsRequest {#yandex.cloud.ai.tuning.v1.ListTuningsRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "status": "Status"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. Required field. ID of the folder to list tunings in. ||
|| page_size | **int64**

Maximum number of tuning tasks to return per page. ||
|| page_token | **string**

Token to retrieve the next page of results. ||
|| status | enum **Status**

- `STATUS_UNSPECIFIED`
- `CREATED`
- `PENDING`
- `IN_PROGRESS`
- `COMPLETED`
- `FAILED`
- `CANCELED`
- `DRAFT`
- `ARCHIVED`
- `PAID` ||
|#

## ListTuningsResponse {#yandex.cloud.ai.tuning.v1.ListTuningsResponse}

```json
{
  "tuning_tasks": [
    {
      "task_id": "string",
      "operation_id": "string",
      "status": "Status",
      "folder_id": "string",
      "created_by": "string",
      "created_at": "google.protobuf.Timestamp",
      "started_at": "google.protobuf.Timestamp",
      "finished_at": "google.protobuf.Timestamp",
      "source_model_uri": "string",
      "target_model_uri": "string",
      "name": "string",
      "description": "string",
      "labels": "map<string, string>"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| tuning_tasks[] | **[TuningTask](#yandex.cloud.ai.tuning.v1.TuningTask)**

List of tuning tasks in the specified folder. ||
|| next_page_token | **string**

Token to retrieve the next page of results. ||
|#

## TuningTask {#yandex.cloud.ai.tuning.v1.TuningTask}

#|
||Field | Description ||
|| task_id | **string** ||
|| operation_id | **string** ||
|| status | enum **Status**

- `STATUS_UNSPECIFIED`
- `CREATED`
- `PENDING`
- `IN_PROGRESS`
- `COMPLETED`
- `FAILED`
- `CANCELED`
- `DRAFT`
- `ARCHIVED`
- `PAID` ||
|| folder_id | **string** ||
|| created_by | **string** ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| source_model_uri | **string** ||
|| target_model_uri | **string** ||
|| name | **string** ||
|| description | **string** ||
|| labels | **object** (map<**string**, **string**>) ||
|#