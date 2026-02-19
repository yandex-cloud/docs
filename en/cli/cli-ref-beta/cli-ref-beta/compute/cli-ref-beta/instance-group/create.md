---
editable: false
noIndex: true
---

# yc beta compute instance-group create

Creates an instance group in the specified folder.
This method starts an operation that can be cancelled by another operation.

#### Command Usage

Syntax:

`yc beta compute instance-group create <FOLDER-ID>`

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
|| `--allocation-policy` | `shorthand/json`

Allocation policy of the instance group by zones and regions.

Shorthand Syntax:

```hcl
{
  zones = [
    {
      instance-tags-pool = string,...,
      zone-id = string
    }, ...
  ]
}
```

JSON Syntax:

```json
{
  "zones": [
    {
      "instance-tags-pool": [
        "string", ...
      ],
      "zone-id": "string"
    }, ...
  ]
}
```

Fields:

```
zones -> ([]struct)
  List of availability zones.
  instance-tags-pool -> ([]string)
    Each instance in a zone will be associated with exactly one of a tag from a pool below. All specified tags must be unique across the whole group not only the zone. It is guaranteed that during whole deploy only tags from prefix of the specified list will be used. It is possible to use tag associated with instance in templating via {instance.tag}.
  zone-id -> (string)
    ID of the availability zone where the instance resides.
``` ||
|| `--application-load-balancer-spec` | `shorthand/json`

Settings for balancing load between instances via documentation (OSI model layer 7). If specified, an Application Load Balancer target group containing all instances from the instance group will be created and attributed to the instance group.

Shorthand Syntax:

```hcl
{
  ignore-health-checks = boolean,
  max-opening-traffic-duration = duration,
  target-group-spec = {
    description = string,
    labels = {key=string, key=...},
    name = string
  }
}
```

JSON Syntax:

```json
{
  "ignore-health-checks": "boolean",
  "max-opening-traffic-duration": "duration",
  "target-group-spec": {
    "description": "string",
    "labels": {
      "<key>": "string", ...
    },
    "name": "string"
  }
}
```

Fields:

```
ignore-health-checks -> (boolean)
  Do not wait load balancer health checks.
max-opening-traffic-duration -> (duration)
  Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds.
target-group-spec -> (struct)
  Basic properties of the Application Load Balancer target group attributed to the instance group.
  description -> (string)
    Description of the target group.
  labels -> (map[string,string])
    Resource labels as 'key:value' pairs.
  name -> (string)
    Name of the target group.
``` ||
|| `--auto-healing-policy` | `shorthand/json`

AutoHealingPolicy policy of the instance group.

Shorthand Syntax:

```hcl
{
  auto-healing-action = RESTART|RECREATE|NONE
}
```

JSON Syntax:

```json
{
  "auto-healing-action": "RESTART|RECREATE|NONE"
}
```

Fields:

```
auto-healing-action -> (struct)
  Instance Groups performs [auto_healing_action] when instance becomes unhealthy.
``` ||
|| `--deletion-protection` | Flag prohibiting deletion of the instance group. Allowed values:&lt;/br&gt;- 'false': The instance group can be deleted.&lt;/br&gt;- 'true': The instance group cannot be deleted. The default is 'false'. ||
|| `--deploy-policy` | `shorthand/json`

Deployment policy of the instance group.

Shorthand Syntax:

```hcl
{
  max-creating = integer,
  max-deleting = integer,
  max-expansion = integer,
  max-unavailable = integer,
  minimal-action = LIVE_UPDATE|RESTART|RECREATE,
  startup-duration = duration,
  strategy = PROACTIVE|OPPORTUNISTIC
}
```

JSON Syntax:

```json
{
  "max-creating": "integer",
  "max-deleting": "integer",
  "max-expansion": "integer",
  "max-unavailable": "integer",
  "minimal-action": "LIVE_UPDATE|RESTART|RECREATE",
  "startup-duration": "duration",
  "strategy": "PROACTIVE|OPPORTUNISTIC"
}
```

Fields:

