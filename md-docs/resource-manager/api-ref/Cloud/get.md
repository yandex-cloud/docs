[Документация Yandex Cloud](../../../index.md) > [Yandex Resource Manager](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [Cloud](index.md) > Get

# Resource Manager API, REST: Cloud.Get

Returns the specified Cloud resource.
To get the list of available Cloud resources, make a [List](list.md#List) request.

## HTTP request

```
GET https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds/{cloudId}
```

## Path parameters

#|
||Field | Description ||
|| cloudId | **string**

Required field. ID of the Cloud resource to return.
To get the cloud ID, use a [CloudService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.resourcemanager.v1.Cloud}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "organizationId": "string",
  "labels": "object"
}
```

A Cloud resource. For more information, see [Cloud](../../concepts/resources-hierarchy.md#cloud).

#|
||Field | Description ||
|| id | **string**

ID of the cloud. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the cloud. 3-63 characters long. ||
|| description | **string**

Description of the cloud. 0-256 characters long. ||
|| organizationId | **string**

ID of the organization that the cloud belongs to. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|#