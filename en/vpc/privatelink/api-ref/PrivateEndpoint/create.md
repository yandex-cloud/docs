---
editable: false
apiPlayground:
  - url: https://vpc.{{ api-host }}/vpc/v1/endpoints
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to create a private endpoint in.
            To get a folder ID make a
            [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
          type: string
        name:
          description: |-
            **string**
            Name of the private endpoint.
            The name must be unique within the folder.
          pattern: '|[a-z]([-a-z0-9]{0,61}[a-z0-9])?'
          type: string
        description:
          description: |-
            **string**
            Description of the private endpoint.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Private endpoint labels as `key:value` pairs.
          pattern: '[a-z][-_./\@0-9a-z]*'
          type: string
        networkId:
          description: |-
            **string**
            Required field. ID of the network to create a private endpoint in.
          type: string
        addressSpec:
          description: |-
            **[AddressSpec](/docs/vpc/privatelink/api-ref/PrivateEndpoint/create#yandex.cloud.vpc.v1.privatelink.AddressSpec)**
            Private endpoint address specification.
          oneOf:
            - type: object
              properties:
                addressId:
                  description: |-
                    **string**
                    ID of IP address to associate with private endpoint.
                    Includes only one of the fields `addressId`, `internalIpv4AddressSpec`.
                  type: string
                internalIpv4AddressSpec:
                  description: |-
                    **[InternalIpv4AddressSpec](/docs/vpc/privatelink/api-ref/PrivateEndpoint/create#yandex.cloud.vpc.v1.privatelink.InternalIpv4AddressSpec)**
                    Internal ipv4 address specification.
                    Includes only one of the fields `addressId`, `internalIpv4AddressSpec`.
                  $ref: '#/definitions/InternalIpv4AddressSpec'
        dnsOptions:
          description: |-
            **[DnsOptions](/docs/vpc/privatelink/api-ref/PrivateEndpoint/get#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.DnsOptions)**
            Private endpoint dns options.
          $ref: '#/definitions/DnsOptions'
        objectStorage:
          description: |-
            **object**
            Yandex Cloud Object Storage.
            Includes only one of the fields `objectStorage`.
            Service to connect with via private endpoint.
          $ref: '#/definitions/ObjectStorage'
      required:
        - folderId
        - networkId
      additionalProperties: false
    definitions:
      InternalIpv4AddressSpec:
        type: object
        properties:
          subnetId:
            description: |-
              **string**
              Required field. ID of the subnet that address belongs to.
            type: string
          address:
            description: |-
              **string**
              Value of address.
            type: string
        required:
          - subnetId
      DnsOptions:
        type: object
        properties:
          privateDnsRecordsEnabled:
            description: |-
              **boolean**
              If enabled - vpc will create private dns records for specified service.
            type: boolean
      ObjectStorage:
        type: object
        properties: {}
sourcePath: en/_api-ref/vpc/v1/privatelink/api-ref/PrivateEndpoint/create.md
---

# Virtual Private Cloud API, REST: PrivateEndpoint.Create

Creates an private endpoint in the specified folder and network.

## HTTP request

```
POST https://vpc.{{ api-host }}/vpc/v1/endpoints
```

## Body parameters {#yandex.cloud.vpc.v1.privatelink.CreatePrivateEndpointRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "networkId": "string",
  "addressSpec": {
    // Includes only one of the fields `addressId`, `internalIpv4AddressSpec`
    "addressId": "string",
    "internalIpv4AddressSpec": {
      "subnetId": "string",
      "address": "string"
    }
    // end of the list of possible fields
  },
  "dnsOptions": {
    "privateDnsRecordsEnabled": "boolean"
  },
  // Includes only one of the fields `objectStorage`
  "objectStorage": "object"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create a private endpoint in.

To get a folder ID make a
[yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| name | **string**

Name of the private endpoint.
The name must be unique within the folder. ||
|| description | **string**

Description of the private endpoint. ||
|| labels | **object** (map<**string**, **string**>)

Private endpoint labels as `key:value` pairs. ||
|| networkId | **string**

Required field. ID of the network to create a private endpoint in. ||
|| addressSpec | **[AddressSpec](#yandex.cloud.vpc.v1.privatelink.AddressSpec)**

Private endpoint address specification. ||
|| dnsOptions | **[DnsOptions](#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.DnsOptions)**

Private endpoint dns options. ||
|| objectStorage | **object**

Yandex Cloud Object Storage.

Includes only one of the fields `objectStorage`.

Service to connect with via private endpoint. ||
|#

## AddressSpec {#yandex.cloud.vpc.v1.privatelink.AddressSpec}

#|
||Field | Description ||
|| addressId | **string**

ID of IP address to associate with private endpoint.

Includes only one of the fields `addressId`, `internalIpv4AddressSpec`. ||
|| internalIpv4AddressSpec | **[InternalIpv4AddressSpec](#yandex.cloud.vpc.v1.privatelink.InternalIpv4AddressSpec)**

Internal ipv4 address specification.

Includes only one of the fields `addressId`, `internalIpv4AddressSpec`. ||
|#

## InternalIpv4AddressSpec {#yandex.cloud.vpc.v1.privatelink.InternalIpv4AddressSpec}

#|
||Field | Description ||
|| subnetId | **string**

Required field. ID of the subnet that address belongs to. ||
|| address | **string**

Value of address. ||
|#

## DnsOptions {#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.DnsOptions}

#|
||Field | Description ||
|| privateDnsRecordsEnabled | **boolean**

If enabled - vpc will create private dns records for specified service. ||
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
  "metadata": {
    "privateEndpointId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
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
|| metadata | **[CreatePrivateEndpointMetadata](#yandex.cloud.vpc.v1.privatelink.CreatePrivateEndpointMetadata)**

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
|| response | **[PrivateEndpoint](#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint)**

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

## CreatePrivateEndpointMetadata {#yandex.cloud.vpc.v1.privatelink.CreatePrivateEndpointMetadata}

#|
||Field | Description ||
|| privateEndpointId | **string**

ID of the private endpoint that is being created. ||
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
|| labels | **object** (map<**string**, **string**>)

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
|| dnsOptions | **[DnsOptions](#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.DnsOptions2)**

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

## DnsOptions {#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.DnsOptions2}

#|
||Field | Description ||
|| privateDnsRecordsEnabled | **boolean**

If enabled - vpc will create private dns records for specified service. ||
|#