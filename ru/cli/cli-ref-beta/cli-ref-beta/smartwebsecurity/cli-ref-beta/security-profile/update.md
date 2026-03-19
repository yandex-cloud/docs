---
editable: false
noIndex: true
---

# yc beta smartwebsecurity security-profile update

Updates the specified security profile.

#### Command Usage

Syntax:

`yc beta smartwebsecurity security-profile update <SECURITY-PROFILE-ID>`

#### Flags

#|
||Flag | Description ||
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
|| `--labels` | `map<string><string>`

Labels as '' key:value '' pairs. Maximum of 64 per resource. ||
|| `--name` | `string`

Name of the security profile. The name is unique within the folder. 1-50 characters long. ||
|| `--security-profile-id` | `string`

ID of the security profile to update. ||
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