```
max-creating -> (integer)
  The maximum number of instances that can be created at the same time. The value 0 is any number of virtual machines within the allowed values.
max-deleting -> (integer)
  The maximum number of instances that can be deleted at the same time. The value 0 is any number of virtual machines within the allowed values.
max-expansion -> (integer)
  The maximum number of instances that can be temporarily allocated above the group's target size during the update process. If [max_unavailable] is not specified or set to zero, [max_expansion] must be set to a non-zero value.
max-unavailable -> (integer)
  The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time during the update process. If [max_expansion] is not specified or set to zero, [max_unavailable] must be set to a non-zero value.
minimal-action -> (struct)
  If instance update requires a less disruptive action than [minimal_action], Instance Groups performs [minimal_action] to execute the update
startup-duration -> (duration)
  Instance startup duration. Instance will be considered up and running (and start receiving traffic) only after startup_duration has elapsed and all health checks are passed. See [ManagedInstance.Status] for more information.
strategy -> (struct)
  Affects the lifecycle of the instance during deployment.
``` ||
|| `--description` | `string`

Description of the instance group. ||
|| `--folder-id` | `string`

ID of the folder to create an instance group in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--health-checks-spec` | `shorthand/json`

Health checking specification. For more information, see documentation.

Shorthand Syntax:

```hcl
{
  health-check-specs = [
    {
      health-check-options = http-options={
        path = string,
        port = integer
      } | tcp-options={
        port = integer
      },
      healthy-threshold = integer,
      interval = duration,
      timeout = duration,
      unhealthy-threshold = integer
    }, ...
  ],
  max-checking-health-duration = duration
}
```

JSON Syntax:

```json
{
  "health-check-specs": [
    {
      "health-check-options": {
        "http-options": {
          "path": "string",
          "port": "integer"
        },
        "tcp-options": {
          "port": "integer"
        }
      },
      "healthy-threshold": "integer",
      "interval": "duration",
      "timeout": "duration",
      "unhealthy-threshold": "integer"
    }, ...
  ],
  "max-checking-health-duration": "duration"
}
```

Fields:

```
health-check-specs -> ([]struct)
  Health checking specification. For more information, see documentation.
  healthy-threshold -> (integer)
    The number of successful health checks required in order for the managed instance to be considered healthy. The default (0) is 2.
  interval -> (duration)
    The interval between health checks. The default is 2 seconds.
  timeout -> (duration)
    Timeout for the managed instance to return a response for the health check. The default is 1 second.
  unhealthy-threshold -> (integer)
    The number of failed health checks for the managed instance to be considered unhealthy. The default (0) is 2.
  health-check-options -> (oneof<http-options|tcp-options>)
    Oneof health-check-options field
    tcp-options -> (struct)
      Configuration options for a TCP health check.
      port -> (integer)
        Port to use for TCP health checks.
    http-options -> (struct)
      Configuration options for an HTTP health check.
      path -> (string)
        URL path to set for health checking requests.
      port -> (integer)
        Port to use for HTTP health checks.
max-checking-health-duration -> (duration)
  Timeout for waiting for the VM to become healthy. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds.
