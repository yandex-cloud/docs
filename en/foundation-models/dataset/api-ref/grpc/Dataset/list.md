---
editable: false
sourcePath: en/_api-ref-grpc/ai/dataset/v1/dataset/api-ref/grpc/Dataset/list.md
---

# Foundation Models Dataset Service API, gRPC: DatasetService.List

Lists datasets in specified folder.

## gRPC request

**rpc List ([ListDatasetsRequest](#yandex.cloud.ai.dataset.v1.ListDatasetsRequest)) returns ([ListDatasetsResponse](#yandex.cloud.ai.dataset.v1.ListDatasetsResponse))**

## ListDatasetsRequest {#yandex.cloud.ai.dataset.v1.ListDatasetsRequest}

```json
{
  "folder_id": "string",
  "status": "Status",
  "dataset_name_pattern": "string",
  "task_type_filter": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. Folder ID of the datasets to list. ||
|| status | enum **Status**

Status of the datasets to list. Optional.

- `STATUS_UNSPECIFIED`
- `DRAFT`
- `VALIDATING`
- `READY`
- `INVALID`
- `DELETING` ||
|| dataset_name_pattern | **string**

Name substring of the datasets to list. Optional. ||
|| task_type_filter | **string**

Task type of the datasets to list. Optional. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListDatasetsResponse.next_page_token](#yandex.cloud.ai.dataset.v1.ListDatasetsResponse)
that can be used to get the next page of results in subsequent list requests. Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListDatasetsResponse.next_page_token](#yandex.cloud.ai.dataset.v1.ListDatasetsResponse) returned by a previous list request. ||
|#

## ListDatasetsResponse {#yandex.cloud.ai.dataset.v1.ListDatasetsResponse}

```json
{
  "datasets": [
    {
      "dataset_id": "string",
      "folder_id": "string",
      "name": "string",
      "description": "string",
      "metadata": "string",
      "status": "Status",
      "task_type": "string",
      "created_at": "google.protobuf.Timestamp",
      "updated_at": "google.protobuf.Timestamp",
      "rows": "int64",
      "size_bytes": "int64",
      "created_by_id": "string",
      "labels": "map<string, string>",
      "created_by": "string",
      "updated_by": "string",
      "validation_error": [
        {
          "error": "string",
          "error_description": "string",
          "row_numbers": [
            "int64"
          ]
        }
      ]
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| datasets[] | **[DatasetInfo](#yandex.cloud.ai.dataset.v1.DatasetInfo)**

Information about listed datasets. ||
|| next_page_token | **string**

`next_page_token` token allows you to get the next page of results for list requests.
If the number of results is larger than [ListDatasetsRequest.page_size](#yandex.cloud.ai.dataset.v1.ListDatasetsRequest), use
the `next_page_token` as the value for the [ListDatasetsRequest.page_token](#yandex.cloud.ai.dataset.v1.ListDatasetsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## DatasetInfo {#yandex.cloud.ai.dataset.v1.DatasetInfo}

Information about the dataset.

#|
||Field | Description ||
|| dataset_id | **string**

ID of the dataset. ||
|| folder_id | **string**

Folder ID of the dataset. ||
|| name | **string**

Name of the dataset. ||
|| description | **string**

Description of the dataset. ||
|| metadata | **string**

Metadata of the dataset. ||
|| status | enum **Status**

Status of the dataset.

- `STATUS_UNSPECIFIED`
- `DRAFT`
- `VALIDATING`
- `READY`
- `INVALID`
- `DELETING` ||
|| task_type | **string**

Task type of the dataset. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Create dataset timestamp. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Update dataset timestamp. ||
|| rows | **int64**

Number of rows in the dataset. ||
|| size_bytes | **int64**

Size of the dataset. ||
|| created_by_id | **string**

Deprecated. Use created_by instead ||
|| labels | **object** (map<**string**, **string**>)

Labels of the dataset ||
|| created_by | **string**

User ID of the dataset's creator. ||
|| updated_by | **string**

User ID of the dataset's last updater. ||
|| validation_error[] | **[ValidationError](#yandex.cloud.ai.dataset.v1.ValidationError)** ||
|#

## ValidationError {#yandex.cloud.ai.dataset.v1.ValidationError}

Information about dataset validation error.

#|
||Field | Description ||
|| error | **string**

Name of the validation error. ||
|| error_description | **string**

Description of the validation error. ||
|| row_numbers[] | **int64**

Row numbers in which the error occurred. ||
|#