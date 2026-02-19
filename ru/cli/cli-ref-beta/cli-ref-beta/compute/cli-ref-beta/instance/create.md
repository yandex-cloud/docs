---
editable: false
noIndex: true
---

# yc beta compute instance create

Creates an instance in the specified folder.
Method starts an asynchronous operation that can be cancelled while it is in progress.

#### Command Usage

Syntax:

`yc beta compute instance create <FOLDER-ID>`

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
|| `--application` | `shorthand/json`

Instance application settings.

Shorthand Syntax:

```hcl
{
  cloudbackup = {
    backup-id = string,
    enabled = boolean,
    initial-policy-ids = string,...,
    instance-registration-id = string,
    recovery-from-backup = boolean
  },
  container = container-solution={
    environment = {key=string, key=...},
    product-id = string,
    secrets = {key={
      id = string,
      key = string,
      version-id = string
    }, key=...}
  }
}
```

JSON Syntax:

```json
{
  "cloudbackup": {
    "backup-id": "string",
    "enabled": "boolean",
    "initial-policy-ids": [
      "string", ...
    ],
    "instance-registration-id": "string",
    "recovery-from-backup": "boolean"
  },
  "container": {
    "container-solution": {
      "environment": {
        "<key>": "string", ...
      },
      "product-id": "string",
      "secrets": {
        "<key>": {
          "id": "string",
          "key": "string",
          "version-id": "string"
        }, ...
      }
    }
  }
}
```

Fields:

```
cloudbackup -> (struct)
  Backup settings.
  backup-id -> (string)
    ID of the backup to recover from.
  enabled -> (boolean)
    If true, backup is enabled.
  initial-policy-ids -> ([]string)
    A list of policy IDs to apply after resource registration.
  instance-registration-id -> (string)
    ID of the instance registration for cloud backup agent installation.
  recovery-from-backup -> (boolean)
    If true, recovery from backup starts on instance.
container -> (oneof<container-solution>)
  Oneof container field
  container-solution -> (struct)
    Container specification.
    environment -> (map[string,string])
      A list of the environmets.
    product-id -> (string)
      ID of the product.
    secrets -> (map[string,struct])
      A list of the secrets.
      id -> (string)
        ID of the secret.
      key -> (string)
        Name of the key.
      version-id -> (string)
        Version of the secret.
``` ||
|| `--boot-disk-spec` | `shorthand/json`

Boot disk to attach to the instance.

Shorthand Syntax:

```hcl
{
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
}
```

JSON Syntax:

```json
{
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
}
```

Fields:

```
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
``` ||
|| `--description` | `string`

Description of the instance. ||
|| `--filesystem-specs` | `shorthand/json`

Array of filesystems to attach to the instance. The filesystems must reside in the same availability zone as the instance. To use the instance with an attached filesystem, the latter must be mounted. For details, see documentation.

Shorthand Syntax:

```hcl
[
  {
    device-name = string,
    filesystem-id = string,
    mode = READ_ONLY|READ_WRITE
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "device-name": "string",
    "filesystem-id": "string",
    "mode": "READ_ONLY|READ_WRITE"
  }, ...
]
```

Fields:

```
device-name -> (string)
  Name of the device representing the filesystem on the instance. The name should be used for referencing the filesystem from within the instance when it's being mounted, resized etc. If not specified, a random value will be generated.
filesystem-id -> (string)
  ID of the filesystem that should be attached.
mode -> (struct)
  Mode of access to the filesystem that should be attached.
``` ||
|| `--folder-id` | `string`

ID of the folder to create an instance in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--gpu-settings` | `shorthand/json`

GPU settings.

Shorthand Syntax:

```hcl
{
  gpu-cluster-id = string
}
```

JSON Syntax:

```json
{
  "gpu-cluster-id": "string"
}
```

Fields:

```
gpu-cluster-id -> (string)
  Attach instance to specified GPU cluster.
``` ||
|| `--hostname` | `string`

Host name for the instance. This field is used to generate the [yandex.cloud.compute.v1.Instance.fqdn] value. The host name must be unique within the network and region. If not specified, the host name will be equal to [yandex.cloud.compute.v1.Instance.id] of the instance and FQDN will be '&lt;id&gt;.auto.internal'. Otherwise FQDN will be '&lt;hostname&gt;.&lt;region_id&gt;.internal'. ||
|| `--labels` | `map<string><string>`

Resource labels as 'key:value' pairs. ||
|| `--local-disk-specs` | `shorthand/json`

Array of local disks to attach to the instance.

Shorthand Syntax:

```hcl
[
  {
    size = integer,
    type = physical-local-disk={
      kms-key-id = string
    }
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "size": "integer",
    "type": {
      "physical-local-disk": {
        "kms-key-id": "string"
      }
    }
  }, ...
]
```

Fields:

```
size -> (integer)
  Size of the disk, specified in bytes.
type -> (oneof<physical-local-disk>)
  Oneof type field
  physical-local-disk -> (struct)
    Local disk configuration
    kms-key-id -> (string)
      ID of KMS key for disk encryption
