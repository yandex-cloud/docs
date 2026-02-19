---
editable: false
noIndex: true
---

# yc beta compute instance add-one-to-one-nat

Enables One-to-one NAT on the network interface.

#### Command Usage

Syntax:

`yc beta compute instance add-one-to-one-nat <INSTANCE-ID>`

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

ID of the instance to enable One-to-One NAT on. ||
|| `--internal-address` | `string`

The network address that is assigned to the instance for this network interface. ||
|| `--network-interface-index` | `string`

The index of the network interface to enable One-to-One NAT on. ||
|| `--one-to-one-nat-spec` | `shorthand/json`

An external IP address configuration. If not specified, then this instance will have no external internet access.

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
  ip-version = IPV4|IPV6
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
  "ip-version": "IPV4|IPV6"
}
```

Fields:

```
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