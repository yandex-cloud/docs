---
editable: false
sourcePath: en/_api-ref-grpc/marketplace/pim/v1/saas/pim/saas/api-ref/grpc/ProductInstance/claim.md
---

# Yandex Cloud Marketplace Product Instance Management API, gRPC: ProductInstanceService.Claim

Claims a product instance - activates it and optionally locks to subscription

## gRPC request

**rpc Claim ([ClaimProductInstanceRequest](#yandex.cloud.marketplace.pim.v1.saas.ClaimProductInstanceRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## ClaimProductInstanceRequest {#yandex.cloud.marketplace.pim.v1.saas.ClaimProductInstanceRequest}

```json
{
  "token": "string",
  "resource_id": "string",
  "resource_info": {
    "id": "string",
    "data": "map<string, string>"
  }
}
```

#|
||Field | Description ||
|| token | **string**

Required field. Signed JWT token which contains information about product instance and subscription. ||
|| resource_id | **string**

ID of the resource to which the product instance will be claimed. ||
|| resource_info | **[SaasInfo](#yandex.cloud.marketplace.pim.v1.saas.SaasInfo)**

Additional information about the resource. ||
|#

## SaasInfo {#yandex.cloud.marketplace.pim.v1.saas.SaasInfo}

#|
||Field | Description ||
|| id | **string**

ID of the SaaS resource. ||
|| data | **object** (map<**string**, **string**>)

Additional data about the SaaS resource. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "product_id": "string",
    "product_instance_id": "string",
    "license_instance_id": "string",
    "lock_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "resource_id": "string",
    "resource_type": "ResourceType",
    "resource_metadata": "map<string, string>",
    "state": "State",
    "created_at": "google.protobuf.Timestamp",
    "updated_at": "google.protobuf.Timestamp",
    // Includes only one of the fields `saas_info`
    "saas_info": {
      "id": "string",
      "data": "map<string, string>"
    }
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[ClaimProductInstanceMetadata](#yandex.cloud.marketplace.pim.v1.saas.ClaimProductInstanceMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[ProductInstance](#yandex.cloud.marketplace.pim.v1.saas.ProductInstance)**

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

## ClaimProductInstanceMetadata {#yandex.cloud.marketplace.pim.v1.saas.ClaimProductInstanceMetadata}

#|
||Field | Description ||
|| product_id | **string**

ID of the product to which the product instance belongs. ||
|| product_instance_id | **string**

ID of the product instance. ||
|| license_instance_id | **string**

ID of the subscription. ||
|| lock_id | **string**

ID of the subscription lock. ||
|#

## ProductInstance {#yandex.cloud.marketplace.pim.v1.saas.ProductInstance}

#|
||Field | Description ||
|| id | **string**

ID of the product instance. ||
|| resource_id | **string**

ID of the resource. ||
|| resource_type | enum **ResourceType**

Type of the resource.

- `RESOURCE_TYPE_UNSPECIFIED`
- `SAAS`: SaaS resource.
- `K8S`: Kubernetes resource.
- `COMPUTE`: Compute resource.
- `CLOUD_APPS`: Cloud Apps resource. ||
|| resource_metadata | **object** (map<**string**, **string**>)

Metadata of the resource; Reserved for future use. ||
|| state | enum **State**

State of the product instance.

- `STATE_UNSPECIFIED`
- `ACTIVATED`: Product instance is activated.
- `DEACTIVATED`: Product instance is deactivated.
- `PENDING_ACTIVATION`: Product instance is pending activation.
- `DEPRECATED`: Product instance is deprecated.
- `DELETED`: Product instance is deleted. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Update timestamp ||
|| saas_info | **[SaasInfo](#yandex.cloud.marketplace.pim.v1.saas.SaasInfo2)**

Includes only one of the fields `saas_info`.

Additional information about the resource. ||
|#

## SaasInfo {#yandex.cloud.marketplace.pim.v1.saas.SaasInfo2}

#|
||Field | Description ||
|| id | **string**

ID of the SaaS resource. ||
|| data | **object** (map<**string**, **string**>)

Additional data about the SaaS resource. ||
|#