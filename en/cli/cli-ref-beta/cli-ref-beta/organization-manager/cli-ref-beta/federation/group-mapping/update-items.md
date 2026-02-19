---
editable: false
noIndex: true
---

# yc beta organization-manager federation group-mapping update-items

Updates group mapping items for a specified federation
Errors:
- if federation is not found
- if internal group in the mapping added does not exist
In case of any error, no changes are applied to existing group mapping
This call is idempotent. The following actions do nothing:
- adding group mapping items that are already present
- removing group mapping items that are not present
Such parts of request will be ignored. Others will be applied.

#### Command Usage

Syntax:

`yc beta organization-manager federation group-mapping update-items <FEDERATION-ID>`

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
|| `--federation-id` | `string`

Federation the group mapping update is requested ||
|| `--group-mapping-item-deltas` | `shorthand/json`

A collection of mapping items to add or remove (ignores update_fields).

Shorthand Syntax:

```hcl
[
  {
    action = ADD|REMOVE,
    item = {
      external-group-id = string,
      internal-group-id = string
    }
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "action": "ADD|REMOVE",
    "item": {
      "external-group-id": "string",
      "internal-group-id": "string"
    }
  }, ...
]
```

Fields:

```
action -> (struct)
item -> (struct)
  external-group-id -> (string)
    External group id (received from identity provider)
  internal-group-id -> (string)
    Internal cloud group id
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