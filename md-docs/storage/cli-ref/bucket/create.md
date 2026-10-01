[Документация Yandex Cloud](../../../index.md) > [Yandex Object Storage](../../index.md) > [Справочник YC CLI (англ.)](../index.md) > [bucket](index.md) > create

# yc storage bucket create

Create new bucket

#### Command Usage

Syntax:

`yc storage bucket create <BUCKET-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

A name of the bucket ||
|| `--default-storage-class` | `string`

Default storage class of the bucket ||
|| `--max-size` | `int`

Sets maximum size of the bucket, 0 for unlimimted ||
|| `--public-read` | Opens bucket for public read ||
|| `--public-list` | Opens bucket for public listing ||
|| `--public-config-read` | Opens bucket for public config ||
|| `--acl` | `string`

Setup bucket with predefined ACL. Conflicts with grants ||
|| `--grants` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Sets bucket ACL more precisely. Conflicts with acl

Possible property names:

- `grantee-id`: Sets grantee id used for grant type account

- `grant-type`: Sets grant type Values: 'grant-type-account', 'grant-type-all-authenticated-users', 'grant-type-all-users'

- `permission`: Sets permission for the grant Values: 'permission-full-control', 'permission-write', 'permission-write-acp', 'permission-read', 'permission-read-acp' ||
|| `--tags` | `key=value[,key=value...]`

A list of tags (or labels) KEY=VALUE pairs to add. For example, to add two tags named 'foo' and 'bar', both with the value 'baz', use '--tags foo=baz,bar=baz'. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#