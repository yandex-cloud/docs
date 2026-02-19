---
editable: false
noIndex: true
---

# yc beta compute instance attach-network-interface

Attaches the network-interface to the instance.
To attach a network-interface, the instance must have a `STOPPED` status ([Instance.status]).
To check the instance status, make a [InstanceService.Get] request.
To stop the running instance, make a [InstanceService.Stop] request.

#### Command Usage

Syntax:

`yc beta compute instance attach-network-interface <INSTANCE-ID>`

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
|| `--instance-id` | `string`

ID of the instance that in which network interface is being attached to. ||
|| `--network-interface-index` | `string`

The index of the network interface ||
|| `--primary-v4-address-spec` | `shorthand/json`

Primary IPv4 address that will be assigned to the instance for this network interface.

Shorthand Syntax:

```hcl
{
  address = string,
  dns-record-specs = [
    {
      dns-zone-id = string,
      fqdn = string,
      ptr = boolean,
      ttl = integer
    }, ...
  ],
  one-to-one-nat-spec = {
    address = string,
    dns-record-specs = [
      {
        dns-zone-id = string,
        fqdn = string,
        ptr = boolean,
        ttl = integer
      }, ...
    ],
    ip-version = IPV4|IPV6
  }
}
```

JSON Syntax:

```json
{
  "address": "string",
  "dns-record-specs": [
    {
      "dns-zone-id": "string",
      "fqdn": "string",
      "ptr": "boolean",
      "ttl": "integer"
    }, ...
  ],
  "one-to-one-nat-spec": {
    "address": "string",
    "dns-record-specs": [
      {
        "dns-zone-id": "string",
        "fqdn": "string",
        "ptr": "boolean",
        "ttl": "integer"
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
  ptr -> (boolean)
    When set to true, also create PTR DNS record (optional)
  ttl -> (integer)
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
    ptr -> (boolean)
      When set to true, also create PTR DNS record (optional)
    ttl -> (integer)
      DNS record ttl, values in 0-86400 (optional)
  ip-version -> (struct)
    External IP address version.
``` ||
|| `--security-group-ids` | `[]string`

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