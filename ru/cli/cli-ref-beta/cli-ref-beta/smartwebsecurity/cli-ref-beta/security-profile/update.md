---
editable: false
noIndex: true
---

# yc beta smartwebsecurity security-profile update

Updates the specified security profile.

#### Command Usage

Syntax:

`yc beta smartwebsecurity security-profile update <SECURITY-PROFILE-ID>`

#### Flags

#|
||Flag | Description ||
|| `--advanced-rate-limiter-profile-id` | `string`

Advanced rate limiter profile ID to use with this security profile. Set empty to use default. ||
|| `--analyze-request-body` | `shorthand/json`

Parameters for request body analyzer.

Shorthand Syntax:

```hcl
{
  size-limit = integer,
  size-limit-action = IGNORE|DENY
}
```

JSON Syntax:

```json
{
  "size-limit": "integer",
  "size-limit-action": "IGNORE|DENY"
}
```

Fields:

```
size-limit -> (integer)
  Maximum size of body to pass to analyzer. In kilobytes.
size-limit-action -> (struct)
  Action to perform if maximum size of body exceeded.
``` ||
|| `--captcha-id` | `string`

Captcha ID to use with this security profile. Set empty to use default. ||
|| `--default-action` | `enum`

Action to perform if none of rules matched. Possible Values: 'allow', 'deny' ||
|| `--description` | `string`

Optional description of the security profile. ||
|| `--labels` | `map<string><string>`

Labels as '' key:value '' pairs. Maximum of 64 per resource. ||
|| `--name` | `string`

Name of the security profile. The name is unique within the folder. 1-50 characters long. ||
|| `--security-profile-id` | `string`

ID of the security profile to update. ||
|| `--security-rules` | `shorthand/json`

List of security rules.

Shorthand Syntax:

