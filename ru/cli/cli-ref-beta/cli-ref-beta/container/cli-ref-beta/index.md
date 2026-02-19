---
editable: false
noIndex: true
---

# yc beta container

Manage Container resources.

#### Command Usage

Syntax:

`yc beta container <group>`

#### Command Tree

- [yc beta container image](image/index.md) — A set of methods for managing Image resources.

  - [yc beta container image delete](image/delete.md) — Deletes the specified Docker image.

  - [yc beta container image get](image/get.md) — Returns the specified Image resource.

  - [yc beta container image list](image/list.md) — Retrieves the list of Image resources in the specified registry or repository.

- [yc beta container lifecycle-policy](lifecycle-policy/index.md) — A set of methods for managing Lifecycle policy resources.

  - [yc beta container lifecycle-policy create](lifecycle-policy/create.md) — Creates a lifecycle policy in the specified repository.

  - [yc beta container lifecycle-policy delete](lifecycle-policy/delete.md) — Deletes the specified lifecycle policy.

  - [yc beta container lifecycle-policy dry-run](lifecycle-policy/dry-run.md) — Creates a request of a dry run of the lifecycle policy.

  - [yc beta container lifecycle-policy get](lifecycle-policy/get.md) — Returns the specified lifecycle policy.

  - [yc beta container lifecycle-policy get-dry-run-result](lifecycle-policy/get-dry-run-result.md) — Returns the dry run result of the specified lifecycle policy.

  - [yc beta container lifecycle-policy list](lifecycle-policy/list.md) — Retrieves the list of lifecycle policies in the specified repository.

  - [yc beta container lifecycle-policy list-dry-run-result-affected-images](lifecycle-policy/list-dry-run-result-affected-images.md) — Retrieves the list of the affected images.

  - [yc beta container lifecycle-policy list-dry-run-results](lifecycle-policy/list-dry-run-results.md) — Retrieves the list of the dry run results.

  - [yc beta container lifecycle-policy update](lifecycle-policy/update.md) — Updates the specified lifecycle policy.

- [yc beta container registry](registry/index.md) — A set of methods for managing Registry resources.

  - [yc beta container registry create](registry/create.md) — Creates a registry in the specified folder.

  - [yc beta container registry delete](registry/delete.md) — Deletes the specified registry.

  - [yc beta container registry get](registry/get.md) — Returns the specified Registry resource.

  - [yc beta container registry list](registry/list.md) — Retrieves the list of Registry resources in the specified folder.

  - [yc beta container registry list-access-bindings](registry/list-access-bindings.md) — Lists access bindings for the specified registry.

  - [yc beta container registry list-ip-permission](registry/list-ip-permission.md) — List ip permissions for the specified registry.

  - [yc beta container registry set-access-bindings](registry/set-access-bindings.md) — Sets access bindings for the specified registry.

  - [yc beta container registry set-ip-permission](registry/set-ip-permission.md) — Set ip permissions for the specified registry.

  - [yc beta container registry update](registry/update.md) — Updates the specified registry.

  - [yc beta container registry update-access-bindings](registry/update-access-bindings.md) — Updates access bindings for the specified registry.

  - [yc beta container registry update-ip-permission](registry/update-ip-permission.md) — Update ip permissions for the specified registry.

- [yc beta container repository](repository/index.md) — A set of methods for managing Repository resources.

  - [yc beta container repository delete](repository/delete.md) — Deletes the specified repository.

  - [yc beta container repository get](repository/get.md) — Returns the specified Repository resource.

  - [yc beta container repository get-by-name](repository/get-by-name.md) — Returns the specified Repository resource.

  - [yc beta container repository list](repository/list.md) — Retrieves the list of Repository resources in the specified registry.

  - [yc beta container repository list-access-bindings](repository/list-access-bindings.md) — Lists access bindings for the specified repository.

  - [yc beta container repository set-access-bindings](repository/set-access-bindings.md) — Sets access bindings for the specified repository.

  - [yc beta container repository update-access-bindings](repository/update-access-bindings.md) — Updates access bindings for the specified repository.

  - [yc beta container repository upsert](repository/upsert.md) — Upserts a repository in the specified registry.

- [yc beta container scan-policy](scan-policy/index.md) — A set of methods for managing scan policy resources.

  - [yc beta container scan-policy create](scan-policy/create.md) — Creates a scan policy for the specified registry.

  - [yc beta container scan-policy delete](scan-policy/delete.md) — Deletes the specified scan policy.

  - [yc beta container scan-policy get](scan-policy/get.md) — Returns the specified scan policy.

  - [yc beta container scan-policy get-by-registry](scan-policy/get-by-registry.md) — Returns scan policy for the registry if any exists.

  - [yc beta container scan-policy update](scan-policy/update.md) — Updates the specified scan policy.

- [yc beta container scanner](scanner/index.md) — A set of methods for scanning Docker images.

  - [yc beta container scanner get](scanner/get.md) — Returns the specified ScanResult resource.

  - [yc beta container scanner get-last](scanner/get-last.md) — Returns the last finished ScanResult for the specified Image.

  - [yc beta container scanner list](scanner/list.md) — Retrieves the list of ScanResults for specified Image.

  - [yc beta container scanner list-vulnerabilities](scanner/list-vulnerabilities.md) — Retrieves the list of vulnerabilities found in particular scan.

  - [yc beta container scanner scan](scanner/scan.md) — Executes scanning of specified image.

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