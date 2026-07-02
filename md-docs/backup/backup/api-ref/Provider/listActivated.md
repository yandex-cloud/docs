[Документация Yandex Cloud](../../../../index.md) > [Yandex Cloud Backup](../../../index.md) > Справочник API > [REST (англ.)](../index.md) > [Provider](index.md) > ListActivated

# Cloud Backup API, REST: Provider.ListActivated

List activated providers for specified client.

## HTTP request

```
GET https://backup.api.cloud.yandex.net/backup/v1/providers
```

## Query parameters {#yandex.cloud.backup.v1.ListActivatedProvidersRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to find out the backup provider.

The maximum string length in characters is 50. ||
|| instanceRegistrationId | **string**

instance registration token for authorization ||
|#

## Response {#yandex.cloud.backup.v1.ListActivatedProvidersResponse}

**HTTP Code: 200 - OK**

```json
{
  "folderId": "string",
  "names": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. Folder ID.

The maximum string length in characters is 50. ||
|| names[] | **string**

Name of the backup provider. ||
|#