---
editable: false
sourcePath: en/_cli-ref/cli-ref/baremetal/cli-ref/server/create.md
---

# yc baremetal server create

Create an server

#### Command Usage

Syntax: 

`yc baremetal server create <SERVER-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>Name of the server.|
|`--description`|<b>`string`</b><br/>Specifies a textual description of the server.|
|`--hardware-pool-id`|<b>`string`</b><br/>Specifies a textual hardware pool id of the server.|
|`--rental-period-id`|<b>`string`</b><br/>Specifies a textual rental period id of the server.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'.|
|`--network-interfaces`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Adds a network interface spec to the server.<br/><br/>Possible property names:<br/><ul> <li><code>private-subnet-id</code>:     Specifies the ID of the private subnet that the interface will be part of.</li> <li><code>public-subnet-id</code>:     Specifies the ID of the public subnet that the interface will be part of.</li> <li><code>private-subnet-name</code>:     Specifies the name of the  private subnet that the interface will be part of.</li> <li><code>public-subnet-name</code>:     Specifies the name of the  public subnet that the interface will be part of.</li> </ul>|
|`--configuration-id`|<b>`string`</b><br/>Specifies a textual configuration id of the server.|
|`--configuration-name`|<b>`string`</b><br/>Specifies a textual configuration name of the server.|
|`--os-settings`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Specifies the image id of the server. Image id or image name is necessary if you want to specify a OsSettingsSpec<br/><br/>Possible property names:<br/><ul> <li><code>image-id</code>:     Specifies the image id of the server. Image id or image name is necessary if you want to specify a OsSettingsSpec</li> <li><code>image-name</code>:     Specifies the image name of the server. Image id or image name is necessary if you want to specify a OsSettingsSpec</li> <li><code>ssh-key-public</code>:     Specifies the ssh key public of the server.</li> <li><code>ssh-key-user-id</code>:     Specifies the ssh key user id of the server.</li> <li><code>password-plain-text</code>:     Specifies the password plain text of the server.</li> <li><code>password-lockbox-secret</code>:     Specifies the lockbox secret password of the server.</li> </ul>|
|`--storage`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Specifies  storages to the server.<br/><br/>Possible property names:<br/><ul> <li><code>partition</code>:     Specifies partitions of the storage</li> <li><code>disk</code>:     Specifies disks of the storage. if you want to specify the disk type, specify only 1 disk and do not specify the raid type.</li> <li><code>raid-type</code>:     Specifies the type of the storage raid type Values: 'raid0', 'raid1', 'raid10'</li> </ul>|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

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
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
