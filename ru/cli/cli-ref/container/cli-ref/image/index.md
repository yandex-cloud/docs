---
editable: false
sourcePath: en/_cli-ref/cli-ref/container/cli-ref/image/index.md
---

# yc container image

Manage Docker images.

#### Command Usage

Syntax: 

`yc container image <command>`

Aliases: 

- `images`
- `img`

#### Command Tree

- [yc container image delete](delete.md) — Delete a Docker image.
- [yc container image get](get.md) — Get information about a Docker image.
- [yc container image get-last-scan-result](get-last-scan-result.md) — [PREVIEW] Get recent scan result of Docker image.
- [yc container image get-scan-result](get-scan-result.md) — [PREVIEW] Get scan result.
- [yc container image list](list.md) — List Docker images.
- [yc container image list-scan-results](list-scan-results.md) — [PREVIEW] List scan results of Docker image.
- [yc container image list-vulnerabilities](list-vulnerabilities.md) — [PREVIEW] List vulnerabilities found during scan.
- [yc container image scan](scan.md) — [PREVIEW] Start scan of Docker image for vulnerabilities.

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
