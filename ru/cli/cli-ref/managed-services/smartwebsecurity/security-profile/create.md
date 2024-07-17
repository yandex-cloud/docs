---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/smartwebsecurity/security-profile/create.md
---

# yc smartwebsecurity security-profile create

Create a security profile

#### Command Usage

Syntax: 

`yc smartwebsecurity security-profile create <SECURITY-PROFILE-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>A name of the captcha preset.|
|`--description`|<b>`string`</b><br/>Specifies a textual description.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'.|
|`--default-action`|<b>`string`</b><br/>Action to perform if none of rules matched.<br/>* 'ALLOW': Used by default. Pass request to service.<br/>* 'DENY': Deny request.|
|`--captcha-id`|<b>`string`</b><br/>Captcha ID to use with this security profile. Set empty to use default.|
|`--security-rules-file`|<b>`string`</b><br/>Path to a text file that contains security rules array in YAML format. Content example:<br/><br/>- name: rule-condition-deny<br/>description: My first security rule. This rule it's just example to show possibilities of configuration.<br/>priority: "11111"<br/>dry_run: true<br/>rule_condition:<br/>action: DENY<br/>condition:<br/>authority:<br/>authorities:<br/>- exact_match: example.com<br/>- exact_match: example.net<br/>http_method:<br/>http_methods:<br/>- exact_match: GET<br/>- exact_match: POST<br/>request_uri:<br/>path:<br/>prefix_match: /search<br/>queries:<br/>- key: firstname<br/>value:<br/>pire_regex_match: .*ivan.*<br/>- key: lastname<br/>value:<br/>pire_regex_not_match: .*petr.*<br/>headers:<br/>- name: User-Agent<br/>value:<br/>pire_regex_match: .*curl.*<br/>- name: Referer<br/>value:<br/>pire_regex_not_match: .*bot.*<br/>source_ip:<br/>ip_ranges_match:<br/>ip_ranges:<br/>- 1.2.33.44<br/>- 2.3.4.56<br/>ip_ranges_not_match:<br/>ip_ranges:<br/>- 8.8.0.0/16<br/>- 10::1234:1abc:1/64<br/>geo_ip_match:<br/>locations:<br/>- ru<br/>- es<br/>geo_ip_not_match:<br/>locations:<br/>- us<br/>- fm<br/>- gb<br/>- name: rule-condition-allow<br/>description: Let's show how to whitelist IP.<br/>priority: "2"<br/>rule_condition:<br/>action: ALLOW<br/>condition:<br/>source_ip:<br/>ip_ranges_match:<br/>ip_ranges:<br/>- 44.44.44.44-44.44.44.45<br/>- 44.44.44.77<br/>- name: smart-protection-full<br/>description: Enable smart protection. Allow to show captcha on /search prefix.<br/>priority: "11"<br/>smart_protection:<br/>mode: FULL<br/>condition:<br/>request_uri:<br/>path:<br/>prefix_match: /search<br/>- name: smart-protection-api<br/>description: Enable smart protection with mode API. We are not expect to see captcha on /api prefix.<br/>priority: "10"<br/>smart_protection:<br/>mode: API<br/>condition:<br/>request_uri:<br/>path:<br/>prefix_match: /api<br/>|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

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
|`-h`,`--help`|Display help for the command.|
