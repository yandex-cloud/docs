[Документация Yandex Cloud](../../../../../index.md) > [Yandex BareMetal](../../../../index.md) > Концепции > Настройка и управление > [Справочник CLI (англ.)](../../../index.md) > [v2](../../index.md) > [extend](../index.md) > [stackland-cluster](index.md) > update

# yc baremetal v2 extend stackland-cluster update

Updates the specified Stackland cluster.

#### Command Usage

Syntax:

`yc baremetal v2 extend stackland-cluster update`

#### Flags

#|
||Flag | Description ||
|| `--update-mask` | `[]string`

Field paths for FieldMask: each segment may be proto snake_case or CLI kebab-case (e.g. name, labels, network-interface). Repeat the flag or use comma-separated values. When set and non-empty, takes precedence over update_mask in the request body/file and over mask inferred from -r. If omitted or empty, the mask is built from the fields you pass (changed flags, JSON/shorthand, and request file when update_mask is absent there). ||
|| `--cluster` | `shorthand/json`

The cluster object to be updated

{% cut "Description" %}

> - cloud-id (string)\
ID of the cloud that the cluster belongs to.
> - folder-id (string)\
ID of the folder that the cluster belongs to.
> - name (string)\
Name of the cluster. The display name is unique within the folder.
> - description (string)\
Description of the server.
> - annotations (map[string,string])\
Resource labels as 'key:value' pairs.
> - hardware-pool-id (string)\
ID of the hardware pool that the cluster belongs to.
> - preset (structure)\
Preset of the cluster.
> - host-roles (structure)\
Which node types are to be used for cluster roles.
>> - controlplane ([]structure)\
Node types used as controlplane nodes.
>>> - configuration-id (string)\
ID of the configuration.
>>> - count (integer)\
Number of nodes in the group.
>> - combined ([]structure)\
Node types used as combined nodes.
>>> - configuration-id (string)\
ID of the configuration.
>>> - count (integer)\
Number of nodes in the group.
>> - worker ([]structure)\
Node types used as workder nodes.
>>> - configuration-id (string)\
ID of the configuration.
>>> - count (integer)\
Number of nodes in the group.
> - bastion-node (structure)\
Bastion node.
>> - configuration-id (string)\
ID of the configuration.
>> - management-ip-address (string)\
IP address of the node in the management network.
>> - hostname (string)\
Hostname of the node inside the cluster.
> - cidr (string)\
Optional CIDR to preselect in subnet.
> - version (string)\
Version of Stackland to be used.
> - license (string)\
License to activate Stackland.
> - cluster-domain (string)\
Base cluster DNS domain.
> - bastion-spec (structure)\
Credentials for access to the bastion node. Input only field.
>> - ssh-key (oneof)\
Oneof ssh-key field
>>> - ssh-public-key-text (string)\
Public SSH key for the server. Input only field.
>>> - user-ssh-id (string)\
ID of the user SSH key to use for the server. Input only field. To get the user SSH key ID, use a [yandex.cloud.organizationmanager.v1.UserSshKeyService.List] request.
>> - password (oneof)\
Oneof password field
>>> - password-plain-text (string)\
Raw password. Input only field.
>>> - password-lockbox-secret (structure)\
Reference to the Lockbox secret used to obtain the password. Input only field.
>>>> - secret-id (string)\
The unique identifier for the lockbox secret that contains the user password.
>>>> - version-id (string)\
The unique identifier for the lockbox version. If omitted, the current version of the secret will be used.
>>>> - key (string)\
The key used to access a specific secret entry.

{% endcut %}

{% cut "Shorthand Syntax" %}

```hcl
{
  annotations = {key=string, key=...},
  bastion-node = {
    configuration-id = string,
    hostname = string,
    management-ip-address = string
  },
  bastion-spec = {
    password = password-lockbox-secret={
      key = string,
      secret-id = string,
      version-id = string
    } | password-plain-text=string,
    ssh-key = ssh-public-key-text=string | user-ssh-id=string
  },
  cidr = string,
  cloud-id = string,
  cluster-domain = string,
  description = string,
  folder-id = string,
  hardware-pool-id = string,
  host-roles = {
    combined = [
      {
        configuration-id = string,
        count = integer
      }, ...
    ],
    controlplane = [
      {
        configuration-id = string,
        count = integer
      }, ...
    ],
    worker = [
      {
        configuration-id = string,
        count = integer
      }, ...
    ]
  },
  license = string,
  name = string,
  preset = MINIMAL|FULL,
  version = string
}
```

{% endcut %}

{% cut "JSON Syntax" %}

```json
{
  "annotations": {
    "<key>": "string", ...
  },
  "bastion-node": {
    "configuration-id": "string",
    "hostname": "string",
    "management-ip-address": "string"
  },
  "bastion-spec": {
    "password": {
      "password-lockbox-secret": {
        "key": "string",
        "secret-id": "string",
        "version-id": "string"
      },
      "password-plain-text": "string"
    },
    "ssh-key": {
      "ssh-public-key-text": "string",
      "user-ssh-id": "string"
    }
  },
  "cidr": "string",
  "cloud-id": "string",
  "cluster-domain": "string",
  "description": "string",
  "folder-id": "string",
  "hardware-pool-id": "string",
  "host-roles": {
    "combined": [
      {
        "configuration-id": "string",
        "count": "integer"
      }, ...
    ],
    "controlplane": [
      {
        "configuration-id": "string",
        "count": "integer"
      }, ...
    ],
    "worker": [
      {
        "configuration-id": "string",
        "count": "integer"
      }, ...
    ]
  },
  "license": "string",
  "name": "string",
  "preset": "MINIMAL|FULL",
  "version": "string"
}
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
yc baremetal v2 extend stackland-cluster update --example-json > request.json
or
yc baremetal v2 extend stackland-cluster update --example-yaml > request.yaml

2. Edit the template file

3. Run with template:
yc baremetal v2 extend stackland-cluster update -r request.json
or
yc baremetal v2 extend stackland-cluster update -r request.yaml ||
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