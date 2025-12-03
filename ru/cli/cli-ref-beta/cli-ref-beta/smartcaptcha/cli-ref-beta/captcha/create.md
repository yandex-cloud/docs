---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/smartcaptcha/cli-ref-beta/captcha/create.md
---

# yc beta smartcaptcha captcha create

Creates a captcha in the specified folder using the data specified in the request.

#### Command Usage

Syntax: 

`yc beta smartcaptcha captcha create <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--allowed-sites`|<b>`strings`</b><br/>List of allowed host names, see [Domain validation](https://yandex.cloud/ru/docs/smartcaptcha/concepts/domain-validation).|
|`--challenge-type`|<b>`enum`</b><br/>Additional task type of the captcha. Possible Values: 'image-text', 'silhouettes', 'kaleidoscope'|
|`--complexity`|<b>`enum`</b><br/>Complexity of the captcha. Possible Values: 'easy', 'medium', 'hard', 'force-hard'|
|`--deletion-protection`|Determines whether captcha is protected from being deleted.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to create a captcha in.|
|`--name`|<b>`string`</b><br/>Name of the captcha.<br/>The name must be unique within the folder.|
|`--override-variants`|<b>`shorthand/json`</b><br/>List of variants to use in security_rules<br/><br/>Example:|
|`--override-variants`|<b>`[{challenge-type=IMAGE_TEXT,`</b><br/>complexity=EASY, description=value, pre-check-type=CHECKBOX, uuid=value}]<br/><br/>Shorthand Syntax:<br/>[{challenge-type=IMAGE_TEXT\|SILHOUETTES\|KALEIDOSCOPE, complexity=EASY\|MEDIUM\|HARD\|FORCE_HARD, description=str, pre-check-type=CHECKBOX\|SLIDER, uuid=str},...]<br/>Fields:<br/>challenge-type  enum<IMAGE_TEXT\|KALEIDOSCOPE\|SILHOUETTES>  — Additional task type of the captcha.<br/>complexity      enum<EASY\|FORCE_HARD\|HARD\|MEDIUM>          — Complexity of the captcha.<br/>description     string                                     — Optional description of the rule. 0-512 characters long.<br/>pre-check-type  enum<CHECKBOX\|SLIDER>                      — Basic check type of the captcha.<br/>uuid            string                                     — Unique identifier of the variant.<br/>|
|`--pre-check-type`|<b>`enum`</b><br/>Basic check type of the captcha. Possible Values: 'checkbox', 'slider'|
|`--security-rules`|<b>`shorthand/json`</b><br/>List of security rules.<br/><br/>Example:|
|`--security-rules`|<b>`[{condition={headers=[{name=value,`</b><br/>value={match={exact-match=value}}}], host={hosts=[{match={exact-match=value}}]}, source-ip={geo-ip-match={locations=value}, geo-ip-not-match={locations=value}, ip-ranges-match={ip-ranges=value}, ip-ranges-not-match={ip-ranges=value}}, uri={path={match={exact-match=value}}, queries=[{key=value, value={match={exact-match=value}}}]}}, description=value, name=value, override-variant-uuid=value, priority=1}]<br/><br/>Shorthand Syntax:<br/>[{condition={headers=[{name=str, value={match={exact-match=str \| exact-not-match=str \| pire-regex-match=str \| pire-regex-not-match=str \| prefix-match=str \| prefix-not-match=str}}},...], host={hosts=[{match={exact-match=str \| exact-not-match=str \| pire-regex-match=str \| pire-regex-not-match=str \| prefix-match=str \| prefix-not-match=str}},...]}, source-ip={geo-ip-match={locations=str,...}, geo-ip-not-match={locations=str,...}, ip-ranges-match={ip-ranges=str,...}, ip-ranges-not-match={ip-ranges=str,...}}, uri={path={match={exact-match=str \| exact-not-match=str \| pire-regex-match=str \| pire-regex-not-match=str \| prefix-match=str \| prefix-not-match=str}}, queries=[{key=str, value={match={exact-match=str \| exact-not-match=str \| pire-regex-match=str \| pire-regex-not-match=str \| prefix-match=str \| prefix-not-match=str}}},...]}}, description=str, name=str, override-variant-uuid=str, priority=int},...]<br/>Fields:<br/>condition              struct            — The condition for matching the rule.<br/>headers    []struct  — Captcha request headers.<br/>name   string  required  — Name of header (case insensitive).<br/>value  struct  required  — Value of the header.<br/>match  oneof<exact-match\|exact-not-match\|pire-regex-match\|pire-regex-not-match\|prefix-match\|prefix-not-match>  — Oneof match field<br/>exact-match           string  —<br/>exact-not-match       string  —<br/>prefix-match          string  —<br/>prefix-not-match      string  —<br/>pire-regex-match      string  —<br/>pire-regex-not-match  string  —<br/>host       struct    — Host where captcha placed.<br/>hosts  []struct  — List of hosts. OR semantics implied.<br/>match  oneof<exact-match\|exact-not-match\|pire-regex-match\|pire-regex-not-match\|prefix-match\|prefix-not-match>  — Oneof match field<br/>exact-match           string  —<br/>exact-not-match       string  —<br/>prefix-match          string  —<br/>prefix-not-match      string  —<br/>pire-regex-match      string  —<br/>pire-regex-not-match  string  —<br/>source-ip  struct    — The IP address of the requester.<br/>geo-ip-match         struct  —<br/>locations  []string  — ISO 3166-1 alpha 2. OR semantics implied.<br/>geo-ip-not-match     struct  —<br/>locations  []string  — ISO 3166-1 alpha 2. OR semantics implied.<br/>ip-ranges-match      struct  —<br/>ip-ranges  []string  — List of IP ranges. OR semantics implied.<br/>ip-ranges-not-match  struct  —<br/>ip-ranges  []string  — List of IP ranges. OR semantics implied.<br/>uri        struct    — URI where captcha placed.<br/>path     struct    — Path of the URI [RFC3986](https://datatracker.ietf.org/doc/html/rfc3986#section-3.3).<br/>match  oneof<exact-match\|exact-not-match\|pire-regex-match\|pire-regex-not-match\|prefix-match\|prefix-not-match>  — Oneof match field<br/>exact-match           string  —<br/>exact-not-match       string  —<br/>prefix-match          string  —<br/>prefix-not-match      string  —<br/>pire-regex-match      string  —<br/>pire-regex-not-match  string  —<br/>queries  []struct  — List of query matchers. AND semantics implied.<br/>key    string  required  — Key of the query parameter.<br/>value  struct  required  — Value of the query parameter.<br/>match  oneof<exact-match\|exact-not-match\|pire-regex-match\|pire-regex-not-match\|prefix-match\|prefix-not-match>  — Oneof match field<br/>exact-match           string  —<br/>exact-not-match       string  —<br/>prefix-match          string  —<br/>prefix-not-match      string  —<br/>pire-regex-match      string  —<br/>pire-regex-not-match  string  —<br/>description            string            — Optional description of the rule. 0-512 characters long.<br/>name                   string  required  — Name of the rule. The name is unique within the captcha. 1-50 characters long.<br/>override-variant-uuid  string            — Variant UUID to show in case of match the rule. Keep empty to use defaults.<br/>priority               int               — Priority of the rule. Lower value means higher priority.<br/>|
|`--style-json`|<b>`string`</b><br/>JSON with variables to define the captcha appearance. For more details see generated JSON in cloud console.|
|`--turn-off-hostname-check`|Turn off host name check, see [Domain validation](https://yandex.cloud/ru/docs/smartcaptcha/concepts/domain-validation).|
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
