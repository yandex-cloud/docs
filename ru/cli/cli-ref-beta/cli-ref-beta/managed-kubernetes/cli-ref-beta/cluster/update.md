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
|`--cluster-id`|<b>`string`</b><br/>ID of the Kubernetes cluster to update.<br/>To get the Kubernetes cluster ID use a [ClusterService.List] request.|
|`--description`|<b>`string`</b><br/>Description of the Kubernetes cluster.|
|`--ip-allocation-policy`|<b>`shorthand/json`</b><br/><br/><br/>Example:|
|`--ip-allocation-policy`|<b>`cluster-ipv4-cidr-block=value,`</b><br/>cluster-ipv6-cidr-block=value, node-ipv4-cidr-mask-size=1, service-ipv4-cidr-block=value, service-ipv6-cidr-block=value<br/><br/>Shorthand Syntax:<br/>{cluster-ipv4-cidr-block=str, cluster-ipv6-cidr-block=str, node-ipv4-cidr-mask-size=int, service-ipv4-cidr-block=str, service-ipv6-cidr-block=str}<br/>Fields:<br/>cluster-ipv4-cidr-block   string  — CIDR block. IP range for allocating pod addresses.<br/><br/>It should not overlap with any subnet in the network the Kubernetes cluster located in. Static routes will be<br/>set up for this CIDR blocks in node subnets.<br/>cluster-ipv6-cidr-block   string  — IPv6 range for allocating pod IP addresses.<br/>node-ipv4-cidr-mask-size  int     — Size of the masks that are assigned for each node in the cluster.<br/><br/>If not specified, 24 is used.<br/>service-ipv4-cidr-block   string  — CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from.<br/><br/>It should not overlap with any subnet in the network the Kubernetes cluster located in.<br/>service-ipv6-cidr-block   string  — IPv6 range for allocating Kubernetes service IP addresses<br/>|
|`--labels`|<b>`stringToString`</b><br/>Resource labels as 'key:value' pairs.<br/><br/>Existing set of 'labels' is completely replaced by the provided set.|
|`--master-spec`|<b>`shorthand/json`</b><br/>Specification of the master update.<br/><br/>Example:|
|`--master-spec`|<b>`external-v6-address-spec={address=value},`</b><br/>locations=[{subnet-id=value, zone-id=value}], maintenance-policy={auto-upgrade=true, maintenance-window={policy={anytime={}}}}, master-logging={audit-enabled=true, cluster-autoscaler-enabled=true, destination={folder-id=value}, enabled=true, events-enabled=true, kube-apiserver-enabled=true}, scale-policy={scale-type={auto-scale={min-resource-preset-id=value}}}, security-group-ids=value, version={specifier={latest-revision=true}}<br/><br/>Shorthand Syntax:<br/>{external-v6-address-spec={address=str}, locations=[{subnet-id=str, zone-id=str},...], maintenance-policy={auto-upgrade=bool, maintenance-window={policy={anytime={} \| daily-maintenance-window={duration=duration, start-time=timeofday} \| weekly-maintenance-window={days-of-week=[{days=MONDAY\|TUESDAY\|WEDNESDAY\|THURSDAY\|FRIDAY\|SATURDAY\|SUNDAY,..., duration=duration, start-time=timeofday},...]}}}}, master-logging={audit-enabled=bool, cluster-autoscaler-enabled=bool, destination={folder-id=str \| log-group-id=str}, enabled=bool, events-enabled=bool, kube-apiserver-enabled=bool}, scale-policy={scale-type={auto-scale={min-resource-preset-id=str}}}, security-group-ids=str,..., version={specifier={latest-revision=bool \| version=str}}}<br/>Fields:<br/>external-v6-address-spec  struct    — Specification of parameters for external IPv6 networking.<br/>address  string  — IP address.<br/>locations                 []struct  — Update master instance locations.<br/>subnet-id  string            — ID of the VPC network's subnet where the master resides.<br/>If not specified and there is a single subnet in specified zone, address in this subnet will be allocated.<br/>zone-id    string  required  — ID of the availability zone where the master resides.<br/>maintenance-policy        struct    — Maintenance policy of the master.<br/>auto-upgrade        bool    — If set to true, automatic updates are installed in the specified period of time with no interaction from the user.<br/>If set to false, automatic upgrades are disabled.<br/>maintenance-window  struct  — Maintenance window settings. Update will start at the specified time and last no more than the specified duration.<br/>The time is set in UTC.<br/>policy  oneof<anytime\|daily-maintenance-window\|weekly-maintenance-window>  — Oneof policy field<br/>anytime                    struct  — Updating the master at any time.<br/>daily-maintenance-window   struct  — Updating the master on any day during the specified time window.<br/>duration    duration             — Window duration.<br/>start-time  timeofday  required  — Window start time, in the UTC timezone.<br/>weekly-maintenance-window  struct  — Updating the master on selected days during the specified time window.<br/>days-of-week  []struct  — Days of the week and the maintenance window for these days when automatic updates are allowed.<br/>days        []int                — Days of the week when automatic updates are allowed.<br/>duration    duration             — Window duration.<br/>start-time  timeofday  required  — Window start time, in the UTC timezone.<br/>master-logging            struct    — Cloud Logging for master components.<br/>audit-enabled               bool                           — Identifies whether Cloud Logging is enabled for audit logs.<br/>cluster-autoscaler-enabled  bool                           — Identifies whether Cloud Logging is enabled for cluster-autoscaler.<br/>enabled                     bool                           — Identifies whether Cloud Logging is enabled for master components.<br/>events-enabled              bool                           — Identifies whether Cloud Logging is enabled for events.<br/>kube-apiserver-enabled      bool                           — Identifies whether Cloud Logging is enabled for kube-apiserver.<br/>destination                 oneof<folder-id\|log-group-id>  — Oneof destination field<br/>log-group-id  string  — ID of the log group where logs of master components should be stored.<br/>folder-id     string  — ID of the folder where logs should be stored (in default group).<br/>scale-policy              struct    — Scale policy of the master.<br/>scale-type  oneof\<auto-scale\>  — Oneof scale-type field<br/>auto-scale  struct  —<br/>min-resource-preset-id  string  required  — Preset of computing resources to be used as lower boundary for scaling.<br/>security-group-ids        []string  — Master security groups.<br/>version                   struct    — Specification of the master update.<br/>specifier  oneof<latest-revision\|version>  — Oneof specifier field<br/>version          string  — Request update to a newer version of Kubernetes (1.x -> 1.y).<br/>latest-revision  bool    — Request update to the latest revision for the current version.<br/>|
|`--name`|<b>`string`</b><br/>Name of the Kubernetes cluster.<br/>The name must be unique within the folder.|
|`--network-policy`|<b>`shorthand/json`</b><br/><br/><br/>Example:<br/>--network-policy provider=CALICO<br/><br/>Shorthand Syntax:<br/>{provider=CALICO}<br/>Fields:<br/>provider  enum\<CALICO\>  —<br/>|
|`--node-service-account-id`|<b>`string`</b><br/>Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry<br/>or to push node logs and metrics.|
|`--service-account-id`|<b>`string`</b><br/>Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster.<br/>Selected service account should have 'edit' role on the folder where the Kubernetes cluster will be<br/>located and on the folder where selected network resides.|
|`--workload-identity-federation`|<b>`shorthand/json`</b><br/><br/><br/>Example:<br/>--workload-identity-federation enabled=true<br/><br/>Shorthand Syntax:<br/>{enabled=bool}<br/>Fields:<br/>enabled  bool  — Identifies whether Workload Identity Federation is enabled.<br/>|
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
