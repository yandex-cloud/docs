---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/baremetal/cli-ref-beta/server/batch-create.md
---

# yc beta baremetal server batch-create

Creates multiple servers in the specified folder.

#### Command Usage

Syntax: 

`yc beta baremetal server batch-create <CONFIGURATION-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--configuration-id`|<b>`string`</b><br/>ID of the configuration to use for the server. To get the configuration ID, use a [ConfigurationService.List] request.|
|`--count`|<b>`int`</b><br/>Number of servers to create.|
|`--description`|<b>`string`</b><br/>Description of the server.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to list images in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List] request.|
|`--hardware-pool-id`|<b>`string`</b><br/>ID of the hardware pool that the server belongs to. To get the hardware pool ID, use a [HardwarePoolService.List] request.|
|`--labels`|<b>`stringToString`</b><br/>Resource labels as 'key:value' pairs.|
|`--name`|<b>`string`</b><br/>Name of the server. The name must be unique within the folder.|
|`--network-interfaces`|<b>`shorthand/json`</b><br/>Network configuration for the server. Specifies how the network interface is configured to interact with other servers on the internal network and on the internet. Currently up to 2 network interfaces are supported: required private network interface and optional public network interface.<br/>Shorthand Syntax:<br/>[<br/>{<br/>id = str,<br/>subnet = private-subnet={<br/>private-subnet-id = str<br/>} \| public-subnet={<br/>public-subnet-id = str<br/>}<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"id": "str",<br/>"subnet": {<br/>"private-subnet": {<br/>"private-subnet-id": "str"<br/>},<br/>"public-subnet": {<br/>"public-subnet-id": "str"<br/>}<br/>}<br/>}, ...<br/>]"<br/>Fields:<br/>id -> (string)<br/>ID of the network interface. Should not be specified when creating a server.<br/>subnet -> (oneof<private-subnet\|public-subnet>)<br/>Oneof subnet field<br/>private-subnet -> (struct)<br/>Private subnet.<br/>private-subnet-id -> (string)<br/>ID of the private subnet.<br/>public-subnet -> (struct)<br/>Public subnet.<br/>public-subnet-id -> (string)<br/>ID of the public subnet. A new ephemeral public subnet will be created if not specified.|
|`--os-settings-spec`|<b>`shorthand/json`</b><br/>Operating system specific settings for provisioning the server. Optional, if omitted, the server will be created without an operating system.<br/>Shorthand Syntax:<br/>{<br/>image-id = str,<br/>password = password-lockbox-secret={<br/>key = str,<br/>secret-id = str,<br/>version-id = str<br/>} \| password-plain-text=str,<br/>ssh-key = ssh-public-key=str \| user-ssh-id=str,<br/>storages = [<br/>{<br/>partitions = [<br/>{<br/>mount-point = str,<br/>size-gib = int,<br/>type = EXT4\|SWAP\|EXT3\|XFS<br/>}, ...<br/>],<br/>storage-type = disk={<br/>id = str,<br/>size-gib = int,<br/>type = HDD\|SSD\|NVME<br/>} \| raid={<br/>disks = [<br/>{<br/>id = str,<br/>size-gib = int,<br/>type = HDD\|SSD\|NVME<br/>}, ...<br/>],<br/>type = RAID0\|RAID1\|RAID10<br/>}<br/>}, ...<br/>]<br/>}<br/>JSON Syntax:<br/>"{<br/>"image-id": "str",<br/>"password": {<br/>"password-lockbox-secret": {<br/>"key": "str",<br/>"secret-id": "str",<br/>"version-id": "str"<br/>},<br/>"password-plain-text": "str"<br/>},<br/>"ssh-key": {<br/>"ssh-public-key": "str",<br/>"user-ssh-id": "str"<br/>},<br/>"storages": [<br/>{<br/>"partitions": [<br/>{<br/>"mount-point": "str",<br/>"size-gib": "int",<br/>"type": "EXT4\|SWAP\|EXT3\|XFS"<br/>}, ...<br/>],<br/>"storage-type": {<br/>"disk": {<br/>"id": "str",<br/>"size-gib": "int",<br/>"type": "HDD\|SSD\|NVME"<br/>},<br/>"raid": {<br/>"disks": [<br/>{<br/>"id": "str",<br/>"size-gib": "int",<br/>"type": "HDD\|SSD\|NVME"<br/>}, ...<br/>],<br/>"type": "RAID0\|RAID1\|RAID10"<br/>}<br/>}<br/>}, ...<br/>]<br/>}"<br/>Fields:<br/>image-id -> (string)<br/>ID of the image that the server was created from.<br/>storages -> ([]struct)<br/>List of storages to be created on the server. If not specified, the default value based on the selected configuration will be used as the field value.<br/>partitions -> ([]struct)<br/>Array of partitions created on the storage.<br/>mount-point -> (string)<br/>Storage mount point.<br/>size-gib -> (int)<br/>Size of the storage partition in gibibytes (2^30 bytes).<br/>type -> (enum<EXT3\|EXT4\|SWAP\|XFS>)<br/>Partition type.<br/>storage-type -> (oneof<disk\|raid>)<br/>Oneof storage-type field<br/>disk -> (struct)<br/>Disk storage.<br/>id -> (string)<br/>ID of the disk.<br/>size-gib -> (int)<br/>Size of the disk in gibibytes (2^30 bytes).<br/>type -> (enum<HDD\|NVME\|SSD>)<br/>Type of the disk drive.<br/>raid -> (struct)<br/>RAID storage.<br/>disks -> ([]struct)<br/>Array of disks in the RAID configuration.<br/>id -> (string)<br/>ID of the disk.<br/>size-gib -> (int)<br/>Size of the disk in gibibytes (2^30 bytes).<br/>type -> (enum<HDD\|NVME\|SSD>)<br/>Type of the disk drive.<br/>type -> (enum<RAID0\|RAID1\|RAID10>)<br/>RAID type.<br/>password -> (oneof<password-lockbox-secret\|password-plain-text>)<br/>Oneof password field<br/>password-plain-text -> (string)<br/>Raw password.<br/>password-lockbox-secret -> (struct)<br/>Reference to the Lockbox secret used to obtain the password.<br/>key -> (string)<br/>The key used to access a specific secret entry.<br/>secret-id -> (string)<br/>The unique identifier for the lockbox secret that contains the user password.<br/>version-id -> (string)<br/>The unique identifier for the lockbox version. If omitted, the current version of the secret will be used.<br/>ssh-key -> (oneof<ssh-public-key\|user-ssh-id>)<br/>Oneof ssh-key field<br/>ssh-public-key -> (string)<br/>Public SSH key for the server.<br/>user-ssh-id -> (string)<br/>ID of the user SSH key to use for the server. To get the user SSH key ID, use a [yandex.cloud.organizationmanager.v1.UserSshKeyService.List] request.|
|`--rental-period-id`|<b>`string`</b><br/>A period of time for which the server is rented. To get the rental period ID, use a [RentalPeriodService.List] request.|
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
