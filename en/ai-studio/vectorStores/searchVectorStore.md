---
editable: false
---

# REST: Search vector store

Search a vector store for relevant chunks based on a query and file attributes filter.

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/vector_stores/{vector_store_id}/search
```

## Path parameters

#|
||Field | Description ||
|| vector_store_id | **string**

Required field. The ID of the vector store to search. ||
|#

## Body parameters

**Request schema: application/json**

```json
{
  "query": "unknown",
  "rewrite_query": "boolean",
  "max_num_results": "integer",
  "filters": "unknown",
  "ranking_options": {
    "ranker": "string",
    "score_threshold": "number"
  }
}
```

#|
||Field | Description ||
|| query | Any of **string** \| **string** ||
|| rewrite_query | **boolean**

Whether to rewrite the natural language query for vector search. ||
|| max_num_results | **integer**

The maximum number of results to return. This number should be between 1 and 50 inclusive. ||
|| filters | Any of **[ComparisonFilter](#ComparisonFilter)** \| **[CompoundFilter](#CompoundFilter)** ||
|| ranking_options | **[RankingOptions](#RankingOptions)**

Ranking options for search. ||
|#

## ComparisonFilter {#ComparisonFilter}

A filter used to compare a specified attribute key to a given value using a defined comparison operation. 


#|
||Field | Description ||
|| type | **enum**

Required field. Specifies the comparison operator: `eq`, `ne`, `gt`, `gte`, `lt`, `lte`, `in`, `nin`.
- `eq`: equals
- `ne`: not equal
- `gt`: greater than
- `gte`: greater than or equal
- `lt`: less than
- `lte`: less than or equal
- `in`: in
- `nin`: not in 


- `eq`
- `ne`
- `gt`
- `gte`
- `lt`
- `lte` ||
|| key | **string**

Required field. The key to compare against the value. ||
|| value | Any of **string** \| **number** \| **boolean** \| **unknown** ||
|#

## CompoundFilter {#CompoundFilter}

Combine multiple filters using `and` or `or`.

#|
||Field | Description ||
|| type | **enum**

Required field. Type of operation: `and` or `or`.

- `and`
- `or` ||
|| filters[] | **unknown**

Required field.  ||
|#

## RankingOptions {#RankingOptions}

Ranking options for search.

#|
||Field | Description ||
|| ranker | **enum**

Enable re-ranking; set to `none` to disable, which can help reduce latency.

- `none`
- `auto`
- `default-2024-11-15` ||
|| score_threshold | **number** ||
|#

## Response {#200}

**HTTP Code: 200**

OK

**Response schema: application/json**

```json
{
  "object": "string",
  "search_query": [
    "string"
  ],
  "data": [
    {
      "file_id": "string",
      "filename": "string",
      "score": "number",
      "attributes": "unknown",
      "content": [
        {
          "type": "string",
          "text": "string"
        }
      ]
    }
  ],
  "has_more": "boolean",
  "next_page": "unknown"
}
```

#|
||Field | Description ||
|| object | **enum**

Required field. The object type, which is always `vector_store.search_results.page`

- `vector_store.search_results.page` ||
|| search_query[] | **string**

Required field. The query used for this search. ||
|| data[] | **[VectorStoreSearchResultItem](#VectorStoreSearchResultItem)**

Required field.  ||
|| has_more | **boolean**

Required field. Indicates if there are more results to fetch. ||
|| next_page | Any of **string** \| **null** ||
|#

## VectorStoreSearchResultItem {#VectorStoreSearchResultItem}

#|
||Field | Description ||
|| file_id | **string**

Required field. The ID of the vector store file. ||
|| filename | **string**

Required field. The name of the vector store file. ||
|| score | **number**

Required field. The similarity score for the result. ||
|| attributes | Any of **object** (map<**string**, **string**>) \| **null** ||
|| content[] | **[VectorStoreSearchResultContentObject](#VectorStoreSearchResultContentObject)**

Required field.  ||
|#

## VectorStoreSearchResultContentObject {#VectorStoreSearchResultContentObject}

#|
||Field | Description ||
|| type | **enum**

Required field. The type of content.

- `text` ||
|| text | **string**

Required field. The text content returned from search. ||
|#