``` ||
|| `--instance-template` | `shorthand/json`

Instance template that the instance group belongs to.

Shorthand Syntax:

```hcl
{
  boot-disk-spec = {
    device-name = string,
    disk-id = string,
    disk-spec = {
      description = string,
      preserve-after-instance-delete = boolean,
      size = integer,
      source-oneof = image-id=string | snapshot-id=string,
      type-id = string
    },
    mode = READ_ONLY|READ_WRITE,
    name = string
  },
  description = string,
  filesystem-specs = [
    {
      device-name = string,
      filesystem-id = string,
      mode = READ_ONLY|READ_WRITE
    }, ...
  ],
  hostname = string,
  labels = {key=string, key=...},
  metadata = {key=string, key=...},
  metadata-options = {
    aws-v1-http-endpoint = ENABLED|DISABLED,
    aws-v1-http-token = ENABLED|DISABLED,
    gce-http-endpoint = ENABLED|DISABLED,
    gce-http-token = ENABLED|DISABLED
  },
  name = string,
  network-interface-specs = [
    {
      network-id = string,
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
      subnet-ids = string,...
    }, ...
  ],
  network-settings = {
    type = STANDARD|SOFTWARE_ACCELERATED|HARDWARE_ACCELERATED
  },
  placement-policy = {
    host-affinity-rules = [
      {
        key = string,
        op = IN|NOT_IN,
        values = string,...
      }, ...
    ],
    placement-group-id = string
  },
  platform-id = string,
  reserved-instance-pool-id = string,
  resources-spec = {
    core-fraction = integer,
    cores = integer,
    gpus = integer,
    memory = integer
  },
  scheduling-policy = {
    preemptible = boolean
  },
  secondary-disk-specs = [
    {
      device-name = string,
      disk-id = string,
      disk-spec = {
        description = string,
        preserve-after-instance-delete = boolean,
        size = integer,
        source-oneof = image-id=string | snapshot-id=string,
        type-id = string
      },
      mode = READ_ONLY|READ_WRITE,
      name = string
    }, ...
  ],
  service-account-id = string
}
```

JSON Syntax:

```json
{
  "boot-disk-spec": {
    "device-name": "string",
    "disk-id": "string",
    "disk-spec": {
      "description": "string",
      "preserve-after-instance-delete": "boolean",
      "size": "integer",
      "source-oneof": {
        "image-id": "string",
        "snapshot-id": "string"
      },
      "type-id": "string"
    },
    "mode": "READ_ONLY|READ_WRITE",
    "name": "string"
  },
  "description": "string",
  "filesystem-specs": [
    {
      "device-name": "string",
      "filesystem-id": "string",
      "mode": "READ_ONLY|READ_WRITE"
    }, ...
  ],
  "hostname": "string",
  "labels": {
    "<key>": "string", ...
  },
  "metadata": {
    "<key>": "string", ...
  },
  "metadata-options": {
    "aws-v1-http-endpoint": "ENABLED|DISABLED",
    "aws-v1-http-token": "ENABLED|DISABLED",
    "gce-http-endpoint": "ENABLED|DISABLED",
    "gce-http-token": "ENABLED|DISABLED"
  },
  "name": "string",
  "network-interface-specs": [
    {
      "network-id": "string",
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
      "subnet-ids": [
        "string", ...
      ]
    }, ...
  ],
  "network-settings": {
    "type": "STANDARD|SOFTWARE_ACCELERATED|HARDWARE_ACCELERATED"
  },
  "placement-policy": {
    "host-affinity-rules": [
      {
        "key": "string",
        "op": "IN|NOT_IN",
        "values": [
          "string", ...
        ]
      }, ...
    ],
    "placement-group-id": "string"
  },
  "platform-id": "string",
  "reserved-instance-pool-id": "string",
  "resources-spec": {
    "core-fraction": "integer",
    "cores": "integer",
    "gpus": "integer",
    "memory": "integer"
  },
  "scheduling-policy": {
    "preemptible": "boolean"
  },
  "secondary-disk-specs": [
    {
      "device-name": "string",
      "disk-id": "string",
      "disk-spec": {
        "description": "string",
        "preserve-after-instance-delete": "boolean",
        "size": "integer",
        "source-oneof": {
          "image-id": "string",
          "snapshot-id": "string"
        },
        "type-id": "string"
      },
      "mode": "READ_ONLY|READ_WRITE",
      "name": "string"
    }, ...
  ],
  "service-account-id": "string"
}
```

Fields:

```
boot-disk-spec -> (struct)
  Boot disk specification that will be attached to the instance.
  device-name -> (string)
    Serial number that is reflected in the /dev/disk/by-id/ tree of a Linux operating system running within the instance. This value can be used to reference the device for mounting, resizing, and so on, from within the instance.
  disk-id -> (string)
    Set to use an existing disk. To set use variables.
  disk-spec -> (struct)
    oneof disk_spec or disk_id Disk specification that is attached to the instance. For more information, see documentation.
    description -> (string)
      Description of the disk.
    preserve-after-instance-delete -> (boolean)
      When set to true, disk will not be deleted even after managed instance is deleted. It will be a user's responsibility to delete such disks.
    size -> (integer)
      Size of the disk, specified in bytes.
    type-id -> (string)
      ID of the disk type.
    source-oneof -> (oneof<image-id|snapshot-id>)
      Oneof source-oneof field
      image-id -> (string)
        ID of the image that will be used for disk creation.
      snapshot-id -> (string)
        ID of the snapshot that will be used for disk creation.
  mode -> (struct)
    Access mode to the Disk resource.
  name -> (string)
    When set can be later used to change DiskSpec of actual disk.
