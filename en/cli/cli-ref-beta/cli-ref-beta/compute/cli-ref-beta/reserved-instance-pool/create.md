---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/compute/cli-ref-beta/reserved-instance-pool/create.md
---

# yc beta compute reserved-instance-pool create

Creates an reserved instance pool in the specified folder.  Method starts an asynchronous operation that can be cancelled while it is in progress.

#### Command Usage

Syntax: 

`yc beta compute reserved-instance-pool create <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--allow-oversubscription`|Allows the pool to contain more linked instances than the number of available slots (size without pending or unavailable slots).<br/>While running instances are still limited by available slots, stopped instances can exceed this limit.<br/>Warning: When this option is enabled, attempting to start more instances than the number of available slots will result in a "Not Enough Resources" error.|
|`--boot-disk-spec`|<b>`shorthand/json`</b><br/>Spec is used to determine which License IDs should be allowed for instances created in the pool.<br/><br/>Example:<br/>--boot-disk-spec boot-source={disk-id=value}<br/><br/>Shorthand Syntax:<br/>{boot-source={disk-id=str \| image-id=str \| product-ids={product-ids=str,...} \| snapshot-id=str}}<br/>Fields:<br/>boot-source  oneof<disk-id\|image-id\|product-ids\|snapshot-id>  — Oneof boot-source field<br/>disk-id      string  — Disk ID.<br/>image-id     string  — Image ID.<br/>snapshot-id  string  — Snapshot ID.<br/>product-ids  struct  — Product IDs.<br/>product-ids  []string  — License IDs that indicate which licenses are attached to resource.<br/>License IDs are used to calculate additional charges for the use of the virtual machine.<br/>|
|`--description`|<b>`string`</b><br/>Description of the reserved instance pool.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to create the reserved instance pool in.<br/>To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List] request.|
|`--gpu-settings`|<b>`shorthand/json`</b><br/>GPU settings.<br/><br/>Example:<br/>--gpu-settings gpu-cluster-id=value<br/><br/>Shorthand Syntax:<br/>{gpu-cluster-id=str}<br/>Fields:<br/>gpu-cluster-id  string  — Attach instance to specified GPU cluster.<br/>|
|`--labels`|<b>`stringToString`</b><br/>Resource labels as 'key:value' pairs.|
|`--name`|<b>`string`</b><br/>Name of the reserved instance pool.|
|`--network-settings`|<b>`shorthand/json`</b><br/>Network settings.<br/><br/>Example:<br/>--network-settings type=STANDARD<br/><br/>Shorthand Syntax:<br/>{type=STANDARD\|SOFTWARE_ACCELERATED\|HARDWARE_ACCELERATED}<br/>Fields:<br/>type  enum<HARDWARE_ACCELERATED\|SOFTWARE_ACCELERATED\|STANDARD>  — Network Type<br/>|
|`--platform-id`|<b>`string`</b><br/>ID of the hardware platform configuration for the reserved instance pool.<br/>This field affects the available values in [resources_spec] field.<br/><br/>For more information, see [Platforms](https://yandex.cloud/ru/docs/compute/concepts/vm-platforms).|
|`--resources-spec`|<b>`shorthand/json`</b><br/>Computing resources of the reserved instance pool instances, such as the amount of memory and number of cores.<br/>To get a list of available values, see [Levels of core performance](https://yandex.cloud/ru/docs/compute/concepts/performance-levels).<br/><br/>Example:|
|`--resources-spec`|<b>`core-fraction=1,`</b><br/>cores=1, gpus=1, memory=1<br/><br/>Shorthand Syntax:<br/>{core-fraction=int, cores=int, gpus=int, memory=int}<br/>Fields:<br/>core-fraction  int            — Baseline level of CPU performance with the ability to burst performance above that baseline level.<br/>This field sets baseline performance for each core.<br/><br/>For example, if you need only 5% of the CPU performance, you can set core_fraction=5.<br/>For more information, see [Levels of core performance](https://yandex.cloud/ru/docs/compute/concepts/performance-levels).<br/>cores          int  required  — The number of cores available to the instance.<br/>gpus           int            — The number of GPUs available to the instance.<br/>memory         int  required  — The amount of memory available to the instance, specified in bytes.<br/>|
|`--size`|<b>`int`</b><br/>Desired size of the pool (number of slots for instances in this pool).|
|`--zone-id`|<b>`string`</b><br/>ID of the availability zone where the reserved instance pool resides.<br/>To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List] request|
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
