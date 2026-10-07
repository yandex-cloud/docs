---
editable: false
apiPlayground:
  - url: https://siem.{{ api-host }}/siem/v1/queries/launches
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        searchId:
          description: |-
            **string**
            Required field. Required. ID of the Search to create SearchLaunch in.
            The maximum string length in characters is 50.
          type: string
        query:
          description: |-
            **[SearchQuery](#yandex.cloud.siem.v1.common.SearchQuery)**
            Required field. Required. Query content of the SearchLaunch.
          $ref: '#/definitions/SearchQuery'
        timeRange:
          description: |-
            **[TimeRange](#yandex.cloud.siem.v1.common.TimeRange)**
            Required. Time range of the SearchLaunch.
          $ref: '#/definitions/TimeRange'
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Resource labels as `key:value` pairs.
            The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource.
          type: object
          additionalProperties:
            type: string
            pattern: '[-_0-9a-z]*'
            maxLength: 63
          propertyNames:
            type: string
            pattern: '[a-z][-_0-9a-z]*'
            maxLength: 63
            minLength: 1
          maxProperties: 64
      required:
        - searchId
        - query
      additionalProperties: false
    definitions:
      SearchQuery:
        type: object
        properties:
          type:
            description: |-
              **enum** (Type)
              Query content type.
              - `NORMALIZATE`: Normalizate
              - `LOOKUP`: Lookup
              - `LAUNCH_RESULT`: Launch result
            type: string
            enum:
              - TYPE_UNSPECIFIED
              - NORMALIZATE
              - LOOKUP
              - LAUNCH_RESULT
          content:
            description: |-
              **string**
              Content of the query.
              for example KQL query text
            type: string
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

# Yandex Cloud SIEM Queries API, REST: SearchLaunch.Create

Creates a new SearchLaunch in Search.

## HTTP request

```
POST https://siem.{{ api-host }}/siem/v1/queries/launches
```

## Body parameters {#yandex.cloud.siem.v1.queries.CreateSearchLaunchRequest}

```json
{
  "searchId": "string",
  "query": {
    "type": "string",
    "content": "string"
  },
  "timeRange": {
    "timeFrom": "string",
    "timeTo": "string"
  },
  "labels": "object"
}
```

#|
||Field | Description ||
|| searchId | **string**

Required field. Required. ID of the Search to create SearchLaunch in.

The maximum string length in characters is 50. ||
|| query | **[SearchQuery](#yandex.cloud.siem.v1.common.SearchQuery)**

Required field. Required. Query content of the SearchLaunch. ||
|| timeRange | **[TimeRange](#yandex.cloud.siem.v1.common.TimeRange)**

Required. Time range of the SearchLaunch. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|#

## SearchQuery {#yandex.cloud.siem.v1.common.SearchQuery}

SearchQuery is a query to be executed against the data.

#|
||Field | Description ||
|| type | **enum** (Type)

Query content type.

- `YAD`: Yandex Data Query syntax.
- `KQL`: Kusto Query Language syntax. ||
|| content | **string**

Content of the query.
for example KQL query text ||
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

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **object**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **object**

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

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#