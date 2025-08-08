---
editable: false
sourcePath: en/_api-ref-grpc/certificatemanager/v1/api-ref/grpc/CertificateContent/getEx.md
---

# Certificate Manager API, gRPC: CertificateContentService.GetEx

## gRPC request

**rpc GetEx ([GetExCertificateContentRequest](#yandex.cloud.certificatemanager.v1.GetExCertificateContentRequest)) returns ([GetExCertificateContentResponse](#yandex.cloud.certificatemanager.v1.GetExCertificateContentResponse))**

## GetExCertificateContentRequest {#yandex.cloud.certificatemanager.v1.GetExCertificateContentRequest}

```json
{
  // Includes only one of the fields `certificate_id`, `folder_and_name`
  "certificate_id": "string",
  "folder_and_name": {
    "folder_id": "string",
    "certificate_name": "string"
  },
  // end of the list of possible fields
  "version_id": "string",
  "private_key_format": "PrivateKeyFormat"
}
```

#|
||Field | Description ||
|| certificate_id | **string**

Includes only one of the fields `certificate_id`, `folder_and_name`. ||
|| folder_and_name | **[FolderAndName](#yandex.cloud.certificatemanager.v1.FolderAndName)**

Includes only one of the fields `certificate_id`, `folder_and_name`. ||
|| version_id | **string** ||
|| private_key_format | enum **PrivateKeyFormat**

- `PRIVATE_KEY_FORMAT_UNSPECIFIED`
- `PKCS1`
- `PKCS8` ||
|#

## FolderAndName {#yandex.cloud.certificatemanager.v1.FolderAndName}

#|
||Field | Description ||
|| folder_id | **string**

Required field.  ||
|| certificate_name | **string**

Required field.  ||
|#

## GetExCertificateContentResponse {#yandex.cloud.certificatemanager.v1.GetExCertificateContentResponse}

```json
{
  "certificate_id": "string",
  "version_id": "string",
  "certificate_chain": [
    "string"
  ],
  "private_key": "string"
}
```

#|
||Field | Description ||
|| certificate_id | **string** ||
|| version_id | **string** ||
|| certificate_chain[] | **string** ||
|| private_key | **string** ||
|#