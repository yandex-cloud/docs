---
editable: false
---

# Managed Services for Kubernetes API, gRPC: ResourcePresetService.Get

Returns the specified ResourcePreset resource.

## gRPC request

**rpc Get ([GetResourcePresetRequest](#yandex.cloud.k8s.v1.GetResourcePresetRequest)) returns ([ResourcePreset](#yandex.cloud.k8s.v1.ResourcePreset))**

## GetResourcePresetRequest {#yandex.cloud.k8s.v1.GetResourcePresetRequest}

```json
{
  "resource_preset_id": "string"
}
```

#|
||Field | Description ||
|| resource_preset_id | **string**

Required field. Required. ID of the resource preset to return. ||
|#

## ResourcePreset {#yandex.cloud.k8s.v1.ResourcePreset}

```json
{
  "id": "string",
  "cores": "int64",
  "core_fraction": "int64",
  "memory": "int64"
}
```

A ResourcePreset resource for describing hardware configuration presets.

#|
||Field | Description ||
|| id | **string**

Human-readable ID of the preset.

The minimum string length in characters is 1. ||
|| cores | **int64**

Number of CPU cores for an instance created with the preset.

The minimum value is 1. ||
|| core_fraction | **int64**

Baseline level of CPU performance with the possibility to burst performance above that baseline level.
This field sets baseline performance for each core.

Acceptable values are 1 to 100, inclusive. ||
|| memory | **int64**

RAM volume for an instance created with the preset, in bytes.

The minimum value is 1. ||
|#