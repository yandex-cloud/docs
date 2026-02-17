---
editable: false
---

# yc organization-manager idp userpool create

Create a user pool

#### Command Usage

Syntax:

`yc organization-manager idp userpool create [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--organization-id` | `string`

Set the ID of the organization to use. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--userpool-name` | `string`

Name of the userpool ||
|| `--description` | `string`

Description of the userpool ||
|| `--labels` | `stringToString`

Labels of the userpool as key=value pairs ||
|| `--default-subdomain` | `string`

Default subdomain for the userpool ||
|| `--password-min-days` | `int`

Minimum number of days before a password can be changed. ||
|| `--password-max-days` | `int`

Maximum number of days a password remains valid. Zero means passwords never expire. ||
|| `--bruteforce-window` | `duration`

Time window for counting failed authentication attempts. ||
|| `--bruteforce-block` | `duration`

Duration of the block after too many failed attempts. ||
|| `--bruteforce-attempts` | `int`

Number of failed attempts allowed within the window before blocking. ||
|| `--password-allow-similar` | Whether passwords similar to previous ones are allowed. ||
|| `--password-max-length` | `int`

Maximum password length. Zero means no maximum length is enforced. ||
|| `--password-match-length` | `int`

Minimum length of substrings to check for similarity to vulnerable sequences. ||
|| `--password-fixed-lowers-required` | Whether lowercase letters are required in passwords (fixed policy). ||
|| `--password-fixed-uppers-required` | Whether uppercase letters are required in passwords (fixed policy). ||
|| `--password-fixed-digits-required` | Whether digits are required in passwords (fixed policy). ||
|| `--password-fixed-specials-required` | Whether special characters are required in passwords (fixed policy). ||
|| `--password-fixed-min-length` | `int`

Minimum password length (fixed policy). ||
|| `--password-smart-one-class` | `int`

Minimum length for passwords with one character class (smart policy). ||
|| `--password-smart-two-classes` | `int`

Minimum length for passwords with two character classes (smart policy). ||
|| `--password-smart-three-classes` | `int`

Minimum length for passwords with three character classes (smart policy). ||
|| `--password-smart-four-classes` | `int`

Minimum length for passwords with four character classes (smart policy). ||
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