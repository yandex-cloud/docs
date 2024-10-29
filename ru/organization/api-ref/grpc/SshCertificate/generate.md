---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/SshCertificate/generate.md
---

# Cloud Organization API, gRPC: SshCertificateService.Generate {#Generate}

Members of an organization can generate certificates for themselves
Signing certificates for other users requires a special permission

## gRPC request

**rpc Generate ([GenerateSshCertificateRequest](#yandex.cloud.organizationmanager.v1.GenerateSshCertificateRequest)) returns ([GenerateSshCertificateResponse](#yandex.cloud.organizationmanager.v1.GenerateSshCertificateResponse))**

## GenerateSshCertificateRequest {#yandex.cloud.organizationmanager.v1.GenerateSshCertificateRequest}

```json
{
  // Includes only one of the fields `cloudId`, `organizationId`
  "cloudId": "string",
  "organizationId": "string",
  // end of the list of possible fields
  // Includes only one of the fields `subjectId`, `osLogin`
  "subjectId": "string",
  "osLogin": "string",
  // end of the list of possible fields
  "publicKey": "string"
}
```

#|
||Field | Description ||
|| cloudId | **string**

the cloud must be attached to an organization

Includes only one of the fields `cloudId`, `organizationId`. ||
|| organizationId | **string**

Includes only one of the fields `cloudId`, `organizationId`. ||
|| subjectId | **string**

specify subject to generate certificate for default login

Includes only one of the fields `subjectId`, `osLogin`. ||
|| osLogin | **string**

specify os_login for a specific login

Includes only one of the fields `subjectId`, `osLogin`. ||
|| publicKey | **string**

Required field.  ||
|#

## GenerateSshCertificateResponse {#yandex.cloud.organizationmanager.v1.GenerateSshCertificateResponse}

```json
{
  "signedCertificate": "string"
}
```

#|
||Field | Description ||
|| signedCertificate | **string**

as per specification https://cvsweb.openbsd.org/src/usr.bin/ssh/PROTOCOL.certkeys?annotate=HEAD ||
|#