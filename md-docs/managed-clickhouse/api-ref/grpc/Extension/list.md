[Документация Yandex Cloud](../../../../index.md) > [Yandex Managed Service for ClickHouse®](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [Extension](index.md) > List

# Managed Service for ClickHouse API, gRPC: ExtensionService.List

Lists extensions available in the specified folder.

## gRPC request

**rpc List ([ListExtensionsRequest](#yandex.cloud.mdb.clickhouse.v1.ListExtensionsRequest)) returns ([ListExtensionsResponse](#yandex.cloud.mdb.clickhouse.v1.ListExtensionsResponse))**

## ListExtensionsRequest {#yandex.cloud.mdb.clickhouse.v1.ListExtensionsRequest}

```json
{
  "page_size": "int64",
  "page_token": "string",
  "folder_id": "string"
}
```

#|
||Field | Description ||
|| page_size | **int64**

Maximum number of extensions to return per response.

The maximum value is 1000. ||
|| page_token | **string**

Token for fetching the next page of results.

The maximum string length in characters is 100. ||
|| folder_id | **string**

ID of the folder.

The maximum string length in characters is 50. ||
|#

## ListExtensionsResponse {#yandex.cloud.mdb.clickhouse.v1.ListExtensionsResponse}

```json
{
  "extensions": [
    {
      "name": "string",
      "versions": [
        {
          "id": "string",
          "default": "bool",
          "deprecated": "bool"
        }
      ]
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| extensions[] | **[Extension](#yandex.cloud.mdb.clickhouse.v1.Extension)**

Requested extensions. ||
|| next_page_token | **string**

Token to retrieve the next page of results. ||
|#

## Extension {#yandex.cloud.mdb.clickhouse.v1.Extension}

#|
||Field | Description ||
|| name | **string**

Required field. Required. Extension name. ||
|| versions[] | **[ExtensionVersion](#yandex.cloud.mdb.clickhouse.v1.ExtensionVersion)**

Required. All extension available versions. ||
|#

## ExtensionVersion {#yandex.cloud.mdb.clickhouse.v1.ExtensionVersion}

#|
||Field | Description ||
|| id | **string**

Required field. Required. Version ID. ||
|| default | **bool**

Is default version. ||
|| deprecated | **bool**

Is version deprecated.
 ||
|#