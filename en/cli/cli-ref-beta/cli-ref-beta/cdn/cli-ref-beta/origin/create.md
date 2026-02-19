---
editable: false
noIndex: true
---

# yc beta cdn origin create

Creates origin inside origin group.

#### Command Usage

Syntax:

`yc beta cdn origin create <FOLDER-ID>`

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
|| `--backup` | Specifies whether the origin is used in its origin group as backup. A backup origin is used when one of active origins becomes unavailable. Default value: False. ||
|| `--enabled` | The setting allows to enable or disable an Origin source in the Origins group. It has two possible values: True - The origin is enabled and used as a source for the CDN. An origins group must contain at least one enabled origin. Default value. False - The origin is disabled and the CDN is not using it to pull content. ||
|| `--folder-id` | `string`

ID of the folder that the origin belongs to. ||
|| `--meta` | `shorthand/json`

Set up origin of the content.

Shorthand Syntax:

```hcl
{
  origin-meta-variant = balancer={
    id = string
  } | bucket={
    name = string
  } | common={
    name = string
  } | website={
    name = string
  }
}
```

JSON Syntax:

```json
{
  "origin-meta-variant": {
    "balancer": {
      "id": "string"
    },
    "bucket": {
      "name": "string"
    },
    "common": {
      "name": "string"
    },
    "website": {
      "name": "string"
    }
  }
}
```

Fields:

```
origin-meta-variant -> (oneof<balancer|bucket|common|website>)
  Oneof origin-meta-variant field
  common -> (struct)
    A server with a domain name linked to it
    name -> (string)
      Name of the origin.
  bucket -> (struct)
    An Object Storage bucket not configured as a static site hosting.
    name -> (string)
      Name of the origin.
  website -> (struct)
    An Object Storage bucket configured as a static site hosting.
    name -> (string)
      Name of the origin.
  balancer -> (struct)
    An L7 load balancer from Application Load Balancer. CDN servers will access the load balancer at one of its IP addresses that must be selected in the origin settings.
    id -> (string)
      ID of the origin.
``` ||
|| `--origin-group-id` | `int`

[origin_group_id] group ID to request origins from. ||
|| `--provider-type` | `string`

Set up origin provider It has two possible values: ourcdn - Based on Yandex technologies gcore - Based on an external partner infrastructure Default value: ourcdn ||
|| `--source` | `string`

IP address or Domain name of your origin and the port (if custom). Used if [meta] variant is 'common'. ||
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