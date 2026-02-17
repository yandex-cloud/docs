---
editable: false
---

# Cloud CDN API, gRPC: ResourceService.GetAttributes

Get resource attributes.

## gRPC request

**rpc GetAttributes ([GetResourceAttributesRequest](#yandex.cloud.cdn.v1.GetResourceAttributesRequest)) returns ([GetResourceAttributesResponse](#yandex.cloud.cdn.v1.GetResourceAttributesResponse))**

## GetResourceAttributesRequest {#yandex.cloud.cdn.v1.GetResourceAttributesRequest}

```json
{
  "resource_id": "string"
}
```

#|
||Field | Description ||
|| resource_id | **string**

Required field. ID of the resource to get attributes for.

The maximum string length in characters is 50. ||
|#

## GetResourceAttributesResponse {#yandex.cloud.cdn.v1.GetResourceAttributesResponse}

```json
{
  "attributes": {
    // Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`
    "nullValue": "NullValue",
    "numberValue": "double",
    "stringValue": "string",
    "boolValue": "bool",
    "structValue": "google.protobuf.Struct",
    "listValue": {
      "values": [
        "Value"
      ]
    }
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| attributes | **[Value](#google.protobuf.Value)**

Resource attributes. ||
|#

## Value {#google.protobuf.Value}

#|
||Field | Description ||
|| nullValue | enum **NullValue**

Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`.

 ||
|| numberValue | **double**

Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`. ||
|| stringValue | **string**

Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`. ||
|| boolValue | **bool**

Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`. ||
|| structValue | **[google.protobuf.Struct](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/struct)**

Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`. ||
|| listValue | **[ListValue](#google.protobuf.ListValue)**

Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`. ||
|#

## ListValue {#google.protobuf.ListValue}

#|
||Field | Description ||
|| values[] | **[Value](#google.protobuf.Value)** ||
|#