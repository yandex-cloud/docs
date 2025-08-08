---
editable: false
apiPlayground:
  - url: https://loadtesting.{{ api-host }}/loadtesting/api/v1/configs/{configId}
    method: get
    path:
      type: object
      properties:
        configId:
          description: |-
            **string**
            ID of the config to return.
          type: string
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/loadtesting/api/v1/user/api-ref/Config/get.md
---

# Load Testing API, REST: Config.Get

Returns the specified config.

To get the list of all available configs, make a [List](/docs/load-testing/user/api-ref/Config/list#List) request.

## HTTP request

```
GET https://loadtesting.{{ api-host }}/loadtesting/api/v1/configs/{configId}
```

## Path parameters

#|
||Field | Description ||
|| configId | **string**

Required field. ID of the config to return. ||
|#

## Response {#yandex.cloud.loadtesting.api.v1.config.Config}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "yamlString": "string",
  "name": "string",
  "createdAt": "string",
  "createdBy": "string"
}
```

Test config.

#|
||Field | Description ||
|| id | **string**

ID of the test config. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the config belongs to. ||
|| yamlString | **string**

Config content in YAML format. ||
|| name | **string**

Name of the config. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

UA or SA that created the config. ||
|#