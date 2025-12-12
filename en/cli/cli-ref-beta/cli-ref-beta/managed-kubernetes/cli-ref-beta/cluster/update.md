---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-kubernetes/cli-ref-beta/cluster/update.md
---

# yc beta managed-kubernetes cluster update

Updates the specified Kubernetes cluster.

#### Command Usage

Syntax: 

`yc beta managed-kubernetes cluster update <CLUSTER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/>ID of the Kubernetes cluster to update. To get the Kubernetes cluster ID use a [ClusterService.List] request.|
|`--description`|<b>`string`</b><br/>Description of the Kubernetes cluster.|
|`--ip-allocation-policy`|<b>`shorthand/json`</b><br/><br/>Shorthand Syntax:<br/>{<br/>cluster-ipv4-cidr-block = str,<br/>cluster-ipv6-cidr-block = str,<br/>node-ipv4-cidr-mask-size = int,<br/>service-ipv4-cidr-block = str,<br/>service-ipv6-cidr-block = str<br/>}<br/>JSON Syntax:<br/>"{<br/>"cluster-ipv4-cidr-block": "str",<br/>"cluster-ipv6-cidr-block": "str",<br/>"node-ipv4-cidr-mask-size": "int",<br/>"service-ipv4-cidr-block": "str",<br/>"service-ipv6-cidr-block": "str"<br/>}"<br/>Fields:<br/>cluster-ipv4-cidr-block -> (string)<br/>CIDR block. IP range for allocating pod addresses. It should not overlap with any subnet in the network the Kubernetes cluster located in. Static routes will be set up for this CIDR blocks in node subnets.<br/>cluster-ipv6-cidr-block -> (string)<br/>IPv6 range for allocating pod IP addresses.<br/>node-ipv4-cidr-mask-size -> (int)<br/>Size of the masks that are assigned for each node in the cluster. If not specified, 24 is used.<br/>service-ipv4-cidr-block -> (string)<br/>CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from. It should not overlap with any subnet in the network the Kubernetes cluster located in.<br/>service-ipv6-cidr-block -> (string)<br/>IPv6 range for allocating Kubernetes service IP addresses|
|`--labels`|<b>`stringToString`</b><br/>Resource labels as 'key:value' pairs. Existing set of 'labels' is completely replaced by the provided set.|
|`--master-spec`|<b>`shorthand/json`</b><br/>Specification of the master update.<br/>Shorthand Syntax:<br/>{<br/>external-v6-address-spec = {<br/>address = str<br/>},<br/>locations = [<br/>{<br/>subnet-id = str,<br/>zone-id = str<br/>}, ...<br/>],<br/>maintenance-policy = {<br/>auto-upgrade = bool,<br/>maintenance-window = {<br/>policy = anytime={} \| daily-maintenance-window={<br/>duration = duration,<br/>start-time = timeofday<br/>} \| weekly-maintenance-window={<br/>days-of-week = [<br/>{<br/>days = MONDAY\|TUESDAY\|WEDNESDAY\|THURSDAY\|FRIDAY\|SATURDAY\|SUNDAY,...,<br/>duration = duration,<br/>start-time = timeofday<br/>}, ...<br/>]<br/>}<br/>}<br/>},<br/>master-logging = {<br/>audit-enabled = bool,<br/>cluster-autoscaler-enabled = bool,<br/>destination = folder-id=str \| log-group-id=str,<br/>enabled = bool,<br/>events-enabled = bool,<br/>kube-apiserver-enabled = bool<br/>},<br/>scale-policy = {<br/>scale-type = auto-scale={<br/>min-resource-preset-id = str<br/>}<br/>},<br/>security-group-ids = str,...,<br/>version = {<br/>specifier = latest-revision=bool \| version=str<br/>}<br/>}<br/>JSON Syntax:<br/>"{<br/>"external-v6-address-spec": {<br/>"address": "str"<br/>},<br/>"locations": [<br/>{<br/>"subnet-id": "str",<br/>"zone-id": "str"<br/>}, ...<br/>],<br/>"maintenance-policy": {<br/>"auto-upgrade": "bool",<br/>"maintenance-window": {<br/>"policy": {<br/>"anytime": {},<br/>"daily-maintenance-window": {<br/>"duration": "duration",<br/>"start-time": "timeofday"<br/>},<br/>"weekly-maintenance-window": {<br/>"days-of-week": [<br/>{<br/>"days": [<br/>"MONDAY\|TUESDAY\|WEDNESDAY\|THURSDAY\|FRIDAY\|SATURDAY\|SUNDAY", ...<br/>],<br/>"duration": "duration",<br/>"start-time": "timeofday"<br/>}, ...<br/>]<br/>}<br/>}<br/>}<br/>},<br/>"master-logging": {<br/>"audit-enabled": "bool",<br/>"cluster-autoscaler-enabled": "bool",<br/>"destination": {<br/>"folder-id": "str",<br/>"log-group-id": "str"<br/>},<br/>"enabled": "bool",<br/>"events-enabled": "bool",<br/>"kube-apiserver-enabled": "bool"<br/>},<br/>"scale-policy": {<br/>"scale-type": {<br/>"auto-scale": {<br/>"min-resource-preset-id": "str"<br/>}<br/>}<br/>},<br/>"security-group-ids": [<br/>"str", ...<br/>],<br/>"version": {<br/>"specifier": {<br/>"latest-revision": "bool",<br/>"version": "str"<br/>}<br/>}<br/>}"<br/>Fields:<br/>external-v6-address-spec -> (struct)<br/>Specification of parameters for external IPv6 networking.<br/>address -> (string)<br/>IP address.<br/>locations -> ([]struct)<br/>Update master instance locations.<br/>subnet-id -> (string)<br/>ID of the VPC network's subnet where the master resides. If not specified and there is a single subnet in specified zone, address in this subnet will be allocated.<br/>zone-id -> (string)<br/>ID of the availability zone where the master resides.<br/>maintenance-policy -> (struct)<br/>Maintenance policy of the master.<br/>auto-upgrade -> (bool)<br/>If set to true, automatic updates are installed in the specified period of time with no interaction from the user. If set to false, automatic upgrades are disabled.<br/>maintenance-window -> (struct)<br/>Maintenance window settings. Update will start at the specified time and last no more than the specified duration. The time is set in UTC.<br/>policy -> (oneof<anytime\|daily-maintenance-window\|weekly-maintenance-window>)<br/>Oneof policy field<br/>anytime -> (struct)<br/>Updating the master at any time.<br/>daily-maintenance-window -> (struct)<br/>Updating the master on any day during the specified time window.<br/>duration -> (duration)<br/>Window duration.<br/>start-time -> (timeofday)<br/>Window start time, in the UTC timezone.<br/>weekly-maintenance-window -> (struct)<br/>Updating the master on selected days during the specified time window.<br/>days-of-week -> ([]struct)<br/>Days of the week and the maintenance window for these days when automatic updates are allowed.<br/>days -> ([]int)<br/>Days of the week when automatic updates are allowed.<br/>duration -> (duration)<br/>Window duration.<br/>start-time -> (timeofday)<br/>Window start time, in the UTC timezone.<br/>master-logging -> (struct)<br/>Cloud Logging for master components.<br/>audit-enabled -> (bool)<br/>Identifies whether Cloud Logging is enabled for audit logs.<br/>cluster-autoscaler-enabled -> (bool)<br/>Identifies whether Cloud Logging is enabled for cluster-autoscaler.<br/>enabled -> (bool)<br/>Identifies whether Cloud Logging is enabled for master components.<br/>events-enabled -> (bool)<br/>Identifies whether Cloud Logging is enabled for events.<br/>kube-apiserver-enabled -> (bool)<br/>Identifies whether Cloud Logging is enabled for kube-apiserver.<br/>destination -> (oneof<folder-id\|log-group-id>)<br/>Oneof destination field<br/>log-group-id -> (string)<br/>ID of the log group where logs of master components should be stored.<br/>folder-id -> (string)<br/>ID of the folder where logs should be stored (in default group).<br/>scale-policy -> (struct)<br/>Scale policy of the master.<br/>scale-type -> (oneof\<auto-scale\>)<br/>Oneof scale-type field<br/>auto-scale -> (struct)<br/>min-resource-preset-id -> (string)<br/>Preset of computing resources to be used as lower boundary for scaling.<br/>security-group-ids -> ([]string)<br/>Master security groups.<br/>version -> (struct)<br/>Specification of the master update.<br/>specifier -> (oneof<latest-revision\|version>)<br/>Oneof specifier field<br/>version -> (string)<br/>Request update to a newer version of Kubernetes (1.x -> 1.y).<br/>latest-revision -> (bool)<br/>Request update to the latest revision for the current version.|
|`--name`|<b>`string`</b><br/>Name of the Kubernetes cluster. The name must be unique within the folder.|
|`--network-policy`|<b>`shorthand/json`</b><br/><br/>Shorthand Syntax:<br/>{<br/>provider = CALICO<br/>}<br/>JSON Syntax:<br/>"{<br/>"provider": "CALICO"<br/>}"<br/>Fields:<br/>provider -> (enum\<CALICO\>)|
|`--node-service-account-id`|<b>`string`</b><br/>Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics.|
|`--service-account-id`|<b>`string`</b><br/>Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster. Selected service account should have 'edit' role on the folder where the Kubernetes cluster will be located and on the folder where selected network resides.|
|`--workload-identity-federation`|<b>`shorthand/json`</b><br/><br/>Shorthand Syntax:<br/>{<br/>enabled = bool<br/>}<br/>JSON Syntax:<br/>"{<br/>"enabled": "bool"<br/>}"<br/>Fields:<br/>enabled -> (bool)<br/>Identifies whether Workload Identity Federation is enabled.|
|`--gateway-ipv4-address`|<b>`string`</b><br/>Gateway IPv4 address.|
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
