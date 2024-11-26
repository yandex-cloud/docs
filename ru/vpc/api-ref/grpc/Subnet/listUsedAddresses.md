---
editable: false
sourcePath: en/_api-ref-grpc/vpc/v1/api-ref/grpc/Subnet/listUsedAddresses.md
---

# Virtual Private Cloud API, gRPC: SubnetService.ListUsedAddresses

List used addresses in specified subnet.

## gRPC request

**rpc ListUsedAddresses ([ListUsedAddressesRequest](#yandex.cloud.vpc.v1.ListUsedAddressesRequest)) returns ([ListUsedAddressesResponse](#yandex.cloud.vpc.v1.ListUsedAddressesResponse))**

## ListUsedAddressesRequest {#yandex.cloud.vpc.v1.ListUsedAddressesRequest}

```json
{
  "subnet_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| subnet_id | **string**

Required field.  ||
|| page_size | **int64** ||
|| page_token | **string** ||
|| filter | **string** ||
|#

## ListUsedAddressesResponse {#yandex.cloud.vpc.v1.ListUsedAddressesResponse}

```json
{
  "addresses": [
    {
      "address": "string",
      "ip_version": "IpVersion",
      "references": [
        {
          "referrer": {
            "type": "string",
            "id": "string"
          },
          "type": "Type"
        }
      ]
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| addresses[] | **[UsedAddress](#yandex.cloud.vpc.v1.UsedAddress)** ||
|| next_page_token | **string** ||
|#

## UsedAddress {#yandex.cloud.vpc.v1.UsedAddress}

#|
||Field | Description ||
|| address | **string** ||
|| ip_version | enum **IpVersion**

- `IP_VERSION_UNSPECIFIED`
- `IPV4`
- `IPV6` ||
|| references[] | **[Reference](#yandex.cloud.reference.Reference)** ||
|#

## Reference {#yandex.cloud.reference.Reference}

#|
||Field | Description ||
|| referrer | **[Referrer](#yandex.cloud.reference.Referrer)** ||
|| type | enum **Type**

- `TYPE_UNSPECIFIED`
- `MANAGED_BY`
- `USED_BY` ||
|#

## Referrer {#yandex.cloud.reference.Referrer}

#|
||Field | Description ||
|| type | **string**

`type = compute.instance, id = <instance id>`
* `type = compute.instanceGroup, id = <instanceGroup id>`
* `type = loadbalancer.networkLoadBalancer, id = <networkLoadBalancer id>`
* `type = managed-kubernetes.cluster, id = <cluster id>`
* `type = managed-mysql.cluster, id = <cluster id>` ||
|| id | **string** ||
|#