---
editable: false
noIndex: true
---

# yc beta serverless api-gateway update

Updates the specified API gateway.

#### Command Usage

Syntax:

`yc beta serverless api-gateway update <API-GATEWAY-ID>`

#### Flags

#|
||Flag | Description ||
|| `--api-gateway-id` | `string`

ID of the API gateway to update. To get a API gateway ID make a [ApiGatewayService.List] request. ||
|| `--canary` | `shorthand/json`

Canary release of the gateway.

Shorthand Syntax:

```hcl
{
  variables = {key={
    variable-value = bool-value=boolean | double-value=float64 | int-value=integer | string-value=string
  }, key=...},
  weight = integer
}
```

JSON Syntax:

```json
{
  "variables": {
    "<key>": {
      "variable-value": {
        "bool-value": "boolean",
        "double-value": "float64",
        "int-value": "integer",
        "string-value": "string"
      }
    }, ...
  },
  "weight": "integer"
}
```

Fields:

```
variables -> (map[string,struct])
  Values specification variables, associated with canary.
  variable-value -> (oneof<bool-value|double-value|int-value|string-value>)
    Oneof variable-value field
    string-value -> (string)
    int-value -> (integer)
    double-value -> (float64)
    bool-value -> (boolean)
weight -> (integer)
  It describes percentage of requests, which will be processed by canary.
``` ||
|| `--connectivity` | `shorthand/json`

Gateway connectivity. If specified the gateway will be attached to specified network/subnet(s).

Shorthand Syntax:

```hcl
{
  network-id = string,
  subnet-id = string,...
}
```

JSON Syntax:

```json
{
  "network-id": "string",
  "subnet-id": [
    "string", ...
  ]
}
```

Fields:

```
network-id -> (string)
  Network the gateway will have access to. It's essential to specify network with subnets in all availability zones.
subnet-id -> ([]string)
  Complete list of subnets (from the same network) the gateway can be attached to. It's essential to specify at least one subnet for each availability zones.
``` ||
|| `--description` | `string`

New description for the API gateway. ||
|| `--execution-timeout` | `duration`

Timeout for gateway call execution (duration, e.g. 30s, 5m10s) ||
|| `--labels` | `map<string><string>`

API gateway labels as 'key:value' pairs. Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label, request the current set of labels with a [yandex.cloud.serverless.apigateway.v1.ApiGatewayService.Get] request. ||
|| `--log-options` | `shorthand/json`

Options for logging from the API gateway.

Shorthand Syntax:

```hcl
{
  destination = folder-id=string | log-group-id=string,
  disabled = boolean,
  min-level = TRACE|DEBUG|INFO|WARN|ERROR|FATAL
}
```

JSON Syntax:

```json
{
  "destination": {
    "folder-id": "string",
    "log-group-id": "string"
  },
  "disabled": "boolean",
  "min-level": "TRACE|DEBUG|INFO|WARN|ERROR|FATAL"
}
```

Fields:

```
disabled -> (boolean)
  Is logging from API gateway disabled.
min-level -> (struct)
  Minimum log entry level. See [LogLevel.Level] for details.
destination -> (oneof<folder-id|log-group-id>)
  Oneof destination field
  log-group-id -> (string)
    Entry should be written to log group resolved by ID.
  folder-id -> (string)
    Entry should be written to default log group for specified folder.
``` ||
|| `--name` | `string`

New name for the API gateway. The name must be unique within the folder. ||
|| `--variables` | `shorthand/json`

Values of variables defined in the specification.

Shorthand Syntax:

```hcl
{key={
  variable-value = bool-value=boolean | double-value=float64 | int-value=integer | string-value=string
}, key=...}
```

JSON Syntax:

```json
{
  "<key>": {
    "variable-value": {
      "bool-value": "boolean",
      "double-value": "float64",
      "int-value": "integer",
      "string-value": "string"
    }
  }, ...
}
```

Fields:

```
variable-value -> (oneof<bool-value|double-value|int-value|string-value>)
  Oneof variable-value field
  string-value -> (string)
  int-value -> (integer)
  double-value -> (float64)
  bool-value -> (boolean)
``` ||
|| `--openapi-spec` | `string`

The text of specification, JSON or YAML. ||
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