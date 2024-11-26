---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/SshCertificate/generate.md
---

# Cloud Organization API, gRPC: SshCertificateService.Generate

Members of an organization can generate certificates for themselves
Signing certificates for other users requires a special permission

## gRPC request

**rpc Generate ([GenerateSshCertificateRequest](#yandex.cloud.organizationmanager.v1.GenerateSshCertificateRequest)) returns ([GenerateSshCertificateResponse](#yandex.cloud.organizationmanager.v1.GenerateSshCertificateResponse))**

## GenerateSshCertificateRequest {#yandex.cloud.organizationmanager.v1.GenerateSshCertificateRequest}

```json
{
  // Includes only one of the fields `cloud_id`, `organization_id`
  "cloud_id": "string",
  "organization_id": "string",
  // end of the list of possible fields
  // Includes only one of the fields `subject_id`, `os_login`
  "subject_id": "string",
  "os_login": "string",
  // end of the list of possible fields
  "public_key": "string"
}
```

#|
||Field | Description ||
|| cloud_id | **string**

the cloud must be attached to an organization

Includes only one of the fields `cloud_id`, `organization_id`. ||
|| organization_id | **string**

Includes only one of the fields `cloud_id`, `organization_id`. ||
|| subject_id | **string**

specify subject to generate certificate for default login

Includes only one of the fields `subject_id`, `os_login`. ||
|| os_login | **string**

specify os_login for a specific login

Includes only one of the fields `subject_id`, `os_login`. ||
|| public_key | **string**

Required field.  ||
|#

## GenerateSshCertificateResponse {#yandex.cloud.organizationmanager.v1.GenerateSshCertificateResponse}

```json
{
  "signed_certificate": "string"
}
```

#|
||Field | Description ||
|| signed_certificate | **string**

as per specification https://cvsweb.openbsd.org/src/usr.bin/ssh/PROTOCOL.certkeys?annotate=HEAD ||
|#