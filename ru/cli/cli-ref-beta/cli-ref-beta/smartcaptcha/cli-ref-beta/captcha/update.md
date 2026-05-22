---
editable: false
noIndex: true
---

# yc beta smartcaptcha captcha update

Updates the specified captcha.

#### Command Usage

Syntax:

`yc beta smartcaptcha captcha update <CAPTCHA-ID>`

#### Flags

#|
||Flag | Description ||
|| `--allowed-sites` | `[]string`

List of allowed host names, see documentation. ||
|| `--captcha-id` | `string`

ID of the captcha to update. ||
|| `--challenge-type` | `enum`

Additional task type of the captcha. Possible Values: 'image-text', 'silhouettes', 'kaleidoscope' ||
|| `--complexity` | `enum`

Complexity of the captcha. Possible Values: 'easy', 'medium', 'hard', 'force-hard' ||
|| `--deletion-protection` | Determines whether captcha is protected from being deleted. ||
|| `--description` | `string`

Optional description of the captcha. ||
|| `--disallow-data-processing` | If true, Yandex team won't be able to read internal data. ||
|| `--labels` | `map<string><string>`

Resource labels as 'key:value' pairs. ||
|| `--name` | `string`

Name of the captcha. The name must be unique within the folder. ||
|| `--override-variants` | `shorthand/json`

List of variants to use in security_rules ||
|| `--pre-check-type` | `enum`

Basic check type of the captcha. Possible Values: 'checkbox', 'slider' ||
|| `--security-rules` | `shorthand/json`

List of security rules. ||
|| `--style-json` | `string`

JSON with variables to define the captcha appearance. For more details see generated JSON in cloud console. ||
|| `--turn-off-hostname-check` | Turn off host name check, see documentation. ||
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