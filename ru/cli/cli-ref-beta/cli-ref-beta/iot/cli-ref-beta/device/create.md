---
editable: false
noIndex: true
---

# yc beta iot device create

Creates a device in the specified registry.

#### Command Usage

Syntax:

`yc beta iot device create <REGISTRY-ID>`

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
|| `--certificates` | `shorthand/json`

Device certificate.

Shorthand Syntax:

```hcl
[
  {
    certificate-data = string
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "certificate-data": "string"
  }, ...
]
```

Fields:

```
certificate-data -> (string)
  Public part of the device certificate.
``` ||
|| `--description` | `string`

Description of the device. ||
|| `--labels` | `map<string><string>`

Resource labels as 'key:value' pairs. ||
|| `--name` | `string`

Name of the device. The name must be unique within the registry. ||
|| `--password` | `string`

Device password. The password must contain at least three character categories among the following: upper case latin, lower case latin, numbers and special symbols. ||
|| `--registry-id` | `string`

ID of the registry to create a device in. To get a registry ID, make a [yandex.cloud.iot.devices.v1.RegistryService.List] request. ||
|| `--topic-aliases` | `map<string><string>`

Alias of a device topic. Alias is an alternate name of a device topic assigned by the user. Map alias to canonical topic name prefix, e.g. 'my/custom/alias' match to '$device/{id}/events'. ||
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