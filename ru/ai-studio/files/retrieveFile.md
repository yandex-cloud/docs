---
editable: false
---

# REST: Retrieve file

Returns information about a specific file.

## HTTP request

```
GET https://ai.api.cloud.yandex.net/v1/files/{file_id}
```

## Path parameters

#|
||Field | Description ||
|| file_id | **string**

Required field. The ID of the file to use for this request. ||
|#

## Response {#200}

**HTTP Code: 200**

OK

**Response schema: application/json**

```json
{
  "id": "string",
  "bytes": "integer",
  "created_at": "integer",
  "expires_at": "integer",
  "filename": "string",
  "object": "string",
  "purpose": "string",
  "status": "string",
  "status_details": "string"
}
```

The `File` object represents a document that has been uploaded to Yandex Cloud AI Studio.

#|
||Field | Description ||
|| id | **string**

Required field. The file identifier, which can be referenced in the API endpoints. ||
|| bytes | **integer**

Required field. The size of the file, in bytes. ||
|| created_at | **integer**

Required field. The Unix timestamp (in seconds) for when the file was created. ||
|| expires_at | **integer**

The Unix timestamp (in seconds) for when the file will expire. ||
|| filename | **string**

Required field. The name of the file. ||
|| object | **enum**

Required field. The object type, which is always `file`.

- `file` ||
|| purpose | **enum**

Required field. The intended purpose of the file. Supported values are `assistants`, `assistants_output`, `batch`, `batch_output`, `fine-tune`, `fine-tune-results`, `vision`, and `user_data`.

- `assistants`
- `assistants_output`
- `batch`
- `batch_output`
- `fine-tune`
- `fine-tune-results`
- `vision`
- `user_data` ||
|| status | **enum**

Required field. Deprecated. The current status of the file, which can be either `uploaded`, `processed`, or `error`.

- `uploaded`
- `processed`
- `error` ||
|| status_details | **string**

Deprecated. For details on why a fine-tuning training file failed validation, see the `error` field on `fine_tuning.job`. ||
|#