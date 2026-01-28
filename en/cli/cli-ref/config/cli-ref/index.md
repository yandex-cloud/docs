---
editable: false
sourcePath: en/_cli-ref/cli-ref/config/cli-ref/index.md
---

# yc config

The 'yc config' command group lets you set, view and unset properties used by Yandex Cloud CLI.
Core properties:
endpoint
string, Main Cloud API endpoint (host:port)
token
string, OAuth token 'yc' should use for authentication. Can be overridden by using the global '--token' flag.
Cannot be set at the same time as the 'service-account-key' and 'instance-service-account' properties. Setting one of them unsets the other.
service-account-key
object, IAM Key issued for service account that 'yc' should use for authentication.
Set from key file. See 'yc iam key create --help' for key create details.
Cannot be set at the same time as the 'token' and 'instance-service-account' property. Setting one of them unsets the other.
instance-service-account
bool, indicating that 'yc' should use for authentication Service Account of Compute Instance where 'yc' is executed.
See doc for yandex.cloud.compute.v1.CreateInstanceRequest.service_account_id for details.
Cannot be set at the same time as the 'token', 'service-account-key' properties. Setting one of them unsets the other.
organization-id
string, ID of the organization to operate on by default. Will be used, for example, in 'yc resource-manager cloud list' command.
Can be overridden by using the '--organization-id' flag.
cloud-id
string, ID of the cloud to operate on by default. Will be used, for example, in 'yc resource-manager folder list' command.
Can be overridden by using the global '--cloud-id' flag.
folder-id
ID of the folder to resolve names, list and create resources in by default. Can be overridden by using the global '--folder-id' flag.
Cannot be set at the same time as the 'folder-name' property. Setting one of them unsets the other.
folder-name
Name of the default folder to list and create resources in. Can be overridden by using the global '--folder-name' flag.
Cannot be set at the same time as the 'folder-id' property. Setting one of them unsets the other.
format
string, default output format: text, yaml, json. Can be overridden by using the global '--format' flag.
storage-endpoint
string, HTTP endpoint of storage service. By default cli takes endpoint from ApiEndpointService/Get handler
Yandex Compute Cloud properties:
compute-default-zone
Default availability zone to create instances, disks, or subnets in.
Yandex S3 Storage properties:
s3.max-concurrent-requests
The maximum number of concurrent requests.
s3.max-queue-size
The maximum number of tasks in the task queue.
s3.multipart-chunksize
When using multipart transfers, this is the chunk size that the CLI uses for multipart transfers of individual files.
s3.multipart-threshold
The size threshold the CLI uses for multipart transfers of individual files.

#### Command Usage

Syntax:

`yc config <group|command>`

#### Command Tree

- [yc config get](get.md) — Get value for the specified configuration property

- [yc config list](list.md) — List configuration values

- [yc config set](set.md) — Set value for the specified configuration property

- [yc config unset](unset.md) — Unset value for the specified configuration property

- [yc config profile](profile/index.md) — Manage configuration profiles

  - [yc config profile activate](profile/activate.md) — Activate the specified configuration profile

  - [yc config profile create](profile/create.md) — Create a configuration profile

  - [yc config profile delete](profile/delete.md) — Delete the specified configuration profile

  - [yc config profile get](profile/get.md) — List values for the specified configuration profile

  - [yc config profile list](profile/list.md) — List configuration profiles

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#