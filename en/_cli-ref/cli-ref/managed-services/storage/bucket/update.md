---
editable: false
---

# yc storage bucket update

Update the specified bucket

#### Command Usage

Syntax: 

`yc storage bucket update <BUCKET-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>A name of the bucket|
|`--default-storage-class`|<b>`string`</b><br/>Sets bucket default storage class|
|`--max-size`|<b>`int`</b><br/>Updates bucket's max size|
|`--public-read`|Opens bucket for public read|
|`--public-list`|Opens bucket for public listing|
|`--public-config-read`|Opens bucket for public config|
|`--grants`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Sets bucket acl with grants<br/><br/>Possible property names:<br/><ul> <li><code>grantee-id</code>:     Sets grantee id used for grant type account</li> <li><code>grant-type</code>:     Sets grant type Values: 'grant-type-account', 'grant-type-all-authenticated-users', 'grant-type-all-users'</li> <li><code>permission</code>:     Sets permission for the grant Values: 'permission-full-control', 'permission-write', 'permission-write-acp', 'permission-read', 'permission-read-acp'</li> </ul>|
|`--acl`|<b>`string`</b><br/>Sets bucket acl using predefined rule|
|`--versioning`|<b>`string`</b><br/>Sets buckets versioning Values: 'versioning-disabled', 'versioning-enabled', 'versioning-suspended'|
|`--cors`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Sets bucket cors<br/><br/>Possible property names:<br/><ul> <li><code>id</code>:     Id of the rule</li> <li><code>allowed-headers</code>:     Sets allowed headers</li> <li><code>allowed-origins</code>:     Sets allowed origins</li> <li><code>expose-headers</code>:     Sets expose headers</li> <li><code>max-age-seconds</code>:     Sets max age seconds header</li> <li><code>allowed-methods</code>:     Sets allowed methods</li> </ul>|
|`--remove-cors`|Remove CORS of bucket|
|`--tags`|<b>`key=value[,key=value...]`</b><br/>A list of tags KEY=VALUE pairs to add. For example, to add two tags named 'foo' and 'bar', both with the value 'baz', use '--tags foo=baz,bar=baz'.|
|`--remove-tags`|Remove tags of bucket|
|`--lifecycle-rules`|<b>`string`</b><br/>Sets bucket lifecycle rules from json input|
|`--lifecycle-rules-from-file`|<b>`string`</b><br/>Loads lifecycle rules from file in json format|
|`--remove-lifecycle-rules`|Remove lifecycle rules of bucket|
|`--website-settings`|<b>`string`</b><br/>Sets bucket website settings from json input|
|`--website-settings-from-file`|<b>`string`</b><br/>Loads website settings from file in json format|
|`--remove-website-settings`|Remove website settings of bucket|
|`--policy`|<b>`string`</b><br/>Sets bucket policy|
|`--policy-from-file`|<b>`string`</b><br/>Same as policy but loads policy from file|
|`--generate-lifecycle-skeleton`|Prints example of lifecycle rules|
|`--generate-website-settings-skeleton`|Prints example of website settings|
|`--encryption`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Sets encryption kms-master-key-id<br/><br/>Possible property names:<br/><ul> <li><code>key-id</code>:     Encryption key id</li> </ul>|
|`--remove-encryption`|Remove encryption from the bucket|
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
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
