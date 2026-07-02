[Документация Yandex Cloud](../../../../index.md) > [Yandex Cloud DNS](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [DnsInboundEndpoint](index.md) > List

# Cloud DNS API, gRPC: DnsInboundEndpointService.List

Retrieves the list of DNS inbound endpoints in the specified folder.

## gRPC request

**rpc List ([ListDnsInboundEndpointsRequest](#yandex.cloud.dns.v1.ListDnsInboundEndpointsRequest)) returns ([ListDnsInboundEndpointsResponse](#yandex.cloud.dns.v1.ListDnsInboundEndpointsResponse))**

## ListDnsInboundEndpointsRequest {#yandex.cloud.dns.v1.ListDnsInboundEndpointsRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

ID of the folder to list DNS inbound endpoints in.

The maximum string length in characters is 50. ||
|| page_size | **int64**

The maximum number of results per page to return.

Acceptable values are 0 to 1000, inclusive. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the value returned by a previous list request.

The maximum string length in characters is 1000. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The maximum string length in characters is 1000. ||
|#

## ListDnsInboundEndpointsResponse {#yandex.cloud.dns.v1.ListDnsInboundEndpointsResponse}

```json
{
  "endpoints": [
    {
      "id": "string",
      "folder_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "map<string, string>",
      "network_id": "string",
      "address": "string",
      "address_id": "string",
      "status": "Status",
      "deletion_protection": "bool"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| endpoints[] | **[DnsInboundEndpoint](#yandex.cloud.dns.v1.DnsInboundEndpoint)**

List of DNS inbound endpoints. ||
|| next_page_token | **string**

Token for getting the next page of the list. ||
|#

## DnsInboundEndpoint {#yandex.cloud.dns.v1.DnsInboundEndpoint}

#|
||Field | Description ||
|| id | **string**

ID of the DNS inbound endpoint. Generated at creation time. ||
|| folder_id | **string**

ID of the folder that the DNS inbound endpoint belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the DNS inbound endpoint.
The name is unique within the folder. ||
|| description | **string**

Description of the DNS inbound endpoint. ||
|| labels | **object** (map<**string**, **string**>)

DNS inbound endpoint labels as `key:value` pairs. ||
|| network_id | **string**

ID of the network that the DNS inbound endpoint belongs to. ||
|| address | **string**

IP address of the DNS inbound endpoint. ||
|| address_id | **string**

ID of the address resource. ||
|| status | enum **Status**

Status of the DNS inbound endpoint.

- `PENDING`: Endpoint is being created.
- `AVAILABLE`: Endpoint is ready to use.
- `DELETING`: Endpoint is being deleted. ||
|| deletion_protection | **bool**

Prevents accidental endpoint removal. ||
|#