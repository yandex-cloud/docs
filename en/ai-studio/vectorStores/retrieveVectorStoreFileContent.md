---
editable: false
sourcePath: en/_openapi/openai-compatible/vectorStores/retrieveVectorStoreFileContent.md
---

# REST: Retrieve vector store file content

Retrieve the parsed contents of a vector store file.

## HTTP request

```
GET https://ai.api.cloud.yandex.net/v1/vector_stores/{vector_store_id}/files/{file_id}/content
```

## Path parameters

#|
||Field | Description ||
|| vector_store_id | **string**

Required field. The ID of the vector store. ||
|| file_id | **string**

Required field. The ID of the file within the vector store. ||
|#

## Response {#200}

**HTTP Code: 200**

OK

**Response schema: application/json**

```json
{
  "object": "string",
  "data": [
    {
      "type": "string",
      "text": "string"
    }
  ],
  "has_more": "boolean",
  "next_page": "unknown"
}
```

Represents the parsed content of a vector store file.

#|
||Field | Description ||
|| object | **enum**

Required field. The object type, which is always `vector_store.file_content.page`

- `vector_store.file_content.page` ||
|| data[] | **[DataItem](#DataItem)**

Required field.  ||
|| has_more | **boolean**

Required field. Indicates if there are more content pages to fetch. ||
|| next_page | Any of **string** \| **null** ||
|#

## DataItem {#DataItem}

#|
||Field | Description ||
|| type | **string**

The content type (currently only `"text"`) ||
|| text | **string**

The text content ||
|#