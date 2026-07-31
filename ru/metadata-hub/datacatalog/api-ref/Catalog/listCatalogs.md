---
editable: false
apiPlayground:
  - url: https://datacatalog.{{ api-host }}/v1/catalogs
    method: get
    path: null
    query:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            ID of the folder to list catalogs in.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `page_size`, the service returns a `next_page_token`
            that can be used to get the next page of results in subsequent list requests.
            if omitted, default value will be used
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `page_token` to the
            `next_page_token` returned by a previous list request.
          type: string
        namePatternOrId:
          description: |-
            **string**
            Filter by name. Use this in case if it's necessary to find catalogs by name
            if empty - filter will be omited
          type: string
      additionalProperties: false
    body: null
    definitions: null
---

# Datacatalog API, REST: Catalog.ListCatalogs

Retrieves the list of catalogs in the specified folder.

## HTTP request

```
GET https://datacatalog.{{ api-host }}/v1/catalogs
```

## Query parameters {#yandex.cloud.datacatalog.v1.ListCatalogsRequest}

Request message for getting catalogs by folder id.

#|
||Field | Description ||
|| folderId | **string**

ID of the folder to list catalogs in. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a `next_page_token`
that can be used to get the next page of results in subsequent list requests.
if omitted, default value will be used ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
`next_page_token` returned by a previous list request. ||
|| namePatternOrId | **string**

Filter by name. Use this in case if it's necessary to find catalogs by name
if empty - filter will be omited ||
|#

## Response {#yandex.cloud.datacatalog.v1.ListCatalogsResponse}

**HTTP Code: 200 - OK**

```json
{
  "catalogs": [
    {
      "id": "string",
      "folderId": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "createdBy": "string",
      "aiMarkupRules": {
        "aiEnabled": "boolean",
        "documentationRules": "string",
        "domainRules": "string",
        "termsRules": "string",
        "tagsRules": "string"
      },
      "autoIngestionParams": {
        "serviceAccountId": "string"
      },
      "createdAt": "string",
      "updatedAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

Response message that contains result of listing catalogs.

#|
||Field | Description ||
|| catalogs[] | **[Catalog](#yandex.cloud.datacatalog.v1.Catalog)**

List of catalogs. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests.
If the number of results is larger than the specified `page_size`, use the
`next_page_token` as the value for the `page_token` parameter in the next list request.
Each subsequent list request will have its own `next_page_token` to continue paging ||
|#

## Catalog {#yandex.cloud.datacatalog.v1.Catalog}

#|
||Field | Description ||
|| id | **string**

Catalog identifier ||
|| folderId | **string**

Folder identifier ||
|| name | **string**

Catalog name ||
|| description | **string**

Catalog description ||
|| labels | **object** (map<**string**, **string**>)

Catalog labels ||
|| createdBy | **string**

Id of subject who created the catalog ||
|| aiMarkupRules | **[CatalogAIMarkupRules](#yandex.cloud.datacatalog.v1.CatalogAIMarkupRules)**

AI markup enabled flag ||
|| autoIngestionParams | **[CatalogAutoIngestionConfig](#yandex.cloud.datacatalog.v1.CatalogAutoIngestionConfig)**

Configuration for auto ingestion feature ||
|| createdAt | **string** (date-time)

Date of catalog creation

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Date of catalog last update

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#

## CatalogAIMarkupRules {#yandex.cloud.datacatalog.v1.CatalogAIMarkupRules}

#|
||Field | Description ||
|| aiEnabled | **boolean**

If set to true, AI marking up of catalog entities will be enabled ||
|| documentationRules | **string**

Rules for the AI agent, that will be used for assets mark up ||
|| domainRules | **string**

Rules for the AI agent, that will be used for domains mark up ||
|| termsRules | **string**

Rules for the AI agent, that will be used for terms mark up ||
|| tagsRules | **string**

Rules for the AI agent, that will be used for tags mark up ||
|#

## CatalogAutoIngestionConfig {#yandex.cloud.datacatalog.v1.CatalogAutoIngestionConfig}

#|
||Field | Description ||
|| serviceAccountId | **string**

ID of service account, which will be used for auto ingestion feature ||
|#