---
editable: false
apiPlayground:
  - url: https://siem.{{ api-host }}/siem/v1/queries/normalizateSchema
    method: get
    path: null
    query:
      type: object
      properties:
        siemInstanceId:
          description: |-
            **string**
            Optional. ID of related SIEM instance.
            The maximum string length in characters is 50.
            Includes only one of the fields `siemInstanceId`, `workspaceId`.
            Required. Related SIEM instance by siem_instance_id or workspace_id.
          type: string
        workspaceId:
          description: |-
            **string**
            Optional. ID of related Security Deck Workspace
            The maximum string length in characters is 50.
            Includes only one of the fields `siemInstanceId`, `workspaceId`.
            Required. Related SIEM instance by siem_instance_id or workspace_id.
          type: string
      additionalProperties: false
      oneOf:
        - required:
            - siemInstanceId
        - required:
            - workspaceId
    body: null
    definitions: null
---

# Yandex Cloud SIEM Queries API, REST: Dataset.GetNormalizateSchema

GetNormalizateSchema retrieves the normalizate-dataset schema.

## HTTP request

```
GET https://siem.{{ api-host }}/siem/v1/queries/normalizateSchema
```

## Query parameters {#yandex.cloud.siem.v1.queries.GetNormalizateSchemaRequest}

#|
||Field | Description ||
|| siemInstanceId | **string**

Optional. ID of related SIEM instance.

The maximum string length in characters is 50.

Includes only one of the fields `siemInstanceId`, `workspaceId`.

Required. Related SIEM instance by siem_instance_id or workspace_id. ||
|| workspaceId | **string**

Optional. ID of related Security Deck Workspace

The maximum string length in characters is 50.

Includes only one of the fields `siemInstanceId`, `workspaceId`.

Required. Related SIEM instance by siem_instance_id or workspace_id. ||
|#

## Response {#yandex.cloud.siem.v1.common.Schema}

**HTTP Code: 200 - OK**

```json
{
  "structs": [
    {
      "name": "string",
      "fields": [
        {
          "name": "string",
          "type": {
            "kind": "string",
            "optional": "boolean",
            "name": "string",
            "arrayElementType": "object"
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
        "kind": "string",
        "optional": "boolean",
        "name": "string",
        "arrayElementType": "object"
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
            "kind": "string",
            "optional": "boolean",
            "name": "string",
            "arrayElementType": "object"
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
|| kind | **enum** (Kind)

Kind of the type

- `PRIMITIVE`: Primitive type.
- `ARRAY`: Array type.
- `STRUCT`: Structured type.
- `ENUM`: Enumeration type. ||
|| optional | **boolean**

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
|| arrayElementType | **[Type](#yandex.cloud.siem.v1.common.Type)**

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