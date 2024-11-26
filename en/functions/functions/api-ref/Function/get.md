---
editable: false
sourcePath: en/_api-ref/serverless/functions/v1/functions/api-ref/Function/get.md
---

# Cloud Functions Service, REST: Function.Get

Returns the specified function.

To get the list of all available functions, make a [List](/docs/functions/functions/api-ref/Function/list#List) request.

## HTTP request

```
GET https://serverless-functions.{{ api-host }}/functions/v1/functions/{functionId}
```

## Path parameters

#|
||Field | Description ||
|| functionId | **string**

Required field. ID of the function to return.

To get a function ID make a [FunctionService.List](/docs/functions/functions/api-ref/Function/list#List) request. ||
|#

## Response {#yandex.cloud.serverless.functions.v1.Function}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "string",
  "httpInvokeUrl": "string",
  "status": "string"
}
```

A serverless function. For details about the concept, see [Functions](/docs/functions/concepts/function).

#|
||Field | Description ||
|| id | **string**

ID of the function. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the function belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp for the function.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the function. The name is unique within the folder. ||
|| description | **string**

Description of the function. ||
|| labels | **string**

Function labels as `key:value` pairs. ||
|| httpInvokeUrl | **string**

URL that needs to be requested to invoke the function. ||
|| status | **enum** (Status)

Status of the function.

- `STATUS_UNSPECIFIED`
- `CREATING`: Function is being created.
- `ACTIVE`: Function is ready to be invoked.
- `DELETING`: Function is being deleted.
- `ERROR`: Function failed. ||
|#