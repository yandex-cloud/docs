---
editable: false
sourcePath: en/_api-ref/ai/assistants/v1/searchindex/api-ref/SearchIndexFile/get.md
---

# Search Index, REST: SearchIndexFile.Get

Retrieves details of a specific file that has been indexed within a search index.

## HTTP request

```
GET https://rest-assistant.{{ api-host }}/assistants/v1/searchIndexFile/{searchIndexId}/{fileId}
```

## Path parameters

Request message for retrieving a file from a search index.

#|
||Field | Description ||
|| fileId | **string**

Required field. ID of the file to retrieve. ||
|| searchIndexId | **string**

Required field. ID of the search index that contains the file. ||
|#

## Response {#yandex.cloud.ai.assistants.v1.searchindex.SearchIndexFile}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "searchIndexId": "string",
  "createdBy": "string",
  "createdAt": "string"
}
```

Represents a file that has been indexed within a search index.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the file that was used for indexing. ||
|| searchIndexId | **string**

ID of the search index that contains this file. ||
|| createdBy | **string**

Identifier of the subject who created the file in the search index. ||
|| createdAt | **string** (date-time)

Timestamp representing when the file was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#