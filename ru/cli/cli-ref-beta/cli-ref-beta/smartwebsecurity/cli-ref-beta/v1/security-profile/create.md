---
editable: false
noIndex: true
---

# yc beta smartwebsecurity v1 security-profile create

Creates a security profile in the specified folder using the data specified in the request.

#### Command Usage

Syntax:

`yc beta smartwebsecurity v1 security-profile create <ADVANCED-RATE-LIMITER-PROFILE-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template:  compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template:  compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template:  compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template:  compute instance create -r request.yaml ||
|| `--advanced-rate-limiter-profile-id` | `string`

Advanced rate limiter profile ID to use with this security profile. Set empty to use default. ||
|| `--analyze-request-body` | `shorthand/json`

Parameters for request body analyzer. ||
|| `--captcha-id` | `string`

Captcha ID to use with this security profile. Set empty to use default. ||
|| `--default-action` | `enum`

Action to perform if none of rules matched. Possible Values: 'allow', 'deny' ||
|| `--description` | `string`

Optional description of the security profile. ||
|| `--folder-id` | `string`

ID of the folder to create a security profile in. ||
|| `--labels` | `map<string><string>`

Labels as '' key:value '' pairs. Maximum of 64 per resource. ||
|| `--name` | `string`

Name of the security profile. The name is unique within the folder. 1-50 characters long. ||
|| `--security-rules` | `shorthand/json`

List of security rules. ||
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