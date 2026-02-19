---
editable: false
noIndex: true
---

# yc beta certificate-manager

Manage Certificate Manager resources

#### Command Usage

Syntax:

`yc beta certificate-manager <group>`

#### Command Tree

- [yc beta certificate-manager certificate](certificate/index.md) — A set of methods for managing certificates.

  - [yc beta certificate-manager certificate create](certificate/create.md) — Creates a certificate in the specified folder.

  - [yc beta certificate-manager certificate delete](certificate/delete.md) — Deletes the specified certificate.

  - [yc beta certificate-manager certificate get](certificate/get.md) — Returns the specified certificate.

  - [yc beta certificate-manager certificate list](certificate/list.md) — Returns the list of certificates in the specified folder.

  - [yc beta certificate-manager certificate list-access-bindings](certificate/list-access-bindings.md) — Lists existing access bindings for the specified certificate.

  - [yc beta certificate-manager certificate list-operations](certificate/list-operations.md) — Lists operations for the specified certificate.

  - [yc beta certificate-manager certificate list-versions](certificate/list-versions.md) — 

  - [yc beta certificate-manager certificate request-new](certificate/request-new.md) — Request a certificate in the specified folder.

  - [yc beta certificate-manager certificate set-access-bindings](certificate/set-access-bindings.md) — Sets access bindings for the certificate.

  - [yc beta certificate-manager certificate update](certificate/update.md) — Updates the specified certificate.

  - [yc beta certificate-manager certificate update-access-bindings](certificate/update-access-bindings.md) — Updates access bindings for the specified certificate.

- [yc beta certificate-manager certificate-content](certificate-content/index.md) — A set of methods for managing certificate content.

  - [yc beta certificate-manager certificate-content get](certificate-content/get.md) — Returns chain and private key of the specified certificate.

  - [yc beta certificate-manager certificate-content get-ex](certificate-content/get-ex.md) — 

- [yc beta certificate-manager policy](policy/index.md) — A set of methods for managing policies.

  - [yc beta certificate-manager policy create](policy/create.md) — Creates a policy for the specified certificate authority.

  - [yc beta certificate-manager policy delete](policy/delete.md) — Deletes the specified policy.

  - [yc beta certificate-manager policy get](policy/get.md) — Returns the specified policy.

  - [yc beta certificate-manager policy list](policy/list.md) — Retrieves the list of policies of the specified certificate authority.

  - [yc beta certificate-manager policy list-access-bindings](policy/list-access-bindings.md) — Lists existing access bindings for the specified policy.

  - [yc beta certificate-manager policy set-access-bindings](policy/set-access-bindings.md) — Sets access bindings for the policy.

  - [yc beta certificate-manager policy update](policy/update.md) — Updates the specified policy.

  - [yc beta certificate-manager policy update-access-bindings](policy/update-access-bindings.md) — Updates access bindings for the policy.

- [yc beta certificate-manager private-certificate](private-certificate/index.md) — A set of methods for managing private certificates that are issued by a Certificate Authority (CA).

  - [yc beta certificate-manager private-certificate delete](private-certificate/delete.md) — Deletes a certificate.

  - [yc beta certificate-manager private-certificate get](private-certificate/get.md) — Retrieves information about a specific certificate.

  - [yc beta certificate-manager private-certificate issue-certificate](private-certificate/issue-certificate.md) — Issues a new certificate for a given Certificate Authority (CA).

  - [yc beta certificate-manager private-certificate issue-certificate-by-csr](private-certificate/issue-certificate-by-csr.md) — Issues a new certificate using a CSR (Certificate Signing Request).

  - [yc beta certificate-manager private-certificate list](private-certificate/list.md) — Lists the certificates issued by a given Certificate Authority (CA).

  - [yc beta certificate-manager private-certificate list-access-bindings](private-certificate/list-access-bindings.md) — bindings for a given certificate.

  - [yc beta certificate-manager private-certificate revoke-certificate](private-certificate/revoke-certificate.md) — Revokes a previously issued certificate. Revoked certificates are added to the CA's CRL or OCSP if enabled.

  - [yc beta certificate-manager private-certificate set-access-bindings](private-certificate/set-access-bindings.md) — Sets access bindings for a specified certificate.

  - [yc beta certificate-manager private-certificate update](private-certificate/update.md) — Updates the specified certificate.

  - [yc beta certificate-manager private-certificate update-access-bindings](private-certificate/update-access-bindings.md) — Updates the specified access bindings for a certificate.

