---
editable: false
sourcePath: en/_cli-ref/cli-ref/storage/cli-ref/bucket/update.md
---

# yc storage bucket update

Update the specified bucket

#### Command Usage

Syntax:

`yc storage bucket update <BUCKET-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

A name of the bucket ||
|| `--default-storage-class` | `string`

Sets bucket default storage class ||
|| `--max-size` | `int`

Updates bucket's max size ||
|| `--public-read` | Opens bucket for public read ||
|| `--public-list` | Opens bucket for public listing ||
|| `--public-config-read` | Opens bucket for public config ||
|| `--grants` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Sets bucket acl with grants

Possible property names:

- `grantee-id`: Sets grantee id used for grant type account

- `grant-type`: Sets grant type Values: 'grant-type-account', 'grant-type-all-authenticated-users', 'grant-type-all-users'

- `permission`: Sets permission for the grant Values: 'permission-full-control', 'permission-write', 'permission-write-acp', 'permission-read', 'permission-read-acp' ||
|| `--acl` | `string`

Sets bucket acl using predefined rule ||
|| `--versioning` | `string`

Sets buckets versioning Values: 'versioning-disabled', 'versioning-enabled', 'versioning-suspended' ||
|| `--cors` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Sets bucket cors

Possible property names:

- `id`: Id of the rule

- `allowed-headers`: Sets allowed headers

- `allowed-origins`: Sets allowed origins

- `expose-headers`: Sets expose headers

- `max-age-seconds`: Sets max age seconds header

- `allowed-methods`: Sets allowed methods ||
|| `--remove-cors` | Remove CORS of bucket ||
|| `--tags` | `key=value[,key=value...]`

A list of tags (or labels) KEY=VALUE pairs to add. For example, to add two tags named 'foo' and 'bar', both with the value 'baz', use '--tags foo=baz,bar=baz'. ||
|| `--remove-tags` | Remove tags of bucket ||
|| `--lifecycle-rules` | `string`

Sets bucket lifecycle rules from json input ||
|| `--lifecycle-rules-from-file` | `string`

Loads lifecycle rules from file in json format ||
|| `--remove-lifecycle-rules` | Remove lifecycle rules of bucket ||
|| `--website-settings` | `string`

Sets bucket website settings from json input ||
|| `--website-settings-from-file` | `string`

Loads website settings from file in json format ||
|| `--remove-website-settings` | Remove website settings of bucket ||
|| `--policy` | `string`

Sets bucket policy ||
|| `--policy-from-file` | `string`

Same as policy but loads policy from file ||
|| `--enable-private-endpoints` | `string`

Sets bucket allowed private endpoints policy: true/false. Example: --enable-private-endpoints=true ||
|| `--private-endpoints` | `value[,value]`

Sets bucket private endpoints ||
|| `--private-endpoints-force-cloudconsole-access` | `string`

If true, Cloud Console will be able to access bucket regardless of private-endpoints-list: true/false. Example: --private-endpoints-force-cloudconsole-access=true ||
|| `--generate-lifecycle-skeleton` | Prints example of lifecycle rules ||
|| `--generate-website-settings-skeleton` | Prints example of website settings ||
|| `--encryption` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Sets encryption kms-master-key-id

Possible property names:

- `key-id`: Encryption key id ||
|| `--remove-encryption` | Remove encryption from the bucket ||
|| `--disable-statickey-auth` | `string`

Disable static key authentication in bucket: true/false. Example: --disable-statickey-auth=true ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

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