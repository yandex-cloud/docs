---
editable: false
sourcePath: en/_cli-ref/cli-ref/smartwebsecurity/cli-ref/security-profile/update.md
---

# yc smartwebsecurity security-profile update

Update the specified security profile

#### Command Usage

Syntax:

`yc smartwebsecurity security-profile update <SECURITY-PROFILE-NAME>|<SECURITY-PROFILE-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Security profile id. ||
|| `--name` | `string`

Security profile name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--new-name` | `string`

A new name of the captcha preset. ||
|| `--description` | `string`

Specifies a textual description. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--default-action` | `string`

Action to perform if none of rules matched.
* 'ALLOW': Used by default. Pass request to service.
* 'DENY': Deny request. ||
|| `--captcha-id` | `string`

Captcha ID to use with this security profile. Set empty to use default. ||
|| `--security-rules-file` | `string`

Path to a text file that contains security rules array in YAML format. Content example:

- name: rule-condition-deny
  description: My first security rule. This rule it's just example to show possibilities of configuration.
  priority: "11111"
  dry_run: true
  rule_condition:
    action: DENY
    condition:
      authority:
        authorities:
          - exact_match: example.com
          - exact_match: example.net
      http_method:
        http_methods:
          - exact_match: GET
          - exact_match: POST
      request_uri:
        path:
          prefix_match: /search
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
- name: rule-condition-allow
  description: Let's show how to whitelist IP.
  priority: "2"
  rule_condition:
    action: ALLOW
    condition:
      source_ip:
        ip_ranges_match:
          ip_ranges:
            - 44.44.44.44-44.44.44.45
            - 44.44.44.77
- name: smart-protection-full
  description: Enable smart protection. Allow to show captcha on /search prefix.
  priority: "11"
  smart_protection:
    mode: FULL
    condition:
      request_uri:
        path:
          prefix_match: /search
- name: smart-protection-api
  description: Enable smart protection with mode API. We are not expect to see captcha on /api prefix.
  priority: "10"
  smart_protection:
    mode: API
    condition:
      request_uri:
        path:
          prefix_match: /api ||
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