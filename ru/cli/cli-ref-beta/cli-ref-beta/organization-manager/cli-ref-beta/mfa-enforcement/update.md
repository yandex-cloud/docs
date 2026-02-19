---
editable: false
noIndex: true
---

# yc beta organization-manager mfa-enforcement update

updates the specified MFA enforcement

#### Command Usage

Syntax:

`yc beta organization-manager mfa-enforcement update <MFA-ENFORCEMENT-ID>`

#### Flags

#|
||Flag | Description ||
|| `--acr-id` | `string`

acr id for the MFA enforcement. one of 'any-mfa' or 'phr', specification https://yandex.cloud/en/docs/organization/concepts/mfa?utm_referrer=https%3A%2F%2Fa.yandex-team.ru%2F#mfa-factors ||
|| `--apply-at` | `time`

the MFA enforcement application start time (RFC3339) ||
|| `--description` | `string`

the MFA enforcement description ||
|| `--enroll-window` | `duration`

the MFA enforcement enroll window (duration, e.g. 30s, 5m10s) ||
|| `--mfa-enforcement-id` | `string`

id of the MFA enforcement ||
|| `--name` | `string`

the MFA enforcement name ||
|| `--status` | `enum`

the MFA enforcement status Possible Values: 'status-active', 'status-inactive' ||
|| `--ttl` | `duration`

the period during which the entered MFA factor will be considered valid and the corresponding acr will be regarded as satisfied (duration, e.g. 30s, 5m10s) ||
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