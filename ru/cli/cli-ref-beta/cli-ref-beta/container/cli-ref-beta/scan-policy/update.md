---
editable: false
noIndex: true
---

# yc beta container scan-policy update

Updates the specified scan policy.

#### Command Usage

Syntax:

`yc beta container scan-policy update <SCAN-POLICY-ID>`

#### Flags

#|
||Flag | Description ||
|| `--description` | `string`

Description of the scan policy. ||
|| `--name` | `string`

Name of the scan policy. ||
|| `--rules` | `shorthand/json`

Rules of the scan policy.

Shorthand Syntax:

```hcl
{
  push-rule = {
    disabled = boolean,
    repository-prefixes = string,...
  },
  schedule-rules = [
    {
      disabled = boolean,
      repository-prefixes = string,...,
      rescan-period = duration
    }, ...
  ]
}
```

JSON Syntax:

```json
{
  "push-rule": {
    "disabled": "boolean",
    "repository-prefixes": [
      "string", ...
    ]
  },
  "schedule-rules": [
    {
      "disabled": "boolean",
      "repository-prefixes": [
        "string", ...
      ],
      "rescan-period": "duration"
    }, ...
  ]
}
```

Fields:

```
push-rule -> (struct)
  Description of on-push scan rule.
  disabled -> (boolean)
    Turns off scan rule.
  repository-prefixes -> ([]string)
    List of repositories that are scanned with rule. Child repositories are included into parent node. "*" - means all repositories in registry
schedule-rules -> ([]struct)
  Description of time based rescan rule.
  disabled -> (boolean)
    Turns off scan rule.
  repository-prefixes -> ([]string)
    List of repositories that are scanned with rule. Child repositories are included into parent node. "*" - means all repositories in registry
  rescan-period -> (duration)
    Period of time since last scan to trigger automatic rescan.
``` ||
|| `--scan-policy-id` | `string`

ID of the scan policy. ||
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