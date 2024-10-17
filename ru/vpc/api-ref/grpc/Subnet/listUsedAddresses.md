---
editable: false
sourcePath: en/_api-ref-grpc/vpc/v1/api-ref/grpc/Subnet/listUsedAddresses.md
---

# Virtual Private Cloud API, gRPC: SubnetService.ListUsedAddresses {#ListUsedAddresses}

List used addresses in specified subnet.

## gRPC request

**rpc ListUsedAddresses ([ListUsedAddressesRequest](#yandex.cloud.vpc.v1.ListUsedAddressesRequest)) returns ([ListUsedAddressesResponse](#yandex.cloud.vpc.v1.ListUsedAddressesResponse))**

## ListUsedAddressesRequest {#yandex.cloud.vpc.v1.ListUsedAddressesRequest}

```json
{
  "subnetId": "string",
  "pageSize": "int64",
  "pageToken": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| subnetId | **string**

Required field.  ||
|| pageSize | **int64** ||
|| pageToken | **string** ||
|| filter | **string** ||
|#

## ListUsedAddressesResponse {#yandex.cloud.vpc.v1.ListUsedAddressesResponse}

```json
{
  "addresses": [
    {
      "address": "string",
      "ipVersion": "IpVersion",
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
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| addresses[] | **[UsedAddress](#yandex.cloud.vpc.v1.UsedAddress)** ||
|| nextPageToken | **string** ||
|#

## UsedAddress {#yandex.cloud.vpc.v1.UsedAddress}

#|
||Field | Description ||
|| address | **string** ||
|| ipVersion | enum **IpVersion**

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