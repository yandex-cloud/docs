---
editable: false
noIndex: true
---

# yc beta loadtesting agent create

Creates an agent in the specified folder.
Also creates a corresponding compute instance.

#### Command Usage

Syntax:

`yc beta loadtesting agent create <FOLDER-ID>`

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
|| `--agent-version` | `string`

Version of the agent. If not provided, the most recent agent version will be used. ||
|| `--compute-instance-params` | `shorthand/json`

Parameters for compute instance to be created.

Shorthand Syntax:

```hcl
{
  boot-disk-spec = {
    auto-delete = boolean,
    device-name = string,
    disk = disk-id=string | disk-spec={
      block-size = integer,
      description = string,
      disk-placement-policy = {
        placement-group-id = string,
        placement-group-partition = integer
      },
      kms-key-id = string,
      name = string,
      size = integer,
      source = image-id=string | snapshot-id=string,
      type-id = string
    },
    mode = READ_ONLY|READ_WRITE
  },
  labels = {key=string, key=...},
  metadata = {key=string, key=...},
  network-interface-specs = [
    {
      index = string,
      primary-v4-address-spec = {
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
      },
      primary-v6-address-spec = {
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
      },
      security-group-ids = string,...,
      subnet-id = string
    }, ...
  ],
  platform-id = string,
  resources-spec = {
    core-fraction = integer,
    cores = integer,
    gpus = integer,
    memory = integer
  },
  service-account-id = string,
  zone-id = string
}
```

JSON Syntax:

```json
{
  "boot-disk-spec": {
    "auto-delete": "boolean",
    "device-name": "string",
    "disk": {
      "disk-id": "string",
      "disk-spec": {
        "block-size": "integer",
        "description": "string",
        "disk-placement-policy": {
          "placement-group-id": "string",
          "placement-group-partition": "integer"
        },
        "kms-key-id": "string",
        "name": "string",
        "size": "integer",
        "source": {
          "image-id": "string",
          "snapshot-id": "string"
        },
        "type-id": "string"
      }
    },
    "mode": "READ_ONLY|READ_WRITE"
  },
  "labels": {
    "<key>": "string", ...
  },
  "metadata": {
    "<key>": "string", ...
  },
  "network-interface-specs": [
    {
      "index": "string",
      "primary-v4-address-spec": {
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
      },
      "primary-v6-address-spec": {
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
      },
      "security-group-ids": [
        "string", ...
      ],
      "subnet-id": "string"
    }, ...
  ],
  "platform-id": "string",
  "resources-spec": {
    "core-fraction": "integer",
    "cores": "integer",
    "gpus": "integer",
    "memory": "integer"
  },
  "service-account-id": "string",
  "zone-id": "string"
}
```

Fields:

```
boot-disk-spec -> (struct)
  Boot disk to attach to the instance.
  auto-delete -> (boolean)
    Specifies whether the disk will be auto-deleted when the instance is deleted.
  device-name -> (string)
    Specifies a unique serial number of your choice that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance. This value can be used to reference the device for mounting, resizing, and so on, from within the instance. If not specified, a random value will be generated.
  mode -> (struct)
    The mode in which to attach this disk.
  disk -> (oneof<disk-id|disk-spec>)
    Oneof disk field
    disk-spec -> (struct)
      Disk specification.
      block-size -> (integer)
        Block size of the disk, specified in bytes. The default is 4096.
      description -> (string)
        Description of the disk.
      disk-placement-policy -> (struct)
        Placement policy configuration.
        placement-group-id -> (string)
          Placement group ID.
        placement-group-partition -> (integer)
      kms-key-id -> (string)
        ID of KMS key for disk encryption
      name -> (string)
        Name of the disk.
      size -> (integer)
        Size of the disk, specified in bytes.
      type-id -> (string)
        ID of the disk type. To get a list of available disk types, use the [yandex.cloud.compute.v1.DiskTypeService.List] request.
      source -> (oneof<image-id|snapshot-id>)
        Oneof source field
        image-id -> (string)
          ID of the image to create the disk from.
        snapshot-id -> (string)
          ID of the snapshot to restore the disk from.
    disk-id -> (string)
      ID of the disk that should be attached.
labels -> (map[string,string])
  Resource labels as 'key:value' pairs.
metadata -> (map[string,string])
  The metadata 'key:value' pairs that will be assigned to this instance. This includes custom metadata and predefined keys. The total size of all keys and values must be less than 512 KB. Values are free-form strings, and only have meaning as interpreted by the programs which configure the instance. The values must be 256 KB or less. For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see documentation.
network-interface-specs -> ([]struct)
  Network configuration for the instance. Specifies how the network interface is configured to interact with other services on the internal network and on the internet. Currently only one network interface is supported per instance.
  index -> (string)
    The index of the network interface, will be generated by the server, 0,1,2... etc if not specified.
  primary-v4-address-spec -> (struct)
    Primary IPv4 address that will be assigned to the instance for this network interface.
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
  primary-v6-address-spec -> (struct)
    Primary IPv6 address that will be assigned to the instance for this network interface. IPv6 not available yet.
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
  security-group-ids -> ([]string)
    ID's of security groups attached to the interface
  subnet-id -> (string)
    ID of the subnet.
platform-id -> (string)
  ID of the documentation on which the agent will be created. Default value: "standard-v2"
resources-spec -> (struct)
  Computing resources of the instance, such as the amount of memory and number of cores. To get a list of available values, see documentation.
  core-fraction -> (integer)
    Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. For example, if you need only 5% of the CPU performance, you can set core_fraction=5. For more information, see documentation.
  cores -> (integer)
    The number of cores available to the instance.
  gpus -> (integer)
    The number of GPUs available to the instance.
  memory -> (integer)
    The amount of memory available to the instance, specified in bytes.
service-account-id -> (string)
  ID of the service account to use for documentation. To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List] request.
zone-id -> (string)
  ID of the availability zone where the instance resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List] request
``` ||
|| `--description` | `string`

Description of the agent. A created compute instance will have the same description. ||
|| `--folder-id` | `string`

ID of the folder to create an agent in. ||
|| `--labels` | `map<string><string>`

Agent labels as 'key:value' pairs. ||
|| `--log-settings` | `shorthand/json`

Agent log settings

Shorthand Syntax:

```hcl
{
  cloud-log-group-id = string
}
```

JSON Syntax:

```json
{
  "cloud-log-group-id": "string"
}
```

Fields:

```
cloud-log-group-id -> (string)
  Id of Yandex Cloud log group to upload agent logs to
``` ||
|| `--name` | `string`

Name of the agent. A created compute instance will have the same name. ||
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