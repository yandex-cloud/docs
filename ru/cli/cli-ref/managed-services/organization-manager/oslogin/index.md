---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/organization-manager/oslogin/index.md
---

# yc organization-manager oslogin

Setting up OS Login

#### Command Usage

Syntax: 

`yc organization-manager oslogin <group|command>`

Aliases: 

- `os-login`

#### Command Tree

- [yc organization-manager oslogin get-settings](get-settings.md) — Show information about OS Login settings for the specified organization.
- [yc organization-manager oslogin update-settings](update-settings.md) — Update OS Login settings for the specified organization.
- [yc organization-manager oslogin user-ssh-key](user-ssh-key/index.md) — Manage SSH keys
	- [yc organization-manager oslogin user-ssh-key get](user-ssh-key/get.md) — Show information about the specified SSH key
	- [yc organization-manager oslogin user-ssh-key create](user-ssh-key/create.md) — Create a user SSH key
	- [yc organization-manager oslogin user-ssh-key update](user-ssh-key/update.md) — Update the specified SSH key
	- [yc organization-manager oslogin user-ssh-key list](user-ssh-key/list.md) — List SSH keys
	- [yc organization-manager oslogin user-ssh-key delete](user-ssh-key/delete.md) — Delete the specified SSH key
- [yc organization-manager oslogin profile](profile/index.md) — Manage OS Login profiles
	- [yc organization-manager oslogin profile get](profile/get.md) — Show information about the specified OS Login profile
	- [yc organization-manager oslogin profile create](profile/create.md) — Create an OS Login profile
	- [yc organization-manager oslogin profile update](profile/update.md) — Update the specified OS Login profile
	- [yc organization-manager oslogin profile list](profile/list.md) — List OS Login profiles
	- [yc organization-manager oslogin profile delete](profile/delete.md) — Delete the specified OS Login profile
	- [yc organization-manager oslogin profile set-default](profile/set-default.md) — Set default OS Login profile

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
