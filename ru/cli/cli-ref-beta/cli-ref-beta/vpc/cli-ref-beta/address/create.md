---
editable: false
noIndex: true
---

# yc beta vpc address create

Creates an address in the specified folder and network.

#### Command Usage

Syntax:

`yc beta vpc address create <FOLDER-ID>`

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
|| `--deletion-protection` | Specifies if address protected from deletion. ||
|| `--description` | `string`

Description of the address. ||
|| `--dns-record-specs` | `shorthand/json`

Optional DNS record specifications

Shorthand Syntax:

```hcl
[
  {
    dns-zone-id = string,
    fqdn = string,
    ptr = boolean,
    ttl = integer
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "dns-zone-id": "string",
    "fqdn": "string",
    "ptr": "boolean",
    "ttl": "integer"
  }, ...
]
```

Fields:

```
dns-zone-id -> (string)
  Required. ID of the public DNS zone. The maximum string length in characters is 20.
fqdn -> (string)
  Required. DNS record name (absolute or relative to the DNS zone in use).
ptr -> (boolean)
  Optional. If the PTR record is required, this parameter must be set to "true".
ttl -> (integer)
  TTL of record. Acceptable values are 0 to 86400, inclusive.
``` ||
|| `--folder-id` | `string`

ID of the folder to create a address in. To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--labels` | `map<string><string>`

Address labels as 'key:value' pairs. ||
|| `--name` | `string`

Name of the address. The name must be unique within the folder. ||
|| `--external-ipv4-address-spec` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  address = string,
  requirements = {
    ddos-protection-provider = string,
    outgoing-smtp-capability = string
  },
  zone-id = string
}
```

JSON Syntax:

```json
{
  "address": "string",
  "requirements": {
    "ddos-protection-provider": "string",
    "outgoing-smtp-capability": "string"
  },
  "zone-id": "string"
}
```

Fields:

```
address -> (string)
  Value of address.
requirements -> (struct)
  Parameters of the allocated address, for example DDoS Protection.
  ddos-protection-provider -> (string)
    DDoS protection provider ID.
  outgoing-smtp-capability -> (string)
    Capability to send SMTP traffic.
zone-id -> (string)
  Availability zone from which the address will be allocated.
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