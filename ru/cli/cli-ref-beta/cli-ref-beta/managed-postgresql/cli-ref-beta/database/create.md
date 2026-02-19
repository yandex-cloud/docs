---
editable: false
noIndex: true
---

# yc beta managed-postgresql database create

Creates a new PostgreSQL database in the specified cluster.

#### Command Usage

Syntax:

`yc beta managed-postgresql database create <CLUSTER-ID>`

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

ID of the PostgreSQL cluster to create a database in. To get the cluster ID use a [ClusterService.List] request. ||
|| `--database-spec` | `shorthand/json`

Configuration of the database to create.

Shorthand Syntax:

```hcl
{
  deletion-protection = boolean,
  extensions = [
    {
      name = string,
      version = string
    }, ...
  ],
  lc-collate = string,
  lc-ctype = string,
  name = string,
  owner = string,
  template-db = string
}
```

JSON Syntax:

```json
{
  "deletion-protection": "boolean",
  "extensions": [
    {
      "name": "string",
      "version": "string"
    }, ...
  ],
  "lc-collate": "string",
  "lc-ctype": "string",
  "name": "string",
  "owner": "string",
  "template-db": "string"
}
```

Fields:

```
deletion-protection -> (boolean)
  Deletion Protection inhibits deletion of the database Default value: 'unspecified' (inherits cluster's deletion_protection)
extensions -> ([]struct)
  PostgreSQL extensions to be enabled for the database.
  name -> (string)
    Name of the extension, e.g. 'pg_trgm' or 'pg_btree'. Extensions supported by Managed Service for PostgreSQL are documentation.
  version -> (string)
    Version of the extension. The setting is deprecated and has no effect.
lc-collate -> (string)
  POSIX locale for string sorting order. Can only be set at creation time.
lc-ctype -> (string)
  POSIX locale for character classification. Can only be set at creation time.
name -> (string)
  Name of the PostgreSQL database. 1-63 characters long.
owner -> (string)
  Name of the user to be assigned as the owner of the database. To get the list of available PostgreSQL users, make a [UserService.List] request.
template-db -> (string)
  Name of the PostgreSQL database template.
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