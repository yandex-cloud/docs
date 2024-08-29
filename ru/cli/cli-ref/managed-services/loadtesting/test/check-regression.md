---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/loadtesting/test/check-regression.md
---

# yc loadtesting test check-regression

Checks for regressions for the specified test. The regression conditions (metric thresholds) should be configured on regression dashboards in the same folder.

#### Command Usage

Syntax: 

`yc loadtesting test check-regression <TEST-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Load testing test id.|
|`-e`,`--error-mode`|Set a non-0 exit status of a command if a given test didn't pass regression checks, or no checks were performed.|
|`--dashboard-id`|<b>`string`</b><br/>ID of a regression dashboard to be checked.|
|`--dashboard`|<b>`string`</b><br/>Name of a regression dashboard to be checked.|
|`--chart-id`|<b>`string`</b><br/>ID of a regression chart to be checked.|
|`--chart`|<b>`string`</b><br/>Name of a regression chart to be checked.|

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
