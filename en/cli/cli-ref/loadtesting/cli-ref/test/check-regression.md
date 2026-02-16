---
editable: false
sourcePath: en/_cli-ref/cli-ref/loadtesting/cli-ref/test/check-regression.md
---

# yc loadtesting test check-regression

Checks for regressions for the specified test.
The regression conditions (metric thresholds) should be configured on regression dashboards in the same folder.

#### Command Usage

Syntax:

`yc loadtesting test check-regression <TEST-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Load testing test id. ||
|| `-e`, `--error-mode` | Set a non-0 exit status of a command if a given test didn't pass regression checks, or no checks were performed. ||
|| `--dashboard-id` | `string`

ID of a regression dashboard to be checked. ||
|| `--dashboard` | `string`

Name of a regression dashboard to be checked. ||
|| `--chart-id` | `string`

ID of a regression chart to be checked. ||
|| `--chart` | `string`

Name of a regression chart to be checked. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#