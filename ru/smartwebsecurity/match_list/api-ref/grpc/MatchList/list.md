---
editable: false
---

# SmartWebSecurity MatchList API, gRPC: MatchListService.List

Retrieves the list of MatchList resources in the specified folder.

## gRPC request

**rpc List ([ListMatchListsRequest](#yandex.cloud.smartwebsecurity.v1.match_list.ListMatchListsRequest)) returns ([ListMatchListsResponse](#yandex.cloud.smartwebsecurity.v1.match_list.ListMatchListsResponse))**

## ListMatchListsRequest {#yandex.cloud.smartwebsecurity.v1.match_list.ListMatchListsRequest}

```json
{
  "folder_id": "string"
}
```

Request message for MatchListService.List.

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list match lists in. ||
|#

## ListMatchListsResponse {#yandex.cloud.smartwebsecurity.v1.match_list.ListMatchListsResponse}

```json
{
  "lists": [
    {
      "id": "string",
      "folder_id": "string",
      "cloud_id": "string",
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
      ],
      "created_at": "google.protobuf.Timestamp",
      "updated_at": "google.protobuf.Timestamp"
    }
  ]
}
```

Response message for MatchListService.List.

#|
||Field | Description ||
|| lists[] | **[MatchList](#yandex.cloud.smartwebsecurity.v1.match_list.MatchList)**

List of match list resources. ||
|#

## MatchList {#yandex.cloud.smartwebsecurity.v1.match_list.MatchList}

A match list resource.

#|
||Field | Description ||
|| id | **string**

ID of the match list. ||
|| folder_id | **string**

ID of the folder that the match list belongs to. ||
|| cloud_id | **string**

ID of the cloud that the match list belongs to. ||
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

Required field. Match list type.

- `MANAGED`: Managed list type.
- `CUSTOM`: Custom list type. ||
|| item_type | enum **ItemType**

Required field. Match list item type.

- `IP`: IP list type.
- `BOT_NAME`: Bot name list type.
- `BOT_CATEGORY`: Bot category list type.
- `ASN`: ASN list type.
- `STR`: String list type.
- `REG_EXP`: Regular expression list type. ||
|| items[] | **[Item](#yandex.cloud.smartwebsecurity.v1.match_list.MatchList.Item)**

Match list items. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Update timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
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