---
editable: false
noIndex: true
---

# yc beta vpc private-endpoint update

Updates the specified private endpoint.

#### Command Usage

Syntax:

`yc beta vpc private-endpoint update <PRIVATE-ENDPOINT-ID>`

#### Flags

#|
||Flag | Description ||
|| `--address-spec` | `shorthand/json`

Private endpoint address specification.

Shorthand Syntax:

```hcl
{
  address = address-id=string | internal-ipv4-address-spec={
    address = string,
    subnet-id = string
  }
}
```

JSON Syntax:

```json
{
  "address": {
    "address-id": "string",
    "internal-ipv4-address-spec": {
      "address": "string",
      "subnet-id": "string"
    }
  }
}
```

Fields:

```
address -> (oneof<address-id|internal-ipv4-address-spec>)
  Oneof address field
  address-id -> (string)
    ID of IP address to associate with private endpoint.
  internal-ipv4-address-spec -> (struct)
    Internal ipv4 address specification.
    address -> (string)
      Value of address.
    subnet-id -> (string)
      ID of the subnet that address belongs to.
``` ||
|| `--description` | `string`

New description of the private endpoint. ||
|| `--dns-options` | `shorthand/json`

Private endpoint dns options.

Shorthand Syntax:

```hcl
{
  private-dns-records-enabled = boolean
}
```

JSON Syntax:

```json
{
  "private-dns-records-enabled": "boolean"
}
```

Fields:

```
private-dns-records-enabled -> (boolean)
  If enabled - vpc will create private dns records for specified service.
``` ||
|| `--labels` | `map<string><string>`

Private endpoint labels as 'key:value' pairs. Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label: 1. Get the current set of labels with a [PrivateEndpointService.Get] request. 2. Add or remove a label in this set. 3. Send the new set in this field. ||
|| `--name` | `string`

New name for the private endpoint. The name must be unique within the folder. ||
|| `--private-endpoint-id` | `string`

ID of the private endpoint to update. To get the private endpoint ID make a [PrivateEndpointService.List] request. ||
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