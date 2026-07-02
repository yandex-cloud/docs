[Документация Yandex Cloud](../../../index.md) > [Yandex Identity Hub](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [SshCertificate](index.md) > Generate

# Identity Hub API, REST: SshCertificate.Generate

Members of an organization can generate certificates for themselves
Signing certificates for other users requires a special permission

## HTTP request

```
POST https://organization-manager.api.cloud.yandex.net/organization-manager/v1/sshCertificates:generate
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