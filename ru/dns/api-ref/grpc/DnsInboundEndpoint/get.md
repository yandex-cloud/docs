---
editable: false
---

# Cloud DNS API, gRPC: DnsInboundEndpointService.Get

Returns the specified DNS inbound endpoint.
To get the list of all available DNS inbound endpoints, make a [List](/docs/dns/api-ref/grpc/DnsInboundEndpoint/list#List) request.

## gRPC request

**rpc Get ([GetDnsInboundEndpointRequest](#yandex.cloud.dns.v1.GetDnsInboundEndpointRequest)) returns ([DnsInboundEndpoint](#yandex.cloud.dns.v1.DnsInboundEndpoint))**

## GetDnsInboundEndpointRequest {#yandex.cloud.dns.v1.GetDnsInboundEndpointRequest}

```json
{
  "dns_inbound_endpoint_id": "string"
}
```

#|
||Field | Description ||
|| dns_inbound_endpoint_id | **string**

Required field. ID of the DNS inbound endpoint to return.

The maximum string length in characters is 50. ||
|#

## DnsInboundEndpoint {#yandex.cloud.dns.v1.DnsInboundEndpoint}

```json
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
```

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