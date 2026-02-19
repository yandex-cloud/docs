---
editable: false
noIndex: true
---

# yc beta organization-manager group update-members

Update group members.

#### Command Usage

Syntax:

`yc beta organization-manager group update-members <GROUP-ID>`

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
|| `--group-id` | `string`

ID of the group to update. To get the group ID, use a [GroupService.List] request. ||
|| `--member-deltas` | `shorthand/json`

Updates to group members.

Shorthand Syntax:

```hcl
[
  {
    action = ADD|REMOVE,
    subject-id = string
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "action": "ADD|REMOVE",
    "subject-id": "string"
  }, ...
]
```

Fields:

```
action -> (struct)
  The action that is being performed on a group member.
subject-id -> (string)
  ID of the subject that is being added or removed from a group. Subject type can be one of following values: * 'userAccount': An account on Yandex, added to Yandex Cloud. * 'federatedUser': A federated account. This type represents a user from an identity federation, like Active Directory.
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