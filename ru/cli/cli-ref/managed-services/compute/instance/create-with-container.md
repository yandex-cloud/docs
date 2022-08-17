---
sourcePath: en/_cli-ref/cli-ref/managed-services/compute/instance/create-with-container.md
---
# yc compute instance create-with-container

Create a virtual machine instance running Docker container

#### Command Usage

Syntax: 

`yc compute instance create-with-container <INSTANCE-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>A name of the instance.|
|`--description`|<b>`string`</b><br/>Specifies a textual description of the instance.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'.|
|`--zone`|<b>`string`</b><br/>The zone of the instance to create.|
|`--metadata`|<b>`key=value[,key=value...]`</b><br/>Metadata to be made available to the guest operating system running on the instance.<br/>See for details https://cloud.yandex.ru/docs/compute/concepts/vm-metadata|
|`--metadata-from-file`|<b>`key=value[,key=value...]`</b><br/>Same as --metadata except that the value for the entry will be read from a local file.|
|`--ssh-key`|<b>`string`</b><br/>Creates user 'yc-user' and adds SSH key from specified file to authorized keys using cloud-config.<br/>If your need more flexibility, use cloud-config passed in 'user-data' metadata key.|
|`--public-ip`|If true, one-to-one NAT public IP will be created for the default network interface. Cannot be passed together with --network-interface|
|`--public-address`|<b>`string`</b><br/>If set, one-to-one NAT public IP will be created for the default network interface with the specified value. Cannot be passed together with --network-interface|
|`--create-disk`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Creates and attaches persistent disks to the instance.<br/><br/>Possible property names:<br/><ul> <li><code>name</code>:     Specifies the name of the disk.</li> <li><code>type</code>:     The type of the disk. To get a list of available disk types, run 'yc compute disk-type list'. The default disk type is network-hdd.</li> <li><code>size</code>:     The size of the disk in GB. You can also use M and T suffixes to specify smaller or greater size respectively. If not specified, inferred size is used. If the disk is created from a snapshot, disk size of the snapshot is used. If the disk is created from an image, size of the image is used.If no source is specified, default disk size is used.</li> <li><code>block-size</code>:     Specifies the block size of the disk in bytes. You can also use K and M suffixes.</li> <li><code>snapshot-name</code>:     A source snapshot used to create the disk.</li> <li><code>snapshot-id</code>:     An ID of the source snapshot used to create the disk.</li> <li><code>image-name</code>:     A source image used to create the disk.</li> <li><code>image-id</code>:     An ID of the source image used to create the disk.</li> <li><code>image-family</code>:     An image family that is used to create the disk.</li> <li><code>image-folder-id</code>:     The folder ID that is used to resolve references for image-name or image-family.</li> <li><code>disk-placement-group-id</code>:     An ID of the placement group to create the disk in</li> <li><code>disk-placement-group-name</code>:     A placement group to create the disk in</li> <li><code>device-name</code>:     Specifies a unique serial number of your choice that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance.</li> <li><code>auto-delete</code>:     Specifies if this persistent disk will be automatically deleted when the instance is deleted.</li> </ul>|
|`--attach-disk`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Attaches persistent disks to the instances. The specified disks must already exist.<br/><br/>Possible property names:<br/><ul> <li><code>disk-name</code>:     The disk to attach to the instance.</li> <li><code>disk-id</code>:     An ID of the disk to attach to the instance.</li> <li><code>device-name</code>:     Specifies a unique serial number of your choice that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance.</li> <li><code>auto-delete</code>:     Specifies if this persistent disk will be automatically deleted when the instance is deleted.</li> </ul>|
|`--create-boot-disk`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Creates a new disk and uses it as a boot disk of the instance.<br/><br/>Possible property names:<br/><ul> <li><code>name</code>:     Specifies the name of the disk.</li> <li><code>type</code>:     The type of the disk. To get a list of available disk types, run 'yc compute disk-type list'. The default disk type is network-hdd.</li> <li><code>size</code>:     The size of the disk. If not specified, inferred size is used. If the disk is created from a snapshot, disk size of the snapshot is used. If the disk is created from an image, size of the image is used.If no source is specified, default disk size is used.</li> <li><code>device-name</code>:     Specifies a unique serial number of your choice that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance.</li> <li><code>auto-delete</code>:     Specifies if this persistent disk will be automatically deleted when the instance is deleted.</li> </ul>|
|`--use-boot-disk`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Uses an already existing disk as a boot disk of the instance.<br/><br/>Possible property names:<br/><ul> <li><code>disk-name</code>:     The disk to attach to the instance.</li> <li><code>disk-id</code>:     An ID of the disk to attach to the instance.</li> <li><code>device-name</code>:     Specifies a unique serial number of your choice that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance.</li> <li><code>auto-delete</code>:     Specifies if this persistent disk will be automatically deleted when the instance is deleted.</li> </ul>|
|`--attach-filesystem`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Attaches filesystems to the instances. The specified filesystems must already exist.<br/><br/>Possible property names:<br/><ul> <li><code>device-name</code>:     This value can be used to reference the device for mounting, resizing, and so on, from within the instance.</li> <li><code>filesystem-name</code>:     The filesystem to attach to the instance.</li> <li><code>filesystem-id</code>:     An ID of the filesystem to attach to the instance.</li> </ul>|
|`--attach-local-disk`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Attaches local disks to the instances.<br/><br/>Possible property names:<br/><ul> <li><code>size</code>:     The size of the local disk in bytes. You can also use M and T suffixes to specify MiB or TiB respectively.</li> </ul>|
|`--network-settings`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Network settings for the instance.<br/><br/>Possible property names:<br/><ul> <li><code>type</code>:     Type of a network for virtual machine instance. Values: standard, software-accelerated</li> </ul>|
|`--network-interface`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Adds a network interface to the instance.<br/><br/>Possible property names:<br/><ul> <li><code>subnet-name</code>:     Specifies the subnet that the interface will be part of.</li> <li><code>subnet-id</code>:     Specifies the ID of the subnet that the interface will be part of.</li> <li><code>address</code>:     Assigns the given internal address to the instance that is created. If no address is specified, some unassigned address from the subnet is used.</li> <li><code>ipv4-address</code>:     Assigns the given internal IPv4 address to the instance that is created. If 'auto' used as value, some unassigned address from the subnet is used.</li> <li><code>nat-ip-version</code>:     Specifies IP version for One-to-One NAT. Can be 'ipv4'. This flag can be applied to network interfaces with ipv4 address.</li> <li><code>nat-address</code>:     Specifies public IP address for One-to-One NAT. This flag can be applied to network interfaces with ipv4 address.</li> <li><code>security-group-ids</code>:     Security groups for the network interface, security-group-ids=[id1,id2],security-group-ids=id3</li> <li><code>dns-record-spec</code>:     DNS records in format {name=&lt;name&gt;[,ttl=&lt;ttl&gt;][,dns-zone-id=&lt;id&gt;][,ptr={true\|false}]}</li> </ul>|
|`--memory`|<b>`byteSize`</b><br/>Specifies how much memory instance should have.|
|`--cores`|<b>`int`</b><br/>Specifies how many CPU cores instance should have.|
|`--core-fraction`|<b>`int`</b><br/>If provided, specifies baseline performance for a core in percent.|
|`--gpus`|<b>`int`</b><br/>Specifies how many GPUs instance should have.|
|`--platform`|<b>`string`</b><br/>Specifies platform for the instance.|
|`--hostname`|<b>`string`</b><br/>Creates instance with specified hostname.|
|`--preemptible`|Creates preemptible instance.|
|`--placement-group-id`|<b>`string`</b><br/>Placement group to create the instance in.|
|`--placement-group-name`|<b>`string`</b><br/>Placement group to create the instance in.|
|`--host-group-id`|<b>`string`</b><br/>Host group to create the instance in.|
|`--host-group-name`|<b>`string`</b><br/>Host group to create the instance in.|
|`--host-id`|<b>`string`</b><br/>Host to create the instance in.|
|`--service-account-id`|<b>`string`</b><br/>Service account, which token can be obtained inside VM from metadata service.|
|`--service-account-name`|<b>`string`</b><br/>Service account, which token can be obtained inside VM from metadata service.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--container-arg`|<b>`value[,value]`</b><br/>A list of arguments to append to container entrypoint. Overrides default container CMD|
|`--container-command`|<b>`string`</b><br/>Executable to run when the container starts. Overrides default container ENTRYPOINT|
|`--container-env`|<b>`key=value[,key=value...]`</b><br/>Declare environment variable KEY with value VALUE passed to container. Only the last value of KEY is taken when KEY is repeated more than once.<br/>Values, declared with --container-env flag override those with the same KEY from file, provided in --container-env-file.|
|`--container-env-file`|<b>`string`</b><br/>Declare environment variables in a file. Values, declared with --container-env flag override those with the same KEY from file.<br/>File must contain lines in format KEY=VALUE, variables without value are not supported.|
|`--container-image`|<b>`string`</b><br/>Container image name.|
|`--container-name`|<b>`string`</b><br/>Container name.|
|`--container-privileged`|Specify whether to run container in privileged mode.|
|`--container-stdin`|Open container STDIN.|
|`--container-tty`|Allocate a pseudo-TTY for the container.|
|`--container-restart-policy`|<b>`string`</b><br/>Specify whether to restart a container on exit. Must be one of: Always, Never, OnFailure. Default: Always.|
|`--container-volume-tmpfs`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Add tmpfs-backed docker volume<br/><br/>Possible property names:<br/><ul> <li><code>name</code>:     Specifies the name of the volume. (required)</li> <li><code>mount-path</code>:     Specifies the mount path of the volume inside a container. (required)</li> </ul>|
|`--container-volume-host-path`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Add docker volume bound to host path<br/><br/>Possible property names:<br/><ul> <li><code>name</code>:     Specifies the name of the volume. (required)</li> <li><code>mount-path</code>:     Specifies the mount path of the volume inside a container. (required)</li> <li><code>ro</code>:     Specifies whether the volume is read-only or not inside a container. Default: false</li> <li><code>host-path</code>:     Specifies a path on host VM that will be bound to the volume. (required)</li> </ul>|
|`--docker-compose-file`|<b>`string`</b><br/>Docker compose file.|
|`--coi-spec-file`|<b>`string`</b><br/>Container optimized image YAML file.|

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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
