---
editable: false
sourcePath: en/_api-ref-grpc/marketplace/pim/v1/saas/pim/saas/api-ref/grpc/ProductInstance/get.md
---

# Yandex Cloud Marketplace Product Instance Management API, gRPC: ProductInstanceService.Get

Returns the specified product instance.

## gRPC request

**rpc Get ([GetProductInstanceRequest](#yandex.cloud.marketplace.pim.v1.saas.GetProductInstanceRequest)) returns ([ProductInstance](#yandex.cloud.marketplace.pim.v1.saas.ProductInstance))**

## GetProductInstanceRequest {#yandex.cloud.marketplace.pim.v1.saas.GetProductInstanceRequest}

```json
{
  "product_instance_id": "string"
}
```

#|
||Field | Description ||
|| product_instance_id | **string**

Required field. ID of the product instance to return. ||
|#

## ProductInstance {#yandex.cloud.marketplace.pim.v1.saas.ProductInstance}

```json
{
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
```

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
|| saas_info | **[SaasInfo](#yandex.cloud.marketplace.pim.v1.saas.SaasInfo)**

Includes only one of the fields `saas_info`.

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