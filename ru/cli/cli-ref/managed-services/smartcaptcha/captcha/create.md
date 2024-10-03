---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/smartcaptcha/captcha/create.md
---

# yc smartcaptcha captcha create

Create a captcha

#### Command Usage

Syntax: 

`yc smartcaptcha captcha create <CAPTCHA-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>A name of the captcha.|
|`--complexity`|<b>`string`</b><br/>Captcha complexity.<br/>* 'MEDIUM': Used by default. Medium chance to pass pre-check and normal advanced challenge.<br/>* 'EASY': High chance to pass pre-check and easy advanced challenge.<br/>* 'HARD': Little chance to pass pre-check and hard advanced challenge.<br/>* 'FORCE_HARD': Impossible to pass pre-check and hard advanced challenge.|
|`--style-json`|<b>`string`</b><br/>JSON with variables to define the captcha appearance. For more details see generated JSON in cloud console.|
|`--pre-check-type`|<b>`string`</b><br/>Basic check type of the captcha.<br/>* 'CHECKBOX': Used by default. User must click the "I am not a robot" button.<br/>* 'SLIDER': User must move the slider from left to right.|
|`--challenge-type`|<b>`string`</b><br/>Additional task.<br/>* 'IMAGE_TEXT': Used by default. Text recognition: The user has to type a distorted text from the picture into a special field.<br/>* 'SILHOUETTES': Silhouettes: The user has to mark several icons from the picture in a particular order.<br/>* 'KALEIDOSCOPE': Kaleidoscope: The user has to build a picture from individual parts by shuffling them using a slider.|
|`--allowed-site`|<b>`value[,value]`</b><br/>List of allowed host names.|
|`--turn-off-hostname-check`|Turn off host name check.|
|`--security-rules-file`|<b>`string`</b><br/>Path to a text file that contains security rules array in YAML format. Content example:<br/><br/>- name: rule1<br/>priority: "11"<br/>description: My first security rule. This rule it's just example to show possibilities of configuration.<br/>override_variant_uuid: variant-1<br/>condition:<br/>host:<br/>hosts:<br/>- exact_match: example.com<br/>- exact_match: example.net<br/>uri:<br/>path:<br/>prefix_match: /form<br/>queries:<br/>- key: firstname<br/>value:<br/>pire_regex_match: .*ivan.*<br/>- key: lastname<br/>value:<br/>pire_regex_not_match: .*petr.*<br/>headers:<br/>- name: User-Agent<br/>value:<br/>pire_regex_match: .*curl.*<br/>- name: Referer<br/>value:<br/>pire_regex_not_match: .*bot.*<br/>source_ip:<br/>ip_ranges_match:<br/>ip_ranges:<br/>- 1.2.33.44<br/>- 2.3.4.56<br/>ip_ranges_not_match:<br/>ip_ranges:<br/>- 8.8.0.0/16<br/>- 10::1234:1abc:1/64<br/>geo_ip_match:<br/>locations:<br/>- ru<br/>- es<br/>geo_ip_not_match:<br/>locations:<br/>- us<br/>- fm<br/>- gb<br/>- name: rule2<br/>priority: "12"<br/>override_variant_uuid: variant-2<br/>condition:<br/>uri:<br/>path:<br/>prefix_match: /form<br/>|
|`--override-variants-file`|<b>`string`</b><br/>Path to a text file that contains variants array in YAML format. Content example:<br/><br/>- uuid: variant-1<br/>description: override variant 1<br/>complexity: EASY<br/>pre_check_type: CHECKBOX<br/>challenge_type: SILHOUETTES<br/>- uuid: variant-2<br/>description: override variant 2<br/>complexity: HARD<br/>pre_check_type: CHECKBOX<br/>challenge_type: KALEIDOSCOPE<br/>|
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
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
