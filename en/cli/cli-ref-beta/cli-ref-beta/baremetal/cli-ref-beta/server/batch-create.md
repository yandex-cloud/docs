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
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--configuration-id`|<b>`string`</b><br/>ID of the configuration to use for the server.<br/><br/>To get the configuration ID, use a [ConfigurationService.List] request.|
|`--count`|<b>`int`</b><br/>Number of servers to create.|
|`--description`|<b>`string`</b><br/>Description of the server.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to list images in.<br/><br/>To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List] request.|
|`--hardware-pool-id`|<b>`string`</b><br/>ID of the hardware pool that the server belongs to.<br/><br/>To get the hardware pool ID, use a [HardwarePoolService.List] request.|
|`--labels`|<b>`stringToString`</b><br/>Resource labels as 'key:value' pairs.|
|`--name`|<b>`string`</b><br/>Name of the server.<br/>The name must be unique within the folder.|
|`--network-interfaces`|<b>`shorthand/json`</b><br/>Network configuration for the server. Specifies how the network interface is configured<br/>to interact with other servers on the internal network and on the internet.<br/>Currently up to 2 network interfaces are supported: required private network interface and<br/>optional public network interface.<br/><br/>Example:|
|`--network-interfaces`|<b>`[{id=value,`</b><br/>subnet={private-subnet={private-subnet-id=value}}}]<br/><br/>Shorthand Syntax:<br/>[{id=str, subnet={private-subnet={private-subnet-id=str} \| public-subnet={public-subnet-id=str}}},...]<br/>Fields:<br/>id      string                               — ID of the network interface. Should not be specified when creating a server.<br/>subnet  oneof<private-subnet\|public-subnet>  — Oneof subnet field<br/>private-subnet  struct  — Private subnet.<br/>private-subnet-id  string  — ID of the private subnet.<br/>public-subnet   struct  — Public subnet.<br/>public-subnet-id  string  — ID of the public subnet.<br/><br/>A new ephemeral public subnet will be created if not specified.<br/>|
|`--os-settings-spec`|<b>`shorthand/json`</b><br/>Operating system specific settings for provisioning the server. Optional, if omitted, the<br/>server will be created without an operating system.<br/><br/>Example:|
|`--os-settings-spec`|<b>`image-id=value,`</b><br/>password={password-lockbox-secret={key=value, secret-id=value, version-id=value}}, ssh-key={ssh-public-key=value}, storages=[{partitions=[{mount-point=value, size-gib=1, type=EXT4}], storage-type={disk={id=value, size-gib=1, type=HDD}}}]<br/><br/>Shorthand Syntax:<br/>{image-id=str, password={password-lockbox-secret={key=str, secret-id=str, version-id=str} \| password-plain-text=str}, ssh-key={ssh-public-key=str \| user-ssh-id=str}, storages=[{partitions=[{mount-point=str, size-gib=int, type=EXT4\|SWAP\|EXT3\|XFS},...], storage-type={disk={id=str, size-gib=int, type=HDD\|SSD\|NVME} \| raid={disks=[{id=str, size-gib=int, type=HDD\|SSD\|NVME},...], type=RAID0\|RAID1\|RAID10}}},...]}<br/>Fields:<br/>image-id  string                                              — ID of the image that the server was created from.<br/>storages  []struct                                            — List of storages to be created on the server. If not specified, the default value based on the<br/>selected configuration will be used as the field value.<br/>partitions    []struct          — Array of partitions created on the storage.<br/>mount-point  string                    — Storage mount point.<br/>size-gib     int                       — Size of the storage partition in gibibytes (2^30 bytes).<br/>type         enum<EXT3\|EXT4\|SWAP\|XFS>  — Partition type.<br/>storage-type  oneof<disk\|raid>  — Oneof storage-type field<br/>disk  struct  — Disk storage.<br/>id        string              — ID of the disk.<br/>size-gib  int                 — Size of the disk in gibibytes (2^30 bytes).<br/>type      enum<HDD\|NVME\|SSD>  — Type of the disk drive.<br/>raid  struct  — RAID storage.<br/>disks  []struct                  — Array of disks in the RAID configuration.<br/>id        string              — ID of the disk.<br/>size-gib  int                 — Size of the disk in gibibytes (2^30 bytes).<br/>type      enum<HDD\|NVME\|SSD>  — Type of the disk drive.<br/>type   enum<RAID0\|RAID1\|RAID10>  — RAID type.<br/>password  oneof<password-lockbox-secret\|password-plain-text>  — Oneof password field<br/>password-plain-text      string  — Raw password.<br/>password-lockbox-secret  struct  — Reference to the Lockbox secret used to obtain the password.<br/>key         string  required  — The key used to access a specific secret entry.<br/>secret-id   string  required  — The unique identifier for the lockbox secret that contains the user password.<br/>version-id  string            — The unique identifier for the lockbox version.<br/>If omitted, the current version of the secret will be used.<br/>ssh-key   oneof<ssh-public-key\|user-ssh-id>                   — Oneof ssh-key field<br/>ssh-public-key  string  — Public SSH key for the server.<br/>user-ssh-id     string  — ID of the user SSH key to use for the server.<br/><br/>To get the user SSH key ID, use a [yandex.cloud.organizationmanager.v1.UserSshKeyService.List] request.<br/>|
|`--rental-period-id`|<b>`string`</b><br/>A period of time for which the server is rented.<br/><br/>To get the rental period ID, use a [RentalPeriodService.List] request.|
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
