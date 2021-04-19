# yc compute instance create-with-container

Create a virtual machine instance running Docker container

#### Command Usage

Syntax: 

`yc compute instance create-with-container <INSTANCE-NAME> [Flags...] [Global Flags...]`

#### Global Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/> A name of the instance.|
|`--description`|<b>`string`</b><br/> Specifies a textual description of the instance. --labels key=value[,key=value...] A list of label KEY=VALUE pairs to add.|
|`--zone`|<b>`string`</b><br/> The zone of the instance to create. --metadata key=value[,key=value...] Metadata to be made available to the guest operating system running on the instance. See for details https://cloud.yandex.ru/docs/compute/concepts/vm-metadata --metadata-from-file key=value[,key=value...] Same as --metadata except that the value for the entry will be read from a local file.|
|`--ssh-key`|<b>`string`</b><br/> Creates user 'yc-user' and adds SSH key from specified file to authorized keys using cloud-config. If your need more flexibility, use cloud-config passed in 'user-data' metadata key.|
|`--public-ip`| If true, one-to-one NAT public IP will be created for the default network interface. Cannot be passed together with --network-interface|
|`--public-address`|<b>`string`</b><br/> If set, one-to-one NAT public IP will be created for the default network interface with the specified value. Cannot be passed together with --network-interface --create-disk PROPERTY=VALUE[,PROPERTY=VALUE...] Creates and attaches persistent disks to the instance.  Possible property names:  name Specifies the name of the disk.  type The type of the disk. To get a list of available disk types, run 'yc compute disk-type list'. The default disk type is network-hdd.  size The size of the disk in GB. You can also use M and T suffixes to specify smaller or greater size respectively. If not specified, inferred size is used. If the disk is created from a snapshot, disk size of the snapshot is used. If the disk is created from an image, size of the image is used.If no source is specified, default disk size is used.  block-size Specifies the block size of the disk in bytes. You can also use K and M suffixes.  snapshot-name A source snapshot used to create the disk.  snapshot-id An ID of the source snapshot used to create the disk.  image-name A source image used to create the disk.  image-id An ID of the source image used to create the disk.  image-family An image family that is used to create the disk.  image-folder-id The folder ID that is used to resolve references for image-name or image-family.  disk-placement-group-id An ID of the placement group to create the disk in  disk-placement-group-name A placement group to create the disk in  device-name Specifies a unique serial number of your choice that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance.  auto-delete Specifies if this persistent disk will be automatically deleted when the instance is deleted.   --attach-disk PROPERTY=VALUE[,PROPERTY=VALUE...] Attaches persistent disks to the instances. The specified disks must already exist.  Possible property names:  disk-name The disk to attach to the instance.  disk-id An ID of the disk to attach to the instance.  device-name Specifies a unique serial number of your choice that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance.  auto-delete Specifies if this persistent disk will be automatically deleted when the instance is deleted.   --create-boot-disk PROPERTY=VALUE[,PROPERTY=VALUE...] Creates a new disk and uses it as a boot disk of the instance.  Possible property names:  name Specifies the name of the disk.  type The type of the disk. To get a list of available disk types, run 'yc compute disk-type list'. The default disk type is network-hdd.  size The size of the disk. If not specified, inferred size is used. If the disk is created from a snapshot, disk size of the snapshot is used. If the disk is created from an image, size of the image is used.If no source is specified, default disk size is used.  device-name Specifies a unique serial number of your choice that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance.  auto-delete Specifies if this persistent disk will be automatically deleted when the instance is deleted.   --use-boot-disk PROPERTY=VALUE[,PROPERTY=VALUE...] Uses an already existing disk as a boot disk of the instance.  Possible property names:  disk-name The disk to attach to the instance.  disk-id An ID of the disk to attach to the instance.  device-name Specifies a unique serial number of your choice that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance.  auto-delete Specifies if this persistent disk will be automatically deleted when the instance is deleted.   --network-settings PROPERTY=VALUE[,PROPERTY=VALUE...] Network settings for the instance.  Possible property names:  type Type of a network for virtual machine instance. Values: standard, software-accelerated   --network-interface PROPERTY=VALUE[,PROPERTY=VALUE...] Adds a network interface to the instance.  Possible property names:  subnet-name Specifies the subnet that the interface will be part of.  subnet-id Specifies the ID of the subnet that the interface will be part of.  address Assigns the given internal address to the instance that is created. If no address is specified, some unassigned address from the subnet is used.  ipv4-address Assigns the given internal IPv4 address to the instance that is created. If 'auto' used as value, some unassigned address from the subnet is used.  nat-ip-version Specifies IP version for One-to-One NAT. Can be 'ipv4'. This flag can be applied to network interfaces with ipv4 address.  nat-address Specifies public IP address for One-to-One NAT. This flag can be applied to network interfaces with ipv4 address.  security-group-ids Security groups for the network interface, security-group-ids=[id1,id2],security-group-ids=id3  |
|`--memory`|<b>`byteSize`</b><br/> Specifies how much memory instance should have.|
|`--cores`|<b>`int`</b><br/> Specifies how many CPU cores instance should have.|
|`--core-fraction`|<b>`int`</b><br/> If provided, specifies baseline performance for a core in percent.|
|`--gpus`|<b>`int`</b><br/> Specifies how many GPUs instance should have.|
|`--platform`|<b>`string`</b><br/> Specifies platform for the instance.|
|`--hostname`|<b>`string`</b><br/> Creates instance with specified hostname.|
|`--preemptible`| Creates preemptible instance.|
|`--placement-group-id`|<b>`string`</b><br/> Placement group to create the instance in.|
|`--placement-group-name`|<b>`string`</b><br/> Placement group to create the instance in.|
|`--host-group-id`|<b>`string`</b><br/> Host group to create the instance in.|
|`--host-group-name`|<b>`string`</b><br/> Host group to create the instance in.|
|`--host-id`|<b>`string`</b><br/> Host to create the instance in.|
|`--service-account-id`|<b>`string`</b><br/> Service account, which token can be obtained inside VM from metadata service.|
|`--service-account-name`|<b>`string`</b><br/> Service account, which token can be obtained inside VM from metadata service.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete. --container-arg value[,value] A list of arguments to append to container entrypoint. Overrides default container CMD|
|`--container-command`|<b>`string`</b><br/> Executable to run when the container starts. Overrides default container ENTRYPOINT --container-env key=value[,key=value...] Declare environment variable KEY with value VALUE passed to container. Only the last value of KEY is taken when KEY is repeated more than once. Values, declared with --container-env flag override those with the same KEY from file, provided in --container-env-file.|
|`--container-env-file`|<b>`string`</b><br/> Declare environment variables in a file. Values, declared with --container-env flag override those with the same KEY from file. File must contain lines in format KEY=VALUE, variables without value are not supported.|
|`--container-image`|<b>`string`</b><br/> Container image name.|
|`--container-name`|<b>`string`</b><br/> Container name.|
|`--container-privileged`| Specify whether to run container in privileged mode.|
|`--container-stdin`| Open container STDIN.|
|`--container-tty`| Allocate a pseudo-TTY for the container.|
|`--container-restart-policy`|<b>`string`</b><br/> Specify whether to restart a container on exit. Must be one of: Always, Never, OnFailure. Default: Always. --container-volume-tmpfs PROPERTY=VALUE[,PROPERTY=VALUE...] Add tmpfs-backed docker volume  Possible property names:  name Specifies the name of the volume. (required)  mount-path Specifies the mount path of the volume inside a container. (required)   --container-volume-host-path PROPERTY=VALUE[,PROPERTY=VALUE...] Add docker volume bound to host path  Possible property names:  name Specifies the name of the volume. (required)  mount-path Specifies the mount path of the volume inside a container. (required)  ro Specifies whether the volume is read-only or not inside a container. Default: false  host-path Specifies a path on host VM that will be bound to the volume. (required)  |
|`--docker-compose-file`|<b>`string`</b><br/> Docker compose file.|
|`--coi-spec-file`|<b>`string`</b><br/> Container optimized image YAML file.|

#### Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts. Pass 0 to disable retries. Pass any negative value for infinite retries. Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
