---
editable: false
sourcePath: en/_cli-ref/cli-ref/smartcaptcha/cli-ref/captcha/update.md
---

# yc smartcaptcha captcha update

Update the specified captcha

#### Command Usage

Syntax:

`yc smartcaptcha captcha update <CAPTCHA-NAME>|<CAPTCHA-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Captcha id. ||
|| `--name` | `string`

Captcha name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--new-name` | `string`

A new name of the captcha. ||
|| `--complexity` | `string`

Captcha complexity.
* 'MEDIUM': Used by default. Medium chance to pass pre-check and normal advanced challenge.
* 'EASY': High chance to pass pre-check and easy advanced challenge.
* 'HARD': Little chance to pass pre-check and hard advanced challenge.
* 'FORCE_HARD': Impossible to pass pre-check and hard advanced challenge. ||
|| `--style-json` | `string`

JSON with variables to define the captcha appearance. For more details see generated JSON in cloud console. ||
|| `--pre-check-type` | `string`

Basic check type of the captcha.
* 'CHECKBOX': Used by default. User must click the "I am not a robot" button.
* 'SLIDER': User must move the slider from left to right. ||
|| `--challenge-type` | `string`

Additional task.
* 'IMAGE_TEXT': Used by default. Text recognition: The user has to type a distorted text from the picture into a special field.
* 'SILHOUETTES': Silhouettes: The user has to mark several icons from the picture in a particular order.
* 'KALEIDOSCOPE': Kaleidoscope: The user has to build a picture from individual parts by shuffling them using a slider. ||
|| `--allowed-site` | `value[,value]`

List of allowed host names. ||
|| `--turn-off-hostname-check` | Turn off host name check. ||
|| `--security-rules-file` | `string`

Path to a text file that contains security rules array in YAML format. Content example:

- name: rule1
  priority: "11"
  description: My first security rule. This rule it's just example to show possibilities of configuration.
  override_variant_uuid: variant-1
  condition:
    host:
      hosts:
        - exact_match: example.com
        - exact_match: example.net
    uri:
      path:
        prefix_match: /form
      queries:
        - key: firstname
          value:
            pire_regex_match: .*ivan.*
        - key: lastname
          value:
            pire_regex_not_match: .*petr.*
    headers:
      - name: User-Agent
        value:
          pire_regex_match: .*curl.*
      - name: Referer
        value:
          pire_regex_not_match: .*bot.*
    source_ip:
      ip_ranges_match:
        ip_ranges:
          - 1.2.33.44
          - 2.3.4.56
      ip_ranges_not_match:
        ip_ranges:
          - 8.8.0.0/16
          - 10::1234:1abc:1/64
      geo_ip_match:
        locations:
          - ru
          - es
      geo_ip_not_match:
        locations:
          - us
          - fm
          - gb
- name: rule2
  priority: "12"
  override_variant_uuid: variant-2
  condition:
    uri:
      path:
        prefix_match: /form ||
|| `--override-variants-file` | `string`

Path to a text file that contains variants array in YAML format. Content example:

- uuid: variant-1
  description: override variant 1
  complexity: EASY
  pre_check_type: CHECKBOX
  challenge_type: SILHOUETTES
- uuid: variant-2
  description: override variant 2
  complexity: HARD
  pre_check_type: CHECKBOX
  challenge_type: KALEIDOSCOPE ||
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