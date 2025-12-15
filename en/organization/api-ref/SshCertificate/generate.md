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
            The maximum string length in characters is 50.
            Includes only one of the fields `cloudId`, `organizationId`.
          type: string
        organizationId:
          description: |-
            **string**
            The maximum string length in characters is 50.
            Includes only one of the fields `cloudId`, `organizationId`.
          type: string
        subjectId:
          description: |-
            **string**
            specify subject to generate certificate for default login
            The maximum string length in characters is 50.
            Includes only one of the fields `subjectId`, `osLogin`.
          type: string
        osLogin:
          description: |-
            **string**
            specify os_login for a specific login
            The maximum string length in characters is 32.
            Includes only one of the fields `subjectId`, `osLogin`.
          type: string
        publicKey:
          description: |-
            **string**
            Required field.
            The maximum string length in characters is 15000.
          type: string
      required:
        - publicKey
      additionalProperties: false
      allOf:
        - oneOf:
            - required:
                - cloudId
            - required:
                - organizationId
        - oneOf:
            - required:
                - subjectId
            - required:
                - osLogin
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

The maximum string length in characters is 50.

Includes only one of the fields `cloudId`, `organizationId`. ||
|| organizationId | **string**

The maximum string length in characters is 50.

Includes only one of the fields `cloudId`, `organizationId`. ||
|| subjectId | **string**

specify subject to generate certificate for default login

The maximum string length in characters is 50.

Includes only one of the fields `subjectId`, `osLogin`. ||
|| osLogin | **string**

specify os_login for a specific login

The maximum string length in characters is 32.

Includes only one of the fields `subjectId`, `osLogin`. ||
|| publicKey | **string**

Required field.

The maximum string length in characters is 15000. ||
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