[Документация Yandex Cloud](../../../../../../index.md) > [Интерфейс командной строки](../../../../../index.md) > [Справочник (англ.)](../../../../index.md) > [smartcaptcha](../../index.md) > [v0](../index.md) > [captcha](index.md) > update

# yc smartcaptcha v0 captcha update

Update the specified captcha

#### Command Usage

Syntax:

`yc smartcaptcha v0 captcha update <CAPTCHA-NAME>|<CAPTCHA-ID> [Flags...] [Global Flags...]`

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
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. ||
|| `--complexity` | `string`

Captcha complexity. ||
|| `--style-json` | `string`

JSON with variables to define the captcha appearance. ||
|| `--pre-check-type` | `string`

Basic check type of the captcha. ||
|| `--challenge-type` | `string`

Additional task. ||
|| `--allowed-site` | `[]string`

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

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#