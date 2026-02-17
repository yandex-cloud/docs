---
editable: false
---

# yc application-load-balancer load-balancer update-stream-listener

Updates Stream listener in the specified application load balancer.

#### Command Usage

Syntax:

`yc application-load-balancer load-balancer update-stream-listener <LOAD-BALANCER-NAME>|<LOAD-BALANCER-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

ID of the Application load balancer. ||
|| `--name` | `string`

Name of the Application load balancer. ||
|| `--listener-name` | `string`

Name of listener to add/update in application load balancer. ||
|| `--enable-tls` | Enable TLS for specified listener. ||
|| `--certificate-id` | `value[,value]`

Certificate ID for specified listener. ||
|| `--external-ipv4-endpoint` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

External IPv4 endpoint settings for specified listener.

Possible property names:

- `port`: Port for the listener.

- `address`: Use allocated address for the listener. ||
|| `--internal-ipv4-endpoint` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Internal IPv4 endpoint settings for specified listener.

Possible property names:

- `port`: Port for the new listener.

- `subnet-id`: Subnet for internal endpoint. ||
|| `--external-ipv6-endpoint` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

External IPv6 endpoint settings for specified listener.

Possible property names:

- `port`: Port for the listener.

- `address`: Use allocated address for the listener. ||
|| `--disable-tls` | Disable TLS for specified listener. ||
|| `--disable-external-ipv4-endpoint` | Disable external ipv4 endpoint for specified listener. ||
|| `--disable-internal-ipv4-endpoint` | Disable internal ipv4 endpoint for specified listener. ||
|| `--disable-external-ipv6-endpoint` | Disable external ipv6 endpoint for specified listener. ||
|| `--clear-sni-matches` | Disable TLS for specified listener. ||
|| `--backend-group-id` | `string`

HTTP router id for specified listener. ||
|| `--backend-group-name` | `string`

HTTP router name for specified listener. ||
|| `--idle-timeout` | `duration`

Idle timeout for the stream. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
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