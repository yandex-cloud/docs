---
editable: false
apiPlayground:
  - url: https://iam.{{ api-host }}/iam/v1/serviceAccounts/{serviceAccountId}
    method: get
    path:
      type: object
      properties:
        serviceAccountId:
          description: |-
            **string**
            Required field. ID of the ServiceAccount resource to return.
            To get the service account ID, use a [ServiceAccountService.List](/docs/iam/api-ref/ServiceAccount/list#List) request.
          type: string
      required:
        - serviceAccountId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/iam/v1/api-ref/ServiceAccount/get.md
---

# Identity and Access Management API, REST: ServiceAccount.Get

Returns the specified ServiceAccount resource.

To get the list of available ServiceAccount resources, make a [List](/docs/iam/api-ref/ServiceAccount/list#List) request.

## HTTP request

```
GET https://iam.{{ api-host }}/iam/v1/serviceAccounts/{serviceAccountId}
```

## Path parameters

#|
||Field | Description ||
|| serviceAccountId | **string**

Required field. ID of the ServiceAccount resource to return.
To get the service account ID, use a [ServiceAccountService.List](/docs/iam/api-ref/ServiceAccount/list#List) request. ||
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
  "lastAuthenticatedAt": "string"
}
```

A ServiceAccount resource. For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts).

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
|#