---
title: Detecting language
description: Detects the language of the source text. The response is returned as the language code.
---

# Detecting language

{% include [speechkit-v1-disclaimer.md](../../../_includes/speechkit-v1-disclaimer.md) %}

Detects the language of the source text. The response is returned as the language code.

When using the Translate API, provide your [authentication](/docs/translate/api-ref/authentication) credentials in the `Authorization` header of each request.

## Request {#request}

```http
POST https://translate.{{ api-host }}/translate/v1/detect
```

### Parameters in the request body {#parameters-in-the-request-body}

All parameters must be URL-encoded. The maximum size of the POST request body is 30 KB.

Parameter | Description
----- | -----
`text` | Required parameter.<br/>UTF-8 encoded text for language detection.
`hint` | List of most probable languages (they will be given priority when detecting the language). The list items are comma-separated.
`folderId` | Required parameter.<br/>Your folder ID.<br/>Learn more about how to get a folder ID.


## Response {#response}

The response is returned in JSON format.

```json
{
    "language": <language_code>
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
     --data-urlencode "text=Hello world" \
     "https://translate.{{ api-host }}/translate/v1/detect"
```

### Response example {#response-example}

The response is returned in JSON format.

```json
{
    "language": "en"
}
```

