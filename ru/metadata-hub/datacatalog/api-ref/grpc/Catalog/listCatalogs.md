---
editable: false
---

# Datacatalog API, gRPC: CatalogService.ListCatalogs

Retrieves the list of catalogs in the specified folder.

## gRPC request

**rpc ListCatalogs ([ListCatalogsRequest](#yandex.cloud.datacatalog.v1.ListCatalogsRequest)) returns ([ListCatalogsResponse](#yandex.cloud.datacatalog.v1.ListCatalogsResponse))**

## ListCatalogsRequest {#yandex.cloud.datacatalog.v1.ListCatalogsRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "name_pattern_or_id": "string"
}
```

Request message for getting catalogs by folder id.

#|
||Field | Description ||
|| folder_id | **string**

ID of the folder to list catalogs in. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a `next_page_token`
that can be used to get the next page of results in subsequent list requests.
if omitted, default value will be used ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
`next_page_token` returned by a previous list request. ||
|| name_pattern_or_id | **string**

Filter by name. Use this in case if it's necessary to find catalogs by name
if empty - filter will be omited ||
|#

## ListCatalogsResponse {#yandex.cloud.datacatalog.v1.ListCatalogsResponse}

```json
{
  "catalogs": [
    {
      "id": "string",
      "folder_id": "string",
      "name": "string",
      "description": "string",
      "labels": "map<string, string>",
      "created_by": "string",
      "ai_markup_rules": {
        "ai_enabled": "bool",
        "documentation_rules": "string",
        "domain_rules": "string",
        "terms_rules": "string",
        "tags_rules": "string"
      },
      "auto_ingestion_params": {
        "service_account_id": "string"
      },
      "created_at": "google.protobuf.Timestamp",
      "updated_at": "google.protobuf.Timestamp"
    }
  ],
  "next_page_token": "string"
}
```

Response message that contains result of listing catalogs.

#|
||Field | Description ||
|| catalogs[] | **[Catalog](#yandex.cloud.datacatalog.v1.Catalog)**

List of catalogs. ||
|| next_page_token | **string**

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
|| folder_id | **string**

Folder identifier ||
|| name | **string**

Catalog name ||
|| description | **string**

Catalog description ||
|| labels | **object** (map<**string**, **string**>)

Catalog labels ||
|| created_by | **string**

Id of subject who created the catalog ||
|| ai_markup_rules | **[CatalogAIMarkupRules](#yandex.cloud.datacatalog.v1.CatalogAIMarkupRules)**

AI markup enabled flag ||
|| auto_ingestion_params | **[CatalogAutoIngestionConfig](#yandex.cloud.datacatalog.v1.CatalogAutoIngestionConfig)**

Configuration for auto ingestion feature ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Date of catalog creation ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Date of catalog last update ||
|#

## CatalogAIMarkupRules {#yandex.cloud.datacatalog.v1.CatalogAIMarkupRules}

#|
||Field | Description ||
|| ai_enabled | **bool**

If set to true, AI marking up of catalog entities will be enabled ||
|| documentation_rules | **string**

Rules for the AI agent, that will be used for assets mark up ||
|| domain_rules | **string**

Rules for the AI agent, that will be used for domains mark up ||
|| terms_rules | **string**

Rules for the AI agent, that will be used for terms mark up ||
|| tags_rules | **string**

Rules for the AI agent, that will be used for tags mark up ||
|#

## CatalogAutoIngestionConfig {#yandex.cloud.datacatalog.v1.CatalogAutoIngestionConfig}

#|
||Field | Description ||
|| service_account_id | **string**

ID of service account, which will be used for auto ingestion feature ||
|#