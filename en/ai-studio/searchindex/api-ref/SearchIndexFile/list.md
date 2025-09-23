---
editable: false
apiPlayground:
  - url: https://rest-assistant.{{ api-host }}/assistants/v1/searchIndexFile/{searchIndexId}
    method: get
    path:
      type: object
      properties:
        searchIndexId:
          description: |-
            **string**
            Required field. ID of the search index whose files will be listed.
          type: string
      required:
        - searchIndexId
      additionalProperties: false
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            Maximum number of files to return per page.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Token to retrieve the next page of results.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/ai/assistants/v1/searchindex/api-ref/SearchIndexFile/list.md
---

# Search Index, REST: SearchIndexFile.List

List files that are indexed within a specific search index.

## HTTP request

```
GET https://rest-assistant.{{ api-host }}/assistants/v1/searchIndexFile/{searchIndexId}
```

## Path parameters

Request message for listing files in a specific search index.

#|
||Field | Description ||
|| searchIndexId | **string**

Required field. ID of the search index whose files will be listed. ||
|#

## Query parameters {#yandex.cloud.ai.assistants.v1.searchindex.ListSearchIndexFilesRequest}

Request message for listing files in a specific search index.

#|
||Field | Description ||
|| pageSize | **string** (int64)

Maximum number of files to return per page. ||
|| pageToken | **string**

Token to retrieve the next page of results. ||
|#

## Response {#yandex.cloud.ai.assistants.v1.searchindex.ListSearchIndexFilesResponse}

**HTTP Code: 200 - OK**

```json
{
  "files": [
    {
      "id": "string",
      "searchIndexId": "string",
      "createdBy": "string",
      "createdAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

Response message for the list operation.

#|
||Field | Description ||
|| files[] | **[SearchIndexFile](#yandex.cloud.ai.assistants.v1.searchindex.SearchIndexFile)**

List of files in the specified search index. ||
|| nextPageToken | **string**

Token to retrieve the next page of results. ||
|#

## SearchIndexFile {#yandex.cloud.ai.assistants.v1.searchindex.SearchIndexFile}

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