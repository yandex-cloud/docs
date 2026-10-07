---
editable: false
---

# Yandex Cloud SIEM Queries API, gRPC: DatasetService.GetRecords

GetRecords retrieves the records of the specified Dataset.

## gRPC request

**rpc GetRecords ([GetRecordsRequest](#yandex.cloud.siem.v1.queries.GetRecordsRequest)) returns ([GetRecordsResponse](#yandex.cloud.siem.v1.queries.GetRecordsResponse))**

## GetRecordsRequest {#yandex.cloud.siem.v1.queries.GetRecordsRequest}

```json
{
  "dataset_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "time_range": {
    "time_from": "google.protobuf.Timestamp",
    "time_to": "google.protobuf.Timestamp"
  }
}
```

#|
||Field | Description ||
|| dataset_id | **string**

Required field. Required. ID of the dataset to get the records of.

The maximum string length in characters is 50. ||
|| page_size | **int64**

The maximum number of results per page that should be returned. If the number of available
results is larger than `page_size`, the service returns a `next_page_token` that can be used
to get the next page of results in subsequent requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100.

The maximum value is 1000. ||
|| page_token | **string**

Page token. Set `page_token` to the `next_page_token` returned by a previous
request to get the next page of results.

The maximum string length in characters is 100. ||
|| time_range | **[TimeRange](#yandex.cloud.siem.v1.common.TimeRange)**

Time range to get the records of.
If not set, the records will be returned for the entire dataset.
Only applied for datasets with time column set in the schema. ||
|#

## TimeRange {#yandex.cloud.siem.v1.common.TimeRange}

Range of time [time_from, time_to).

#|
||Field | Description ||
|| time_from | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Inclusive start of the time range. ||
|| time_to | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Exclusive end of the time range. ||
|#

## GetRecordsResponse {#yandex.cloud.siem.v1.queries.GetRecordsResponse}

```json
{
  "schema": {
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
  },
  "records": [
    {
      "values": [
        {
          // Includes only one of the fields `null_value`, `string_value`, `bool_value`, `int_value`, `double_value`, `timestamp_value`, `ipv4_value`, `ipv6_value`
          "null_value": "NullValue",
          "string_value": "string",
          "bool_value": "bool",
          "int_value": "int64",
          "double_value": "double",
          "timestamp_value": "google.protobuf.Timestamp",
          "ipv4_value": "string",
          "ipv6_value": "string",
          // end of the list of possible fields
          "items": [
            "Value"
          ],
          "fields": "map<string, Value>"
        }
      ]
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| schema | **[Schema](#yandex.cloud.siem.v1.common.Schema)**

Schema of the returned records ||
|| records[] | **[Record](#yandex.cloud.siem.v1.common.Record)**

Requested list of records. ||
|| next_page_token | **string**

This token allows you to get the next page of results for requests,
if the number of results is larger than `page_size` specified in the request.
To get the next page, specify the value of `next_page_token` as a value for
the `page_token` parameter in the next request. Subsequent requests will have their own
`next_page_token` to continue paging through the results. ||
|#

## Schema {#yandex.cloud.siem.v1.common.Schema}

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

## Record {#yandex.cloud.siem.v1.common.Record}

Record is a single row of the data, described by the Schema.

#|
||Field | Description ||
|| values[] | **[Value](#yandex.cloud.siem.v1.common.Value)**

Values of the record ||
|#

## Value {#yandex.cloud.siem.v1.common.Value}

Value is a single value of a Record, typed according to the Schema.

#|
||Field | Description ||
|| null_value | enum **NullValue**

null value

Includes only one of the fields `null_value`, `string_value`, `bool_value`, `int_value`, `double_value`, `timestamp_value`, `ipv4_value`, `ipv6_value`.

only set for scalar values

 ||
|| string_value | **string**

String value.

Includes only one of the fields `null_value`, `string_value`, `bool_value`, `int_value`, `double_value`, `timestamp_value`, `ipv4_value`, `ipv6_value`.

only set for scalar values ||
|| bool_value | **bool**

Boolean value.

Includes only one of the fields `null_value`, `string_value`, `bool_value`, `int_value`, `double_value`, `timestamp_value`, `ipv4_value`, `ipv6_value`.

only set for scalar values ||
|| int_value | **int64**

Integer value.

Includes only one of the fields `null_value`, `string_value`, `bool_value`, `int_value`, `double_value`, `timestamp_value`, `ipv4_value`, `ipv6_value`.

only set for scalar values ||
|| double_value | **double**

Double-precision floating-point value.

Includes only one of the fields `null_value`, `string_value`, `bool_value`, `int_value`, `double_value`, `timestamp_value`, `ipv4_value`, `ipv6_value`.

only set for scalar values ||
|| timestamp_value | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp value.

Includes only one of the fields `null_value`, `string_value`, `bool_value`, `int_value`, `double_value`, `timestamp_value`, `ipv4_value`, `ipv6_value`.

only set for scalar values ||
|| ipv4_value | **string**

IPv4 address value.

Includes only one of the fields `null_value`, `string_value`, `bool_value`, `int_value`, `double_value`, `timestamp_value`, `ipv4_value`, `ipv6_value`.

only set for scalar values ||
|| ipv6_value | **string**

IPv6 address value.

Includes only one of the fields `null_value`, `string_value`, `bool_value`, `int_value`, `double_value`, `timestamp_value`, `ipv4_value`, `ipv6_value`.

only set for scalar values ||
|| items[] | **[Value](#yandex.cloud.siem.v1.common.Value)**

only set for array values ||
|| fields | **object** (map<**string**, **[Value](#yandex.cloud.siem.v1.common.Value)**>)

only set for struct values ||
|#