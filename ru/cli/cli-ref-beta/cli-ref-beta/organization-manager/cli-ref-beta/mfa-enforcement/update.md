---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/organization-manager/cli-ref-beta/mfa-enforcement/update.md
---

# yc beta organization-manager mfa-enforcement update

updates the specified MFA enforcement

#### Command Usage

Syntax: 

`yc beta organization-manager mfa-enforcement update <MFA-ENFORCEMENT-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--acr-id`|<b>`string`</b><br/>acr id for the MFA enforcement. one of 'any-mfa' or 'phr',<br/>specification https://yandex.cloud/en/docs/organization/concepts/mfa?utm_referrer=https%3A%2F%2Fa.yandex-team.ru%2F#mfa-factors|
|`--apply-at`|<b>`time`</b><br/>the MFA enforcement application start time (RFC3339)|
|`--description`|<b>`string`</b><br/>the MFA enforcement description|
|`--enroll-window`|<b>`duration`</b><br/>the MFA enforcement enroll window (duration, e.g. 30s, 5m10s)|
|`--mfa-enforcement-id`|<b>`string`</b><br/>id of the MFA enforcement|
|`--name`|<b>`string`</b><br/>the MFA enforcement name|
|`--status`|<b>`enum`</b><br/>the MFA enforcement status Possible Values: 'status-active', 'status-inactive'|
|`--ttl`|<b>`duration`</b><br/>the period during which the entered MFA factor will be considered valid and the<br/>corresponding acr will be regarded as satisfied (duration, e.g. 30s, 5m10s)|
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