```hcl
[
  {
    description = string,
    dry-run = boolean,
    name = string,
    priority = integer,
    rule-specifier = rule-condition={
      action = ALLOW|DENY,
      condition = {
        authority = {
          authorities = [
            {
              match = exact-match=string | exact-not-match=string | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
            }, ...
          ]
        },
        headers = [
          {
            name = string,
            value = {
              match = exact-match=string | exact-not-match=string | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
            }
          }, ...
        ],
        http-method = {
          http-methods = [
            {
              match = exact-match=string | exact-not-match=string | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
            }, ...
          ]
        },
        request-uri = {
          path = {
            match = exact-match=string | exact-not-match=string | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
          },
          queries = [
            {
              key = string,
              value = {
                match = exact-match=string | exact-not-match=string | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
              }
            }, ...
          ]
        },
        source-ip = {
          geo-ip-match = {
            locations = string,...
          },
          geo-ip-not-match = {
            locations = string,...
          },
          ip-ranges-match = {
            ip-ranges = string,...
          },
          ip-ranges-not-match = {
            ip-ranges = string,...
          }
        }
      }
    } | smart-protection={
      condition = {
        authority = {
          authorities = [
            {
              match = exact-match=string | exact-not-match=string | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
            }, ...
          ]
        },
        headers = [
          {
            name = string,
            value = {
              match = exact-match=string | exact-not-match=string | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
            }
          }, ...
        ],
        http-method = {
          http-methods = [
            {
              match = exact-match=string | exact-not-match=string | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
            }, ...
          ]
        },
        request-uri = {
          path = {
            match = exact-match=string | exact-not-match=string | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
          },
          queries = [
            {
              key = string,
              value = {
                match = exact-match=string | exact-not-match=string | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
              }
            }, ...
          ]
        },
        source-ip = {
          geo-ip-match = {
            locations = string,...
          },
          geo-ip-not-match = {
            locations = string,...
          },
          ip-ranges-match = {
            ip-ranges = string,...
          },
          ip-ranges-not-match = {
            ip-ranges = string,...
          }
        }
      },
      mode = FULL|API
    } | waf={
      condition = {
        authority = {
          authorities = [
            {
              match = exact-match=string | exact-not-match=string | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
            }, ...
          ]
        },
        headers = [
          {
            name = string,
            value = {
              match = exact-match=string | exact-not-match=string | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
            }
          }, ...
        ],
        http-method = {
          http-methods = [
            {
              match = exact-match=string | exact-not-match=string | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
            }, ...
          ]
        },
        request-uri = {
          path = {
            match = exact-match=string | exact-not-match=string | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
          },
          queries = [
            {
              key = string,
              value = {
                match = exact-match=string | exact-not-match=string | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
              }
            }, ...
          ]
        },
        source-ip = {
          geo-ip-match = {
            locations = string,...
          },
          geo-ip-not-match = {
            locations = string,...
          },
          ip-ranges-match = {
            ip-ranges = string,...
          },
          ip-ranges-not-match = {
            ip-ranges = string,...
          }
        }
      },
      mode = FULL|API,
      waf-profile-id = string
    }
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "description": "string",
    "dry-run": "boolean",
    "name": "string",
    "priority": "integer",
    "rule-specifier": {
      "rule-condition": {
        "action": "ALLOW|DENY",
        "condition": {
          "authority": {
            "authorities": [
              {
                "match": {
                  "exact-match": "string",
                  "exact-not-match": "string",
                  "pire-regex-match": "string",
                  "pire-regex-not-match": "string",
                  "prefix-match": "string",
                  "prefix-not-match": "string"
                }
              }, ...
            ]
          },
          "headers": [
            {
              "name": "string",
              "value": {
                "match": {
                  "exact-match": "string",
                  "exact-not-match": "string",
                  "pire-regex-match": "string",
                  "pire-regex-not-match": "string",
                  "prefix-match": "string",
                  "prefix-not-match": "string"
                }
              }
            }, ...
          ],
          "http-method": {
            "http-methods": [
              {
                "match": {
                  "exact-match": "string",
                  "exact-not-match": "string",
                  "pire-regex-match": "string",
                  "pire-regex-not-match": "string",
                  "prefix-match": "string",
                  "prefix-not-match": "string"
                }
              }, ...
            ]
          },
          "request-uri": {
            "path": {
              "match": {
                "exact-match": "string",
                "exact-not-match": "string",
                "pire-regex-match": "string",
                "pire-regex-not-match": "string",
                "prefix-match": "string",
                "prefix-not-match": "string"
              }
            },
            "queries": [
              {
                "key": "string",
                "value": {
                  "match": {
                    "exact-match": "string",
                    "exact-not-match": "string",
                    "pire-regex-match": "string",
                    "pire-regex-not-match": "string",
                    "prefix-match": "string",
                    "prefix-not-match": "string"
                  }
                }
              }, ...
            ]
          },
          "source-ip": {
            "geo-ip-match": {
              "locations": [
                "string", ...
              ]
            },
            "geo-ip-not-match": {
              "locations": [
                "string", ...
              ]
            },
            "ip-ranges-match": {
              "ip-ranges": [
                "string", ...
              ]
            },
            "ip-ranges-not-match": {
              "ip-ranges": [
                "string", ...
              ]
            }
          }
        }
      },
      "smart-protection": {
        "condition": {
          "authority": {
            "authorities": [
              {
                "match": {
                  "exact-match": "string",
                  "exact-not-match": "string",
                  "pire-regex-match": "string",
                  "pire-regex-not-match": "string",
                  "prefix-match": "string",
                  "prefix-not-match": "string"
                }
              }, ...
            ]
          },
          "headers": [
            {
              "name": "string",
              "value": {
                "match": {
                  "exact-match": "string",
                  "exact-not-match": "string",
                  "pire-regex-match": "string",
                  "pire-regex-not-match": "string",
                  "prefix-match": "string",
                  "prefix-not-match": "string"
                }
              }
            }, ...
          ],
          "http-method": {
            "http-methods": [
              {
                "match": {
                  "exact-match": "string",
                  "exact-not-match": "string",
                  "pire-regex-match": "string",
                  "pire-regex-not-match": "string",
                  "prefix-match": "string",
                  "prefix-not-match": "string"
                }
              }, ...
            ]
          },
          "request-uri": {
            "path": {
              "match": {
                "exact-match": "string",
                "exact-not-match": "string",
                "pire-regex-match": "string",
                "pire-regex-not-match": "string",
                "prefix-match": "string",
                "prefix-not-match": "string"
              }
            },
            "queries": [
              {
                "key": "string",
                "value": {
                  "match": {
                    "exact-match": "string",
                    "exact-not-match": "string",
                    "pire-regex-match": "string",
                    "pire-regex-not-match": "string",
                    "prefix-match": "string",
                    "prefix-not-match": "string"
                  }
                }
              }, ...
            ]
          },
          "source-ip": {
            "geo-ip-match": {
              "locations": [
                "string", ...
              ]
            },
            "geo-ip-not-match": {
              "locations": [
                "string", ...
              ]
            },
            "ip-ranges-match": {
              "ip-ranges": [
                "string", ...
              ]
            },
            "ip-ranges-not-match": {
              "ip-ranges": [
                "string", ...
              ]
            }
          }
        },
        "mode": "FULL|API"
      },
      "waf": {
        "condition": {
          "authority": {
            "authorities": [
              {
                "match": {
                  "exact-match": "string",
                  "exact-not-match": "string",
                  "pire-regex-match": "string",
                  "pire-regex-not-match": "string",
                  "prefix-match": "string",
                  "prefix-not-match": "string"
                }
              }, ...
            ]
          },
          "headers": [
            {
              "name": "string",
              "value": {
                "match": {
                  "exact-match": "string",
                  "exact-not-match": "string",
                  "pire-regex-match": "string",
                  "pire-regex-not-match": "string",
                  "prefix-match": "string",
                  "prefix-not-match": "string"
                }
              }
            }, ...
          ],
          "http-method": {
            "http-methods": [
              {
                "match": {
                  "exact-match": "string",
                  "exact-not-match": "string",
                  "pire-regex-match": "string",
                  "pire-regex-not-match": "string",
                  "prefix-match": "string",
                  "prefix-not-match": "string"
                }
              }, ...
            ]
          },
          "request-uri": {
            "path": {
              "match": {
                "exact-match": "string",
                "exact-not-match": "string",
                "pire-regex-match": "string",
                "pire-regex-not-match": "string",
                "prefix-match": "string",
                "prefix-not-match": "string"
              }
            },
            "queries": [
              {
                "key": "string",
                "value": {
                  "match": {
                    "exact-match": "string",
                    "exact-not-match": "string",
                    "pire-regex-match": "string",
                    "pire-regex-not-match": "string",
                    "prefix-match": "string",
                    "prefix-not-match": "string"
                  }
                }
              }, ...
            ]
          },
          "source-ip": {
            "geo-ip-match": {
              "locations": [
                "string", ...
              ]
            },
            "geo-ip-not-match": {
              "locations": [
                "string", ...
              ]
            },
            "ip-ranges-match": {
              "ip-ranges": [
                "string", ...
              ]
            },
            "ip-ranges-not-match": {
              "ip-ranges": [
                "string", ...
              ]
            }
          }
        },
        "mode": "FULL|API",
        "waf-profile-id": "string"
      }
    }
  }, ...
]
```

