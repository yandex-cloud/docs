---
editable: false
noIndex: true
---

# yc beta compute instance-group

A set of methods for managing InstanceGroup resources.

#### Command Usage

Syntax:

`yc beta compute instance-group <command>`

#### Command Tree

- [yc beta compute instance-group create](create.md) — Creates an instance group in the specified folder.

- [yc beta compute instance-group create-from-yaml](create-from-yaml.md) — Creates an instance group in the specified folder from a YAML file.

- [yc beta compute instance-group delete](delete.md) — Deletes the specified instance group.

- [yc beta compute instance-group delete-instances](delete-instances.md) — Delete instances from the instance group.

- [yc beta compute instance-group disable-zones](disable-zones.md) — Disable zones for the specified instance group.

- [yc beta compute instance-group enable-zones](enable-zones.md) — Enable zones for the specified instance group.

- [yc beta compute instance-group get](get.md) — Returns the specified InstanceGroup resource.

- [yc beta compute instance-group list](list.md) — Retrieves the list of InstanceGroup resources in the specified folder.

- [yc beta compute instance-group list-access-bindings](list-access-bindings.md) — Lists existing access bindings for the specified instance group.

- [yc beta compute instance-group list-instances](list-instances.md) — Lists instances for the specified instance group.

- [yc beta compute instance-group list-log-records](list-log-records.md) — Lists logs for the specified instance group.

- [yc beta compute instance-group list-operations](list-operations.md) — Lists operations for the specified instance group.

- [yc beta compute instance-group pause-processes](pause-processes.md) — Pauses all processes regarding management of the specified instance group,

- [yc beta compute instance-group resume-processes](resume-processes.md) — Resumes all processes regarding management of the specified instance group,

- [yc beta compute instance-group rolling-recreate](rolling-recreate.md) — Performs rolling recreate of specified instances for the specified instance group.

- [yc beta compute instance-group rolling-restart](rolling-restart.md) — Performs rolling restart of specified instances for the specified instance group.

- [yc beta compute instance-group set-access-bindings](set-access-bindings.md) — Sets access bindings for the specified instance group.

- [yc beta compute instance-group start](start.md) — Starts the specified instance group.

- [yc beta compute instance-group stop](stop.md) — Stops the specified instance group.

- [yc beta compute instance-group stop-instances](stop-instances.md) — Stop instances from the instance group.

- [yc beta compute instance-group update](update.md) — Updates the specified instance group.

- [yc beta compute instance-group update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified instance group.

- [yc beta compute instance-group update-from-yaml](update-from-yaml.md) — Updates the specified instance group from a YAML file.

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