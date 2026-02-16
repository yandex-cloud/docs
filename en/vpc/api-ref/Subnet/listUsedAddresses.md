---
editable: false
apiPlayground:
  - url: https://vpc.{{ api-host }}/vpc/v1/subnets/{subnetId}/addresses
    method: get
    path:
      type: object
      properties:
        subnetId:
          description: |-
            **string**
            Required field. 
          type: string
      required:
        - subnetId
      additionalProperties: false
    query:
      type: object
      properties:
        pageSize:
          description: '**string** (int64)'
          type: string
          format: int64
        pageToken:
          description: '**string**'
          type: string
        filter:
          description: '**string**'
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/vpc/v1/api-ref/Subnet/listUsedAddresses.md
---

# Virtual Private Cloud API, REST: Subnet.ListUsedAddresses

List used addresses in specified subnet.

## HTTP request

```
GET https://vpc.{{ api-host }}/vpc/v1/subnets/{subnetId}/addresses
```

## Path parameters

#|
||Field | Description ||
|| subnetId | **string**

Required field.  ||
|#

## Query parameters {#yandex.cloud.vpc.v1.ListUsedAddressesRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64) ||
|| pageToken | **string** ||
|| filter | **string** ||
|#

## Response {#yandex.cloud.vpc.v1.ListUsedAddressesResponse}

**HTTP Code: 200 - OK**

```json
{
  "addresses": [
    {
      "address": "string",
      "ipVersion": "string",
      "references": [
        {
          "referrer": {
            "type": "string",
            "id": "string"
          },
          "type": "string"
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
|| ipVersion | **enum** (IpVersion)

- `IP_VERSION_UNSPECIFIED`
- `IPV4`
- `IPV6` ||
|| references[] | **[Reference](#yandex.cloud.reference.Reference)** ||
|#

## Reference {#yandex.cloud.reference.Reference}

#|
||Field | Description ||
|| referrer | **[Referrer](#yandex.cloud.reference.Referrer)** ||
|| type | **enum** (Type)

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