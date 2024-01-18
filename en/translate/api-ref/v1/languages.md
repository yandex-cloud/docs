---
title: "List of supported languages"
description: "Get a list of translation directions supported by the service."
---

# List of supported languages

{% include [speechkit-v1-disclaimer.md](../../../_includes/speechkit-v1-disclaimer.md) %}

Get a list of translation directions supported by the service.

## Request {#request}

```
POST https://translate.{{ api-host }}/translate/v1/languages
```

### Parameters in the request body {#parameters-in-the-request-body}

The maximum size of the POST request body is 30 KB.


| Parameter | Description |
----- | -----
| `folderId` | Required parameter.<br/>The ID of your folder.<br/> |


## Response {#response}

The response is returned in JSON format.

```json
{
   "languages": [
        {"language": <language_code>},
        ...
        {"language": <language_code>}
   ]
}
```


## Examples {#examples}

### Sample request {#sample-request}

```httpget
export FOLDER_ID=<folder_ID>
export TOKEN=<IAM_token>
curl -X POST \
     -H "Authorization: Bearer ${TOKEN}" \
     -d "folderId=${FOLDER_ID}" \
     "https://translate.{{ api-host }}/translate/v1/languages"
```

### Response example {#response-example}

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


