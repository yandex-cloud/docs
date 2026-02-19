---
editable: false
noIndex: true
---

# yc beta managed-mysql user grant-permission

Grants permission to access a database to a user in a cluster.

#### Command Usage

Syntax:

`yc beta managed-mysql user grant-permission <CLUSTER-ID>`

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

ID of the cluster to grant permission to the user in. To get this ID, make a [ClusterService.List] request. ||
|| `--permission` | `shorthand/json`

Permission that should be granted to the specified user.

Shorthand Syntax:

```hcl
{
  database-name = string,
  roles = [
    ALL_PRIVILEGES|ALTER|ALTER_ROUTINE|CREATE|CREATE_ROUTINE|CREATE_TEMPORARY_TABLES|CREATE_VIEW|DELETE|DROP|EVENT|EXECUTE|INDEX|INSERT|LOCK_TABLES|SELECT|SHOW_VIEW|TRIGGER|UPDATE|REFERENCES, ...
  ]
}
```

JSON Syntax:

```json
{
  "database-name": "string",
  "roles": [
    "ALL_PRIVILEGES|ALTER|ALTER_ROUTINE|CREATE|CREATE_ROUTINE|CREATE_TEMPORARY_TABLES|CREATE_VIEW|DELETE|DROP|EVENT|EXECUTE|INDEX|INSERT|LOCK_TABLES|SELECT|SHOW_VIEW|TRIGGER|UPDATE|REFERENCES", ...
  ]
}
```

Fields:

```
database-name -> (string)
  Name of the database that the permission grants access to.
roles -> ([]struct)
  Roles granted to the user within the database. See documentation for details.
``` ||
|| `--user-name` | `string`

Name of the user to grant permission to. To get this name, make a [UserService.List] request. ||
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