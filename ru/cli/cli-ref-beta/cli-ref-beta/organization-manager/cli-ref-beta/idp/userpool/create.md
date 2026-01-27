---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/organization-manager/cli-ref-beta/idp/userpool/create.md
---

# yc beta organization-manager idp userpool create

Creates a userpool in the specified organization.

#### Command Usage

Syntax:

`yc beta organization-manager idp userpool create <ORGANIZATION-ID>`

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
|| `--bruteforce-protection-policy` | `shorthand/json`

Bruteforce protection policy for the userpool.

Shorthand Syntax:

```hcl
{
  attempts = int,
  block = duration,
  window = duration
}
```

JSON Syntax:

```json
{
  "attempts": "int",
  "block": "duration",
  "window": "duration"
}
```

Fields:

```
attempts -> (int)
  Number of failed attempts allowed within the window before blocking.
block -> (duration)
  Duration of the block after too many failed attempts.
window -> (duration)
  Time window for counting failed authentication attempts.
``` ||
|| `--default-subdomain` | `string`

Default subdomain for the userpool. ||
|| `--description` | `string`

Description of the userpool. ||
|| `--labels` | `stringToString`

Resource labels as key:value pairs. ||
|| `--name` | `string`

Name of the userpool. The name must be unique within the organization. ||
|| `--organization-id` | `string`

ID of the organization to create a userpool in. ||
|| `--password-lifetime-policy` | `shorthand/json`

Password lifetime policy for the userpool.

Shorthand Syntax:

```hcl
{
  max-days-count = int,
  min-days-count = int
}
```

JSON Syntax:

```json
{
  "max-days-count": "int",
  "min-days-count": "int"
}
```

Fields:

```
max-days-count -> (int)
  Maximum number of days a password remains valid. Zero means passwords never expire.
min-days-count -> (int)
  Minimum number of days before a password can be changed.
``` ||
|| `--password-quality-policy` | `shorthand/json`

Password quality policy for the userpool.

Shorthand Syntax:

```hcl
{
  allow-similar = bool,
  complexity-policy = fixed={
    digits-required = bool,
    lowers-required = bool,
    min-length = int,
    specials-required = bool,
    uppers-required = bool
  } | smart={
    four-classes = int,
    one-class = int,
    three-classes = int,
    two-classes = int
  },
  match-length = int,
  max-length = int,
  min-length = int,
  min-length-by-class-settings = {
    one = int,
    three = int,
    two = int
  },
  required-classes = {
    digits = bool,
    lowers = bool,
    specials = bool,
    uppers = bool
  }
}
```

JSON Syntax:

```json
{
  "allow-similar": "bool",
  "complexity-policy": {
    "fixed": {
      "digits-required": "bool",
      "lowers-required": "bool",
      "min-length": "int",
      "specials-required": "bool",
      "uppers-required": "bool"
    },
    "smart": {
      "four-classes": "int",
      "one-class": "int",
      "three-classes": "int",
      "two-classes": "int"
    }
  },
  "match-length": "int",
  "max-length": "int",
  "min-length": "int",
  "min-length-by-class-settings": {
    "one": "int",
    "three": "int",
    "two": "int"
  },
  "required-classes": {
    "digits": "bool",
    "lowers": "bool",
    "specials": "bool",
    "uppers": "bool"
  }
}
```

Fields:

```
allow-similar -> (bool)
  Whether passwords similar to previous ones are allowed.
match-length -> (int)
  Minimum length of substrings to check for similarity to vulnerable sequences.
max-length -> (int)
  Maximum password length. Zero means no maximum length is enforced.
min-length -> (int)
  Deprecated. Use Fixed instead.
min-length-by-class-settings -> (struct)
  Deprecated. Use Smart instead.
  one -> (int)
    Minimum length for passwords with one character class.
  three -> (int)
    Minimum length for passwords with three character classes.
  two -> (int)
    Minimum length for passwords with two character classes.
required-classes -> (struct)
  Deprecated. Use Fixed instead.
  digits -> (bool)
    Whether digits are required.
  lowers -> (bool)
    Whether lowercase letters are required.
  specials -> (bool)
    Whether special characters are required.
  uppers -> (bool)
    Whether uppercase letters are required.
complexity-policy -> (oneof<fixed|smart>)
  Oneof complexity-policy field
  fixed -> (struct)
    Fixed complexity requirements. Exactly one of complexity requirements must be specified.
    digits-required -> (bool)
      Whether digits are required in the password.
    lowers-required -> (bool)
      Whether lowercase letters are required in the password.
    min-length -> (int)
      Minimum length required for all passwords.
    specials-required -> (bool)
      Whether special characters are required in the password.
    uppers-required -> (bool)
      Whether uppercase letters are required in the password.
  smart -> (struct)
    Smart complexity requirements. Exactly one of complexity requirements must be specified.
    four-classes -> (int)
      For passwords with all four classes of characters
    one-class -> (int)
      For passwords with one class of characters
    three-classes -> (int)
      For passwords with three classes of characters
    two-classes -> (int)
      For passwords with two classes of characters
``` ||
|| `--user-settings` | `shorthand/json`

User settings for the userpool.

Shorthand Syntax:

```hcl
{
  allow-edit-self-contacts = bool,
  allow-edit-self-info = bool,
  allow-edit-self-login = bool,
  allow-edit-self-password = bool
}
```

JSON Syntax:

```json
{
  "allow-edit-self-contacts": "bool",
  "allow-edit-self-info": "bool",
  "allow-edit-self-login": "bool",
  "allow-edit-self-password": "bool"
}
```

Fields:

```
allow-edit-self-contacts -> (bool)
  Whether users can edit their own contact information.
allow-edit-self-info -> (bool)
  Whether users can edit their own profile information.
allow-edit-self-login -> (bool)
  Whether users can edit their own login information.
allow-edit-self-password -> (bool)
  Whether users can change their own passwords.
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

Set the output format: text, yaml, json, table, summary. ||
|| `--summary` | `strings`

Fields to include in summary output.
Each value is a dot-separated path to a field.
Examples:
  --summary instance.id                  # simple field
  --summary instance.type                # another simple field
  --summary instance.disks.size          # collect values from all list elements
  --summary instance.disks[0].size       # field from a specific list element ||
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