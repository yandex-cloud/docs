---
editable: false
noIndex: true
---

# yc beta lockbox secret update

Updates the specified secret.

#### Command Usage

Syntax:

`yc beta lockbox secret update <SECRET-ID>`

#### Flags

#|
||Flag | Description ||
|| `--deletion-protection` | Flag that inhibits deletion of the secret. ||
|| `--description` | `string`

New description of the secret. ||
|| `--labels` | `map<string><string>`

Custom labels for the secret as 'key:value' pairs. Maximum 64 per key. ||
|| `--name` | `string`

New name of the secret. ||
|| `--secret-id` | `string`

ID of the secret to update. ||
|| `--password-payload-specification` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  excluded-punctuation = string,
  include-digits = boolean,
  include-lowercase = boolean,
  include-punctuation = boolean,
  include-uppercase = boolean,
  included-punctuation = string,
  length = integer,
  password-key = string
}
```

JSON Syntax:

```json
{
  "excluded-punctuation": "string",
  "include-digits": "boolean",
  "include-lowercase": "boolean",
  "include-punctuation": "boolean",
  "include-uppercase": "boolean",
  "included-punctuation": "string",
  "length": "integer",
  "password-key": "string"
}
```

Fields:

```
excluded-punctuation -> (string)
  a string of punctuation characters to exclude from the default (at most 31, it's not allowed to exclude all the 32)
include-digits -> (boolean)
  whether at least one 0..9 character is included in the password, true by default
include-lowercase -> (boolean)
  whether at least one a..z character is included in the password, true by default
include-punctuation -> (boolean)
  whether at least one punctuation character is included in the password, true by default punctuation characters by default (there are 32): !"#$%&'()*+,-./:;<=>?@[\]^_'{|}~ to customize the punctuation characters, see included_punctuation and excluded_punctuation below
include-uppercase -> (boolean)
  whether at least one A..Z character is included in the password, true by default
included-punctuation -> (string)
  If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation: a string of specific punctuation characters to use (at most, all the 32)
length -> (integer)
  password length; by default, a reasonable length will be decided
password-key -> (string)
  key of the entry to store generated password value
``` ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

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