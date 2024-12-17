---
editable: false
sourcePath: en/_api-ref/organizationmanager/v1/api-ref/Organization/get.md
---

# Cloud Organization API, REST: Organization.Get

Returns the specified Organization resource.

To get the list of available Organization resources, make a [List](/docs/organization/api-ref/Organization/list#List) request.

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/{organizationId}
```

## Path parameters

#|
||Field | Description ||
|| organizationId | **string**

Required field. ID of the Organization resource to return.
To get the organization ID, use a [OrganizationService.List](/docs/organization/api-ref/Organization/list#List) request. ||
|#

## Response {#yandex.cloud.organizationmanager.v1.Organization}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "title": "string",
  "labels": "object"
}
```

An Organization resource. For more information, see [Organization](/docs/organization/enable-org).

#|
||Field | Description ||
|| id | **string**

ID of the organization. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the organization. 3-63 characters long. ||
|| description | **string**

Description of the organization. 0-256 characters long. ||
|| title | **string**

Display name of the organization. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|#