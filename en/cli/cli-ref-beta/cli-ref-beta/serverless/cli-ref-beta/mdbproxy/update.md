---
editable: false
noIndex: true
---

# yc beta serverless mdbproxy update

Updates the specified proxy.

#### Command Usage

Syntax:

`yc beta serverless mdbproxy update <PROXY-ID>`

#### Flags

#|
||Flag | Description ||
|| `--description` | `string`

New description for the proxy. ||
|| `--labels` | `map<string><string>`

Proxy labels as 'key:value' pairs. ||
|| `--name` | `string`

New name for the proxy. The name must be unique within the folder. ||
|| `--proxy-id` | `string`

ID of the proxy to update. ||
|| `--target` | `shorthand/json`

Proxy target.

Shorthand Syntax:

```hcl
{
  mdb = clickhouse={
    cluster-id = string,
    db = string,
    endpoint = string,
    password = string,
    user = string
  } | postgresql={
    cluster-id = string,
    db = string,
    endpoint = string,
    password = string,
    user = string
  }
}
```

JSON Syntax:

```json
{
  "mdb": {
    "clickhouse": {
      "cluster-id": "string",
      "db": "string",
      "endpoint": "string",
      "password": "string",
      "user": "string"
    },
    "postgresql": {
      "cluster-id": "string",
      "db": "string",
      "endpoint": "string",
      "password": "string",
      "user": "string"
    }
  }
}
```

Fields:

```
mdb -> (oneof<clickhouse|postgresql>)
  Oneof mdb field
  clickhouse -> (struct)
    Clickhouse settings for proxy.
    cluster-id -> (string)
      Cluster identifier for clickhouse.
    db -> (string)
      Clickhouse database name.
    endpoint -> (string)
      Clickhouse proxy-host for connection, output only field.
    password -> (string)
      Clickhouse password, input only field.
    user -> (string)
      Clickhouse user.
  postgresql -> (struct)
    PostgreSQL settings for proxy.
    cluster-id -> (string)
      Cluster identifier for postgresql.
    db -> (string)
      PostgreSQL database name.
    endpoint -> (string)
      PostgreSQL proxy-host for connection, output only field.
    password -> (string)
      PostgreSQL password, input only field.
    user -> (string)
      PostgreSQL user.
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