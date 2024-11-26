---
editable: false
sourcePath: en/_api-ref/datasphere/v2/api-ref/Community/get.md
---

# DataSphere API v2, REST: Community.Get

Returns community.

## HTTP request

```
GET https://datasphere.{{ api-host }}/datasphere/v2/communities/{communityId}
```

## Path parameters

#|
||Field | Description ||
|| communityId | **string**

Required field. ID of the community. ||
|#

## Response {#yandex.cloud.datasphere.v2.Community}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "string",
  "createdById": "string",
  "organizationId": "string",
  "zoneId": "string"
}
```

#|
||Field | Description ||
|| id | **string**

ID of the community. ||
|| createdAt | **string** (date-time)

Time when community was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the community. ||
|| description | **string**

Description of the comminuty. ||
|| labels | **string**

Labels of the community. ||
|| createdById | **string**

ID of the user who created the community. ||
|| organizationId | **string**

ID of the organization to which community belongs. ||
|| zoneId | **string**

ID of the zone where this community was created ||
|#