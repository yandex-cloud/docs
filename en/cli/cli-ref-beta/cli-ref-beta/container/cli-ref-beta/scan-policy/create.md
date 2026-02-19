---
editable: false
noIndex: true
---

# yc beta container scan-policy create

Creates a scan policy for the specified registry.

#### Command Usage

Syntax:

`yc beta container scan-policy create <REGISTRY-ID>`

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
|| `--description` | `string`

Description of the scan policy. ||
|| `--name` | `string`

Name of the scan policy. ||
|| `--registry-id` | `string`

ID of the scan policy registry. ||
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