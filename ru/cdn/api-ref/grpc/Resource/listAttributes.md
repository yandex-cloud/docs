---
editable: false
---

# Cloud CDN API, gRPC: ResourceService.ListAttributes

List resource attributes.

## gRPC request

**rpc ListAttributes ([ListResourceAttributesRequest](#yandex.cloud.cdn.v1.ListResourceAttributesRequest)) returns ([ListResourceAttributesResponse](#yandex.cloud.cdn.v1.ListResourceAttributesResponse))**

## ListResourceAttributesRequest {#yandex.cloud.cdn.v1.ListResourceAttributesRequest}

```json
{
  "folder_id": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. Folder ID to list attributes.

The maximum string length in characters is 50. ||
|#

## ListResourceAttributesResponse {#yandex.cloud.cdn.v1.ListResourceAttributesResponse}

```json
{
  "attributes": "map<string, Value>"
}
```

#|
||Field | Description ||
|| attributes | **object** (map<**string**, **[Value](#google.protobuf.Value)**>)

Mapping resource ID to its attributes. ||
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