description -> (string)
  Description of the instance template.
filesystem-specs -> ([]struct)
  Array of filesystems to attach to the instance. The filesystems must reside in the same availability zone as the instance. To use the instance with an attached filesystem, the latter must be mounted. For details, see documentation.
  device-name -> (string)
    Name of the device representing the filesystem on the instance. The name should be used for referencing the filesystem from within the instance when it's being mounted, resized etc. If not specified, a random value will be generated.
  filesystem-id -> (string)
    ID of the filesystem that should be attached.
  mode -> (struct)
    Mode of access to the filesystem that should be attached.
hostname -> (string)
  Host name for the instance. This field is used to generate the [yandex.cloud.compute.v1.Instance.fqdn] value. The host name must be unique within the network and region. If not specified, the host name will be equal to [yandex.cloud.compute.v1.Instance.id] of the instance and FQDN will be '<id>.auto.internal'. Otherwise FQDN will be '<hostname>.<region_id>.internal'. In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, 'name' value will be used It may also contain another placeholders, see metadata doc for full list.
labels -> (map[string,string])
  Resource labels as 'key:value' pairs.
metadata -> (map[string,string])
  The metadata 'key:value' pairs assigned to this instance template. This includes custom metadata and predefined keys. Metadata values may contain one of the supported placeholders: {instance_group.id} {instance.short_id} {instance.index} {instance.index_in_zone} {instance.zone_id} InstanceGroup and Instance labels may be copied to metadata following way: {instance_group.labels.some_label_key} {instance.labels.another_label_key} These placeholders will be substituted for each created instance anywhere in the value text. In the rare case the value requires to contain this placeholder explicitly, it must be escaped with double brackets, in example {instance.index}. For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see documentation.
metadata-options -> (struct)
  Metadata options for the instance
  aws-v1-http-endpoint -> (struct)
    Enabled access to AWS flavored metadata (IMDSv1)
  aws-v1-http-token -> (struct)
    Enabled access to IAM credentials with AWS flavored metadata (IMDSv1)
  gce-http-endpoint -> (struct)
    Enabled access to GCE flavored metadata
  gce-http-token -> (struct)
    Enabled access to IAM credentials with GCE flavored metadata
name -> (string)
  Name of the instance. In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, default is used: {instance_group.id}-{instance.short_id} It may also contain another placeholders, see metadata doc for full list.
network-interface-specs -> ([]struct)
  Array of network interfaces that will be attached to the instance.
  network-id -> (string)
    ID of the network.
  primary-v4-address-spec -> (struct)
    Primary IPv4 address that is assigned to the instance for this network interface.
    address -> (string)
      Optional. Manual set static internal IP. To set use variables.
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
      An external IP address configuration. If not specified, then this managed instance will have no external internet access.
      address -> (string)
        Manual set static public IP. To set use variables. (optional)
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
        IP version for the public IP address.
  primary-v6-address-spec -> (struct)
    Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet.
    address -> (string)
      Optional. Manual set static internal IP. To set use variables.
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
      An external IP address configuration. If not specified, then this managed instance will have no external internet access.
      address -> (string)
        Manual set static public IP. To set use variables. (optional)
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
        IP version for the public IP address.
  security-group-ids -> ([]string)
    IDs of security groups.
  subnet-ids -> ([]string)
    IDs of the subnets.
