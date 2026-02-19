---
editable: false
noIndex: true
---

# yc beta cloudrouter routing-instance create

Creates a RoutingInstance resource in the specified folder using the data specified in the request.
Method starts an asynchronous operation that can be cancelled while it is in progress.

#### Command Usage

Syntax:

`yc beta cloudrouter routing-instance create <FOLDER-ID>`

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
|| `--cic-private-connection-info` | `shorthand/json`

List of the info about privateConnections which are attached to the RoutingInstance.

Shorthand Syntax:

```hcl
[
  {
    cic-private-connection-id = string
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "cic-private-connection-id": "string"
  }, ...
]
```

Fields:

```
cic-private-connection-id -> (string)
  ID of the cicPrivateConnection that is attached to the routingInstance.
``` ||
|| `--description` | `string`

Optional description of the RoutingInstance. 0-256 characters long. ||
|| `--folder-id` | `string`

ID of the folder that the RoutingInstance belongs to. ||
|| `--labels` | `map<string><string>`

Resource labels, 'key:value' pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression '[-_0-9a-z]*'. The string length in characters for each key must be 1-63. Each key must match the regular expression '[a-z][-_0-9a-z]*'. ||
|| `--name` | `string`

Name of the RoutingInstance. The name must be unique within the folder. Value must match the regular expression ''\\|a-zA-Z?''. ||
|| `--region-id` | `string`

ID of the region that the routingInstance belongs to. ||
|| `--vpc-info` | `shorthand/json`

List of the info about vpcNetworks which are attached to the RoutingInstance.

Shorthand Syntax:

```hcl
[
  {
    az-infos = [
      {
        manual-info = {
          az-id = string,
          prefixes = string,...
        }
      }, ...
    ],
    vpc-network-id = string
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "az-infos": [
      {
        "manual-info": {
          "az-id": "string",
          "prefixes": [
            "string", ...
          ]
        }
      }, ...
    ],
    "vpc-network-id": "string"
  }, ...
]
```

Fields:

```
az-infos -> ([]struct)
  List of the az-related info about vpcNetworks which are attached to routingInstance
  manual-info -> (struct)
    VpcInfo which is set by user
    az-id -> (string)
      ID of the AZ
    prefixes -> ([]string)
      List of prefixes to announce
vpc-network-id -> (string)
  ID of the vpcNetwork that is attached to the routingInstance.
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