---
editable: false
sourcePath: en/_cli-ref/cli-ref/organization-manager/cli-ref/idp/userpool/create.md
---

# yc organization-manager idp userpool create

Create a user pool

#### Command Usage

Syntax: 

`yc organization-manager idp userpool create [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--organization-id`|<b>`string`</b><br/>Set the ID of the organization to use.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--userpool-name`|<b>`string`</b><br/>Name of the userpool|
|`--description`|<b>`string`</b><br/>Description of the userpool|
|`--labels`|<b>`stringToString`</b><br/>Labels of the userpool as key=value pairs|
|`--default-subdomain`|<b>`string`</b><br/>Default subdomain for the userpool|
|`--password-allow-similar`|Whether passwords similar to previous ones are allowed.|
|`--password-max-length`|<b>`int`</b><br/>Maximum password length. Zero means no maximum length is enforced.|
|`--password-min-length`|<b>`int`</b><br/>Minimum password length.|
|`--password-match-length`|<b>`int`</b><br/>Minimum length of substrings to check for similarity to vulnerable sequences.|
|`--password-lowers-required`|Whether lowercase letters are required in passwords.|
|`--password-uppers-required`|Whether uppercase letters are required in passwords.|
|`--password-digits-required`|Whether digits are required in passwords.|
|`--password-specials-required`|Whether special characters are required in passwords.|
|`--password-one-class-min-length`|<b>`int`</b><br/>Minimum length for passwords with one character class.|
|`--password-two-classes-min-length`|<b>`int`</b><br/>Minimum length for passwords with two character classes.|
|`--password-three-classes-min-length`|<b>`int`</b><br/>Minimum length for passwords with three character classes.|
|`--password-min-days`|<b>`int`</b><br/>Minimum number of days before a password can be changed.|
|`--password-max-days`|<b>`int`</b><br/>Maximum number of days a password remains valid. Zero means passwords never expire.|
|`--bruteforce-window`|<b>`duration`</b><br/>Time window for counting failed authentication attempts.|
|`--bruteforce-block`|<b>`duration`</b><br/>Duration of the block after too many failed attempts.|
|`--bruteforce-attempts`|<b>`int`</b><br/>Number of failed attempts allowed within the window before blocking.|

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
