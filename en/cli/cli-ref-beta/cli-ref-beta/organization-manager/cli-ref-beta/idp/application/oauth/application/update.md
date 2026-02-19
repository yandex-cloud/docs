---
editable: false
noIndex: true
---

# yc beta organization-manager idp application oauth application update

Updates the specified OAuth application.

#### Command Usage

Syntax:

`yc beta organization-manager idp application oauth application update <APPLICATION-ID>`

#### Flags

#|
||Flag | Description ||
|| `--application-id` | `string`

ID of the OAuth application to update. To get the OAuth application ID, make a [ApplicationService.List] request. ||
|| `--client-grant` | `shorthand/json`

Connection to the OAuth client with specified scopes

Shorthand Syntax:

```hcl
{
  authorized-scopes = string,...,
  client-id = string
}
```

JSON Syntax:

```json
{
  "authorized-scopes": [
    "string", ...
  ],
  "client-id": "string"
}
```

Fields:

```
authorized-scopes -> ([]string)
  List of authorized client scopes by the application
client-id -> (string)
  OAuth client id
``` ||
|| `--description` | `string`

Description of the OAuth application. ||
|| `--group-claims-settings` | `shorthand/json`

Settings of the group claims

Shorthand Syntax:

```hcl
{
  group-distribution-type = NONE|ASSIGNED_GROUPS|ALL_GROUPS
}
```

JSON Syntax:

```json
{
  "group-distribution-type": "NONE|ASSIGNED_GROUPS|ALL_GROUPS"
}
```

Fields:

```
group-distribution-type -> (struct)
  Represents current distribution type of the groups. I.e. which groups are visible for the application users.
``` ||
|| `--labels` | `map<string><string>`

Resource labels as key:value pairs. ||
|| `--name` | `string`

Name of the OAuth application. The name must be unique within the organization. ||
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