network-settings -> (struct)
  Network settings for the instance.
  type -> (struct)
    Type of instance network.
placement-policy -> (struct)
  Placement Group
  host-affinity-rules -> ([]struct)
    List of affinity rules. Scheduler will attempt to allocate instances according to order of rules.
    key -> (string)
      Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId'
    op -> (struct)
      Include or exclude action
    values -> ([]string)
      Affinity value or host ID or host group ID
  placement-group-id -> (string)
    Identifier of placement group
platform-id -> (string)
  ID of the hardware platform configuration for the instance. Platforms allows you to create various types of instances: with a large amount of memory, with a large number of cores, with a burstable performance. For more information, see documentation.
reserved-instance-pool-id -> (string)
  ID of the reserved instance pool that the instance should belong to. Attaching/detaching running instance will increase/decrease the size of the reserved instance pool. Attaching/detaching stopped instance will leave the size of the reserved instance pool unchanged. Starting such attached instance will use resources from the reserved instance pool. Reserved instance pool resource configuration must match the resource configuration of the instance.
resources-spec -> (struct)
  Computing resources of the instance such as the amount of memory and number of cores.
  core-fraction -> (integer)
    Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core.
  cores -> (integer)
    The number of cores available to the instance.
  gpus -> (integer)
    The number of GPUs available to the instance.
  memory -> (integer)
    The amount of memory available to the instance, specified in bytes.
scheduling-policy -> (struct)
  Scheduling policy for the instance.
  preemptible -> (boolean)
    Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see documentation.
secondary-disk-specs -> ([]struct)
  Array of secondary disks that will be attached to the instance.
  device-name -> (string)
    Serial number that is reflected in the /dev/disk/by-id/ tree of a Linux operating system running within the instance. This value can be used to reference the device for mounting, resizing, and so on, from within the instance.
  disk-id -> (string)
    Set to use an existing disk. To set use variables.
  disk-spec -> (struct)
    oneof disk_spec or disk_id Disk specification that is attached to the instance. For more information, see documentation.
    description -> (string)
      Description of the disk.
    preserve-after-instance-delete -> (boolean)
      When set to true, disk will not be deleted even after managed instance is deleted. It will be a user's responsibility to delete such disks.
    size -> (integer)
      Size of the disk, specified in bytes.
    type-id -> (string)
      ID of the disk type.
    source-oneof -> (oneof<image-id|snapshot-id>)
      Oneof source-oneof field
      image-id -> (string)
        ID of the image that will be used for disk creation.
      snapshot-id -> (string)
        ID of the snapshot that will be used for disk creation.
  mode -> (struct)
    Access mode to the Disk resource.
  name -> (string)
    When set can be later used to change DiskSpec of actual disk.
service-account-id -> (string)
  Service account ID for the instance.
``` ||
|| `--labels` | `map<string><string>`

Resource labels as 'key:value' pairs. ||
|| `--load-balancer-spec` | `shorthand/json`

Settings for balancing load between instances via documentation (OSI model layer 3). If specified, a Network Load Balancer target group containing all instances from the instance group will be created and attributed to the instance group.

Shorthand Syntax:

```hcl
{
  ignore-health-checks = boolean,
  max-opening-traffic-duration = duration,
  target-group-spec = {
    description = string,
    labels = {key=string, key=...},
    name = string
  }
}
```

JSON Syntax:

```json
{
  "ignore-health-checks": "boolean",
  "max-opening-traffic-duration": "duration",
  "target-group-spec": {
    "description": "string",
    "labels": {
      "<key>": "string", ...
    },
    "name": "string"
  }
}
```

Fields:

```
ignore-health-checks -> (boolean)
  Do not wait load balancer health checks.
max-opening-traffic-duration -> (duration)
  Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds.
target-group-spec -> (struct)
  Specification of the target group that the instance group will be added to. For more information, see documentation.
  description -> (string)
    Description of the target group.
  labels -> (map[string,string])
    Resource labels as 'key:value' pairs.
  name -> (string)
    Name of the target group.
