---
editable: false
apiPlayground:
  - url: https://compute.{{ api-host }}/compute/v1/instances/{instanceId}:relocate
    method: post
    path:
      type: object
      properties:
        instanceId:
          description: |-
            **string**
            ID of the instance to move.
            To get the instance ID, make a [InstanceService.List](/docs/compute/api-ref/Instance/list#List) request.
            The length must be less than or equal to 50.
            This field is required.
          type: string
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        destinationZoneId:
          description: |-
            **string**
            ID of the availability zone to move the instance to.
            To get the zone ID, make a [ZoneService.List](/docs/compute/api-ref/Zone/list#List) request.
            The length must be less than or equal to 50.
            This field is required.
          type: string
        networkInterfaceSpecs:
          description: |-
            **[NetworkInterfaceSpec](#yandex.cloud.compute.v1.NetworkInterfaceSpec)**
            Network configuration for the instance. Specifies how the network interface is configured
            to interact with other services on the internal network and on the internet.
            Currently only one network interface is supported per instance.
            The number of elements must be exactly 1.
            This field is required.
          type: array
          items:
            $ref: '#/definitions/NetworkInterfaceSpec'
        bootDiskPlacement:
          description: |-
            **[DiskPlacementPolicy](#yandex.cloud.compute.v1.DiskPlacementPolicy)**
            Boot disk placement policy configuration in target zone. Must be specified if disk has placement policy.
          $ref: '#/definitions/DiskPlacementPolicy'
        secondaryDiskPlacements:
          description: |-
            **[DiskPlacementPolicyChange](#yandex.cloud.compute.v1.DiskPlacementPolicyChange)**
            Secondary disk placement policy configurations in target zone. Must be specified for each disk that has placement policy.
          type: array
          items:
            $ref: '#/definitions/DiskPlacementPolicyChange'
      additionalProperties: false
    definitions:
      DnsRecordSpec:
        type: object
        properties:
          fqdn:
            description: |-
              **string**
              FQDN (required)
              This field is required.
            type: string
          dnsZoneId:
            description: |-
              **string**
              DNS zone id (optional, if not set, private zone used)
            type: string
          ttl:
            description: |-
              **string** (int64)
              DNS record ttl, values in 0-86400 (optional)
              The value must be between 0 and 86400.
            type: string
            format: int64
          ptr:
            description: |-
              **boolean**
              When set to true, also create PTR DNS record (optional)
            type: boolean
      OneToOneNatSpec:
        type: object
        properties:
          ipVersion:
            description: |-
              **enum** (IpVersion)
              External IP address version.
              - `IPV4`: IPv4 address, for example 192.0.2.235.
              - `IPV6`: IPv6 address. Not available yet.
            type: string
            enum:
              - IP_VERSION_UNSPECIFIED
              - IPV4
              - IPV6
          address:
            description: |-
              **string**
              set static IP by value
            type: string
          dnsRecordSpecs:
            description: |-
              **[DnsRecordSpec](#yandex.cloud.compute.v1.DnsRecordSpec)**
              External DNS configuration
            type: array
            items:
              $ref: '#/definitions/DnsRecordSpec'
      PrimaryAddressSpec:
        type: object
        properties:
          address:
            description: |-
              **string**
              An IPv4 internal network address that is assigned to the instance for this network interface.
              If not specified by the user, an unused internal IP is assigned by the system.
            type: string
          oneToOneNatSpec:
            description: |-
              **[OneToOneNatSpec](#yandex.cloud.compute.v1.OneToOneNatSpec)**
              An external IP address configuration.
              If not specified, then this instance will have no external internet access.
            $ref: '#/definitions/OneToOneNatSpec'
          dnsRecordSpecs:
            description: |-
              **[DnsRecordSpec](#yandex.cloud.compute.v1.DnsRecordSpec)**
              Internal DNS configuration
            type: array
            items:
              $ref: '#/definitions/DnsRecordSpec'
      NetworkInterfaceSpec:
        type: object
        properties:
          index:
            description: |-
              **string**
              The index of the network interface, will be generated by the server, 0,1,2... etc if not specified.
            type: string
          subnetId:
            description: |-
              **string**
              ID of the subnet.
              The length must be less than or equal to 50.
              This field is required.
            type: string
          primaryV4AddressSpec:
            description: |-
              **[PrimaryAddressSpec](#yandex.cloud.compute.v1.PrimaryAddressSpec)**
              Primary IPv4 address that will be assigned to the instance for this network interface.
            $ref: '#/definitions/PrimaryAddressSpec'
          primaryV6AddressSpec:
            description: |-
              **[PrimaryAddressSpec](#yandex.cloud.compute.v1.PrimaryAddressSpec)**
              Primary IPv6 address that will be assigned to the instance for this network interface. IPv6 not available yet.
            $ref: '#/definitions/PrimaryAddressSpec'
          securityGroupIds:
            description: |-
              **string**
              ID's of security groups attached to the interface
            type: array
            items:
              type: string
      DiskPlacementPolicy:
        type: object
        properties:
          placementGroupId:
            description: |-
              **string**
              Placement group ID.
            type: string
          placementGroupPartition:
            description: '**string** (int64)'
            type: string
            format: int64
      DiskPlacementPolicyChange:
        type: object
        properties:
          diskId:
            description: |-
              **string**
              Disk ID.
            type: string
          diskPlacementPolicy:
            description: |-
              **[DiskPlacementPolicy](#yandex.cloud.compute.v1.DiskPlacementPolicy)**
              Placement policy configuration for given disk.
            $ref: '#/definitions/DiskPlacementPolicy'
---

# Compute Cloud API, REST: Instance.Relocate

Moves the specified instance to another availability zone
Running instance will be restarted during this operation.

## HTTP request

```
POST https://compute.{{ api-host }}/compute/v1/instances/{instanceId}:relocate
```

## Path parameters

#|
||Field | Description ||
|| instanceId | **string**

Required field. ID of the instance to move.
To get the instance ID, make a [InstanceService.List](/docs/compute/api-ref/Instance/list#List) request.
The length must be less than or equal to 50.
This field is required. ||
|#

## Body parameters {#yandex.cloud.compute.v1.RelocateInstanceRequest}

```json
{
  "destinationZoneId": "string",
  "networkInterfaceSpecs": [
    {
      "index": "string",
      "subnetId": "string",
      "primaryV4AddressSpec": {
        "address": "string",
        "oneToOneNatSpec": {
          "ipVersion": "string",
          "address": "string",
          "dnsRecordSpecs": [
            {
              "fqdn": "string",
              "dnsZoneId": "string",
              "ttl": "string",
              "ptr": "boolean"
            }
          ]
        },
        "dnsRecordSpecs": [
          {
            "fqdn": "string",
            "dnsZoneId": "string",
            "ttl": "string",
            "ptr": "boolean"
          }
        ]
      },
      "primaryV6AddressSpec": {
        "address": "string",
        "oneToOneNatSpec": {
          "ipVersion": "string",
          "address": "string",
          "dnsRecordSpecs": [
            {
              "fqdn": "string",
              "dnsZoneId": "string",
              "ttl": "string",
              "ptr": "boolean"
            }
          ]
        },
        "dnsRecordSpecs": [
          {
            "fqdn": "string",
            "dnsZoneId": "string",
            "ttl": "string",
            "ptr": "boolean"
          }
        ]
      },
      "securityGroupIds": [
        "string"
      ]
    }
  ],
  "bootDiskPlacement": {
    "placementGroupId": "string",
    "placementGroupPartition": "string"
  },
  "secondaryDiskPlacements": [
    {
      "diskId": "string",
      "diskPlacementPolicy": {
        "placementGroupId": "string",
        "placementGroupPartition": "string"
      }
    }
  ]
}
```

#|
||Field | Description ||
|| destinationZoneId | **string**

ID of the availability zone to move the instance to.
To get the zone ID, make a [ZoneService.List](/docs/compute/api-ref/Zone/list#List) request.
The length must be less than or equal to 50.
This field is required. ||
|| networkInterfaceSpecs[] | **[NetworkInterfaceSpec](#yandex.cloud.compute.v1.NetworkInterfaceSpec)**

Network configuration for the instance. Specifies how the network interface is configured
to interact with other services on the internal network and on the internet.
Currently only one network interface is supported per instance.
The number of elements must be exactly 1.
This field is required. ||
|| bootDiskPlacement | **[DiskPlacementPolicy](#yandex.cloud.compute.v1.DiskPlacementPolicy)**

Boot disk placement policy configuration in target zone. Must be specified if disk has placement policy. ||
|| secondaryDiskPlacements[] | **[DiskPlacementPolicyChange](#yandex.cloud.compute.v1.DiskPlacementPolicyChange)**

Secondary disk placement policy configurations in target zone. Must be specified for each disk that has placement policy. ||
|#

## NetworkInterfaceSpec {#yandex.cloud.compute.v1.NetworkInterfaceSpec}

#|
||Field | Description ||
|| index | **string**

The index of the network interface, will be generated by the server, 0,1,2... etc if not specified. ||
|| subnetId | **string**

ID of the subnet.
The length must be less than or equal to 50.
This field is required. ||
|| primaryV4AddressSpec | **[PrimaryAddressSpec](#yandex.cloud.compute.v1.PrimaryAddressSpec)**

Primary IPv4 address that will be assigned to the instance for this network interface. ||
|| primaryV6AddressSpec | **[PrimaryAddressSpec](#yandex.cloud.compute.v1.PrimaryAddressSpec)**

Primary IPv6 address that will be assigned to the instance for this network interface. IPv6 not available yet. ||
|| securityGroupIds[] | **string**

ID's of security groups attached to the interface ||
|#

## PrimaryAddressSpec {#yandex.cloud.compute.v1.PrimaryAddressSpec}

#|
||Field | Description ||
|| address | **string**

An IPv4 internal network address that is assigned to the instance for this network interface.
If not specified by the user, an unused internal IP is assigned by the system. ||
|| oneToOneNatSpec | **[OneToOneNatSpec](#yandex.cloud.compute.v1.OneToOneNatSpec)**

An external IP address configuration.
If not specified, then this instance will have no external internet access. ||
|| dnsRecordSpecs[] | **[DnsRecordSpec](#yandex.cloud.compute.v1.DnsRecordSpec)**

Internal DNS configuration ||
|#

## OneToOneNatSpec {#yandex.cloud.compute.v1.OneToOneNatSpec}

#|
||Field | Description ||
|| ipVersion | **enum** (IpVersion)

External IP address version.

- `IPV4`: IPv4 address, for example 192.0.2.235.
- `IPV6`: IPv6 address. Not available yet. ||
|| address | **string**

set static IP by value ||
|| dnsRecordSpecs[] | **[DnsRecordSpec](#yandex.cloud.compute.v1.DnsRecordSpec)**

External DNS configuration ||
|#

## DnsRecordSpec {#yandex.cloud.compute.v1.DnsRecordSpec}

#|
||Field | Description ||
|| fqdn | **string**

FQDN (required)
This field is required. ||
|| dnsZoneId | **string**

DNS zone id (optional, if not set, private zone used) ||
|| ttl | **string** (int64)

DNS record ttl, values in 0-86400 (optional)
The value must be between 0 and 86400. ||
|| ptr | **boolean**

When set to true, also create PTR DNS record (optional) ||
|#

## DiskPlacementPolicy {#yandex.cloud.compute.v1.DiskPlacementPolicy}

#|
||Field | Description ||
|| placementGroupId | **string**

Placement group ID. ||
|| placementGroupPartition | **string** (int64) ||
|#

## DiskPlacementPolicyChange {#yandex.cloud.compute.v1.DiskPlacementPolicyChange}

#|
||Field | Description ||
|| diskId | **string**

Disk ID. ||
|| diskPlacementPolicy | **[DiskPlacementPolicy](#yandex.cloud.compute.v1.DiskPlacementPolicy)**

Placement policy configuration for given disk. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **object**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **object**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#