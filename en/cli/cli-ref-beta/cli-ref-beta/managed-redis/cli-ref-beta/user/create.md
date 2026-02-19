---
editable: false
noIndex: true
---

# yc beta managed-redis user create

Creates a Redis user in the specified cluster.

#### Command Usage

Syntax:

`yc beta managed-redis user create <CLUSTER-ID>`

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
|| `--cluster-id` | `string`

ID of the Redis cluster to create a user in. To get the cluster ID, use a [ClusterService.List] request. ||
|| `--user-spec` | `shorthand/json`

Properties of the user to be created.

Shorthand Syntax:

```hcl
{
  enabled = boolean,
  name = string,
  passwords = string,...,
  permissions = {
    categories = string,
    commands = string,
    patterns = string,
    pub-sub-channels = string,
    sanitize-payload = string
  }
}
```

JSON Syntax:

```json
{
  "enabled": "boolean",
  "name": "string",
  "passwords": [
    "string", ...
  ],
  "permissions": {
    "categories": "string",
    "commands": "string",
    "patterns": "string",
    "pub-sub-channels": "string",
    "sanitize-payload": "string"
  }
}
```

Fields:

```
enabled -> (boolean)
  Is Redis user enabled
name -> (string)
  Name of the Redis user.
passwords -> ([]string)
  Password of the Redis user.
permissions -> (struct)
  Set of permissions to grant to the user.
  categories -> (string)
    Command categories user has permissions to.
  commands -> (string)
    Commands user can execute.
  patterns -> (string)
    Keys patterns user has permission to.
  pub-sub-channels -> (string)
    Channel patterns user has permissions to.
  sanitize-payload -> (string)
    SanitizePayload parameter.
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