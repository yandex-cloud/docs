---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/lockbox/cli-ref-beta/secret/update.md
---

# yc beta lockbox secret update

Updates the specified secret.

#### Command Usage

Syntax: 

`yc beta lockbox secret update <SECRET-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--deletion-protection`|Flag that inhibits deletion of the secret.|
|`--description`|<b>`string`</b><br/>New description of the secret.|
|`--labels`|<b>`stringToString`</b><br/>Custom labels for the secret as 'key:value' pairs. Maximum 64 per key.|
|`--name`|<b>`string`</b><br/>New name of the secret.|
|`--secret-id`|<b>`string`</b><br/>ID of the secret to update.|
|`--password-payload-specification`|<b>`shorthand/json`</b><br/><br/><br/>Example:|
|`--password-payload-specification`|<b>`excluded-punctuation=value,`</b><br/>include-digits=true, include-lowercase=true, include-punctuation=true, include-uppercase=true, included-punctuation=value, length=1, password-key=value<br/><br/>Shorthand Syntax:<br/>{excluded-punctuation=str, include-digits=bool, include-lowercase=bool, include-punctuation=bool, include-uppercase=bool, included-punctuation=str, length=int, password-key=str}<br/>Fields:<br/>excluded-punctuation  string            — a string of punctuation characters to exclude from the default (at most 31, it's not allowed to exclude all the 32)<br/>include-digits        bool              — whether at least one 0..9 character is included in the password, true by default<br/>include-lowercase     bool              — whether at least one a..z character is included in the password, true by default<br/>include-punctuation   bool              — whether at least one punctuation character is included in the password, true by default<br/>punctuation characters by default (there are 32): !"#\$%&'()*+,-./:;<=>?@[\]^_'{\|}~<br/>to customize the punctuation characters, see included_punctuation and excluded_punctuation below<br/>include-uppercase     bool              — whether at least one A..Z character is included in the password, true by default<br/>included-punctuation  string            — If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation:<br/>a string of specific punctuation characters to use (at most, all the 32)<br/>length                int               — password length; by default, a reasonable length will be decided<br/>password-key          string  required  — key of the entry to store generated password value<br/>|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
