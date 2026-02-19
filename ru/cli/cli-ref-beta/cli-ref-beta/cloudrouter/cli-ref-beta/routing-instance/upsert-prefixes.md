---
editable: false
noIndex: true
---

# yc beta cloudrouter routing-instance upsert-prefixes

Upserts specified prefixes to a RoutingInstance resource.
Method starts an asynchronous operation that can be cancelled while it is in progress.

#### Command Usage

Syntax:

`yc beta cloudrouter routing-instance upsert-prefixes <ROUTING-INSTANCE-ID>`

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
|| `--routing-instance-id` | `string`

ID of the RoutingInstance resource. ||
|| `--vpc-az-info-prefixes` | `shorthand/json`

List of VpcAzInfoPrefixes to upsert.

Shorthand Syntax:

```hcl
[
  {
    az-id = string,
    prefixes = string,...
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "az-id": "string",
    "prefixes": [
      "string", ...
    ]
  }, ...
]
```

Fields:

```
az-id -> (string)
  ID of the AZ.
prefixes -> ([]string)
  List of prefixes.
``` ||
|| `--vpc-network-id` | `string`

ID of the VpcNetwork to update. ||
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