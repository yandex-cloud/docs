---
editable: false
---

# Datacatalog API, gRPC: CatalogService.GetCatalog

Returns the specified catalog.

## gRPC request

**rpc GetCatalog ([GetCatalogRequest](#yandex.cloud.datacatalog.v1.GetCatalogRequest)) returns ([Catalog](#yandex.cloud.datacatalog.v1.Catalog))**

## GetCatalogRequest {#yandex.cloud.datacatalog.v1.GetCatalogRequest}

```json
{
  "catalog_id": "string"
}
```

Request message for getting a catalog.

#|
||Field | Description ||
|| catalog_id | **string**

ID of the catalog to return. ||
|#

## Catalog {#yandex.cloud.datacatalog.v1.Catalog}

```json
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
```

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