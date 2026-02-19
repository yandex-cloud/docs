---
editable: false
noIndex: true
---

# yc beta managed-greenplum hba-rule update

Update specified HBA rule for the specified Greenplum cluster without changind it order.

#### Command Usage

Syntax:

`yc beta managed-greenplum hba-rule update <CLUSTER-ID>`

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

ID of the Greenplum cluster. To get the Greenplum cluster ID use a [ClusterService.List] request. ||
|| `--hba-rule` | `shorthand/json`

Updated hba rule for the cluster.

Shorthand Syntax:

```hcl
{
  address = string,
  auth-method = MD5|LDAP|REJECT|IAM,
  connection-type = HOST|HOSTSSL|HOSTNOSSL,
  database = string,
  priority = integer,
  user = string
}
```

JSON Syntax:

```json
{
  "address": "string",
  "auth-method": "MD5|LDAP|REJECT|IAM",
  "connection-type": "HOST|HOSTSSL|HOSTNOSSL",
  "database": "string",
  "priority": "integer",
  "user": "string"
}
```

Fields:

```
address -> (string)
  Specifies the client machine addresses that this record matches.
auth-method -> (struct)
  Specifies the authentication method to use when a connection matches this record. https://gpdb.docs.pivotal.io/6-6/security-guide/topics/Authenticate.html
connection-type -> (struct)
database -> (string)
  Specifies which database names this record matches.
priority -> (integer)
  Priority of the Greenplum cluster rule.
user -> (string)
  Specifies which database role names this user matches.
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