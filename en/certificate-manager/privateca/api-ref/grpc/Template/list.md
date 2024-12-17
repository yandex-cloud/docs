---
editable: false
sourcePath: en/_api-ref-grpc/certificatemanager/v1/privateca/api-ref/grpc/Template/list.md
---

# Certificate Manager Private CA API, gRPC: TemplateService.List

Lists all certificate templates in a specified folder.

## gRPC request

**rpc List ([ListTemplateRequest](#yandex.cloud.certificatemanager.v1.privateca.ListTemplateRequest)) returns ([ListTemplateResponse](#yandex.cloud.certificatemanager.v1.privateca.ListTemplateResponse))**

## ListTemplateRequest {#yandex.cloud.certificatemanager.v1.privateca.ListTemplateRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

Request message to list templates in a folder.

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder into which list templates. ||
|| page_size | **int64**

The maximum number of results to return per page. Couldn't exceed 100, default value is 100 ||
|| page_token | **string**

Token to retrieve specific pages of results.
If this is set, the service will return the next page of results based on this token. ||
|#

## ListTemplateResponse {#yandex.cloud.certificatemanager.v1.privateca.ListTemplateResponse}

```json
{
  "templates": [
    {
      "id": "string",
      "folder_id": "string",
      "name": "string",
      "data": "string",
      "created_at": "google.protobuf.Timestamp",
      "updated_at": "google.protobuf.Timestamp"
    }
  ],
  "next_page_token": "string"
}
```

Response containing the list of templates.

#|
||Field | Description ||
|| templates[] | **[Template](#yandex.cloud.certificatemanager.v1.privateca.Template)**

List of certificate templates in the specified folder. ||
|| next_page_token | **string**

Token for obtaining the next page of results.
If the number of results exceeds `page_size`, this token will be returned and can be passed to
the `ListTemplateRequest` for the next page. ||
|#

## Template {#yandex.cloud.certificatemanager.v1.privateca.Template}

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