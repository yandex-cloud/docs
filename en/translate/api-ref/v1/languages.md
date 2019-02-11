# List of supported languages

[!INCLUDE [speechkit-v1-disclaimer.md](../../../_includes/speechkit-v1-disclaimer.md)]

Get a list of translation directions supported by the service.

## Request {#request}

```
POST https://translate.api.cloud.yandex.net/translate/v1/languages
```

### Parameters in the request body

The maximum size of the POST request body is 30 KB.

| Parameter | Description |
| ----- | ----- |
| `folderId` | Required parameter.<br/>ID of your folder.<br/>For more information about how to find out the folder ID, see the section [Authorization in the API](../../concepts/auth.md). |

## Response {#response}

The response is returned in JSON format.

```json
{
   "languages": [
        {"language": <language code>},
        ...
        {"language": <language code>}
   ]
}
```

## Examples {#examples}

### Sample request

```httpget
export FOLDER_ID=<folder id>
export TOKEN=<IAM-token>
curl -X POST \
     -H "Authorization: Bearer ${TOKEN}" \
     -d "folderId=${FOLDER_ID}" \
     "https://translate.api.cloud.yandex.net/translate/v1/languages"
```

### Response example

The response is returned in JSON format.

```json
{
   "languages": [
        {"language": "az"},
        ...
        {"language": "ja"}
   ]
}
```

