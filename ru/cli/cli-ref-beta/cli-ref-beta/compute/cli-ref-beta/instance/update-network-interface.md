---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/compute/cli-ref-beta/instance/update-network-interface.md
---

# yc beta compute instance update-network-interface

Updates the specified instance network interface.

#### Command Usage

Syntax:

`yc beta compute instance update-network-interface <INSTANCE-ID>`

#### Flags

#|
||Flag | Description ||
|| `--instance-id` | `string`

ID of the instance that is being updated. ||
|| `--network-interface-index` | `string`

The index of the network interface to be updated. ||
|| `--primary-v4-address-spec` | `shorthand/json`

Primary IPv4 address that will be assigned to the instance for this network interface.

Shorthand Syntax:

```hcl
{
  address = str,
  dns-record-specs = [
    {
      dns-zone-id = str,
      fqdn = str,
      ptr = bool,
      ttl = int
    }, ...
  ],
  one-to-one-nat-spec = {
    address = str,
    dns-record-specs = [
      {
        dns-zone-id = str,
        fqdn = str,
        ptr = bool,
        ttl = int
      }, ...
    ],
    ip-version = IPV4|IPV6
  }
}
```

JSON Syntax:

```json
{
  "address": "str",
  "dns-record-specs": [
    {
      "dns-zone-id": "str",
      "fqdn": "str",
      "ptr": "bool",
      "ttl": "int"
    }, ...
  ],
  "one-to-one-nat-spec": {
    "address": "str",
    "dns-record-specs": [
      {
        "dns-zone-id": "str",
        "fqdn": "str",
        "ptr": "bool",
        "ttl": "int"
      }, ...
    ],
    "ip-version": "IPV4|IPV6"
  }
}
```

Fields:

```
address -> (string)
  An IPv4 internal network address that is assigned to the instance for this network interface. If not specified by the user, an unused internal IP is assigned by the system.
dns-record-specs -> ([]struct)
  Internal DNS configuration
  dns-zone-id -> (string)
    DNS zone id (optional, if not set, private zone used)
  fqdn -> (string)
    FQDN (required)
  ptr -> (bool)
    When set to true, also create PTR DNS record (optional)
  ttl -> (int)
    DNS record ttl, values in 0-86400 (optional)
one-to-one-nat-spec -> (struct)
  An external IP address configuration. If not specified, then this instance will have no external internet access.
  address -> (string)
  dns-record-specs -> ([]struct)
    External DNS configuration
    dns-zone-id -> (string)
      DNS zone id (optional, if not set, private zone used)
    fqdn -> (string)
      FQDN (required)
    ptr -> (bool)
      When set to true, also create PTR DNS record (optional)
    ttl -> (int)
      DNS record ttl, values in 0-86400 (optional)
  ip-version -> (struct)
    External IP address version.
``` ||
|| `--primary-v6-address-spec` | `shorthand/json`

Primary IPv6 address that will be assigned to the instance for this network interface. IPv6 not available yet.

Shorthand Syntax:

```hcl
{
  address = str,
  dns-record-specs = [
    {
      dns-zone-id = str,
      fqdn = str,
      ptr = bool,
      ttl = int
    }, ...
  ],
  one-to-one-nat-spec = {
    address = str,
    dns-record-specs = [
      {
        dns-zone-id = str,
        fqdn = str,
        ptr = bool,
        ttl = int
      }, ...
    ],
    ip-version = IPV4|IPV6
  }
}
```

JSON Syntax:

```json
{
  "address": "str",
  "dns-record-specs": [
    {
      "dns-zone-id": "str",
      "fqdn": "str",
      "ptr": "bool",
      "ttl": "int"
    }, ...
  ],
  "one-to-one-nat-spec": {
    "address": "str",
    "dns-record-specs": [
      {
        "dns-zone-id": "str",
        "fqdn": "str",
        "ptr": "bool",
        "ttl": "int"
      }, ...
    ],
    "ip-version": "IPV4|IPV6"
  }
}
```

Fields:

```
address -> (string)
  An IPv4 internal network address that is assigned to the instance for this network interface. If not specified by the user, an unused internal IP is assigned by the system.
dns-record-specs -> ([]struct)
  Internal DNS configuration
  dns-zone-id -> (string)
    DNS zone id (optional, if not set, private zone used)
  fqdn -> (string)
    FQDN (required)
  ptr -> (bool)
    When set to true, also create PTR DNS record (optional)
  ttl -> (int)
    DNS record ttl, values in 0-86400 (optional)
one-to-one-nat-spec -> (struct)
  An external IP address configuration. If not specified, then this instance will have no external internet access.
  address -> (string)
  dns-record-specs -> ([]struct)
    External DNS configuration
    dns-zone-id -> (string)
      DNS zone id (optional, if not set, private zone used)
    fqdn -> (string)
      FQDN (required)
    ptr -> (bool)
      When set to true, also create PTR DNS record (optional)
    ttl -> (int)
      DNS record ttl, values in 0-86400 (optional)
  ip-version -> (struct)
    External IP address version.
``` ||
|| `--security-group-ids` | `strings`

ID's of security groups attached to the interface. ||
|| `--subnet-id` | `string`

ID of the subnet. ||
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

Set the output format: text, yaml, json, table, summary. ||
|| `--summary` | `strings`

Fields to include in summary output.
Each value is a dot-separated path to a field.
Examples:
  --summary instance.id                  # simple field
  --summary instance.type                # another simple field
  --summary instance.disks.size          # collect values from all list elements
  --summary instance.disks[0].size       # field from a specific list element ||
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