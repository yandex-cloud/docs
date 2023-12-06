---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/compute/instance/relocate.md
---

# yc compute instance relocate

Relocate the specified virtual machine instance to the zone

#### Command Usage

Syntax: 

`yc compute instance relocate <INSTANCE-NAME>|<INSTANCE-ID> [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Instance id.|
|`--name`|<b>`string`</b><br/>Instance name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--destination-zone-id`|<b>`string`</b><br/>The zone to relocate to.|
|`--network-interface`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Reconfigure network interface of the instance.<br/><br/>Possible property names:<br/><ul> <li><code>subnet-name</code>:     Specifies the subnet that the interface will be part of.</li> <li><code>subnet-id</code>:     Specifies the ID of the subnet that the interface will be part of.</li> <li><code>address</code>:     Assigns the given internal address to the instance that is created. If no address is specified, some unassigned address from the subnet is used.</li> <li><code>ipv4-address</code>:     Assigns the given internal IPv4 address to the instance that is created. If 'auto' used as value, some unassigned address from the subnet is used.</li> <li><code>nat-ip-version</code>:     Specifies IP version for One-to-One NAT. Can be 'ipv4'. This flag can be applied to network interfaces with ipv4 address.</li> <li><code>nat-address</code>:     Specifies public IP address for One-to-One NAT. This flag can be applied to network interfaces with ipv4 address.</li> <li><code>security-group-ids</code>:     Security groups for the network interface, security-group-ids=[id1,id2],security-group-ids=id3</li> <li><code>dns-record-spec</code>:     DNS records in format {name=&lt;name&gt;[,ttl=&lt;ttl&gt;][,dns-zone-id=&lt;id&gt;][,ptr={true\|false}]}</li> </ul>|
|`--boot-disk-placement-group-id`|<b>`string`</b><br/>Placement group to move boot disk to.|
|`--boot-disk-placement-group-name`|<b>`string`</b><br/>Placement group to move boot disk to.|
|`--boot-disk-placement-group-partition`|<b>`int`</b><br/>Placement group partition. Used when a placement group is created with the partition strategy.|
|`--secondary-disk-placement`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Target placement policies for secondary disks.<br/><br/>Possible property names:<br/><ul> <li><code>disk-name</code>:     The disk which placement policy is to be changes.</li> <li><code>disk-id</code>:     An ID of the disk which placement policy is to be changes.</li> <li><code>disk-placement-group-id</code>:     Placement group to move the disk to.</li> <li><code>disk-placement-group-name</code>:     Placement group to move the disk to.</li> <li><code>disk-placement-group-partition</code>:     Placement group partition. Used when a placement group is created with the partition strategy.</li> </ul>|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