``` ||
|| `--maintenance-grace-period` | `duration`

Time between notification via metadata service and maintenance (duration, e.g. 30s, 5m10s) ||
|| `--maintenance-policy` | `enum`

Behaviour on maintenance events Possible Values: 'restart', 'migrate' ||
|| `--metadata` | `map<string><string>`

The metadata 'key:value' pairs that will be assigned to this instance. This includes custom metadata and predefined keys. The total size of all keys and values must be less than 512 KB. Values are free-form strings, and only have meaning as interpreted by the programs which configure the instance. The values must be 256 KB or less. For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see documentation. ||
|| `--metadata-options` | `shorthand/json`

Options allow user to configure access to instance's metadata

Shorthand Syntax:

```hcl
{
  aws-v1-http-endpoint = ENABLED|DISABLED,
  aws-v1-http-token = ENABLED|DISABLED,
  gce-http-endpoint = ENABLED|DISABLED,
  gce-http-token = ENABLED|DISABLED
}
```

JSON Syntax:

```json
{
  "aws-v1-http-endpoint": "ENABLED|DISABLED",
  "aws-v1-http-token": "ENABLED|DISABLED",
  "gce-http-endpoint": "ENABLED|DISABLED",
  "gce-http-token": "ENABLED|DISABLED"
}
```

Fields:

```
aws-v1-http-endpoint -> (struct)
  Enabled access to AWS flavored metadata (IMDSv1)
aws-v1-http-token -> (struct)
  Enabled access to IAM credentials with AWS flavored metadata (IMDSv1)
gce-http-endpoint -> (struct)
  Enabled access to GCE flavored metadata
gce-http-token -> (struct)
  Enabled access to IAM credentials with GCE flavored metadata
``` ||
|| `--name` | `string`

Name of the instance. ||
|| `--network-interface-specs` | `shorthand/json`

Network configuration for the instance. Specifies how the network interface is configured to interact with other services on the internal network and on the internet.

Shorthand Syntax:

```hcl
[
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
]
```

JSON Syntax:

```json
[
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
]
```

Fields:

```
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
``` ||
|| `--network-settings` | `shorthand/json`

Network settings.

Shorthand Syntax:

```hcl
{
  type = STANDARD|SOFTWARE_ACCELERATED|HARDWARE_ACCELERATED
}
```

JSON Syntax:

```json
{
  "type": "STANDARD|SOFTWARE_ACCELERATED|HARDWARE_ACCELERATED"
}
```

Fields:

```
type -> (struct)
  Network Type
``` ||
|| `--placement-policy` | `shorthand/json`

Placement policy configuration.

Shorthand Syntax:

```hcl
{
  host-affinity-rules = [
    {
      key = string,
      op = IN|NOT_IN,
      values = string,...
    }, ...
  ],
  placement-group-id = string,
  placement-group-partition = integer
}
```

JSON Syntax:

```json
{
  "host-affinity-rules": [
    {
      "key": "string",
      "op": "IN|NOT_IN",
      "values": [
        "string", ...
      ]
    }, ...
  ],
  "placement-group-id": "string",
  "placement-group-partition": "integer"
}
```

Fields:

```
host-affinity-rules -> ([]struct)
  List of affinity rules. Scheduler will attempt to allocate instances according to order of rules.
  key -> (string)
    Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId'
  op -> (struct)
    Include or exclude action
  values -> ([]string)
    Affinity value or host ID or host group ID
placement-group-id -> (string)
  Placement group ID.
placement-group-partition -> (integer)
  Placement group partition
``` ||
|| `--platform-id` | `string`

ID of the hardware platform configuration for the instance. This field affects the available values in [resources_spec] field. Platforms allows you to create various types of instances: with a large amount of memory, with a large number of cores, with a burstable performance. For more information, see documentation. ||
|| `--reserved-instance-pool-id` | `string`

ID of the reserved instance pool that the instance should belong to. Instance will be created using resources from the reserved instance pool. Reserved instance pool resource configuration must match the resource configuration of the instance. ||
|| `--resources-spec` | `shorthand/json`

Computing resources of the instance, such as the amount of memory and number of cores. To get a list of available values, see documentation.

Shorthand Syntax:

```hcl
{
  core-fraction = integer,
  cores = integer,
  gpus = integer,
  memory = integer
}
```

JSON Syntax:

```json
{
  "core-fraction": "integer",
  "cores": "integer",
  "gpus": "integer",
  "memory": "integer"
}
```

Fields:

```
core-fraction -> (integer)
  Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. For example, if you need only 5% of the CPU performance, you can set core_fraction=5. For more information, see documentation.
cores -> (integer)
  The number of cores available to the instance.
gpus -> (integer)
  The number of GPUs available to the instance.
memory -> (integer)
  The amount of memory available to the instance, specified in bytes.
``` ||
|| `--scheduling-policy` | `shorthand/json`

Scheduling policy configuration.

Shorthand Syntax:

```hcl
{
  preemptible = boolean
}
```

JSON Syntax:

```json
{
  "preemptible": "boolean"
}
```

Fields:

```
preemptible -> (boolean)
  True for short-lived compute instances. For more information, see documentation.
``` ||
|| `--secondary-disk-specs` | `shorthand/json`

Array of secondary disks to attach to the instance.

Shorthand Syntax:

```hcl
[
  {
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
  }, ...
]
```

JSON Syntax:

```json
[
  {
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
  }, ...
]
```

Fields:

```
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
``` ||
|| `--serial-port-settings` | `shorthand/json`

Serial port settings

Shorthand Syntax:

```hcl
{
  ssh-authorization = INSTANCE_METADATA|OS_LOGIN
}
```

JSON Syntax:

```json
{
  "ssh-authorization": "INSTANCE_METADATA|OS_LOGIN"
}
```

Fields:

```
ssh-authorization -> (struct)
  Authentication and authorization in serial console when using SSH protocol
``` ||
|| `--service-account-id` | `string`

ID of the service account to use for documentation. To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List] request. ||
|| `--zone-id` | `string`

ID of the availability zone where the instance resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List] request ||
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