---
editable: false
---

# REST: Upload file

Upload a file that can be used across various endpoints. Individual files can be up to 128 MB.

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/files
```

## Body parameters

**Request schema: multipart/form-data**

#|
||Field | Description ||
|| file | **string** (binary)

Required field. The File object (not file name) to be uploaded. ||
|| purpose | **enum**

Required field. The intended purpose of the uploaded file. One of: - `assistants`: Used in the Assistants API - `batch`: Used in the Batch API - `fine-tune`: Used for fine-tuning - `vision`: Images used for vision fine-tuning - `user_data`: Flexible file type for any purpose - `evals`: Used for eval data sets 


- `assistants`
- `batch`
- `fine-tune`
- `vision`
- `user_data`
- `evals` ||
|| expires_after | **[FileExpirationAfter](#FileExpirationAfter)**

Required field. The expiration policy for a file. By default, files with `purpose=batch` expire after 30 days and all other files are persisted until they are manually deleted. ||
|#

## FileExpirationAfter {#FileExpirationAfter}

The expiration policy for a file. By default, files with `purpose=batch` expire after 30 days and all other files are persisted until they are manually deleted.

#|
||Field | Description ||
|| anchor | **enum**

Required field. Anchor timestamp after which the expiration policy applies. Supported anchors: `created_at`.

- `created_at` ||
|| seconds | **integer**

Required field. The number of seconds after the anchor time that the file will expire. Must be between 3600 (1 hour) and 2592000 (30 days). ||
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