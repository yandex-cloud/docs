---
editable: false
apiPlayground:
  - url: https://siem.{{ api-host }}/siem/v1/queries/datasets/{datasetId}/records
    method: get
    path:
      type: object
      properties:
        datasetId:
          description: |-
            **string**
            Required field. Required. ID of the dataset to get the records of.
            The maximum string length in characters is 50.
          type: string
      required:
        - datasetId
      additionalProperties: false
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page that should be returned. If the number of available
            results is larger than `page_size`, the service returns a `next_page_token` that can be used
            to get the next page of results in subsequent requests.
            Acceptable values are 0 to 1000, inclusive. Default value: 100.
            The maximum value is 1000.
          default: '100'
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. Set `page_token` to the `next_page_token` returned by a previous
            request to get the next page of results.
            The maximum string length in characters is 100.
          type: string
        timeRange:
          description: |-
            **[TimeRange](#yandex.cloud.siem.v1.common.TimeRange)**
            Time range to get the records of.
            If not set, the records will be returned for the entire dataset.
            Only applied for datasets with time column set in the schema.
          $ref: '#/definitions/TimeRange'
      additionalProperties: false
    body: null
    definitions:
      TimeRange:
        type: object
        properties:
          timeFrom:
            description: |-
              **string** (date-time)
              Inclusive start of the time range.
              String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
              `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
              To work with values in this field, use the APIs described in the
              [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
              In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
            type: string
            format: date-time
          timeTo:
            description: |-
              **string** (date-time)
              Exclusive end of the time range.
              String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
              `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
              To work with values in this field, use the APIs described in the
              [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
              In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
            type: string
            format: date-time
---

# Yandex Cloud SIEM Queries API, REST: Dataset.GetRecords

GetRecords retrieves the records of the specified Dataset.

## HTTP request

```
GET https://siem.{{ api-host }}/siem/v1/queries/datasets/{datasetId}/records
```

## Path parameters

#|
||Field | Description ||
|| datasetId | **string**

Required field. Required. ID of the dataset to get the records of.

The maximum string length in characters is 50. ||
|#

## Query parameters {#yandex.cloud.siem.v1.queries.GetRecordsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page that should be returned. If the number of available
results is larger than `page_size`, the service returns a `next_page_token` that can be used
to get the next page of results in subsequent requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100.

The maximum value is 1000. ||
|| pageToken | **string**

Page token. Set `page_token` to the `next_page_token` returned by a previous
request to get the next page of results.

The maximum string length in characters is 100. ||
|| timeRange | **[TimeRange](#yandex.cloud.siem.v1.common.TimeRange)**

Time range to get the records of.
If not set, the records will be returned for the entire dataset.
Only applied for datasets with time column set in the schema. ||
|#

## TimeRange {#yandex.cloud.siem.v1.common.TimeRange}

Range of time [time_from, time_to).

#|
||Field | Description ||
|| timeFrom | **string** (date-time)

Inclusive start of the time range.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| timeTo | **string** (date-time)

Exclusive end of the time range.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#

## Response {#yandex.cloud.siem.v1.queries.GetRecordsResponse}

**HTTP Code: 200 - OK**

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
  },
  "records": [
    {
      "values": [
        {
          // Includes only one of the fields `nullValue`, `stringValue`, `boolValue`, `intValue`, `doubleValue`, `timestampValue`, `ipv4Value`, `ipv6Value`
          "nullValue": "string",
          "stringValue": "string",
          "boolValue": "boolean",
          "intValue": "string",
          "doubleValue": "string",
          "timestampValue": "string",
          "ipv4Value": "string",
          "ipv6Value": "string",
          // end of the list of possible fields
          "items": [
            "object"
          ],
          "fields": "object"
        }
      ]
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| schema | **[Schema](#yandex.cloud.siem.v1.common.Schema)**

Schema of the returned records ||
|| records[] | **[Record](#yandex.cloud.siem.v1.common.Record)**

Requested list of records. ||
|| nextPageToken | **string**

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
|| nullValue | **enum** (NullValue)

null value

Includes only one of the fields `nullValue`, `stringValue`, `boolValue`, `intValue`, `doubleValue`, `timestampValue`, `ipv4Value`, `ipv6Value`.

only set for scalar values

 ||
|| stringValue | **string**

String value.

Includes only one of the fields `nullValue`, `stringValue`, `boolValue`, `intValue`, `doubleValue`, `timestampValue`, `ipv4Value`, `ipv6Value`.

only set for scalar values ||
|| boolValue | **boolean**

Boolean value.

Includes only one of the fields `nullValue`, `stringValue`, `boolValue`, `intValue`, `doubleValue`, `timestampValue`, `ipv4Value`, `ipv6Value`.

only set for scalar values ||
|| intValue | **string** (int64)

Integer value.

Includes only one of the fields `nullValue`, `stringValue`, `boolValue`, `intValue`, `doubleValue`, `timestampValue`, `ipv4Value`, `ipv6Value`.

only set for scalar values ||
|| doubleValue | **string**

Double-precision floating-point value.

Includes only one of the fields `nullValue`, `stringValue`, `boolValue`, `intValue`, `doubleValue`, `timestampValue`, `ipv4Value`, `ipv6Value`.

only set for scalar values ||
|| timestampValue | **string** (date-time)

Timestamp value.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).

Includes only one of the fields `nullValue`, `stringValue`, `boolValue`, `intValue`, `doubleValue`, `timestampValue`, `ipv4Value`, `ipv6Value`.

only set for scalar values ||
|| ipv4Value | **string**

IPv4 address value.

Includes only one of the fields `nullValue`, `stringValue`, `boolValue`, `intValue`, `doubleValue`, `timestampValue`, `ipv4Value`, `ipv6Value`.

only set for scalar values ||
|| ipv6Value | **string**

IPv6 address value.

Includes only one of the fields `nullValue`, `stringValue`, `boolValue`, `intValue`, `doubleValue`, `timestampValue`, `ipv4Value`, `ipv6Value`.

only set for scalar values ||
|| items[] | **[Value](#yandex.cloud.siem.v1.common.Value)**

only set for array values ||
|| fields | **object** (map<**string**, **[Value](#yandex.cloud.siem.v1.common.Value)**>)

only set for struct values ||
|#