---
editable: false
---

# yc organization-manager idp user create

Create a user in the specified user pool

#### Command Usage

Syntax:

`yc organization-manager idp user create [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--userpool-id` | `string`

ID of the userpool to create the user in ||
|| `--username` | `string`

Username for the new user ||
|| `--full-name` | `string`

Full name of the user ||
|| `--given-name` | `string`

First name of the user ||
|| `--family-name` | `string`

Last name of the user ||
|| `--email` | `string`

Email address of the user ||
|| `--phone-number` | `string`

Phone number of the user ||
|| `--password` | `string`

Password for the user ||
|| `--external-id` | `string`

External identifier for the user ||
|| `--is-active` | Whether the user is active ||
|| `--generation-proof` | `string`

Proof of generated password ||
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