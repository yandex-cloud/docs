---
editable: false
---

# yc storage s3api

[PREVIEW] An aws s3api-like interface for accessing Object Storage

#### Command Usage

Syntax: 

`yc storage s3api <command>`

#### Command Tree

- [yc storage s3api copy-object](copy-object.md) — Creates a copy of an object that is already stored in Object Storage
- [yc storage s3api delete-object](delete-object.md) — Deletes an object from Object Storage
- [yc storage s3api delete-objects](delete-objects.md) — Deletes objects based on a list of keys passed in a request
- [yc storage s3api get-object](get-object.md) — Returns an object from Object Storage
- [yc storage s3api get-object-legal-hold](get-object-legal-hold.md) — Returns the settings of the legal hold placed on the object version
- [yc storage s3api get-object-retention](get-object-retention.md) — Returns settings of the retention put on an object version
- [yc storage s3api head-object](head-object.md) — Returns object metadata from Object Storage
- [yc storage s3api put-object](put-object.md) — Puts an object and its metadata to Object Storage
- [yc storage s3api put-object-legal-hold](put-object-legal-hold.md) — Puts or removes legal hold for an object version
- [yc storage s3api put-object-retention](put-object-retention.md) — Puts retention on the object version or enables/disables a previously set lock

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
