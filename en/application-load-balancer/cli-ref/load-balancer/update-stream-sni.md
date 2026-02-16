---
editable: false
sourcePath: en/_cli-ref/cli-ref/application-load-balancer/cli-ref/load-balancer/update-stream-sni.md
---

# yc application-load-balancer load-balancer update-stream-sni

Updates Stream sni match of the application load balancer's listener.

#### Command Usage

Syntax:

`yc application-load-balancer load-balancer update-stream-sni <LOAD-BALANCER-NAME>|<LOAD-BALANCER-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

ID of the Application load balancer. ||
|| `--name` | `string`

Name of the Application load balancer. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--listener-name` | `string`

Name of the listener to add/update SNI match to. ||
|| `--sni-name` | `string`

Name of the SNI match to add/update. ||
|| `--server-name` | `value[,value]`

Server name to match. ||
|| `--certificate-id` | `value[,value]`

Certificate ID for SNI match. ||
|| `--backend-group-id` | `string`

Backend group id for SNI match. ||
|| `--backend-group-name` | `string`

Backend group name for SNI match. ||
|| `--idle-timeout` | `duration`

Idle timeout for the stream. ||
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