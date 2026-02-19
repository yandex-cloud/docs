---
editable: false
noIndex: true
---

# yc beta lockbox secret create

Creates a secret in the specified folder.

#### Command Usage

Syntax:

`yc beta lockbox secret create <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--create-version` | If true: a version will be created with either version_payload_entries or password_payload_specification (one is required). If false: a version is NOT created, no matter version_payload_entries or password_payload_specification. Default: a version is created IF either version_payload_entries or password_payload_specification are specified. It's never allowed to set both version_payload_entries and password_payload_specification. ||
|| `--deletion-protection` | Flag that inhibits deletion of the secret. ||
|| `--description` | `string`

Description of the secret. ||
|| `--folder-id` | `string`

ID of the folder to create a secret in. ||
|| `--kms-key-id` | `string`

Optional ID of the KMS key will be used to encrypt and decrypt the secret. ||
|| `--labels` | `map<string><string>`

Custom labels for the secret as 'key:value' pairs. Maximum 64 per key. For example, '"project": "mvp"' or '"source": "dictionary"'. ||
|| `--name` | `string`

Name of the secret. ||
|| `--version-description` | `string`

Description of the first version. ||
|| `--version-payload-entries` | `shorthand/json`

Payload entries added to the first version.

Shorthand Syntax:

```hcl
[
  {
    key = string,
    value = binary-value=uint,... | text-value=string
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "key": "string",
    "value": {
      "binary-value": [
        "uint", ...
      ],
      "text-value": "string"
    }
  }, ...
]
```

Fields:

```
key -> (string)
  Non-confidential key of the entry.
value -> (oneof<binary-value|text-value>)
  Oneof value field
  text-value -> (string)
    Use the field to set a text value.
  binary-value -> (bytes)
    Use the field to set a binary value.
``` ||
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