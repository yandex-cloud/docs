---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/sshCertificates:generate
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        cloudId:
          description: |-
            **string**
            the cloud must be attached to an organization
            Includes only one of the fields `cloudId`, `organizationId`.
          type: string
        organizationId:
          description: |-
            **string**
            Includes only one of the fields `cloudId`, `organizationId`.
          type: string
        subjectId:
          description: |-
            **string**
            specify subject to generate certificate for default login
            Includes only one of the fields `subjectId`, `osLogin`.
          type: string
        osLogin:
          description: |-
            **string**
            specify os_login for a specific login
            Includes only one of the fields `subjectId`, `osLogin`.
          type: string
        publicKey:
          description: |-
            **string**
            Required field. 
          type: string
      required:
        - publicKey
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/organizationmanager/v1/api-ref/SshCertificate/generate.md
---

# Identity Hub API, REST: SshCertificate.Generate

Members of an organization can generate certificates for themselves
Signing certificates for other users requires a special permission

## HTTP request

```
POST https://organization-manager.{{ api-host }}/organization-manager/v1/sshCertificates:generate
```

## Body parameters {#yandex.cloud.organizationmanager.v1.GenerateSshCertificateRequest}

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

## Response {#yandex.cloud.organizationmanager.v1.GenerateSshCertificateResponse}

**HTTP Code: 200 - OK**

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