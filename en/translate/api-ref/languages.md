# List of supported languages

Get a list of translation directions supported by the service.

## Request {#request}

```
POST https://translate.api.cloud.yandex.net/translate/v1/languages
```

### Parameters in the request body

The maximum size of the POST request body is 30 KB.

| Parameter | Description |
| ----- | ----- |
| `folderId` | Required parameter.<br/>ID of your folder.<br/>For more information about how to find out the folder ID, see the section [Authorization in the API](../concepts/auth.md). |

## Response {#response}

The response is returned in JSON format.

```json
{
   "languages": [
        {"language": <text code>},
        ...
        {"language": <text code>}
   ]
} 
```

## Examples {#examples}

### Sample request

```no-highlight
curl -X POST \
     -H "Authorization: Bearer <IAM-token>" \
     -d "folderId=<folder id>" \
     "https://translate.api.cloud.yandex.net/translate/v1/languages"
```

### Sample response

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

