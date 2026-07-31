---
editable: false
apiPlayground:
  - url: https://datacatalog.{{ api-host }}/v1/catalog/{catalogId}
    method: get
    path:
      type: object
      properties:
        catalogId:
          description: |-
            **string**
            ID of the catalog to return.
          type: string
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# Datacatalog API, REST: Catalog.GetCatalog

Returns the specified catalog.

## HTTP request

```
GET https://datacatalog.{{ api-host }}/v1/catalog/{catalogId}
```

## Path parameters

Request message for getting a catalog.

#|
||Field | Description ||
|| catalogId | **string**

Required field. ID of the catalog to return. ||
|#

## Response {#yandex.cloud.datacatalog.v1.Catalog}

**HTTP Code: 200 - OK**

```json
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
```

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