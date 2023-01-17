---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/storage/bucket/create.md
---

# yc storage bucket create

Create new bucket

#### Command Usage

Syntax: 

`yc storage bucket create <BUCKET-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>A name of the bucket|
|`--default-storage-class`|<b>`string`</b><br/>Default storage class of the bucket|
|`--max-size`|<b>`int`</b><br/>Sets maximum size of the bucket, 0 for unlimimted|
|`--public-read`|Opens bucket for public read|
|`--public-list`|Opens bucket for public listing|
|`--public-config-read`|Opens bucket for public config|
|`--acl`|<b>`string`</b><br/>Setup bucket with predefined ACL. Conflicts with grants|
|`--grants`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Sets bucket ACL more precisely. Conflicts with acl<br/><br/>Possible property names:<br/><ul> <li><code>grantee-id</code>:     Sets grantee id used for grant type account</li> <li><code>grant-type</code>:     Sets grant type Values: 'grant-type-account', 'grant-type-all-authenticated-users', 'grant-type-all-users'</li> <li><code>permission</code>:     Sets permission for the grant Values: 'permission-full-control', 'permission-write', 'permission-write-acp', 'permission-read', 'permission-read-acp'</li> </ul>|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