- [yc beta certificate-manager private-certificate-authority](private-certificate-authority/index.md) — Service for managing Private Certificate Authorities (CAs).

  - [yc beta certificate-manager private-certificate-authority delete](private-certificate-authority/delete.md) — Deletes an existing Certificate Authority (CA).

  - [yc beta certificate-manager private-certificate-authority generate-certificate-authority](private-certificate-authority/generate-certificate-authority.md) — Generates a new Certificate Authority (CA).

  - [yc beta certificate-manager private-certificate-authority generate-certificate-authority-by-csr](private-certificate-authority/generate-certificate-authority-by-csr.md) — Generates a Certificate Authority (CA) by using a Certificate Signing Request (CSR).

  - [yc beta certificate-manager private-certificate-authority generate-csr-for-certificate-authority](private-certificate-authority/generate-csr-for-certificate-authority.md) — Generates a Certificate Signing Request (CSR) for a new CA.

  - [yc beta certificate-manager private-certificate-authority get](private-certificate-authority/get.md) — Retrieves detailed information about a specific Certificate Authority (CA).

  - [yc beta certificate-manager private-certificate-authority get-csr-for-certificate-authority](private-certificate-authority/get-csr-for-certificate-authority.md) — Retrieves the CSR for a given Certificate Authority (CA), generated by GenerateCsrForCertificateAuthority method.

  - [yc beta certificate-manager private-certificate-authority import-certificate-authority](private-certificate-authority/import-certificate-authority.md) — Imports an externally generated Certificate Authority (CA).

  - [yc beta certificate-manager private-certificate-authority list](private-certificate-authority/list.md) — Lists the available Certificate Authorities (CAs).

  - [yc beta certificate-manager private-certificate-authority list-access-bindings](private-certificate-authority/list-access-bindings.md) — Lists access bindings for a specified Certificate Authority.

  - [yc beta certificate-manager private-certificate-authority send-signed-certificate-of-certificate-authority](private-certificate-authority/send-signed-certificate-of-certificate-authority.md) — Sends a signed certificate chain after a CSR has been generated.

  - [yc beta certificate-manager private-certificate-authority set-access-bindings](private-certificate-authority/set-access-bindings.md) — Sets access bindings for a Certificate Authority.

  - [yc beta certificate-manager private-certificate-authority update](private-certificate-authority/update.md) — Updates the specified Certificate Authority (CA).

  - [yc beta certificate-manager private-certificate-authority update-access-bindings](private-certificate-authority/update-access-bindings.md) — Updates access bindings for the specified Certificate Authority.

- [yc beta certificate-manager private-certificate-authority-content](private-certificate-authority-content/index.md) — A set of methods for retrieving private certificate authority content.

  - [yc beta certificate-manager private-certificate-authority-content get-chain](private-certificate-authority-content/get-chain.md) — Returns the certificate chain for the specified certificate authority.

  - [yc beta certificate-manager private-certificate-authority-content get-private-key](private-certificate-authority-content/get-private-key.md) — Returns the private key and passphrase for the specified certificate authority.

- [yc beta certificate-manager private-certificate-content](private-certificate-content/index.md) — A set of methods for retrieving certificate content from a private certificate authority.

  - [yc beta certificate-manager private-certificate-content get-chain](private-certificate-content/get-chain.md) — Returns the certificate chain for the specified certificate.

  - [yc beta certificate-manager private-certificate-content get-private-key](private-certificate-content/get-private-key.md) — Returns the private key for the specified certificate.

- [yc beta certificate-manager template](template/index.md) — A set of methods for managing certificate templates.

  - [yc beta certificate-manager template create](template/create.md) — Creates a new certificate template in the specified folder.

  - [yc beta certificate-manager template delete](template/delete.md) — Deletes a certificate template by the specified ID.

  - [yc beta certificate-manager template get](template/get.md) — Retrieves specified certificate template.

  - [yc beta certificate-manager template list](template/list.md) — Lists all certificate templates in a specified folder.

  - [yc beta certificate-manager template list-access-bindings](template/list-access-bindings.md) — Lists access bindings for a specific certificate template to see current permissions.

  - [yc beta certificate-manager template set-access-bindings](template/set-access-bindings.md) — Set new access bindings for a specific certificate template.

  - [yc beta certificate-manager template update](template/update.md) — Updates an existing certificate template.

  - [yc beta certificate-manager template update-access-bindings](template/update-access-bindings.md) — Updates existing access bindings for a certificate template.

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#