---
editable: false
sourcePath: en/_api-ref/vpc/v1/privatelink/api-ref/PrivateEndpoint/list.md
---

# Virtual Private Cloud API, REST: PrivateEndpoint.List {#List}

Retrieves the list of PrivateEndpoint resources in the specified folder.

## HTTP request

```
GET https://vpc.{{ api-host }}/vpc/v1/endpoints
```

## Query parameters {#yandex.cloud.vpc.v1.privatelink.ListPrivateEndpointsRequest}

#|
||Field | Description ||
|| folderId | **string**

ID of the folder to list private endpoints in.

To get the folder ID use a
[yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.

Includes only one of the fields `folderId`. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of
available results is larger than `page_size`, the service returns a
[ListPrivateEndpointsResponse.nextPageToken](#yandex.cloud.vpc.v1.privatelink.ListPrivateEndpointsResponse) that can be used to get the
next page of results in subsequent list requests. Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListPrivateEndpointsResponse.nextPageToken](#yandex.cloud.vpc.v1.privatelink.ListPrivateEndpointsResponse) returned by a previous list
request. ||
|| filter | **string**

A filter expression that filters PrivateEndpoint listed in the response.

The expression must specify:
1. The field name. Currently you can use filtering only on
[PrivateEndpoint.name](#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match
the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. Example of a filter:
`name=my-private-endpoint`. ||
|#

## Response {#yandex.cloud.vpc.v1.privatelink.ListPrivateEndpointsResponse}

**HTTP Code: 200 - OK**

```json
{
  "privateEndpoints": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "string",
      "networkId": "string",
      "status": "string",
      "address": {
        "subnetId": "string",
        "address": "string",
        "addressId": "string"
      },
      "dnsOptions": {
        "privateDnsRecordsEnabled": "boolean"
      },
      // Includes only one of the fields `objectStorage`
      "objectStorage": "object"
      // end of the list of possible fields
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| privateEndpoints[] | **[PrivateEndpoint](#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint)**

List of private endpoints. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is
greater than the specified [ListPrivateEndpointsRequest.pageSize](#yandex.cloud.vpc.v1.privatelink.ListPrivateEndpointsRequest), use
`next_page_token` as the value for the
[ListPrivateEndpointsRequest.pageToken](#yandex.cloud.vpc.v1.privatelink.ListPrivateEndpointsRequest) parameter in the next list
request.

Each subsequent page will have its own `next_page_token` to continue paging
through the results. ||
|#

## PrivateEndpoint {#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint}

#|
||Field | Description ||
|| id | **string**

ID of the private endpoint. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the private endpoint belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the private endpoint.
The name is unique within the folder.
Value must match the regular expression
``\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``. ||
|| description | **string**

Description of the private endpoint. 0-256 characters long. ||
|| labels | **string**

Private endpoint labels as `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_0-9a-z]*`. ||
|| networkId | **string**

ID of the network that the private endpoint belongs to. ||
|| status | **enum** (Status)

Status of the private endpoint.

- `STATUS_UNSPECIFIED`
- `PENDING`: Private endpoint is still creating / updating.
- `AVAILABLE`: Private endpoint is available.
- `DELETING`: Private endpoint is deleting. ||
|| address | **[EndpointAddress](#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.EndpointAddress)**

Private endpoint ip address details. ||
|| dnsOptions | **[DnsOptions](#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.DnsOptions)**

Private endpoint dns options. ||
|| objectStorage | **object**

Yandex Cloud Object Storage.

Includes only one of the fields `objectStorage`.

Service to connect with via private endpoint. ||
|#

## EndpointAddress {#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.EndpointAddress}

Private endpoint ip address details.

#|
||Field | Description ||
|| subnetId | **string**

ID of the subnet that the private endpoint address belongs to. ||
|| address | **string**

IP address of the private endpoint. ||
|| addressId | **string**

ID of the private endpoint address. ||
|#

## DnsOptions {#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.DnsOptions}

#|
||Field | Description ||
|| privateDnsRecordsEnabled | **boolean**

If enabled - vpc will create private dns records for specified service. ||
|#