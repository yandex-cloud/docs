---
editable: false
apiPlayground:
  - url: https://rest-assistant.{{ api-host }}/assistants/v1/searchIndex/{searchIndexId}
    method: delete
    path:
      type: object
      properties:
        searchIndexId:
          description: |-
            **string**
            Required field. ID of the search index to delete.
          type: string
      required:
        - searchIndexId
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# Search Index, REST: SearchIndex.Delete

Delete a search index by its ID.

## HTTP request

```
DELETE https://rest-assistant.{{ api-host }}/assistants/v1/searchIndex/{searchIndexId}
```

## Path parameters

Request message for deleting a search index by ID.

#|
||Field | Description ||
|| searchIndexId | **string**

Required field. ID of the search index to delete. ||
|#

## Response {#yandex.cloud.ai.assistants.v1.searchindex.DeleteSearchIndexResponse}

**HTTP Code: 200 - OK**