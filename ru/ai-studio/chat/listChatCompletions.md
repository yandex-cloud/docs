---
editable: false
sourcePath: en/_openapi/openai-compatible/chat/listChatCompletions.md
---

# REST: List Chat Completions

[CURRENTLY NOT SUPPORTED]

## HTTP request

```
GET https://ai.api.cloud.yandex.net/v1/chat/completions
```

## Query parameters

#|
||Field | Description ||
|| model | **string**

The model used to generate the Chat Completions. ||
|| metadata | **unknown**

A list of metadata keys to filter the Chat Completions by. Example: `metadata[key1]=value1&metadata[key2]=value2` ||
|| after | **string**

Identifier for the last chat completion from the previous pagination request. ||
|| limit | **integer**

Number of Chat Completions to retrieve. ||
|| order | **enum**

Sort order for Chat Completions by timestamp. Use `asc` for ascending order or `desc` for descending order. Defaults to `asc`.

- `asc`
- `desc` ||
|#

## Response {#200}

**HTTP Code: 200**

A list of Chat Completions

**Response schema: application/json**

```json
{
  "role": "string",
  "content": "unknown",
  "name": "string"
}
```

Schema reference for server-to-client Realtime events. Servers emit JSON messages where the `type` field selects the event schema.

#|
||Field | Description ||
|| role | **enum**

Required field. The role of the messages author, in this case `function`.

- `function` ||
|| content | Any of **string** \| **null** ||
|| name | **string**

Required field. The name of the function to call. ||
|#