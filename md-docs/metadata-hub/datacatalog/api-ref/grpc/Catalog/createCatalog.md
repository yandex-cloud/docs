[Документация Yandex Cloud](../../../../../index.md) > [Yandex MetaData Hub](../../../../index.md) > Data Catalog > Справочник API > [gRPC (англ.)](../index.md) > [Catalog](index.md) > CreateCatalog

# Datacatalog API, gRPC: CatalogService.CreateCatalog

Creates a catalog.

## gRPC request

**rpc CreateCatalog ([CreateCatalogRequest](#yandex.cloud.datacatalog.v1.CreateCatalogRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateCatalogRequest {#yandex.cloud.datacatalog.v1.CreateCatalogRequest}

```json
{
  "catalog": {
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
}
```

Request message for creating a catalog.

#|
||Field | Description ||
|| catalog | **[Catalog](#yandex.cloud.datacatalog.v1.Catalog)**

Catalog to create. ||
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

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../../../api-design-guide/concepts/operation.md).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#