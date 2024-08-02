---
editable: false
---

# yc loadtesting agent create

Create a load testing agent

#### Command Usage

Syntax: 

`yc loadtesting agent create <AGENT-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>A name of the load testing agent.|
|`--description`|<b>`string`</b><br/>A description of the load testing agent.|
|`--agent-version`|<b>`string`</b><br/>A version of load testing agent to deploy.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'.|
|`--zone`|<b>`string`</b><br/>The zone of the instance to create.|
|`--platform-id`|<b>`string`</b><br/>The Compute platform of virtual machine.|
|`--metadata`|<b>`key=value[,key=value...]`</b><br/>Metadata to be made available to the guest operating system running on the instance.<br/>See for details https://yandex.cloud/ru/docs/compute/concepts/vm-metadata|
|`--metadata-from-file`|<b>`key=value[,key=value...]`</b><br/>Same as --metadata except that the value for the entry will be read from a local file.|
|`--boot-disk`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Specification of a new disk that will be used as a boot disk of the instance.<br/><br/>Possible property names:<br/><ul> <li><code>name</code>:     Specifies the name of the disk.</li> <li><code>device-name</code>:     Specifies a unique serial number of your choice that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the agent comput instance.</li> <li><code>auto-delete</code>:     Specifies if this persistent disk will be automatically deleted when the agent is deleted.</li> <li><code>type</code>:     The type of the disk. To get a list of available disk types, run 'yc compute disk-type list'. The default disk type is network-hdd.</li> <li><code>size</code>:     The size of the disk in GB. You can also use M and T suffixes to specify smaller or greater size respectively. If not specified, default disk size 15GB is used.</li> <li><code>block-size</code>:     Specifies the block size of the disk in bytes. You can also use K and M suffixes.</li> <li><code>disk-placement-group-id</code>:     An ID of the placement group to create the disk in</li> <li><code>disk-placement-group-name</code>:     A placement group to create the disk in</li> <li><code>disk-placement-group-partition</code>:     A placement group partition to create the disk in. Used when a placement group is created with the partition strategy.</li> </ul>|
|`--network-interface`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Adds a network interface to the instance.<br/><br/>Possible property names:<br/><ul> <li><code>subnet-name</code>:     Specifies the subnet that the interface will be part of.</li> <li><code>subnet-id</code>:     Specifies the ID of the subnet that the interface will be part of.</li> <li><code>ipv4-address</code>:     Assigns the given internal IPv4 address to the instance that is created. If 'auto' used as value, some unassigned address from the subnet is used.</li> <li><code>nat-ip-version</code>:     Specifies IP version for One-to-One NAT. Can be 'ipv4'. This flag can be applied to network interfaces with ipv4 address.</li> <li><code>nat-address</code>:     Specifies public IP address for One-to-One NAT. This flag can be applied to network interfaces with ipv4 address.</li> <li><code>security-group-ids</code>:     Security groups for the network interface, security-group-ids=[id1,id2],security-group-ids=id3</li> <li><code>dns-record-spec</code>:     DNS records in format {name=&lt;name&gt;[,ttl=&lt;ttl&gt;][,dns-zone-id=&lt;id&gt;][,ptr={true\|false}]}</li> </ul>|
|`--memory`|<b>`byteSize`</b><br/>Specifies how much memory instance should have.|
|`--cores`|<b>`int`</b><br/>Specifies how many CPU cores instance should have.|
|`--core-fraction`|<b>`int`</b><br/>If provided, specifies baseline performance for a core in percent.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--wait-ready`|Wait until an agent connects to the service|
|`--wait-ready-timeout`|<b>`duration`</b><br/>The timeout to interrupt the command if an agent cannot connect to the service within specified period.|
|`--service-account-id`|<b>`string`</b><br/>Service account ID, which token can be obtained inside VM from metadata service.|
|`--service-account-name`|<b>`string`</b><br/>Service account name, which token can be obtained inside VM from metadata service.|

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
