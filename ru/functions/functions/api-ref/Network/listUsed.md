---
editable: false
sourcePath: en/_api-ref/serverless/functions/v1/functions/api-ref/Network/listUsed.md
---

# Cloud Functions Service, REST: Network.ListUsed

Retrieves the list of networks in the specified scope that are used in serverless resources.

## HTTP request

```
GET https://serverless-functions.{{ api-host }}/functions/v1/networks/used
```

## Query parameters {#yandex.cloud.serverless.functions.v1.ListUsedNetworksRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListUsedNetworksResponse.nextPageToken](#yandex.cloud.serverless.functions.v1.ListUsedNetworksResponse)
that can be used to get the next page of results in subsequent list requests.

Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListUsedNetworksResponse.nextPageToken](#yandex.cloud.serverless.functions.v1.ListUsedNetworksResponse) returned by a previous list request. ||
|| cloudId | **string**

ID of the cloud to list used networks in.

Includes only one of the fields `cloudId`, `folderId`. ||
|| folderId | **string**

ID of the folder to list used networks in.

Includes only one of the fields `cloudId`, `folderId`. ||
|#

## Response {#yandex.cloud.serverless.functions.v1.ListUsedNetworksResponse}

**HTTP Code: 200 - OK**

```json
{
  "networks": [
    {
      "networkId": "string",
      "cloudId": "string",
      "folderId": "string",
      "status": "string",
      "willBeCleanedUpAt": "string",
      "connectionsCount": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| networks[] | **[UsedNetwork](#yandex.cloud.serverless.functions.v1.UsedNetwork)**

List of used networks in the specified scope. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListUsedNetworksRequest.pageSize](#yandex.cloud.serverless.functions.v1.ListUsedNetworksRequest), use `nextPageToken` as the value
for the [ListUsedNetworksRequest.pageToken](#yandex.cloud.serverless.functions.v1.ListUsedNetworksRequest) parameter in the next list request.

Each subsequent page will have its own `nextPageToken` to continue paging through the results. ||
|#

## UsedNetwork {#yandex.cloud.serverless.functions.v1.UsedNetwork}

A VPC network used in serverless resources.

#|
||Field | Description ||
|| networkId | **string**

ID of the VPC network. ||
|| cloudId | **string**

ID of the cloud that the network belongs to. ||
|| folderId | **string**

ID of the folder that the network belongs to. ||
|| status | **enum** (Status)

Status of the network.

- `STATUS_UNSPECIFIED`
- `CREATING`: Network is connecting to its first serverless resource.
- `ACTIVE`: Network is already being used by some serverless resources.
- `OBSOLETE`: Network is no longer used by any serverless resources.
It will be cleaned-up after a while. ||
|| willBeCleanedUpAt | **string** (date-time)

Clean-up timestamp of the obsolete network.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| connectionsCount | **string** (int64)

Number of serverless resources connected to the network. ||
|#