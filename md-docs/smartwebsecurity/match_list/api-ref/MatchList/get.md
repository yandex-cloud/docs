# SmartWebSecurity MatchList API, REST: MatchList.Get

Returns the specified MatchList resource.

## HTTP request

```
GET https://smartwebsecurity.api.cloud.yandex.net/smartwebsecurity/v1/matchLists/{listId}
```

## Path parameters

Request message for MatchListService.Get.

#|
||Field | Description ||
|| listId | **string**

Required field. ID of the match list resource to return. ||
|#

## Response {#yandex.cloud.smartwebsecurity.v1.match_list.MatchList}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "cloudId": "string",
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
  ],
  "createdAt": "string",
  "updatedAt": "string"
}
```

A match list resource.

#|
||Field | Description ||
|| id | **string**

ID of the match list. ||
|| folderId | **string**

ID of the folder that the match list belongs to. ||
|| cloudId | **string**

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
|| listType | **enum** (ListType)

Required field. Match list type.

- `MANAGED`: Managed list type.
- `CUSTOM`: Custom list type. ||
|| itemType | **enum** (ItemType)

Required field. Match list item type.

- `IP`: IP list type.
- `BOT_NAME`: Bot name list type.
- `BOT_CATEGORY`: Bot category list type.
- `ASN`: ASN list type.
- `STR`: String list type.
- `REG_EXP`: Regular expression list type. ||
|| items[] | **[Item](#yandex.cloud.smartwebsecurity.v1.match_list.MatchList.Item)**

Match list items. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Update timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
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