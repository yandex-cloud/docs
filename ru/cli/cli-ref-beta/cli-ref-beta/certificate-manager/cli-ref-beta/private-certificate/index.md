---
editable: false
noIndex: true
---

# yc beta certificate-manager private-certificate

A set of methods for managing private certificates that are issued by a Certificate Authority (CA).

#### Command Usage

Syntax:

`yc beta certificate-manager private-certificate <command>`

#### Command Tree

- [yc beta certificate-manager private-certificate delete](delete.md) — Deletes a certificate.

- [yc beta certificate-manager private-certificate get](get.md) — Retrieves information about a specific certificate.

- [yc beta certificate-manager private-certificate issue-certificate](issue-certificate.md) — Issues a new certificate for a given Certificate Authority (CA).

- [yc beta certificate-manager private-certificate issue-certificate-by-csr](issue-certificate-by-csr.md) — Issues a new certificate using a CSR (Certificate Signing Request).

- [yc beta certificate-manager private-certificate list](list.md) — Lists the certificates issued by a given Certificate Authority (CA).

- [yc beta certificate-manager private-certificate list-access-bindings](list-access-bindings.md) — bindings for a given certificate.

- [yc beta certificate-manager private-certificate revoke-certificate](revoke-certificate.md) — Revokes a previously issued certificate. Revoked certificates are added to the CA's CRL or OCSP if enabled.

- [yc beta certificate-manager private-certificate set-access-bindings](set-access-bindings.md) — Sets access bindings for a specified certificate.

- [yc beta certificate-manager private-certificate update](update.md) — Updates the specified certificate.

- [yc beta certificate-manager private-certificate update-access-bindings](update-access-bindings.md) — Updates the specified access bindings for a certificate.

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