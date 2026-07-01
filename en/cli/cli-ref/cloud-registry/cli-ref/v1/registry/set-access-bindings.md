---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/cloud-registry/cli-ref/v1/registry/set-access-bindings/
---

# yc cloud-registry v1 registry set-access-bindings

Sets access bindings for the specified registry.

#### Command Usage

Syntax:

`yc cloud-registry v1 registry set-access-bindings <RESOURCE-ID>`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

ID of the resource for which access bindings are being set. To get the resource ID, use a corresponding List request. ||
|| `--access-bindings` | `shorthand/json`

Access bindings to be set. For more information, see documentation.

{% cut "Description" %}

> - role-id (string)\
ID of the [yandex.cloud.iam.v1.Role] that is assigned to the [subject].
> - subject (structure)\
Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier.
>> - id (string)\
ID of the subject. It can contain one of the following values:oauth * 'allAuthenticatedUsers': A special public group that represents anyone who is authenticated. It can be used only if the [type] is 'system'. * 'allUsers': A special public group that represents anyone. No authentication is required. For example, you don't need to specify the IAM token in an API query. It can be used only if the [type] is 'system'. * 'group:organization:&lt;id&gt;:users': A special system group that represents all members of organization with given &lt;id&gt;. It can be used only if the [type] is 'system'. * 'group:federation:&lt;id&gt;:users': A special system group that represents all users of federation with given &lt;id&gt;. It can be used only if the [type] is 'system'. * '&lt;cloud generated id&gt;': An identifier that represents a user account. It can be used only if the [type] is 'userAccount', 'federatedUser' or 'serviceAccount'.
>> - type (string)\
Type of the subject. It can contain one of the following values: * 'userAccount': An account on Yandex or Yandex Connect, added to Yandex Cloud. * 'serviceAccount': A service account. This type represents the [yandex.cloud.iam.v1.ServiceAccount] resource. * 'federatedUser': A federated account. This type represents a user from an identity federation, like Active Directory. * 'system': System group. This type represents several accounts with a common system identifier. For more information, see documentation.

{% endcut %}

{% cut "Shorthand Syntax" %}

```hcl
[
  {
    role-id = string,
    subject = {
      id = string,
      type = string
    }
  }, ...
]
```

{% endcut %}

{% cut "JSON Syntax" %}

```json
[
  {
    "role-id": "string",
    "subject": {
      "id": "string",
      "type": "string"
    }
  }, ...
]
```

{% endcut %} ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request. ||
|| `-e`, `--example-yaml` | Generates a YAML template of the request.

The template can be customized and used as input for the command.

Usage example:

1. Generate template:
yc cloud-registry v1 registry set-access-bindings --example-json > request.json
or
yc cloud-registry v1 registry set-access-bindings --example-yaml > request.yaml

2. Edit the template file

3. Run with template:
yc cloud-registry v1 registry set-access-bindings -r request.json
or
yc cloud-registry v1 registry set-access-bindings -r request.yaml ||
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
|| `--no-pager` | Do not pipe help output through a pager. ||
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
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#