``` ||
|| `--name` | `string`

Name of the instance group. ||
|| `--scale-policy` | `shorthand/json`

documentation of the instance group.

Shorthand Syntax:

```hcl
{
  scale-type = auto-scale={
    auto-scale-type = ZONAL|REGIONAL,
    cpu-utilization-rule = {
      utilization-target = float64
    },
    custom-rules = [
      {
        folder-id = string,
        labels = {key=string, key=...},
        metric-name = string,
        metric-type = GAUGE|COUNTER,
        rule-type = UTILIZATION|WORKLOAD,
        service = string,
        target = float64
      }, ...
    ],
    initial-size = integer,
    max-size = integer,
    measurement-duration = duration,
    min-zone-size = integer,
    stabilization-duration = duration,
    warmup-duration = duration
  } | fixed-scale={
    size = integer
  },
  test-auto-scale = {
    auto-scale-type = ZONAL|REGIONAL,
    cpu-utilization-rule = {
      utilization-target = float64
    },
    custom-rules = [
      {
        folder-id = string,
        labels = {key=string, key=...},
        metric-name = string,
        metric-type = GAUGE|COUNTER,
        rule-type = UTILIZATION|WORKLOAD,
        service = string,
        target = float64
      }, ...
    ],
    initial-size = integer,
    max-size = integer,
    measurement-duration = duration,
    min-zone-size = integer,
    stabilization-duration = duration,
    warmup-duration = duration
  }
}
```

JSON Syntax:

```json
{
  "scale-type": {
    "auto-scale": {
      "auto-scale-type": "ZONAL|REGIONAL",
      "cpu-utilization-rule": {
        "utilization-target": "float64"
      },
      "custom-rules": [
        {
          "folder-id": "string",
          "labels": {
            "<key>": "string", ...
          },
          "metric-name": "string",
          "metric-type": "GAUGE|COUNTER",
          "rule-type": "UTILIZATION|WORKLOAD",
          "service": "string",
          "target": "float64"
        }, ...
      ],
      "initial-size": "integer",
      "max-size": "integer",
      "measurement-duration": "duration",
      "min-zone-size": "integer",
      "stabilization-duration": "duration",
      "warmup-duration": "duration"
    },
    "fixed-scale": {
      "size": "integer"
    }
  },
  "test-auto-scale": {
    "auto-scale-type": "ZONAL|REGIONAL",
    "cpu-utilization-rule": {
      "utilization-target": "float64"
    },
    "custom-rules": [
      {
        "folder-id": "string",
        "labels": {
          "<key>": "string", ...
        },
        "metric-name": "string",
        "metric-type": "GAUGE|COUNTER",
        "rule-type": "UTILIZATION|WORKLOAD",
        "service": "string",
        "target": "float64"
      }, ...
    ],
    "initial-size": "integer",
    "max-size": "integer",
    "measurement-duration": "duration",
    "min-zone-size": "integer",
    "stabilization-duration": "duration",
    "warmup-duration": "duration"
  }
}
```

Fields:

```
test-auto-scale -> (struct)
  Test spec for documentation of the instance group.
  auto-scale-type -> (struct)
    Autoscaling type.
  cpu-utilization-rule -> (struct)
    Defines an autoscaling rule based on the average CPU utilization of the instance group. If more than one rule is specified, e.g. CPU utilization and one or more Monitoring metrics ([custom_rules]), the size of the instance group will be equal to the maximum of sizes calculated according to each metric.
    utilization-target -> (float64)
      Target CPU utilization level. Instance Groups maintains this level for each availability zone.
  custom-rules -> ([]struct)
    Defines an autoscaling rule based on a documentation from Monitoring. If more than one rule is specified, e.g. CPU utilization ([cpu_utilization_rule]) and one or more Monitoring metrics, the size of the instance group will be equal to the maximum of sizes calculated according to each metric.
    folder-id -> (string)
      Folder id of custom metric in Monitoring that should be used for scaling.
    labels -> (map[string,string])
      Labels of custom metric in Monitoring that should be used for scaling.
    metric-name -> (string)
      Name of custom metric in Monitoring that should be used for scaling.
    metric-type -> (struct)
      Type of custom metric. This field affects how Instance Groups calculates the average metric value.
    rule-type -> (struct)
      Custom metric rule type. This field affects which label from the custom metric should be used: 'zone_id' or 'instance_id'.
    service -> (string)
      Service of custom metric in Monitoring that should be used for scaling.
    target -> (float64)
      Target value for the custom metric. Instance Groups maintains this level for each availability zone.
  initial-size -> (integer)
    Target group size.
  max-size -> (integer)
    Upper limit for total instance count (across all zones). 0 means maximum limit = 100.
  measurement-duration -> (duration)
    Time in seconds allotted for averaging metrics. 1 minute by default.
  min-zone-size -> (integer)
    Lower limit for instance count in each zone.
  stabilization-duration -> (duration)
    Minimum amount of time in seconds allotted for monitoring before Instance Groups can reduce the number of instances in the group. During this time, the group size doesn't decrease, even if the new metric values indicate that it should.
  warmup-duration -> (duration)
    The warmup time of the instance in seconds. During this time, traffic is sent to the instance, but instance metrics are not collected.
