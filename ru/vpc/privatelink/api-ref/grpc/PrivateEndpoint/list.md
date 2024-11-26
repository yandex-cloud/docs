---
editable: false
sourcePath: en/_api-ref-grpc/vpc/v1/privatelink/api-ref/grpc/PrivateEndpoint/list.md
---

# Virtual Private Cloud API, gRPC: PrivateEndpointService.List

Retrieves the list of PrivateEndpoint resources in the specified folder.

## gRPC request

**rpc List ([ListPrivateEndpointsRequest](#yandex.cloud.vpc.v1.privatelink.ListPrivateEndpointsRequest)) returns ([ListPrivateEndpointsResponse](#yandex.cloud.vpc.v1.privatelink.ListPrivateEndpointsResponse))**

## ListPrivateEndpointsRequest {#yandex.cloud.vpc.v1.privatelink.ListPrivateEndpointsRequest}

```json
{
  // Includes only one of the fields `folder_id`
  "folder_id": "string",
  // end of the list of possible fields
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

ID of the folder to list private endpoints in.

To get the folder ID use a
[yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request.

Includes only one of the fields `folder_id`. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of
available results is larger than `page_size`, the service returns a
[ListPrivateEndpointsResponse.next_page_token](#yandex.cloud.vpc.v1.privatelink.ListPrivateEndpointsResponse) that can be used to get the
next page of results in subsequent list requests. Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListPrivateEndpointsResponse.next_page_token](#yandex.cloud.vpc.v1.privatelink.ListPrivateEndpointsResponse) returned by a previous list
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

## ListPrivateEndpointsResponse {#yandex.cloud.vpc.v1.privatelink.ListPrivateEndpointsResponse}

```json
{
  "private_endpoints": [
    {
      "id": "string",
      "folder_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "string",
      "network_id": "string",
      "status": "Status",
      "address": {
        "subnet_id": "string",
        "address": "string",
        "address_id": "string"
      },
      "dns_options": {
        "private_dns_records_enabled": "bool"
      },
      // Includes only one of the fields `object_storage`
      "object_storage": "ObjectStorage"
      // end of the list of possible fields
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| private_endpoints[] | **[PrivateEndpoint](#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint)**

List of private endpoints. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is
greater than the specified [ListPrivateEndpointsRequest.page_size](#yandex.cloud.vpc.v1.privatelink.ListPrivateEndpointsRequest), use
`next_page_token` as the value for the
[ListPrivateEndpointsRequest.page_token](#yandex.cloud.vpc.v1.privatelink.ListPrivateEndpointsRequest) parameter in the next list
request.

Each subsequent page will have its own `next_page_token` to continue paging
through the results. ||
|#

## PrivateEndpoint {#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint}

#|
||Field | Description ||
|| id | **string**

ID of the private endpoint. Generated at creation time. ||
|| folder_id | **string**

ID of the folder that the private endpoint belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
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
|| network_id | **string**

ID of the network that the private endpoint belongs to. ||
|| status | enum **Status**

Status of the private endpoint.

- `STATUS_UNSPECIFIED`
- `PENDING`: Private endpoint is still creating / updating.
- `AVAILABLE`: Private endpoint is available.
- `DELETING`: Private endpoint is deleting. ||
|| address | **[EndpointAddress](#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.EndpointAddress)**

Private endpoint ip address details. ||
|| dns_options | **[DnsOptions](#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.DnsOptions)**

Private endpoint dns options. ||
|| object_storage | **[ObjectStorage](#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.ObjectStorage)**

Yandex Cloud Object Storage.

Includes only one of the fields `object_storage`.

Service to connect with via private endpoint. ||
|#

## EndpointAddress {#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.EndpointAddress}

Private endpoint ip address details.

#|
||Field | Description ||
|| subnet_id | **string**

ID of the subnet that the private endpoint address belongs to. ||
|| address | **string**

IP address of the private endpoint. ||
|| address_id | **string**

ID of the private endpoint address. ||
|#

## DnsOptions {#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.DnsOptions}

#|
||Field | Description ||
|| private_dns_records_enabled | **bool**

If enabled - vpc will create private dns records for specified service. ||
|#

## ObjectStorage {#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.ObjectStorage}

Yandex Cloud Object Storage.

#|
||Field | Description ||
|| Empty | > ||
|#