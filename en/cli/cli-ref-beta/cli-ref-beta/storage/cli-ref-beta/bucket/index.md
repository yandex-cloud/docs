---
editable: false
noIndex: true
---

# yc beta storage bucket

A set of methods for managing buckets.

#### Command Usage

Syntax:

`yc beta storage bucket <command>`

#### Command Tree

- [yc beta storage bucket create](create.md) — Creates a bucket in the specified folder.

- [yc beta storage bucket create-inventory-configuration](create-inventory-configuration.md) — Create/Update an inventory configuration with the corresponding ID

- [yc beta storage bucket delete](delete.md) — Deletes the specified bucket.

- [yc beta storage bucket delete-https-config](delete-https-config.md) — Deletes the HTTPS configuration for the specified bucket.

- [yc beta storage bucket delete-inventory-configuration](delete-inventory-configuration.md) — Delete an inventory configuration with the corresponding ID

- [yc beta storage bucket get](get.md) — Returns the specified bucket.

- [yc beta storage bucket get-https-config](get-https-config.md) — Returns the HTTPS configuration for the specified bucket.

- [yc beta storage bucket get-inventory-configuration](get-inventory-configuration.md) — Get an inventory configuration with the corresponding ID

- [yc beta storage bucket get-stats](get-stats.md) — Returns the statistics for the specified bucket.

- [yc beta storage bucket list](list.md) — Retrieves the list of buckets in the specified folder.

- [yc beta storage bucket list-access-bindings](list-access-bindings.md) — Lists access bindings for the specified bucket.

- [yc beta storage bucket list-inventory-configurations](list-inventory-configurations.md) — Listing inventory configurations

- [yc beta storage bucket set-access-bindings](set-access-bindings.md) — Sets access bindings for the specified bucket.

- [yc beta storage bucket set-https-config](set-https-config.md) — Updates the HTTPS configuration for the specified bucket.

- [yc beta storage bucket update](update.md) — Updates the specified bucket.

- [yc beta storage bucket update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified bucket.

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