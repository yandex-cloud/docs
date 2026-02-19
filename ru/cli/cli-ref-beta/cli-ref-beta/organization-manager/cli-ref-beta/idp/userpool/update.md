---
editable: false
noIndex: true
---

# yc beta organization-manager idp userpool update

Updates the specified userpool.

#### Command Usage

Syntax:

`yc beta organization-manager idp userpool update <USERPOOL-ID>`

#### Flags

#|
||Flag | Description ||
|| `--bruteforce-protection-policy` | `shorthand/json`

Bruteforce protection policy for the userpool.

Shorthand Syntax:

```hcl
{
  attempts = integer,
  block = duration,
  window = duration
}
```

JSON Syntax:

```json
{
  "attempts": "integer",
  "block": "duration",
  "window": "duration"
}
```

Fields:

```
attempts -> (integer)
  Number of failed attempts allowed within the window before blocking.
block -> (duration)
  Duration of the block after too many failed attempts.
window -> (duration)
  Time window for counting failed authentication attempts.
``` ||
|| `--description` | `string`

Description of the userpool. ||
|| `--labels` | `map<string><string>`

Resource labels as key:value pairs. ||
|| `--name` | `string`

Name of the userpool. The name must be unique within the organization. ||
|| `--password-lifetime-policy` | `shorthand/json`

Password lifetime policy for the userpool.

Shorthand Syntax:

```hcl
{
  max-days-count = integer,
  min-days-count = integer
}
```

JSON Syntax:

```json
{
  "max-days-count": "integer",
  "min-days-count": "integer"
}
```

Fields:

```
max-days-count -> (integer)
  Maximum number of days a password remains valid. Zero means passwords never expire.
min-days-count -> (integer)
  Minimum number of days before a password can be changed.
``` ||
|| `--password-quality-policy` | `shorthand/json`

Password quality policy for the userpool.

Shorthand Syntax:

```hcl
{
  allow-similar = boolean,
  complexity-policy = fixed={
    digits-required = boolean,
    lowers-required = boolean,
    min-length = integer,
    specials-required = boolean,
    uppers-required = boolean
  } | smart={
    four-classes = integer,
    one-class = integer,
    three-classes = integer,
    two-classes = integer
  },
  match-length = integer,
  max-length = integer,
  min-length = integer,
  min-length-by-class-settings = {
    one = integer,
    three = integer,
    two = integer
  },
  required-classes = {
    digits = boolean,
    lowers = boolean,
    specials = boolean,
    uppers = boolean
  }
}
```

JSON Syntax:

```json
{
  "allow-similar": "boolean",
  "complexity-policy": {
    "fixed": {
      "digits-required": "boolean",
      "lowers-required": "boolean",
      "min-length": "integer",
      "specials-required": "boolean",
      "uppers-required": "boolean"
    },
    "smart": {
      "four-classes": "integer",
      "one-class": "integer",
      "three-classes": "integer",
      "two-classes": "integer"
    }
  },
  "match-length": "integer",
  "max-length": "integer",
  "min-length": "integer",
  "min-length-by-class-settings": {
    "one": "integer",
    "three": "integer",
    "two": "integer"
  },
  "required-classes": {
    "digits": "boolean",
    "lowers": "boolean",
    "specials": "boolean",
    "uppers": "boolean"
  }
}
```

Fields:

```
allow-similar -> (boolean)
  Whether passwords similar to previous ones are allowed.
match-length -> (integer)
  Minimum length of substrings to check for similarity to vulnerable sequences.
max-length -> (integer)
  Maximum password length. Zero means no maximum length is enforced.
min-length -> (integer)
  Deprecated. Use Fixed instead.
min-length-by-class-settings -> (struct)
  Deprecated. Use Smart instead.
  one -> (integer)
    Minimum length for passwords with one character class.
  three -> (integer)
    Minimum length for passwords with three character classes.
  two -> (integer)
    Minimum length for passwords with two character classes.
required-classes -> (struct)
  Deprecated. Use Fixed instead.
  digits -> (boolean)
    Whether digits are required.
  lowers -> (boolean)
    Whether lowercase letters are required.
  specials -> (boolean)
    Whether special characters are required.
  uppers -> (boolean)
    Whether uppercase letters are required.
complexity-policy -> (oneof<fixed|smart>)
  Oneof complexity-policy field
  fixed -> (struct)
    Fixed complexity requirements. Exactly one of complexity requirements must be specified.
    digits-required -> (boolean)
      Whether digits are required in the password.
    lowers-required -> (boolean)
      Whether lowercase letters are required in the password.
    min-length -> (integer)
      Minimum length required for all passwords.
    specials-required -> (boolean)
      Whether special characters are required in the password.
    uppers-required -> (boolean)
      Whether uppercase letters are required in the password.
  smart -> (struct)
    Smart complexity requirements. Exactly one of complexity requirements must be specified.
    four-classes -> (integer)
      For passwords with all four classes of characters
    one-class -> (integer)
      For passwords with one class of characters
    three-classes -> (integer)
      For passwords with three classes of characters
    two-classes -> (integer)
      For passwords with two classes of characters
``` ||
|| `--user-settings` | `shorthand/json`

User settings for the userpool.

Shorthand Syntax:

```hcl
{
  allow-edit-self-contacts = boolean,
  allow-edit-self-info = boolean,
  allow-edit-self-login = boolean,
  allow-edit-self-password = boolean
}
```

JSON Syntax:

```json
{
  "allow-edit-self-contacts": "boolean",
  "allow-edit-self-info": "boolean",
  "allow-edit-self-login": "boolean",
  "allow-edit-self-password": "boolean"
}
```

Fields:

```
allow-edit-self-contacts -> (boolean)
  Whether users can edit their own contact information.
allow-edit-self-info -> (boolean)
  Whether users can edit their own profile information.
allow-edit-self-login -> (boolean)
  Whether users can edit their own login information.
allow-edit-self-password -> (boolean)
  Whether users can change their own passwords.
``` ||
|| `--userpool-id` | `string`

ID of the userpool to update. To get the userpool ID, make a [UserpoolService.List] request. ||
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