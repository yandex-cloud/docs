---
editable: false
---

# REST: Retrieve vector store file batch

Retrieves a vector store file batch.

## HTTP request

```
GET https://ai.api.cloud.yandex.net/v1/vector_stores/{vector_store_id}/file_batches/{batch_id}
```

## Path parameters

#|
||Field | Description ||
|| vector_store_id | **string**

Required field. The ID of the vector store that the file batch belongs to. ||
|| batch_id | **string**

Required field. The ID of the file batch being retrieved. ||
|#

## Response {#200}

**HTTP Code: 200**

OK

**Response schema: application/json**

```json
{
  "id": "string",
  "object": "string",
  "created_at": "integer",
  "vector_store_id": "string",
  "status": "string",
  "file_counts": {
    "in_progress": "integer",
    "completed": "integer",
    "failed": "integer",
    "cancelled": "integer",
    "total": "integer"
  }
}
```

A batch of files attached to a vector store.

#|
||Field | Description ||
|| id | **string**

Required field. The identifier, which can be referenced in API endpoints. ||
|| object | **enum**

Required field. The object type, which is always `vector_store.file_batch`.

- `vector_store.files_batch` ||
|| created_at | **integer**

Required field. The Unix timestamp (in seconds) for when the vector store files batch was created. ||
|| vector_store_id | **string**

Required field. The ID of the vector store that the file is attached to. ||
|| status | **enum**

Required field. The status of the vector store files batch, which can be either `in_progress`, `completed`, `cancelled` or `failed`.

- `in_progress`
- `completed`
- `cancelled`
- `failed` ||
|| file_counts | **[FileCounts](#FileCounts)**

Required field.  ||
|#

## FileCounts {#FileCounts}

#|
||Field | Description ||
|| in_progress | **integer**

Required field. The number of files that are currently being processed. ||
|| completed | **integer**

Required field. The number of files that have been processed. ||
|| failed | **integer**

Required field. The number of files that have failed to process. ||
|| cancelled | **integer**

Required field. The number of files that where cancelled. ||
|| total | **integer**

Required field. The total number of files. ||
|#