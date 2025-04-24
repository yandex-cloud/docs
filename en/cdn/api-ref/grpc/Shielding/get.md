---
editable: false
sourcePath: en/_api-ref-grpc/cdn/v1/api-ref/grpc/Shielding/get.md
---

# Cloud CDN API, gRPC: ShieldingService.Get

Get shielding details by resource ID.

## gRPC request

**rpc Get ([GetShieldingDetailsRequest](#yandex.cloud.cdn.v1.GetShieldingDetailsRequest)) returns ([ShieldingDetails](#yandex.cloud.cdn.v1.ShieldingDetails))**

## GetShieldingDetailsRequest {#yandex.cloud.cdn.v1.GetShieldingDetailsRequest}

```json
{
  "resource_id": "string"
}
```

Request to retrieve shielding details for a specific resource.

#|
||Field | Description ||
|| resource_id | **string**

Required field. ID of the resource for which to get shielding details. ||
|#

## ShieldingDetails {#yandex.cloud.cdn.v1.ShieldingDetails}

```json
{
  "location_id": "int64",
  "data_center": "string",
  "country": "string",
  "city": "string"
}
```

Message representing the details of a shielding server.

#|
||Field | Description ||
|| location_id | **int64**

Unique identifier for the geographical location of the shielding server. ||
|| data_center | **string**

Name of the data center where the shielding server is located. ||
|| country | **string**

Country where the shielding server's data center is located, useful for understanding geographical distribution. ||
|| city | **string**

City where the shielding server's data center is situated, providing a more precise location than just the country. ||
|#