Fields:

```
description -> (string)
  Optional description of the rule. 0-512 characters long.
dry-run -> (boolean)
  This mode allows you to test your security profile or a single rule. For example, you can have the number of alarms for a specific rule displayed. Note: if this option is true, no real action affecting your traffic regarding this rule will be taken.
name -> (string)
  Name of the rule. The name is unique within the security profile. 1-50 characters long.
priority -> (integer)
  Determines the priority for checking the incoming traffic. Enter an integer within the range of 1 and 999999. The rule priority must be unique within the entire security profile. A lower numeric value means a higher priority. The default_action has the lowest priority.
rule-specifier -> (oneof<rule-condition|smart-protection|waf>)
  Oneof rule-specifier field
  rule-condition -> (struct)
    Rule actions, see documentation.
    action -> (struct)
      Action to perform if this rule matched.
    condition -> (struct)
      The condition for matching the rule.
      authority -> (struct)
        Match authority (Host header).
        authorities -> ([]struct)
          List of authorities. OR semantics implied.
          match -> (oneof<exact-match|exact-not-match|pire-regex-match|pire-regex-not-match|prefix-match|prefix-not-match>)
            Oneof match field
            exact-match -> (string)
            exact-not-match -> (string)
            prefix-match -> (string)
            prefix-not-match -> (string)
            pire-regex-match -> (string)
            pire-regex-not-match -> (string)
      headers -> ([]struct)
        Match HTTP headers.
        name -> (string)
          Name of header (case insensitive).
        value -> (struct)
          Value of the header.
          match -> (oneof<exact-match|exact-not-match|pire-regex-match|pire-regex-not-match|prefix-match|prefix-not-match>)
            Oneof match field
            exact-match -> (string)
            exact-not-match -> (string)
            prefix-match -> (string)
            prefix-not-match -> (string)
            pire-regex-match -> (string)
            pire-regex-not-match -> (string)
      http-method -> (struct)
        Match HTTP method.
        http-methods -> ([]struct)
          List of HTTP methods. OR semantics implied.
          match -> (oneof<exact-match|exact-not-match|pire-regex-match|pire-regex-not-match|prefix-match|prefix-not-match>)
            Oneof match field
            exact-match -> (string)
            exact-not-match -> (string)
            prefix-match -> (string)
            prefix-not-match -> (string)
            pire-regex-match -> (string)
            pire-regex-not-match -> (string)
      request-uri -> (struct)
        Match Request URI.
        path -> (struct)
          Path of the URI RFC3986.
          match -> (oneof<exact-match|exact-not-match|pire-regex-match|pire-regex-not-match|prefix-match|prefix-not-match>)
            Oneof match field
            exact-match -> (string)
            exact-not-match -> (string)
            prefix-match -> (string)
            prefix-not-match -> (string)
            pire-regex-match -> (string)
            pire-regex-not-match -> (string)
        queries -> ([]struct)
          List of query matchers. AND semantics implied.
          key -> (string)
            Key of the query parameter.
          value -> (struct)
            Value of the query parameter.
            match -> (oneof<exact-match|exact-not-match|pire-regex-match|pire-regex-not-match|prefix-match|prefix-not-match>)
              Oneof match field
              exact-match -> (string)
              exact-not-match -> (string)
              prefix-match -> (string)
              prefix-not-match -> (string)
              pire-regex-match -> (string)
              pire-regex-not-match -> (string)
      source-ip -> (struct)
        Match IP.
        geo-ip-match -> (struct)
          locations -> ([]string)
            ISO 3166-1 alpha 2. OR semantics implied.
        geo-ip-not-match -> (struct)
          locations -> ([]string)
            ISO 3166-1 alpha 2. OR semantics implied.
        ip-ranges-match -> (struct)
          ip-ranges -> ([]string)
            List of IP ranges. OR semantics implied.
        ip-ranges-not-match -> (struct)
          ip-ranges -> ([]string)
            List of IP ranges. OR semantics implied.
  smart-protection -> (struct)
    Smart Protection rule, see documentation.
    condition -> (struct)
      The condition for matching the rule.
      authority -> (struct)
        Match authority (Host header).
        authorities -> ([]struct)
          List of authorities. OR semantics implied.
          match -> (oneof<exact-match|exact-not-match|pire-regex-match|pire-regex-not-match|prefix-match|prefix-not-match>)
            Oneof match field
            exact-match -> (string)
            exact-not-match -> (string)
            prefix-match -> (string)
            prefix-not-match -> (string)
            pire-regex-match -> (string)
            pire-regex-not-match -> (string)
      headers -> ([]struct)
        Match HTTP headers.
        name -> (string)
          Name of header (case insensitive).
        value -> (struct)
          Value of the header.
          match -> (oneof<exact-match|exact-not-match|pire-regex-match|pire-regex-not-match|prefix-match|prefix-not-match>)
            Oneof match field
            exact-match -> (string)
            exact-not-match -> (string)
            prefix-match -> (string)
            prefix-not-match -> (string)
            pire-regex-match -> (string)
            pire-regex-not-match -> (string)
      http-method -> (struct)
        Match HTTP method.
        http-methods -> ([]struct)
          List of HTTP methods. OR semantics implied.
          match -> (oneof<exact-match|exact-not-match|pire-regex-match|pire-regex-not-match|prefix-match|prefix-not-match>)
            Oneof match field
            exact-match -> (string)
            exact-not-match -> (string)
            prefix-match -> (string)
            prefix-not-match -> (string)
            pire-regex-match -> (string)
            pire-regex-not-match -> (string)
      request-uri -> (struct)
        Match Request URI.
        path -> (struct)
          Path of the URI RFC3986.
          match -> (oneof<exact-match|exact-not-match|pire-regex-match|pire-regex-not-match|prefix-match|prefix-not-match>)
            Oneof match field
            exact-match -> (string)
            exact-not-match -> (string)
            prefix-match -> (string)
            prefix-not-match -> (string)
            pire-regex-match -> (string)
            pire-regex-not-match -> (string)
        queries -> ([]struct)
          List of query matchers. AND semantics implied.
          key -> (string)
            Key of the query parameter.
          value -> (struct)
            Value of the query parameter.
            match -> (oneof<exact-match|exact-not-match|pire-regex-match|pire-regex-not-match|prefix-match|prefix-not-match>)
              Oneof match field
              exact-match -> (string)
              exact-not-match -> (string)
              prefix-match -> (string)
              prefix-not-match -> (string)
              pire-regex-match -> (string)
              pire-regex-not-match -> (string)
      source-ip -> (struct)
        Match IP.
        geo-ip-match -> (struct)
          locations -> ([]string)
            ISO 3166-1 alpha 2. OR semantics implied.
        geo-ip-not-match -> (struct)
          locations -> ([]string)
            ISO 3166-1 alpha 2. OR semantics implied.
        ip-ranges-match -> (struct)
          ip-ranges -> ([]string)
            List of IP ranges. OR semantics implied.
        ip-ranges-not-match -> (struct)
          ip-ranges -> ([]string)
            List of IP ranges. OR semantics implied.
    mode -> (struct)
      Mode of protection.
  waf -> (struct)
    Web Application Firewall (WAF) rule, see documentation.
    condition -> (struct)
      The condition for matching the rule.
      authority -> (struct)
        Match authority (Host header).
        authorities -> ([]struct)
          List of authorities. OR semantics implied.
          match -> (oneof<exact-match|exact-not-match|pire-regex-match|pire-regex-not-match|prefix-match|prefix-not-match>)
            Oneof match field
            exact-match -> (string)
            exact-not-match -> (string)
            prefix-match -> (string)
            prefix-not-match -> (string)
            pire-regex-match -> (string)
            pire-regex-not-match -> (string)
      headers -> ([]struct)
        Match HTTP headers.
        name -> (string)
          Name of header (case insensitive).
        value -> (struct)
          Value of the header.
          match -> (oneof<exact-match|exact-not-match|pire-regex-match|pire-regex-not-match|prefix-match|prefix-not-match>)
            Oneof match field
            exact-match -> (string)
            exact-not-match -> (string)
            prefix-match -> (string)
            prefix-not-match -> (string)
            pire-regex-match -> (string)
            pire-regex-not-match -> (string)
      http-method -> (struct)
        Match HTTP method.
        http-methods -> ([]struct)
          List of HTTP methods. OR semantics implied.
          match -> (oneof<exact-match|exact-not-match|pire-regex-match|pire-regex-not-match|prefix-match|prefix-not-match>)
            Oneof match field
            exact-match -> (string)
            exact-not-match -> (string)
            prefix-match -> (string)
            prefix-not-match -> (string)
            pire-regex-match -> (string)
            pire-regex-not-match -> (string)
      request-uri -> (struct)
        Match Request URI.
        path -> (struct)
          Path of the URI RFC3986.
          match -> (oneof<exact-match|exact-not-match|pire-regex-match|pire-regex-not-match|prefix-match|prefix-not-match>)
            Oneof match field
            exact-match -> (string)
            exact-not-match -> (string)
            prefix-match -> (string)
            prefix-not-match -> (string)
            pire-regex-match -> (string)
            pire-regex-not-match -> (string)
        queries -> ([]struct)
          List of query matchers. AND semantics implied.
          key -> (string)
            Key of the query parameter.
          value -> (struct)
            Value of the query parameter.
            match -> (oneof<exact-match|exact-not-match|pire-regex-match|pire-regex-not-match|prefix-match|prefix-not-match>)
              Oneof match field
              exact-match -> (string)
              exact-not-match -> (string)
              prefix-match -> (string)
              prefix-not-match -> (string)
              pire-regex-match -> (string)
              pire-regex-not-match -> (string)
      source-ip -> (struct)
        Match IP.
        geo-ip-match -> (struct)
          locations -> ([]string)
            ISO 3166-1 alpha 2. OR semantics implied.
        geo-ip-not-match -> (struct)
          locations -> ([]string)
            ISO 3166-1 alpha 2. OR semantics implied.
        ip-ranges-match -> (struct)
          ip-ranges -> ([]string)
            List of IP ranges. OR semantics implied.
        ip-ranges-not-match -> (struct)
          ip-ranges -> ([]string)
            List of IP ranges. OR semantics implied.
    mode -> (struct)
      Mode of protection.
    waf-profile-id -> (string)
      ID of WAF profile to use in this rule.
``` ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#