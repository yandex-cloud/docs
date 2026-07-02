[Документация Yandex Cloud](../../../../index.md) > [Yandex Smart Web Security](../../../index.md) > Справочник API > REST (англ.) > [SmartWebSecurity MatchList API](../index.md) > [MatchList](index.md) > Create

# SmartWebSecurity MatchList API, REST: MatchList.Create

Creates a MatchList resource in the specified folder.

## HTTP request

```
POST https://smartwebsecurity.api.cloud.yandex.net/smartwebsecurity/v1/matchLists
```

## Body parameters {#yandex.cloud.smartwebsecurity.v1.match_list.CreateMatchListRequest}

```json
{
  "folderId": "string",
  "labels": "object",
  "name": "string",
  "description": "string",
  "listType": "string",
  "itemType": "string",
  "items": [
    {
      "value": "string",
      "description": "string"
    }
  ]
}
```

Request message for MatchListService.Create.

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create the match list in. ||
|| labels | **object** (map<**string**, **string**>)

Labels as `` key:value `` pairs. Maximum of 64 per resource.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| name | **string**

Required field. Name of the match list.

The string length in characters must be 1-50. Value must match the regular expression ` [a-zA-Z0-9][a-zA-Z0-9-_.]* `. ||
|| description | **string**

Description of the match list.

The maximum string length in characters is 512. ||
|| listType | **enum** (ListType)

Match list type.

- `MANAGED`: Managed list type.
- `CUSTOM`: Custom list type. ||
|| itemType | **enum** (ItemType)

Match list item type.

- `IP`: IP list type.
- `BOT_NAME`: Bot name list type.
- `BOT_CATEGORY`: Bot category list type.
- `ASN`: ASN list type.
- `STR`: String list type.
- `REG_EXP`: Regular expression list type. ||
|| items[] | **[Item](#yandex.cloud.smartwebsecurity.v1.match_list.MatchList.Item)**

Match list items. ||
|#

## Item {#yandex.cloud.smartwebsecurity.v1.match_list.MatchList.Item}

Item

#|
||Field | Description ||
|| value | **string**

Required field. Value of the item.

The maximum string length in characters is 256. ||
|| description | **string**

Description of the item.

The maximum string length in characters is 128. ||
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