scale-type -> (oneof<auto-scale|fixed-scale>)
  Oneof scale-type field
  fixed-scale -> (struct)
    documentation of the instance group.
    size -> (integer)
      Number of instances in the instance group.
  auto-scale -> (struct)
    documentation of the instance group.
    auto-scale-type -> (struct)
      Autoscaling type.
    cpu-utilization-rule -> (struct)
      Defines an autoscaling rule based on the average CPU utilization of the instance group. If more than one rule is specified, e.g. CPU utilization and one or more Monitoring metrics ([custom_rules]), the size of the instance group will be equal to the maximum of sizes calculated according to each metric.
      utilization-target -> (float64)
        Target CPU utilization level. Instance Groups maintains this level for each availability zone.
    custom-rules -> ([]struct)
      Defines an autoscaling rule based on a documentation from Monitoring. If more than one rule is specified, e.g. CPU utilization ([cpu_utilization_rule]) and one or more Monitoring metrics, the size of the instance group will be equal to the maximum of sizes calculated according to each metric.
      folder-id -> (string)
        Folder id of custom metric in Monitoring that should be used for scaling.
      labels -> (map[string,string])
        Labels of custom metric in Monitoring that should be used for scaling.
      metric-name -> (string)
        Name of custom metric in Monitoring that should be used for scaling.
      metric-type -> (struct)
        Type of custom metric. This field affects how Instance Groups calculates the average metric value.
      rule-type -> (struct)
        Custom metric rule type. This field affects which label from the custom metric should be used: 'zone_id' or 'instance_id'.
      service -> (string)
        Service of custom metric in Monitoring that should be used for scaling.
      target -> (float64)
        Target value for the custom metric. Instance Groups maintains this level for each availability zone.
    initial-size -> (integer)
      Target group size.
    max-size -> (integer)
      Upper limit for total instance count (across all zones). 0 means maximum limit = 100.
    measurement-duration -> (duration)
      Time in seconds allotted for averaging metrics. 1 minute by default.
    min-zone-size -> (integer)
      Lower limit for instance count in each zone.
    stabilization-duration -> (duration)
      Minimum amount of time in seconds allotted for monitoring before Instance Groups can reduce the number of instances in the group. During this time, the group size doesn't decrease, even if the new metric values indicate that it should.
    warmup-duration -> (duration)
      The warmup time of the instance in seconds. During this time, traffic is sent to the instance, but instance metrics are not collected.
``` ||
|| `--service-account-id` | `string`

ID of the service account. The service account will be used for all API calls made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see documentation. To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List] request. ||
|| `--variables` | `shorthand/json`

Shorthand Syntax:

```hcl
[
  {
    key = string,
    value = string
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "key": "string",
    "value": "string"
  }, ...
]
```

Fields:

```
key -> (string)
value -> (string)
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