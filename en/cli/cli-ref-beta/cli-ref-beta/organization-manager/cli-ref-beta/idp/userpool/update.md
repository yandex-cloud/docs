---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/organization-manager/cli-ref-beta/idp/userpool/update.md
---

# yc beta organization-manager idp userpool update

Updates the specified userpool.

#### Command Usage

Syntax: 

`yc beta organization-manager idp userpool update <USERPOOL-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--bruteforce-protection-policy`|<b>`shorthand/json`</b><br/>Bruteforce protection policy for the userpool.<br/>Shorthand Syntax:<br/>{<br/>attempts = int,<br/>block = duration,<br/>window = duration<br/>}<br/>JSON Syntax:<br/>"{<br/>"attempts": "int",<br/>"block": "duration",<br/>"window": "duration"<br/>}"<br/>Fields:<br/>attempts -> (int)<br/>Number of failed attempts allowed within the window before blocking.<br/>block -> (duration)<br/>Duration of the block after too many failed attempts.<br/>window -> (duration)<br/>Time window for counting failed authentication attempts.|
|`--description`|<b>`string`</b><br/>Description of the userpool.|
|`--labels`|<b>`stringToString`</b><br/>Resource labels as key:value pairs.|
|`--name`|<b>`string`</b><br/>Name of the userpool. The name must be unique within the organization.|
|`--password-lifetime-policy`|<b>`shorthand/json`</b><br/>Password lifetime policy for the userpool.<br/>Shorthand Syntax:<br/>{<br/>max-days-count = int,<br/>min-days-count = int<br/>}<br/>JSON Syntax:<br/>"{<br/>"max-days-count": "int",<br/>"min-days-count": "int"<br/>}"<br/>Fields:<br/>max-days-count -> (int)<br/>Maximum number of days a password remains valid. Zero means passwords never expire.<br/>min-days-count -> (int)<br/>Minimum number of days before a password can be changed.|
|`--password-quality-policy`|<b>`shorthand/json`</b><br/>Password quality policy for the userpool.<br/>Shorthand Syntax:<br/>{<br/>allow-similar = bool,<br/>complexity-policy = fixed={<br/>digits-required = bool,<br/>lowers-required = bool,<br/>min-length = int,<br/>specials-required = bool,<br/>uppers-required = bool<br/>} \| smart={<br/>four-classes = int,<br/>one-class = int,<br/>three-classes = int,<br/>two-classes = int<br/>},<br/>match-length = int,<br/>max-length = int,<br/>min-length = int,<br/>min-length-by-class-settings = {<br/>one = int,<br/>three = int,<br/>two = int<br/>},<br/>required-classes = {<br/>digits = bool,<br/>lowers = bool,<br/>specials = bool,<br/>uppers = bool<br/>}<br/>}<br/>JSON Syntax:<br/>"{<br/>"allow-similar": "bool",<br/>"complexity-policy": {<br/>"fixed": {<br/>"digits-required": "bool",<br/>"lowers-required": "bool",<br/>"min-length": "int",<br/>"specials-required": "bool",<br/>"uppers-required": "bool"<br/>},<br/>"smart": {<br/>"four-classes": "int",<br/>"one-class": "int",<br/>"three-classes": "int",<br/>"two-classes": "int"<br/>}<br/>},<br/>"match-length": "int",<br/>"max-length": "int",<br/>"min-length": "int",<br/>"min-length-by-class-settings": {<br/>"one": "int",<br/>"three": "int",<br/>"two": "int"<br/>},<br/>"required-classes": {<br/>"digits": "bool",<br/>"lowers": "bool",<br/>"specials": "bool",<br/>"uppers": "bool"<br/>}<br/>}"<br/>Fields:<br/>allow-similar -> (bool)<br/>Whether passwords similar to previous ones are allowed.<br/>match-length -> (int)<br/>Minimum length of substrings to check for similarity to vulnerable sequences.<br/>max-length -> (int)<br/>Maximum password length. Zero means no maximum length is enforced.<br/>min-length -> (int)<br/>Minimum password length.<br/>min-length-by-class-settings -> (struct)<br/>Minimum length requirements based on character class diversity. If not specified, these checks are disabled.<br/>one -> (int)<br/>Minimum length for passwords with one character class.<br/>three -> (int)<br/>Minimum length for passwords with three character classes.<br/>two -> (int)<br/>Minimum length for passwords with two character classes.<br/>required-classes -> (struct)<br/>Character classes required in passwords.<br/>digits -> (bool)<br/>Whether digits are required.<br/>lowers -> (bool)<br/>Whether lowercase letters are required.<br/>specials -> (bool)<br/>Whether special characters are required.<br/>uppers -> (bool)<br/>Whether uppercase letters are required.<br/>complexity-policy -> (oneof<fixed\|smart>)<br/>Oneof complexity-policy field<br/>fixed -> (struct)<br/>Fixed complexity requirements. Exactly one of complexity requirements must be specified.<br/>digits-required -> (bool)<br/>Whether digits are required in the password.<br/>lowers-required -> (bool)<br/>Whether lowercase letters are required in the password.<br/>min-length -> (int)<br/>Minimum length required for all passwords.<br/>specials-required -> (bool)<br/>Whether special characters are required in the password.<br/>uppers-required -> (bool)<br/>Whether uppercase letters are required in the password.<br/>smart -> (struct)<br/>Smart complexity requirements. Exactly one of complexity requirements must be specified.<br/>four-classes -> (int)<br/>For passwords with all four classes of characters<br/>one-class -> (int)<br/>For passwords with one class of characters<br/>three-classes -> (int)<br/>For passwords with three classes of characters<br/>two-classes -> (int)<br/>For passwords with two classes of characters|
|`--user-settings`|<b>`shorthand/json`</b><br/>User settings for the userpool.<br/>Shorthand Syntax:<br/>{<br/>allow-edit-self-contacts = bool,<br/>allow-edit-self-info = bool,<br/>allow-edit-self-login = bool,<br/>allow-edit-self-password = bool<br/>}<br/>JSON Syntax:<br/>"{<br/>"allow-edit-self-contacts": "bool",<br/>"allow-edit-self-info": "bool",<br/>"allow-edit-self-login": "bool",<br/>"allow-edit-self-password": "bool"<br/>}"<br/>Fields:<br/>allow-edit-self-contacts -> (bool)<br/>Whether users can edit their own contact information.<br/>allow-edit-self-info -> (bool)<br/>Whether users can edit their own profile information.<br/>allow-edit-self-login -> (bool)<br/>Whether users can edit their own login information.<br/>allow-edit-self-password -> (bool)<br/>Whether users can change their own passwords.|
|`--userpool-id`|<b>`string`</b><br/>ID of the userpool to update. To get the userpool ID, make a [UserpoolService.List] request.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
