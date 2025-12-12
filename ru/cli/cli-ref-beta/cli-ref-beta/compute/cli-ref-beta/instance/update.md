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
|`--application`|<b>`shorthand/json`</b><br/>Instance application settings.<br/>Shorthand Syntax:<br/>{<br/>cloudbackup = {<br/>backup-id = str,<br/>enabled = bool,<br/>initial-policy-ids = str,...,<br/>instance-registration-id = str,<br/>recovery-from-backup = bool<br/>},<br/>container = container-solution={<br/>environment = {key=str, key=...},<br/>product-id = str,<br/>secrets = {key={<br/>id = str,<br/>key = str,<br/>version-id = str<br/>}, key=...}<br/>}<br/>}<br/>JSON Syntax:<br/>"{<br/>"cloudbackup": {<br/>"backup-id": "str",<br/>"enabled": "bool",<br/>"initial-policy-ids": [<br/>"str", ...<br/>],<br/>"instance-registration-id": "str",<br/>"recovery-from-backup": "bool"<br/>},<br/>"container": {<br/>"container-solution": {<br/>"environment": {<br/>"\<key\>": "str", ...<br/>},<br/>"product-id": "str",<br/>"secrets": {<br/>"\<key\>": {<br/>"id": "str",<br/>"key": "str",<br/>"version-id": "str"<br/>}, ...<br/>}<br/>}<br/>}<br/>}"<br/>Fields:<br/>cloudbackup -> (struct)<br/>Backup settings.<br/>backup-id -> (string)<br/>ID of the backup to recover from.<br/>enabled -> (bool)<br/>If true, backup is enabled.<br/>initial-policy-ids -> ([]string)<br/>A list of policy IDs to apply after resource registration.<br/>instance-registration-id -> (string)<br/>ID of the instance registration for cloud backup agent installation.<br/>recovery-from-backup -> (bool)<br/>If true, recovery from backup starts on instance.<br/>container -> (oneof\<container-solution\>)<br/>Oneof container field<br/>container-solution -> (struct)<br/>Container specification.<br/>environment -> (map[string,string])<br/>A list of the environmets.<br/>product-id -> (string)<br/>ID of the product.<br/>secrets -> (map[string,struct])<br/>A list of the secrets.<br/>id -> (string)<br/>ID of the secret.<br/>key -> (string)<br/>Name of the key.<br/>version-id -> (string)<br/>Version of the secret.|
|`--description`|<b>`string`</b><br/>Description of the instance.|
|`--instance-id`|<b>`string`</b><br/>ID of the Instance resource to update. To get the instance ID, use a [InstanceService.List] request.|
|`--labels`|<b>`stringToString`</b><br/>Resource labels as 'key:value' pairs. Existing set of 'labels' is completely replaced by the provided set.|
|`--maintenance-grace-period`|<b>`duration`</b><br/>Time between notification via metadata service and maintenance (duration, e.g. 30s, 5m10s)|
|`--maintenance-policy`|<b>`enum`</b><br/>Behaviour on maintenance events Possible Values: 'restart', 'migrate'|
|`--metadata`|<b>`stringToString`</b><br/>The metadata 'key:value' pairs that will be assigned to this instance. This includes custom metadata and predefined keys. The total size of all keys and values must be less than 512 KB. Existing set of 'metadata' is completely replaced by the provided set. Values are free-form strings, and only have meaning as interpreted by the programs which configure the instance. The values must be 256 KB or less. For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see documentation.|
|`--metadata-options`|<b>`shorthand/json`</b><br/>Options allow user to configure access to instance's metadata<br/>Shorthand Syntax:<br/>{<br/>aws-v1-http-endpoint = ENABLED\|DISABLED,<br/>aws-v1-http-token = ENABLED\|DISABLED,<br/>gce-http-endpoint = ENABLED\|DISABLED,<br/>gce-http-token = ENABLED\|DISABLED<br/>}<br/>JSON Syntax:<br/>"{<br/>"aws-v1-http-endpoint": "ENABLED\|DISABLED",<br/>"aws-v1-http-token": "ENABLED\|DISABLED",<br/>"gce-http-endpoint": "ENABLED\|DISABLED",<br/>"gce-http-token": "ENABLED\|DISABLED"<br/>}"<br/>Fields:<br/>aws-v1-http-endpoint -> (enum<DISABLED\|ENABLED>)<br/>Enabled access to AWS flavored metadata (IMDSv1)<br/>aws-v1-http-token -> (enum<DISABLED\|ENABLED>)<br/>Enabled access to IAM credentials with AWS flavored metadata (IMDSv1)<br/>gce-http-endpoint -> (enum<DISABLED\|ENABLED>)<br/>Enabled access to GCE flavored metadata<br/>gce-http-token -> (enum<DISABLED\|ENABLED>)<br/>Enabled access to IAM credentials with GCE flavored metadata|
|`--name`|<b>`string`</b><br/>Name of the instance.|
|`--network-settings`|<b>`shorthand/json`</b><br/>Network settings.<br/>Shorthand Syntax:<br/>{<br/>type = STANDARD\|SOFTWARE_ACCELERATED\|HARDWARE_ACCELERATED<br/>}<br/>JSON Syntax:<br/>"{<br/>"type": "STANDARD\|SOFTWARE_ACCELERATED\|HARDWARE_ACCELERATED"<br/>}"<br/>Fields:<br/>type -> (enum<HARDWARE_ACCELERATED\|SOFTWARE_ACCELERATED\|STANDARD>)<br/>Network Type|
|`--placement-policy`|<b>`shorthand/json`</b><br/>Placement policy configuration.<br/>Shorthand Syntax:<br/>{<br/>host-affinity-rules = [<br/>{<br/>key = str,<br/>op = IN\|NOT_IN,<br/>values = str,...<br/>}, ...<br/>],<br/>placement-group-id = str,<br/>placement-group-partition = int<br/>}<br/>JSON Syntax:<br/>"{<br/>"host-affinity-rules": [<br/>{<br/>"key": "str",<br/>"op": "IN\|NOT_IN",<br/>"values": [<br/>"str", ...<br/>]<br/>}, ...<br/>],<br/>"placement-group-id": "str",<br/>"placement-group-partition": "int"<br/>}"<br/>Fields:<br/>host-affinity-rules -> ([]struct)<br/>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules.<br/>key -> (string)<br/>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId'<br/>op -> (enum<IN\|NOT_IN>)<br/>Include or exclude action<br/>values -> ([]string)<br/>Affinity value or host ID or host group ID<br/>placement-group-id -> (string)<br/>Placement group ID.<br/>placement-group-partition -> (int)<br/>Placement group partition|
|`--platform-id`|<b>`string`</b><br/>ID of the hardware platform configuration for the instance. This field affects the available values in [resources_spec] field. Platforms allows you to create various types of instances: with a large amount of memory, with a large number of cores, with a burstable performance. For more information, see documentation.|
|`--reserved-instance-pool-id`|<b>`string`</b><br/>ID of the reserved instance pool that the instance should belong to. Attaching/detaching running instance will increase/decrease the size of the reserved instance pool. Attaching/detaching stopped instance will leave the size of the reserved instance pool unchanged. Starting such attached instance will use resources from the reserved instance pool. Reserved instance pool resource configuration must match the resource configuration of the instance.|
|`--resources-spec`|<b>`shorthand/json`</b><br/>Computing resources of the instance, such as the amount of memory and number of cores. To get a list of available values, see documentation.<br/>Shorthand Syntax:<br/>{<br/>core-fraction = int,<br/>cores = int,<br/>gpus = int,<br/>memory = int<br/>}<br/>JSON Syntax:<br/>"{<br/>"core-fraction": "int",<br/>"cores": "int",<br/>"gpus": "int",<br/>"memory": "int"<br/>}"<br/>Fields:<br/>core-fraction -> (int)<br/>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. For example, if you need only 5% of the CPU performance, you can set core_fraction=5. For more information, see documentation.<br/>cores -> (int)<br/>The number of cores available to the instance.<br/>gpus -> (int)<br/>The number of GPUs available to the instance.<br/>memory -> (int)<br/>The amount of memory available to the instance, specified in bytes.|
|`--scheduling-policy`|<b>`shorthand/json`</b><br/>Scheduling policy configuration.<br/>Shorthand Syntax:<br/>{<br/>preemptible = bool<br/>}<br/>JSON Syntax:<br/>"{<br/>"preemptible": "bool"<br/>}"<br/>Fields:<br/>preemptible -> (bool)<br/>True for short-lived compute instances. For more information, see documentation.|
|`--serial-port-settings`|<b>`shorthand/json`</b><br/>Serial port settings<br/>Shorthand Syntax:<br/>{<br/>ssh-authorization = INSTANCE_METADATA\|OS_LOGIN<br/>}<br/>JSON Syntax:<br/>"{<br/>"ssh-authorization": "INSTANCE_METADATA\|OS_LOGIN"<br/>}"<br/>Fields:<br/>ssh-authorization -> (enum<INSTANCE_METADATA\|OS_LOGIN>)<br/>Authentication and authorization in serial console when using SSH protocol|
|`--service-account-id`|<b>`string`</b><br/>ID of the service account to use for documentation. To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List] request.|
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
