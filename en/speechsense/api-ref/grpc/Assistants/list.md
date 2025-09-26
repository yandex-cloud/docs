---
editable: false
sourcePath: en/_api-ref-grpc/speechsense/v1/api-ref/grpc/Assistants/list.md
---

# Talk Analytics API, gRPC: AssistantsService.List

Rpc for listing assistants in a project

## gRPC request

**rpc List ([ListAssistantsRequest](#yandex.cloud.speechsense.v1.ListAssistantsRequest)) returns ([ListAssistantsResponse](#yandex.cloud.speechsense.v1.ListAssistantsResponse))**

## ListAssistantsRequest {#yandex.cloud.speechsense.v1.ListAssistantsRequest}

```json
{
  "project_id": "string"
}
```

#|
||Field | Description ||
|| project_id | **string**

Project id ||
|#

## ListAssistantsResponse {#yandex.cloud.speechsense.v1.ListAssistantsResponse}

```json
{
  "assistants": [
    {
      "id": "string",
      "project_id": "string",
      "model_id": "string",
      "name": "string",
      "description": "string",
      "prompt": "string",
      "fields": [
        {
          "id": "string",
          "name": "string",
          "description": "string",
          "type": "AssistantFieldType"
        }
      ],
      "enabled": "bool",
      "labels": "map<string, string>",
      "created_at": "google.protobuf.Timestamp",
      "created_by": "string",
      "modified_at": "google.protobuf.Timestamp",
      "modified_by": "string"
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
|| project_id | **string**

Project id ||
|| model_id | **string**

Model id ||
|| name | **string**

Assistant name ||
|| description | **string**

Assistant description ||
|| prompt | **string**

Prompt ||
|| fields[] | **[AssistantField](#yandex.cloud.speechsense.v1.AssistantField)**

Fields that will be set after assistant processing ||
|| enabled | **bool** ||
|| labels | **object** (map<**string**, **string**>)

Billing labels ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| created_by | **string**

Subject id ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| modified_by | **string**

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
|| type | enum **AssistantFieldType**

Field type

- `ASSISTANT_FIELD_TYPE_UNSPECIFIED`
- `ASSISTANT_FIELD_TYPE_STRING`
- `ASSISTANT_FIELD_TYPE_NUMBER`
- `ASSISTANT_FIELD_TYPE_DECIMAL`: Floating-point number ||
|#