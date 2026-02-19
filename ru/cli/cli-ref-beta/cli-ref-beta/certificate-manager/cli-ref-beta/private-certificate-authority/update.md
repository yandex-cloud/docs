---
editable: false
noIndex: true
---

# yc beta certificate-manager private-certificate-authority update

Updates the specified Certificate Authority (CA).
This allows updating attributes of an already existing CA, such as name, description, etc.

#### Command Usage

Syntax:

`yc beta certificate-manager private-certificate-authority update <CERTIFICATE-AUTHORITY-ID>`

#### Flags

#|
||Flag | Description ||
|| `--certificate-authority-id` | `string`

The ID of the Certificate Authority to update. ||
|| `--deletion-protection` | Update the deletion protection flag. Protects the Certificate Authority from accidental deletion. ||
|| `--description` | `string`

New description of the Certificate Authority (if applicable). Allows adding or updating the description to clarify the CA's purpose. ||
|| `--end-entities-ttl-limit-days` | `int`

Update the end-entity TTL limit for certificates issued by this Certificate Authority. ||
|| `--name` | `string`

New name of the Certificate Authority (if applicable). This field is optional and will only be applied if included in the update mask. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

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