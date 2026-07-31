[Документация Yandex Cloud](../../../../index.md) > [Yandex MetaData Hub](../../../index.md) > Data Catalog > Справочник API > [REST (англ.)](../index.md) > [Catalog](index.md) > UpdateCatalog

# Datacatalog API, REST: Catalog.UpdateCatalog

Updates the specified catalog.

## HTTP request

```
PATCH https://datacatalog.api.cloud.yandex.net/v1/catalog/{catalog.id}
```

## Body parameters {#yandex.cloud.datacatalog.v1.UpdateCatalogRequest}

```json
{
  "catalog": {
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
  },
  "updateMask": "string"
}
```

Request message for updating a catalog.

#|
||Field | Description ||
|| catalog | **[Catalog](#yandex.cloud.datacatalog.v1.Catalog)**

Catalog to update. ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
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

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../../api-design-guide/concepts/operation.md).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **object**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **object**

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

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#