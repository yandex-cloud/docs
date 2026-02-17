---
editable: false
apiPlayground:
  - url: https://backup.{{ api-host }}/backup/v1/providers
    method: get
    path: null
    query:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to find out the backup provider.
            The maximum string length in characters is 50.
          type: string
        instanceRegistrationId:
          description: |-
            **string**
            instance registration token for authorization
          type: string
      required:
        - folderId
      additionalProperties: false
    body: null
    definitions: null
---

# Cloud Backup API, REST: Provider.ListActivated

List activated providers for specified client.

## HTTP request

```
GET https://backup.{{ api-host }}/backup/v1/providers
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

Folder ID. ||
|| names[] | **string**

Name of the backup provider. ||
|#