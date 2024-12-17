---
editable: false
sourcePath: en/_api-ref-grpc/certificatemanager/v1/privateca/api-ref/grpc/PrivateCaCertificate/index.md
---

# Certificate Manager Private CA API, gRPC: PrivateCaCertificateService

A set of methods for managing private certificates that are issued by a Certificate Authority (CA).

## Methods

#|
||Method | Description ||
|| [IssueCertificate](issueCertificate.md) | Issues a new certificate for a given Certificate Authority (CA). ||
|| [IssueCertificateByCsr](issueCertificateByCsr.md) | Issues a new certificate using a CSR (Certificate Signing Request). ||
|| [Update](update.md) | Updates the specified certificate. ||
|| [Delete](delete.md) | Deletes a certificate. ||
|| [Get](get.md) | Retrieves information about a specific certificate. ||
|| [List](list.md) | Lists the certificates issued by a given Certificate Authority (CA). ||
|| [RevokeCertificate](revokeCertificate.md) | Revokes a previously issued certificate. Revoked certificates are added to the CA's CRL or OCSP if enabled. ||
|| [ListAccessBindings](listAccessBindings.md) | bindings for a given certificate. ||
|| [SetAccessBindings](setAccessBindings.md) | Sets access bindings for a specified certificate. ||
|| [UpdateAccessBindings](updateAccessBindings.md) | Updates the specified access bindings for a certificate. ||
|#