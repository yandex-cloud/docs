---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/organization-manager/cli-ref-beta/idp/userpool/create.md
---

# yc beta organization-manager idp userpool create

Creates a userpool in the specified organization.

#### Command Usage

Syntax: 

`yc beta organization-manager idp userpool create <ORGANIZATION-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--bruteforce-protection-policy`|<b>`shorthand/json`</b><br/>Bruteforce protection policy for the userpool.<br/><br/>Example:|
|`--bruteforce-protection-policy`|<b>`attempts=1,`</b><br/>block=1h30m, window=1h30m<br/><br/>Shorthand Syntax:<br/>{attempts=int, block=duration, window=duration}<br/>Fields:<br/>attempts  int       — Number of failed attempts allowed within the window before blocking.<br/>block     duration  — Duration of the block after too many failed attempts.<br/>window    duration  — Time window for counting failed authentication attempts.<br/>|
|`--default-subdomain`|<b>`string`</b><br/>Default subdomain for the userpool.|
|`--description`|<b>`string`</b><br/>Description of the userpool.|
|`--labels`|<b>`stringToString`</b><br/>Resource labels as key:value pairs.|
|`--name`|<b>`string`</b><br/>Name of the userpool.<br/>The name must be unique within the organization.|
|`--organization-id`|<b>`string`</b><br/>ID of the organization to create a userpool in.|
|`--password-lifetime-policy`|<b>`shorthand/json`</b><br/>Password lifetime policy for the userpool.<br/><br/>Example:|
|`--password-lifetime-policy`|<b>`max-days-count=1,`</b><br/>min-days-count=1<br/><br/>Shorthand Syntax:<br/>{max-days-count=int, min-days-count=int}<br/>Fields:<br/>max-days-count  int  — Maximum number of days a password remains valid.<br/>Zero means passwords never expire.<br/>min-days-count  int  — Minimum number of days before a password can be changed.<br/>|
|`--password-quality-policy`|<b>`shorthand/json`</b><br/>Password quality policy for the userpool.<br/><br/>Example:|
|`--password-quality-policy`|<b>`allow-similar=true,`</b><br/>complexity-policy={fixed={digits-required=true, lowers-required=true, min-length=1, specials-required=true, uppers-required=true}}, match-length=1, max-length=1, min-length=1, min-length-by-class-settings={one=1, three=1, two=1}, required-classes={digits=true, lowers=true, specials=true, uppers=true}<br/><br/>Shorthand Syntax:<br/>{allow-similar=bool, complexity-policy={fixed={digits-required=bool, lowers-required=bool, min-length=int, specials-required=bool, uppers-required=bool} \| smart={four-classes=int, one-class=int, three-classes=int, two-classes=int}}, match-length=int, max-length=int, min-length=int, min-length-by-class-settings={one=int, three=int, two=int}, required-classes={digits=bool, lowers=bool, specials=bool, uppers=bool}}<br/>Fields:<br/>allow-similar                 bool                — Whether passwords similar to previous ones are allowed.<br/>match-length                  int                 — Minimum length of substrings to check for similarity to vulnerable sequences.<br/>max-length                    int                 — Maximum password length. Zero means no maximum length is enforced.<br/>min-length                    int                 — Minimum password length.<br/>min-length-by-class-settings  struct              — Minimum length requirements based on character class diversity.<br/>If not specified, these checks are disabled.<br/>one    int  — Minimum length for passwords with one character class.<br/>three  int  — Minimum length for passwords with three character classes.<br/>two    int  — Minimum length for passwords with two character classes.<br/>required-classes              struct              — Character classes required in passwords.<br/>digits    bool  — Whether digits are required.<br/>lowers    bool  — Whether lowercase letters are required.<br/>specials  bool  — Whether special characters are required.<br/>uppers    bool  — Whether uppercase letters are required.<br/>complexity-policy             oneof<fixed\|smart>  — Oneof complexity-policy field<br/>fixed  struct  — Fixed complexity requirements<br/>digits-required    bool  — Whether digits are required in the password.<br/>lowers-required    bool  — Whether lowercase letters are required in the password.<br/>min-length         int   — Minimum length required for all passwords.<br/>specials-required  bool  — Whether special characters are required in the password.<br/>uppers-required    bool  — Whether uppercase letters are required in the password.<br/>smart  struct  — Smart complexity requirements<br/>four-classes   int  — For passwords with all four classes of characters<br/>one-class      int  — For passwords with one class of characters<br/>three-classes  int  — For passwords with three classes of characters<br/>two-classes    int  — For passwords with two classes of characters<br/>|
|`--user-settings`|<b>`shorthand/json`</b><br/>User settings for the userpool.<br/><br/>Example:|
|`--user-settings`|<b>`allow-edit-self-contacts=true,`</b><br/>allow-edit-self-info=true, allow-edit-self-login=true, allow-edit-self-password=true<br/><br/>Shorthand Syntax:<br/>{allow-edit-self-contacts=bool, allow-edit-self-info=bool, allow-edit-self-login=bool, allow-edit-self-password=bool}<br/>Fields:<br/>allow-edit-self-contacts  bool  — Whether users can edit their own contact information.<br/>allow-edit-self-info      bool  — Whether users can edit their own profile information.<br/>allow-edit-self-login     bool  — Whether users can edit their own login information.<br/>allow-edit-self-password  bool  — Whether users can change their own passwords.<br/>|
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
