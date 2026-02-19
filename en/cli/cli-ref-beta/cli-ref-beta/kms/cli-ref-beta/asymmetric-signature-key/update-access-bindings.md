---
editable: false
noIndex: true
---

# yc beta kms asymmetric-signature-key update-access-bindings

Updates access bindings for the specified key.

#### Command Usage

Syntax:

`yc beta kms asymmetric-signature-key update-access-bindings <RESOURCE-ID>`

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
|| `--access-binding-deltas` | `shorthand/json`

Updates to access bindings.

Shorthand Syntax:

```hcl
[
  {
    access-binding = {
      role-id = string,
      subject = {
        id = string,
        type = string
      }
    },
    action = ADD|REMOVE
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "access-binding": {
      "role-id": "string",
      "subject": {
        "id": "string",
        "type": "string"
      }
    },
    "action": "ADD|REMOVE"
  }, ...
]
```

Fields:

```
access-binding -> (struct)
  Access binding. For more information, see documentation.
  role-id -> (string)
    ID of the [yandex.cloud.iam.v1.Role] that is assigned to the [subject].
  subject -> (struct)
    Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier.
    id -> (string)
      ID of the subject. It can contain one of the following values: * 'allAuthenticatedUsers': A special public group that represents anyone who is authenticated. It can be used only if the [type] is 'system'. * 'allUsers': A special public group that represents anyone. No authentication is required. For example, you don't need to specify the IAM token in an API query. It can be used only if the [type] is 'system'. * 'group:organization:<id>:users': A special system group that represents all members of organization with given <id>. It can be used only if the [type] is 'system'. * 'group:federation:<id>:users': A special system group that represents all users of federation with given <id>. It can be used only if the [type] is 'system'. * '<cloud generated id>': An identifier that represents a user account. It can be used only if the [type] is 'userAccount', 'federatedUser' or 'serviceAccount'.
    type -> (string)
      Type of the subject. It can contain one of the following values: * 'userAccount': An account on Yandex or Yandex Connect, added to Yandex Cloud. * 'serviceAccount': A service account. This type represents the [yandex.cloud.iam.v1.ServiceAccount] resource. * 'federatedUser': A federated account. This type represents a user from an identity federation, like Active Directory. * 'system': System group. This type represents several accounts with a common system identifier. For more information, see documentation.
action -> (struct)
  The action that is being performed on an access binding.
``` ||
|| `--resource-id` | `string`

ID of the resource for which access bindings are being updated. ||
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