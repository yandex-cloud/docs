---
editable: false
noIndex: true
---

# yc beta organization-manager mfa-enforcement create

creates an MFA enforcement in the specified organization

#### Command Usage

Syntax:

`yc beta organization-manager mfa-enforcement create <ACR-ID>`

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
|| `--acr-id` | `string`

acr id for the MFA enforcement. one of 'any-mfa' or 'phr', specification https://yandex.cloud/en/docs/organization/concepts/mfa?utm_referrer=https%3A%2F%2Fa.yandex-team.ru%2F#mfa-factors ||
|| `--apply-at` | `time`

the MFA enforcement application start time (RFC3339) ||
|| `--description` | `string`

the MFA enforcement description ||
|| `--enroll-window` | `duration`

the MFA enforcement enroll window (duration, e.g. 30s, 5m10s) ||
|| `--name` | `string`

the MFA enforcement name ||
|| `--organization-id` | `string`

organization id of the MFA enforcement ||
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