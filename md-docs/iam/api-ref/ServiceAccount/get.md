# Identity and Access Management API, REST: ServiceAccount.Get

Returns the specified ServiceAccount resource.
To get the list of available ServiceAccount resources, make a [List](list.md#List) request.

## HTTP request

```
GET https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts/{serviceAccountId}
```

## Path parameters

#|
||Field | Description ||
|| serviceAccountId | **string**

Required field. ID of the ServiceAccount resource to return.
To get the service account ID, use a [ServiceAccountService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.iam.v1.ServiceAccount}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "lastAuthenticatedAt": "string",
  "status": "string",
  "expiresAt": "string"
}
```

A ServiceAccount resource. For more information, see [Service accounts](../../concepts/users/service-accounts.md).

#|
||Field | Description ||
|| id | **string**

ID of the service account. ||
|| folderId | **string**

ID of the folder that the service account belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the service account.
The name is unique within the cloud. 3-63 characters long. ||
|| description | **string**

Description of the service account. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| lastAuthenticatedAt | **string** (date-time)

Timestamp for the last authentication of this service account.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| status | **enum** (Status)

Current status of the service account.
Determines whether the service account can authenticate and access the system.

- `CREATING`: The service account is in the process of being created.
- `ACTIVE`: The service account is active and can authenticate.
Active service accounts have full access to the system according to their permissions.
- `SUSPENDED`: The service account is suspended and cannot authenticate.
Suspended service accounts retain their data but cannot access the system.
- `DELETING`: The service account is in the process of being deleted.
This is a transitional state before the service account is completely removed from the system. ||
|| expiresAt | **string** (date-time)

Timestamp when the service account expires.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#