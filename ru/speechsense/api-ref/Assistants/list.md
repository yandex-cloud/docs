---
editable: false
apiPlayground:
  - url: https://rest-api.speechsense.yandexcloud.net/speechsense/v1/assistants/list
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        projectId:
          description: |-
            **string**
            Project id
          type: string
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/speechsense/v1/api-ref/Assistants/list.md
---

# Talk Analytics API, REST: Assistants.List

Rpc for listing assistants in a project

## HTTP request

```
POST https://rest-api.speechsense.yandexcloud.net/speechsense/v1/assistants/list
```

## Body parameters {#yandex.cloud.speechsense.v1.ListAssistantsRequest}

```json
{
  "projectId": "string"
}
```

#|
||Field | Description ||
|| projectId | **string**

Project id ||
|#

## Response {#yandex.cloud.speechsense.v1.ListAssistantsResponse}

**HTTP Code: 200 - OK**

```json
{
  "assistants": [
    {
      "id": "string",
      "projectId": "string",
      "modelId": "string",
      "name": "string",
      "description": "string",
      "prompt": "string",
      "fields": [
        {
          "id": "string",
          "name": "string",
          "description": "string",
          "type": "string"
        }
      ],
      "enabled": "boolean",
      "labels": "object",
      "createdAt": "string",
      "createdBy": "string",
      "modifiedAt": "string",
      "modifiedBy": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| assistants[] | **[Assistant](#yandex.cloud.speechsense.v1.Assistant)**

Assistants belonging to the given project ||
|#

## Assistant {#yandex.cloud.speechsense.v1.Assistant}

#|
||Field | Description ||
|| id | **string**

Assistant id ||
|| projectId | **string**

Project id ||
|| modelId | **string**

Model id ||
|| name | **string**

Assistant name ||
|| description | **string**

Assistant description ||
|| prompt | **string**

Prompt ||
|| fields[] | **[AssistantField](#yandex.cloud.speechsense.v1.AssistantField)**

Fields that will be set after assistant processing ||
|| enabled | **boolean** ||
|| labels | **object** (map<**string**, **string**>)

Billing labels ||
|| createdAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

Subject id ||
|| modifiedAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| modifiedBy | **string**

Subject id ||
|#

## AssistantField {#yandex.cloud.speechsense.v1.AssistantField}

#|
||Field | Description ||
|| id | **string**

Field id ||
|| name | **string**

Field name ||
|| description | **string**

Field description ||
|| type | **enum** (AssistantFieldType)

Field type

- `ASSISTANT_FIELD_TYPE_UNSPECIFIED`
- `ASSISTANT_FIELD_TYPE_STRING`
- `ASSISTANT_FIELD_TYPE_NUMBER`
- `ASSISTANT_FIELD_TYPE_DECIMAL`: Floating-point number ||
|#