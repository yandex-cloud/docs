---
editable: false
---

# Yandex Cloud SIEM Queries API, gRPC: DatasetService.GetNormalizateSchema

GetNormalizateSchema retrieves the normalizate-dataset schema.

## gRPC request

**rpc GetNormalizateSchema ([GetNormalizateSchemaRequest](#yandex.cloud.siem.v1.queries.GetNormalizateSchemaRequest)) returns ([common.Schema](#yandex.cloud.siem.v1.common.Schema))**

## GetNormalizateSchemaRequest {#yandex.cloud.siem.v1.queries.GetNormalizateSchemaRequest}

```json
{
  // Includes only one of the fields `siem_instance_id`, `workspace_id`
  "siem_instance_id": "string",
  "workspace_id": "string"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| siem_instance_id | **string**

Optional. ID of related SIEM instance.

The maximum string length in characters is 50.

Includes only one of the fields `siem_instance_id`, `workspace_id`.

Required. Related SIEM instance by siem_instance_id or workspace_id. ||
|| workspace_id | **string**

Optional. ID of related Security Deck Workspace

The maximum string length in characters is 50.

Includes only one of the fields `siem_instance_id`, `workspace_id`.

Required. Related SIEM instance by siem_instance_id or workspace_id. ||
|#

## common.Schema {#yandex.cloud.siem.v1.common.Schema}

```json
{
  "structs": [
    {
      "name": "string",
      "fields": [
        {
          "name": "string",
          "type": {
            "kind": "Kind",
            "optional": "bool",
            "name": "string",
            "array_element_type": "Type"
          }
        }
      ]
    }
  ],
  "enums": [
    {
      "name": "string",
      "values": [
        "string"
      ]
    }
  ],
  "fields": [
    {
      "name": "string",
      "type": {
        "kind": "Kind",
        "optional": "bool",
        "name": "string",
        "array_element_type": "Type"
      }
    }
  ],
  "classes": [
    {
      "name": "string",
      "fields": [
        {
          "name": "string",
          "type": {
            "kind": "Kind",
            "optional": "bool",
            "name": "string",
            "array_element_type": "Type"
          }
        }
      ]
    }
  ]
}
```

Schema describes the structure of the data.

#|
||Field | Description ||
|| structs[] | **[StructType](#yandex.cloud.siem.v1.common.StructType)**

Structs, that may be used as field type in the schema ||
|| enums[] | **[EnumType](#yandex.cloud.siem.v1.common.EnumType)**

Enums, that may be used as field type in the schema ||
|| fields[] | **[Field](#yandex.cloud.siem.v1.common.Field)**

Fields of the schema ||
|| classes[] | **[Class](#yandex.cloud.siem.v1.common.Class)**

Classes of the schema ||
|#

## StructType {#yandex.cloud.siem.v1.common.StructType}

StructType is a named set of Fields that may be used as a field type in the Schema.

#|
||Field | Description ||
|| name | **string**

Name of the struct type. ||
|| fields[] | **[Field](#yandex.cloud.siem.v1.common.Field)**

Fields that comprise the struct type. ||
|#

## Field {#yandex.cloud.siem.v1.common.Field}

Field is a named typed element of the Schema.

#|
||Field | Description ||
|| name | **string**

Name of the field. ||
|| type | **[Type](#yandex.cloud.siem.v1.common.Type)**

Type of the field. ||
|#

## Type {#yandex.cloud.siem.v1.common.Type}

Type describes the type of a single Field.

#|
||Field | Description ||
|| kind | enum **Kind**

Kind of the type

- `PRIMITIVE`: Primitive type.
- `ARRAY`: Array type.
- `STRUCT`: Structured type.
- `ENUM`: Enumeration type. ||
|| optional | **bool**

Whether the field is optional ||
|| name | **string**

Name of the type
For PRIMITIVE type, it is the name of the primitive type:
- string
- bool
- int
- decimal
- timestamp
- ipv4
- ipv6

For STRUCT type, it is the name of the struct type, that is defined in `structs` list

For ENUM type, it is the name of the enum type, that is defined in `enums` list

For ARRAY type, it is ignored and the name of the array element type is used instead ||
|| array_element_type | **[Type](#yandex.cloud.siem.v1.common.Type)**

Type of the array element. Only used for ARRAY type. ||
|#

## EnumType {#yandex.cloud.siem.v1.common.EnumType}

EnumType is a named set of string values that may be used as a field type in the Schema.

#|
||Field | Description ||
|| name | **string**

Name of the enum type. ||
|| values[] | **string**

Values defined by the enum type. ||
|#

## Class {#yandex.cloud.siem.v1.common.Class}

Class is a named group of Fields of the Schema.

#|
||Field | Description ||
|| name | **string**

Name of the class. ||
|| fields[] | **[Field](#yandex.cloud.siem.v1.common.Field)**

Fields that belong to the class. ||
|#