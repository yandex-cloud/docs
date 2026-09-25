[Документация Yandex Cloud](../../../index.md) > [Yandex Application Load Balancer](../../index.md) > [Справочник CLI (англ.)](../index.md) > [load-balancer](index.md) > update-stream-sni

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

Name of the listener to add/update the SNI match to. ||
|| `--sni-name` | `string`

Name of the SNI match to add/update. ||
|| `--server-name` | `[]string`

Server name to match. ||
|| `--certificate-id` | `[]string`

Certificate ID for the SNI match. ||
|| `--require-client-certificate` | Require client certificate for the SNI match. ||
|| `--client-certificates-trusted-ca-file` | `string`

Trusted CA filename (PEM) for the specified listener. ||
|| `--client-certificates-accept-untrusted` | Don't check client certificates' trusted chain for the SNI match. It is additionally allows expired client certificates. ||
|| `--client-certificates-allow-expired` | Accept expired client certificates for the SNI match. ||
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

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#