---
editable: false
sourcePath: en/_api-ref/iam/v1/api-ref/ServiceAccount/list.md
---

# Identity and Access Management API, REST: ServiceAccount.List

Retrieves the list of ServiceAccount resources in the specified folder.

## HTTP request

```
GET https://iam.{{ api-host }}/iam/v1/serviceAccounts
```

## Query parameters {#yandex.cloud.iam.v1.ListServiceAccountsRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list service accounts in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListServiceAccountsResponse.nextPageToken](#yandex.cloud.iam.v1.ListServiceAccountsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100 ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken`
to the [ListServiceAccountsResponse.nextPageToken](#yandex.cloud.iam.v1.ListServiceAccountsResponse)
returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on the [ServiceAccount.name](#yandex.cloud.iam.v1.ServiceAccount) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|#

## Response {#yandex.cloud.iam.v1.ListServiceAccountsResponse}

**HTTP Code: 200 - OK**

```json
{
  "serviceAccounts": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "lastAuthenticatedAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| serviceAccounts[] | **[ServiceAccount](#yandex.cloud.iam.v1.ServiceAccount)**

List of ServiceAccount resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListServiceAccountsRequest.pageSize](#yandex.cloud.iam.v1.ListServiceAccountsRequest), use
the `nextPageToken` as the value
for the [ListServiceAccountsRequest.pageToken](#yandex.cloud.iam.v1.ListServiceAccountsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## ServiceAccount {#yandex.cloud.iam.v1.ServiceAccount}

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