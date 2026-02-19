---
editable: false
noIndex: true
---

# yc beta vpc address update

Updates the specified address.

#### Command Usage

Syntax:

`yc beta vpc address update <ADDRESS-ID>`

#### Flags

#|
||Flag | Description ||
|| `--address-id` | `string`

ID of the address to update. To get the address ID make a [AddressService.List] request. ||
|| `--deletion-protection` | Specifies if address protected from deletion. ||
|| `--description` | `string`

New description of the address. ||
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
|| `--labels` | `map<string><string>`

Address labels as 'key:value' pairs. Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label: 1. Get the current set of labels with a [AddressService.Get] request. 2. Add or remove a label in this set. 3. Send the new set in this field. ||
|| `--name` | `string`

New name for the address. The name must be unique within the folder. ||
|| `--reserved` | Specifies if address is reserved or not. ||
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