---
editable: false
sourcePath: en/_api-ref-grpc/certificatemanager/v1/privateca/api-ref/grpc/Template/get.md
---

# Certificate Manager Private CA API, gRPC: TemplateService.Get

Retrieves specified certificate template.

## gRPC request

**rpc Get ([GetTemplateRequest](#yandex.cloud.priv.certificatemanager.v1.privateca.GetTemplateRequest)) returns ([Template](#yandex.cloud.priv.certificatemanager.v1.privateca.Template))**

## GetTemplateRequest {#yandex.cloud.priv.certificatemanager.v1.privateca.GetTemplateRequest}

```json
{
  "id": "string"
}
```

Request message to retrieve details of a template.

#|
||Field | Description ||
|| id | **string**

Required field. ID of the template to retrieve. ||
|#

## Template {#yandex.cloud.priv.certificatemanager.v1.privateca.Template}

```json
{
  "id": "string",
  "folder_id": "string",
  "name": "string",
  "data": "string",
  "created_at": "google.protobuf.Timestamp",
  "updated_at": "google.protobuf.Timestamp"
}
```

Json or yaml template for easier certificate issuing. If used while certificate creation, certificate would take all fields from template.

#|
||Field | Description ||
|| id | **string**

ID of the template. Generated at creation time. ||
|| folder_id | **string**

ID of the folder that the template belongs to. ||
|| name | **string**

Name of the template. ||
|| data | **string**

Json representation of template. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the template was created. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the template was last updated. ||
|#