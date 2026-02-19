---
editable: false
noIndex: true
---

# yc beta baremetal private-cloud-connection

A set of methods for managing Private cloud connection resources.

#### Command Usage

Syntax:

`yc beta baremetal private-cloud-connection <command>`

#### Command Tree

- [yc beta baremetal private-cloud-connection create](create.md) — Creates a private cloud connection in the specified folder.

- [yc beta baremetal private-cloud-connection delete](delete.md) — Removes a private cloud connection and all allocated network resouces

- [yc beta baremetal private-cloud-connection get](get.md) — Returns the specific Private cloud connection resource.

- [yc beta baremetal private-cloud-connection list](list.md) — Retrieves the list of Private cloud connection resources in the specified folder.

- [yc beta baremetal private-cloud-connection update](update.md) — Updates the routing_instance_id in a private cloud connection.

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