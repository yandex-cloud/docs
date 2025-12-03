---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/compute/cli-ref-beta/instance/update.md
---

# yc beta compute instance update

Updates the specified instance.

#### Command Usage

Syntax: 

`yc beta compute instance update <INSTANCE-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--application`|<b>`shorthand/json`</b><br/>Instance application settings.<br/><br/>Example:|
|`--application`|<b>`cloudbackup={backup-id=value,`</b><br/>enabled=true, initial-policy-ids=value, instance-registration-id=value, recovery-from-backup=true}, container={container-solution={environment={key=value}, product-id=value, secrets={key={id=value, key=value, version-id=value}}}}<br/><br/>Shorthand Syntax:<br/>{cloudbackup={backup-id=str, enabled=bool, initial-policy-ids=str,..., instance-registration-id=str, recovery-from-backup=bool}, container={container-solution={environment={key=str, key=...}, product-id=str, secrets={key={id=str, key=str, version-id=str}, key=...}}}}<br/>Fields:<br/>cloudbackup  struct                     — Backup settings.<br/>backup-id                 string    — ID of the backup to recover from.<br/>enabled                   bool      — If true, backup is enabled.<br/>initial-policy-ids        []string  — A list of policy IDs to apply after resource registration.<br/>instance-registration-id  string    — ID of the instance registration for cloud backup agent installation.<br/>recovery-from-backup      bool      — If true, recovery from backup starts on instance.<br/>container    oneof\<container-solution\>  — Oneof container field<br/>container-solution  struct  — Container specification.<br/>environment  map[string,string]            — A list of the environmets.<br/>product-id   string              required  — ID of the product.<br/>secrets      map[string,struct]            — A list of the secrets.<br/>id          string  required  — ID of the secret.<br/>key         string  required  — Name of the key.<br/>version-id  string            — Version of the secret.<br/>|
|`--description`|<b>`string`</b><br/>Description of the instance.|
|`--instance-id`|<b>`string`</b><br/>ID of the Instance resource to update.<br/>To get the instance ID, use a [InstanceService.List] request.|
|`--labels`|<b>`stringToString`</b><br/>Resource labels as 'key:value' pairs.<br/><br/>Existing set of 'labels' is completely replaced by the provided set.|
|`--maintenance-grace-period`|<b>`duration`</b><br/>Time between notification via metadata service and maintenance (duration, e.g. 30s, 5m10s)|
|`--maintenance-policy`|<b>`enum`</b><br/>Behaviour on maintenance events Possible Values: 'restart', 'migrate'|
|`--metadata`|<b>`stringToString`</b><br/>The metadata 'key:value' pairs that will be assigned to this instance. This includes custom metadata and predefined keys.<br/>The total size of all keys and values must be less than 512 KB.<br/><br/>Existing set of 'metadata' is completely replaced by the provided set.<br/><br/>Values are free-form strings, and only have meaning as interpreted by the programs which configure the instance.<br/>The values must be 256 KB or less.<br/><br/>For example, you may use the metadata in order to provide your public SSH key to the instance.<br/>For more information, see [Metadata](/docs/compute/concepts/vm-metadata).|
|`--metadata-options`|<b>`shorthand/json`</b><br/>Options allow user to configure access to instance's metadata<br/><br/>Example:|
|`--metadata-options`|<b>`aws-v1-http-endpoint=ENABLED,`</b><br/>aws-v1-http-token=ENABLED, gce-http-endpoint=ENABLED, gce-http-token=ENABLED<br/><br/>Shorthand Syntax:<br/>{aws-v1-http-endpoint=ENABLED\|DISABLED, aws-v1-http-token=ENABLED\|DISABLED, gce-http-endpoint=ENABLED\|DISABLED, gce-http-token=ENABLED\|DISABLED}<br/>Fields:<br/>aws-v1-http-endpoint  enum<DISABLED\|ENABLED>  — Enabled access to AWS flavored metadata (IMDSv1)<br/>aws-v1-http-token     enum<DISABLED\|ENABLED>  — Enabled access to IAM credentials with AWS flavored metadata (IMDSv1)<br/>gce-http-endpoint     enum<DISABLED\|ENABLED>  — Enabled access to GCE flavored metadata<br/>gce-http-token        enum<DISABLED\|ENABLED>  — Enabled access to IAM credentials with GCE flavored metadata<br/>|
|`--name`|<b>`string`</b><br/>Name of the instance.|
|`--network-settings`|<b>`shorthand/json`</b><br/>Network settings.<br/><br/>Example:<br/>--network-settings type=STANDARD<br/><br/>Shorthand Syntax:<br/>{type=STANDARD\|SOFTWARE_ACCELERATED\|HARDWARE_ACCELERATED}<br/>Fields:<br/>type  enum<HARDWARE_ACCELERATED\|SOFTWARE_ACCELERATED\|STANDARD>  — Network Type<br/>|
|`--placement-policy`|<b>`shorthand/json`</b><br/>Placement policy configuration.<br/><br/>Example:|
|`--placement-policy`|<b>`host-affinity-rules=[{key=value,`</b><br/>op=IN, values=value}], placement-group-id=value, placement-group-partition=1<br/><br/>Shorthand Syntax:<br/>{host-affinity-rules=[{key=str, op=IN\|NOT_IN, values=str,...},...], placement-group-id=str, placement-group-partition=int}<br/>Fields:<br/>host-affinity-rules        []struct  — List of affinity rules. Scheduler will attempt to allocate instances according to order of rules.<br/>key     string           — Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId'<br/>op      enum<IN\|NOT_IN>  — Include or exclude action<br/>values  []string         — Affinity value or host ID or host group ID<br/>placement-group-id         string    — Placement group ID.<br/>placement-group-partition  int       — Placement group partition<br/>|
|`--platform-id`|<b>`string`</b><br/>ID of the hardware platform configuration for the instance.<br/>This field affects the available values in [resources_spec] field.<br/><br/>Platforms allows you to create various types of instances: with a large amount of memory,<br/>with a large number of cores, with a burstable performance.<br/>For more information, see [Platforms](https://yandex.cloud/ru/docs/compute/concepts/vm-platforms).|
|`--reserved-instance-pool-id`|<b>`string`</b><br/>ID of the reserved instance pool that the instance should belong to.<br/>Attaching/detaching running instance will increase/decrease the size of the reserved instance pool.<br/>Attaching/detaching stopped instance will leave the size of the reserved instance pool unchanged. Starting such attached instance will use resources from the reserved instance pool.<br/>Reserved instance pool resource configuration must match the resource configuration of the instance.|
|`--resources-spec`|<b>`shorthand/json`</b><br/>Computing resources of the instance, such as the amount of memory and number of cores.<br/>To get a list of available values, see [Levels of core performance](https://yandex.cloud/ru/docs/compute/concepts/performance-levels).<br/><br/>Example:|
|`--resources-spec`|<b>`core-fraction=1,`</b><br/>cores=1, gpus=1, memory=1<br/><br/>Shorthand Syntax:<br/>{core-fraction=int, cores=int, gpus=int, memory=int}<br/>Fields:<br/>core-fraction  int            — Baseline level of CPU performance with the ability to burst performance above that baseline level.<br/>This field sets baseline performance for each core.<br/><br/>For example, if you need only 5% of the CPU performance, you can set core_fraction=5.<br/>For more information, see [Levels of core performance](https://yandex.cloud/ru/docs/compute/concepts/performance-levels).<br/>cores          int  required  — The number of cores available to the instance.<br/>gpus           int            — The number of GPUs available to the instance.<br/>memory         int  required  — The amount of memory available to the instance, specified in bytes.<br/>|
|`--scheduling-policy`|<b>`shorthand/json`</b><br/>Scheduling policy configuration.<br/><br/>Example:<br/>--scheduling-policy preemptible=true<br/><br/>Shorthand Syntax:<br/>{preemptible=bool}<br/>Fields:<br/>preemptible  bool  — True for short-lived compute instances. For more information, see [Preemptible VMs](https://yandex.cloud/ru/docs/compute/concepts/preemptible-vm).<br/>|
|`--serial-port-settings`|<b>`shorthand/json`</b><br/>Serial port settings<br/><br/>Example:<br/>--serial-port-settings ssh-authorization=INSTANCE_METADATA<br/><br/>Shorthand Syntax:<br/>{ssh-authorization=INSTANCE_METADATA\|OS_LOGIN}<br/>Fields:<br/>ssh-authorization  enum<INSTANCE_METADATA\|OS_LOGIN>  — Authentication and authorization in serial console when using SSH protocol<br/>|
|`--service-account-id`|<b>`string`</b><br/>ID of the service account to use for [authentication inside the instance](https://yandex.cloud/ru/docs/compute/operations/vm-connect/auth-inside-vm).<br/>To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List] request.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
