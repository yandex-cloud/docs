---
editable: false
---

# SmartWebSecurity MatchList API, gRPC: MatchListService.Create

Creates a MatchList resource in the specified folder.

## gRPC request

**rpc Create ([CreateMatchListRequest](#yandex.cloud.smartwebsecurity.v1.match_list.CreateMatchListRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateMatchListRequest {#yandex.cloud.smartwebsecurity.v1.match_list.CreateMatchListRequest}

```json
{
  "folder_id": "string",
  "labels": "map<string, string>",
  "name": "string",
  "description": "string",
  "list_type": "ListType",
  "item_type": "ItemType",
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
|| folder_id | **string**

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
|| list_type | enum **ListType**

Match list type.

- `MANAGED`: Managed list type.
- `CUSTOM`: Custom list type. ||
|| item_type | enum **ItemType**

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

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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