---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/smartwebsecurity/cli-ref/waf/waf-profile/create/
---

# yc smartwebsecurity waf waf-profile create

Creates a WAF profile in the specified folder using the data specified in the request.

#### Command Usage

Syntax:

`yc smartwebsecurity waf waf-profile create <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--folder-id` | `string`

ID of the folder to create a WAF profile in. ||
|| `--name` | `string`

Name of the WAF profile. The name is unique within the folder. 1-50 characters long. ||
|| `--description` | `string`

Optional description of the WAF profile. ||
|| `--labels` | `map<string><string>`

Labels as '' key:value '' pairs. Maximum of 64 per resource. ||
|| `--rules` | `shorthand/json`

Settings for each rule in rule set.

{% cut "Description" %}

> - rule-id (string)\
Rule ID.
> - is-enabled (boolean)\
Determines is it rule enabled or not.
> - is-blocking (boolean)\
Determines is it rule blocking or not.

{% endcut %}

{% cut "Shorthand Syntax" %}

```hcl
[
  {
    is-blocking = boolean,
    is-enabled = boolean,
    rule-id = string
  }, ...
]
```

{% endcut %}

{% cut "JSON Syntax" %}

```json
[
  {
    "is-blocking": "boolean",
    "is-enabled": "boolean",
    "rule-id": "string"
  }, ...
]
```

{% endcut %} ||
|| `--exclusion-rules` | `shorthand/json`

List of exclusion rules. See documentation.

{% cut "Description" %}

> - name (string)\
Name of exclusion rule.
> - description (string)\
Optional description of the rule. 0-512 characters long.
> - condition (structure)\
The condition for matching traffic.
>> - authority (structure)\
Match authority (Host header).
>>> - authorities ([]structure)\
List of authorities. OR semantics implied.
>>>> - match (oneof)\
Oneof match field
>>>>> - exact-match (string)\
Exact match condition.
>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>> - prefix-match (string)\
Prefix match condition.
>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>> - authority-matcher (structure)\
Authority matcher.
>>>> - match (oneof)\
Oneof match field
>>>>> - exact-match (string)\
Exact match condition.
>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>> - prefix-match (string)\
Prefix match condition.
>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>> - http-method (structure)\
Match HTTP method.
>>> - http-methods ([]structure)\
List of HTTP methods. OR semantics implied.
>>>> - match (oneof)\
Oneof match field
>>>>> - exact-match (string)\
Exact match condition.
>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>> - prefix-match (string)\
Prefix match condition.
>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>> - http-method-matcher (structure)\
HTTP method matcher.
>>>> - match (oneof)\
Oneof match field
>>>>> - exact-match (string)\
Exact match condition.
>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>> - prefix-match (string)\
Prefix match condition.
>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>> - request-uri (structure)\
Match Request URI.
>>> - path (structure)\
Path of the URI RFC3986.
>>>> - match (oneof)\
Oneof match field
>>>>> - exact-match (string)\
Exact match condition.
>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>> - prefix-match (string)\
Prefix match condition.
>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>> - queries ([]structure)\
List of query matchers. AND semantics implied.
>>>> - key (string)\
Key of the query parameter.
>>>> - value (structure)\
Value of the query parameter.
>>>>> - match (oneof)\
Oneof match field
>>>>>> - exact-match (string)\
Exact match condition.
>>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>>> - prefix-match (string)\
Prefix match condition.
>>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>> - headers ([]structure)\
Match HTTP headers.
>>> - name (string)\
Name of header (case insensitive).
>>> - value (structure)\
Value of the header.
>>>> - match (oneof)\
Oneof match field
>>>>> - exact-match (string)\
Exact match condition.
>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>> - prefix-match (string)\
Prefix match condition.
>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>> - source-ip (structure)\
Match IP.
>>> - ip-ranges-match (structure)\
IP ranges to match with.
>>>> - ip-ranges ([]string)\
List of IP ranges. OR semantics implied.
>>> - ip-ranges-not-match (structure)\
IP ranges to not match with.
>>>> - ip-ranges ([]string)\
List of IP ranges. OR semantics implied.
>>> - geo-ip-match (structure)\
Geo locations to match with.
>>>> - locations ([]string)\
ISO 3166-1 alpha 2. OR semantics implied.
>>> - geo-ip-not-match (structure)\
Geo locations to not match with.
>>>> - locations ([]string)\
ISO 3166-1 alpha 2. OR semantics implied.
>>> - ip-lists-match (structure)\
IP lists to match with.
>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>> - ip-lists-not-match (structure)\
IP lists to not match with.
>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>> - asn-ranges-match (structure)\
ASN ranges to match with.
>>>> - asn-ranges ([]integer)\
List of ASN values to match against. OR semantics implied.
>>> - asn-ranges-not-match (structure)\
ASN ranges to not match with.
>>>> - asn-ranges ([]integer)\
List of ASN values to match against. OR semantics implied.
>>> - asn-lists-match (structure)\
ASN lists to match with.
>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>> - asn-lists-not-match (structure)\
ASN lists to not match with.
>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>> - cookies ([]structure)\
Match cookies.
>>> - name (string)\
Name of the cookie parametr.
>>> - value (structure)\
Value of the cookie parametr.
>>>> - match (oneof)\
Oneof match field
>>>>> - exact-match (string)\
Exact match condition.
>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>> - prefix-match (string)\
Prefix match condition.
>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>> - bot-category (structure)\
Match bot category.
>>> - bot-category-lists-match (structure)\
Bot category lists to match with.
>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>> - bot-category-lists-not-match (structure)\
Bot category lists to not match with.
>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>> - bot-name (structure)\
Match bot name.
>>> - bot-name-lists-match (structure)\
Bot name lists to match with.
>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>> - bot-name-lists-not-match (structure)\
Bot name lists to not match with.
>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>> - bot-score (structure)\
Match bot score.
>>> - value ([]structure)\
List of integer matchers for bot score. OR semantics implied.
>>>> - match (oneof)\
Oneof match field
>>>>> - le-match (structure)\
Less than or equal condition.
>>>>>> - value (integer)\
Upper bound value (inclusive).
>>>>> - ge-match (structure)\
Greater than or equal condition.
>>>>>> - value (integer)\
Lower bound value (inclusive).
>>>>> - eq-match (structure)\
Equal condition.
>>>>>> - value (integer)\
Value to match against.
>>>>> - ne-match (structure)\
Not equal condition.
>>>>>> - value (integer)\
Value to not match against.
>> - verified-bot (structure)\
Match verified bot.
>>> - verified (structure)\
Matches if the bot is verified or not.
>>>> - match (boolean)\
Boolean value to match against.
>> - finger-print (structure)\
Match fingerprint.
>>> - ja3-ranges ([]structure)\
List of JA3 fingerprint matchers. OR semantics implied.
>>>> - match (oneof)\
Oneof match field
>>>>> - exact-match (string)\
Exact match condition.
>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>> - prefix-match (string)\
Prefix match condition.
>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>> - ja4-ranges ([]structure)\
List of JA4 fingerprint matchers. OR semantics implied.
>>>> - match (oneof)\
Oneof match field
>>>>> - exact-match (string)\
Exact match condition.
>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>> - prefix-match (string)\
Prefix match condition.
>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>> - ja3-matcher (structure)\
JA3 fingerprint matcher.
>>>> - match (oneof)\
Oneof match field
>>>>> - exact-match (string)\
Exact match condition.
>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>> - prefix-match (string)\
Prefix match condition.
>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>> - ja4-matcher (structure)\
JA4 fingerprint matcher.
>>>> - match (oneof)\
Oneof match field
>>>>> - exact-match (string)\
Exact match condition.
>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>> - prefix-match (string)\
Prefix match condition.
>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
> - exclude-rules (structure)\
Exclude rules.
>> - exclude-all (boolean)\
Set this option true to exclude all rules.
>> - rule-ids ([]string)\
List of rules to exclude.
> - log-excluded (boolean)\
Records the fact that an exception rule is triggered.
> - request-condition (structure)\
Additional condition applied to specific parts of the request to refine when the exclusion is triggered.
>> - param-matcher (structure)\
Matcher for request query parameters.
>>> - param-names ([]structure)\
List of request query parameter names to match. Up to 20 entries.
>>>> - value (string)\
String value to match against.
>>>> - case-sensitive (boolean)\
Whether the match is case sensitive.
>> - header-matcher (structure)\
Matcher for request headers.
>>> - header-names ([]structure)\
List of request header names to match. Up to 20 entries.
>>>> - value (string)\
String value to match against.
>>>> - case-sensitive (boolean)\
Whether the match is case sensitive.
>> - cookie-matcher (structure)\
Matcher for request cookies.
>>> - cookie-names ([]structure)\
List of cookie names to match. Up to 20 entries.
>>>> - value (string)\
String value to match against.
>>>> - case-sensitive (boolean)\
Whether the match is case sensitive.
>> - body-matcher (structure)\
Matcher for request body.
>>> - body-values ([]structure)\
List of request body values to match. Up to 20 entries.
>>>> - value (string)\
String value to match against.
>>>> - case-sensitive (boolean)\
Whether the match is case sensitive.

{% endcut %}

{% cut "Shorthand Syntax" %}

```hcl
[
  {
    condition = {
      authority = {
        authorities = [
          {
            match = defined=boolean | exact-match=string | exact-not-match=string | lists-matchers={
              reg-exp-lists-match = {
                list-ids = string,...
              },
              reg-exp-lists-not-match = {
                list-ids = string,...
              },
              str-lists-match = {
                list-ids = string,...
              },
              str-lists-not-match = {
                list-ids = string,...
              }
            } | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
          }, ...
        ],
        authority-matcher = {
          match = defined=boolean | exact-match=string | exact-not-match=string | lists-matchers={
            reg-exp-lists-match = {
              list-ids = string,...
            },
            reg-exp-lists-not-match = {
              list-ids = string,...
            },
            str-lists-match = {
              list-ids = string,...
            },
            str-lists-not-match = {
              list-ids = string,...
            }
          } | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
        }
      },
      bot-category = {
        bot-category-lists-match = {
          list-ids = string,...
        },
        bot-category-lists-not-match = {
          list-ids = string,...
        }
      },
      bot-name = {
        bot-name-lists-match = {
          list-ids = string,...
        },
        bot-name-lists-not-match = {
          list-ids = string,...
        }
      },
      bot-score = {
        value = [
          {
            match = eq-match={
              value = integer
            } | ge-match={
              value = integer
            } | le-match={
              value = integer
            } | ne-match={
              value = integer
            }
          }, ...
        ]
      },
      cookies = [
        {
          name = string,
          value = {
            match = defined=boolean | exact-match=string | exact-not-match=string | lists-matchers={
              reg-exp-lists-match = {
                list-ids = string,...
              },
              reg-exp-lists-not-match = {
                list-ids = string,...
              },
              str-lists-match = {
                list-ids = string,...
              },
              str-lists-not-match = {
                list-ids = string,...
              }
            } | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
          }
        }, ...
      ],
      finger-print = {
        ja3-matcher = {
          match = defined=boolean | exact-match=string | exact-not-match=string | lists-matchers={
            reg-exp-lists-match = {
              list-ids = string,...
            },
            reg-exp-lists-not-match = {
              list-ids = string,...
            },
            str-lists-match = {
              list-ids = string,...
            },
            str-lists-not-match = {
              list-ids = string,...
            }
          } | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
        },
        ja3-ranges = [
          {
            match = defined=boolean | exact-match=string | exact-not-match=string | lists-matchers={
              reg-exp-lists-match = {
                list-ids = string,...
              },
              reg-exp-lists-not-match = {
                list-ids = string,...
              },
              str-lists-match = {
                list-ids = string,...
              },
              str-lists-not-match = {
                list-ids = string,...
              }
            } | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
          }, ...
        ],
        ja4-matcher = {
          match = defined=boolean | exact-match=string | exact-not-match=string | lists-matchers={
            reg-exp-lists-match = {
              list-ids = string,...
            },
            reg-exp-lists-not-match = {
              list-ids = string,...
            },
            str-lists-match = {
              list-ids = string,...
            },
            str-lists-not-match = {
              list-ids = string,...
            }
          } | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
        },
        ja4-ranges = [
          {
            match = defined=boolean | exact-match=string | exact-not-match=string | lists-matchers={
              reg-exp-lists-match = {
                list-ids = string,...
              },
              reg-exp-lists-not-match = {
                list-ids = string,...
              },
              str-lists-match = {
                list-ids = string,...
              },
              str-lists-not-match = {
                list-ids = string,...
              }
            } | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
          }, ...
        ]
      },
      headers = [
        {
          name = string,
          value = {
            match = defined=boolean | exact-match=string | exact-not-match=string | lists-matchers={
              reg-exp-lists-match = {
                list-ids = string,...
              },
              reg-exp-lists-not-match = {
                list-ids = string,...
              },
              str-lists-match = {
                list-ids = string,...
              },
              str-lists-not-match = {
                list-ids = string,...
              }
            } | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
          }
        }, ...
      ],
      http-method = {
        http-method-matcher = {
          match = defined=boolean | exact-match=string | exact-not-match=string | lists-matchers={
            reg-exp-lists-match = {
              list-ids = string,...
            },
            reg-exp-lists-not-match = {
              list-ids = string,...
            },
            str-lists-match = {
              list-ids = string,...
            },
            str-lists-not-match = {
              list-ids = string,...
            }
          } | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
        },
        http-methods = [
          {
            match = defined=boolean | exact-match=string | exact-not-match=string | lists-matchers={
              reg-exp-lists-match = {
                list-ids = string,...
              },
              reg-exp-lists-not-match = {
                list-ids = string,...
              },
              str-lists-match = {
                list-ids = string,...
              },
              str-lists-not-match = {
                list-ids = string,...
              }
            } | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
          }, ...
        ]
      },
      request-uri = {
        path = {
          match = defined=boolean | exact-match=string | exact-not-match=string | lists-matchers={
            reg-exp-lists-match = {
              list-ids = string,...
            },
            reg-exp-lists-not-match = {
              list-ids = string,...
            },
            str-lists-match = {
              list-ids = string,...
            },
            str-lists-not-match = {
              list-ids = string,...
            }
          } | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
        },
        queries = [
          {
            key = string,
            value = {
              match = defined=boolean | exact-match=string | exact-not-match=string | lists-matchers={
                reg-exp-lists-match = {
                  list-ids = string,...
                },
                reg-exp-lists-not-match = {
                  list-ids = string,...
                },
                str-lists-match = {
                  list-ids = string,...
                },
                str-lists-not-match = {
                  list-ids = string,...
                }
              } | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
            }
          }, ...
        ]
      },
      source-ip = {
        asn-lists-match = {
          list-ids = string,...
        },
        asn-lists-not-match = {
          list-ids = string,...
        },
        asn-ranges-match = {
          asn-ranges = integer,...
        },
        asn-ranges-not-match = {
          asn-ranges = integer,...
        },
        geo-ip-match = {
          locations = string,...
        },
        geo-ip-not-match = {
          locations = string,...
        },
        ip-lists-match = {
          list-ids = string,...
        },
        ip-lists-not-match = {
          list-ids = string,...
        },
        ip-ranges-match = {
          ip-ranges = string,...
        },
        ip-ranges-not-match = {
          ip-ranges = string,...
        }
      },
      verified-bot = {
        verified = {
          match = boolean
        }
      }
    },
    description = string,
    exclude-rules = {
      exclude-all = boolean,
      rule-ids = string,...
    },
    log-excluded = boolean,
    name = string,
    request-condition = {
      body-matcher = {
        body-values = [
          {
            case-sensitive = boolean,
            value = string
          }, ...
        ]
      },
      cookie-matcher = {
        cookie-names = [
          {
            case-sensitive = boolean,
            value = string
          }, ...
        ]
      },
      header-matcher = {
        header-names = [
          {
            case-sensitive = boolean,
            value = string
          }, ...
        ]
      },
      param-matcher = {
        param-names = [
          {
            case-sensitive = boolean,
            value = string
          }, ...
        ]
      }
    }
  }, ...
]
```

{% endcut %}

{% cut "JSON Syntax" %}

```json
[
  {
    "condition": {
      "authority": {
        "authorities": [
          {
            "match": {
              "defined": "boolean",
              "exact-match": "string",
              "exact-not-match": "string",
              "lists-matchers": {
                "reg-exp-lists-match": {
                  "list-ids": [
                    "string", ...
                  ]
                },
                "reg-exp-lists-not-match": {
                  "list-ids": [
                    "string", ...
                  ]
                },
                "str-lists-match": {
                  "list-ids": [
                    "string", ...
                  ]
                },
                "str-lists-not-match": {
                  "list-ids": [
                    "string", ...
                  ]
                }
              },
              "pire-regex-match": "string",
              "pire-regex-not-match": "string",
              "prefix-match": "string",
              "prefix-not-match": "string"
            }
          }, ...
        ],
        "authority-matcher": {
          "match": {
            "defined": "boolean",
            "exact-match": "string",
            "exact-not-match": "string",
            "lists-matchers": {
              "reg-exp-lists-match": {
                "list-ids": [
                  "string", ...
                ]
              },
              "reg-exp-lists-not-match": {
                "list-ids": [
                  "string", ...
                ]
              },
              "str-lists-match": {
                "list-ids": [
                  "string", ...
                ]
              },
              "str-lists-not-match": {
                "list-ids": [
                  "string", ...
                ]
              }
            },
            "pire-regex-match": "string",
            "pire-regex-not-match": "string",
            "prefix-match": "string",
            "prefix-not-match": "string"
          }
        }
      },
      "bot-category": {
        "bot-category-lists-match": {
          "list-ids": [
            "string", ...
          ]
        },
        "bot-category-lists-not-match": {
          "list-ids": [
            "string", ...
          ]
        }
      },
      "bot-name": {
        "bot-name-lists-match": {
          "list-ids": [
            "string", ...
          ]
        },
        "bot-name-lists-not-match": {
          "list-ids": [
            "string", ...
          ]
        }
      },
      "bot-score": {
        "value": [
          {
            "match": {
              "eq-match": {
                "value": "integer"
              },
              "ge-match": {
                "value": "integer"
              },
              "le-match": {
                "value": "integer"
              },
              "ne-match": {
                "value": "integer"
              }
            }
          }, ...
        ]
      },
      "cookies": [
        {
          "name": "string",
          "value": {
            "match": {
              "defined": "boolean",
              "exact-match": "string",
              "exact-not-match": "string",
              "lists-matchers": {
                "reg-exp-lists-match": {
                  "list-ids": [
                    "string", ...
                  ]
                },
                "reg-exp-lists-not-match": {
                  "list-ids": [
                    "string", ...
                  ]
                },
                "str-lists-match": {
                  "list-ids": [
                    "string", ...
                  ]
                },
                "str-lists-not-match": {
                  "list-ids": [
                    "string", ...
                  ]
                }
              },
              "pire-regex-match": "string",
              "pire-regex-not-match": "string",
              "prefix-match": "string",
              "prefix-not-match": "string"
            }
          }
        }, ...
      ],
      "finger-print": {
        "ja3-matcher": {
          "match": {
            "defined": "boolean",
            "exact-match": "string",
            "exact-not-match": "string",
            "lists-matchers": {
              "reg-exp-lists-match": {
                "list-ids": [
                  "string", ...
                ]
              },
              "reg-exp-lists-not-match": {
                "list-ids": [
                  "string", ...
                ]
              },
              "str-lists-match": {
                "list-ids": [
                  "string", ...
                ]
              },
              "str-lists-not-match": {
                "list-ids": [
                  "string", ...
                ]
              }
            },
            "pire-regex-match": "string",
            "pire-regex-not-match": "string",
            "prefix-match": "string",
            "prefix-not-match": "string"
          }
        },
        "ja3-ranges": [
          {
            "match": {
              "defined": "boolean",
              "exact-match": "string",
              "exact-not-match": "string",
              "lists-matchers": {
                "reg-exp-lists-match": {
                  "list-ids": [
                    "string", ...
                  ]
                },
                "reg-exp-lists-not-match": {
                  "list-ids": [
                    "string", ...
                  ]
                },
                "str-lists-match": {
                  "list-ids": [
                    "string", ...
                  ]
                },
                "str-lists-not-match": {
                  "list-ids": [
                    "string", ...
                  ]
                }
              },
              "pire-regex-match": "string",
              "pire-regex-not-match": "string",
              "prefix-match": "string",
              "prefix-not-match": "string"
            }
          }, ...
        ],
        "ja4-matcher": {
          "match": {
            "defined": "boolean",
            "exact-match": "string",
            "exact-not-match": "string",
            "lists-matchers": {
              "reg-exp-lists-match": {
                "list-ids": [
                  "string", ...
                ]
              },
              "reg-exp-lists-not-match": {
                "list-ids": [
                  "string", ...
                ]
              },
              "str-lists-match": {
                "list-ids": [
                  "string", ...
                ]
              },
              "str-lists-not-match": {
                "list-ids": [
                  "string", ...
                ]
              }
            },
            "pire-regex-match": "string",
            "pire-regex-not-match": "string",
            "prefix-match": "string",
            "prefix-not-match": "string"
          }
        },
        "ja4-ranges": [
          {
            "match": {
              "defined": "boolean",
              "exact-match": "string",
              "exact-not-match": "string",
              "lists-matchers": {
                "reg-exp-lists-match": {
                  "list-ids": [
                    "string", ...
                  ]
                },
                "reg-exp-lists-not-match": {
                  "list-ids": [
                    "string", ...
                  ]
                },
                "str-lists-match": {
                  "list-ids": [
                    "string", ...
                  ]
                },
                "str-lists-not-match": {
                  "list-ids": [
                    "string", ...
                  ]
                }
              },
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
              "defined": "boolean",
              "exact-match": "string",
              "exact-not-match": "string",
              "lists-matchers": {
                "reg-exp-lists-match": {
                  "list-ids": [
                    "string", ...
                  ]
                },
                "reg-exp-lists-not-match": {
                  "list-ids": [
                    "string", ...
                  ]
                },
                "str-lists-match": {
                  "list-ids": [
                    "string", ...
                  ]
                },
                "str-lists-not-match": {
                  "list-ids": [
                    "string", ...
                  ]
                }
              },
              "pire-regex-match": "string",
              "pire-regex-not-match": "string",
              "prefix-match": "string",
              "prefix-not-match": "string"
            }
          }
        }, ...
      ],
      "http-method": {
        "http-method-matcher": {
          "match": {
            "defined": "boolean",
            "exact-match": "string",
            "exact-not-match": "string",
            "lists-matchers": {
              "reg-exp-lists-match": {
                "list-ids": [
                  "string", ...
                ]
              },
              "reg-exp-lists-not-match": {
                "list-ids": [
                  "string", ...
                ]
              },
              "str-lists-match": {
                "list-ids": [
                  "string", ...
                ]
              },
              "str-lists-not-match": {
                "list-ids": [
                  "string", ...
                ]
              }
            },
            "pire-regex-match": "string",
            "pire-regex-not-match": "string",
            "prefix-match": "string",
            "prefix-not-match": "string"
          }
        },
        "http-methods": [
          {
            "match": {
              "defined": "boolean",
              "exact-match": "string",
              "exact-not-match": "string",
              "lists-matchers": {
                "reg-exp-lists-match": {
                  "list-ids": [
                    "string", ...
                  ]
                },
                "reg-exp-lists-not-match": {
                  "list-ids": [
                    "string", ...
                  ]
                },
                "str-lists-match": {
                  "list-ids": [
                    "string", ...
                  ]
                },
                "str-lists-not-match": {
                  "list-ids": [
                    "string", ...
                  ]
                }
              },
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
            "defined": "boolean",
            "exact-match": "string",
            "exact-not-match": "string",
            "lists-matchers": {
              "reg-exp-lists-match": {
                "list-ids": [
                  "string", ...
                ]
              },
              "reg-exp-lists-not-match": {
                "list-ids": [
                  "string", ...
                ]
              },
              "str-lists-match": {
                "list-ids": [
                  "string", ...
                ]
              },
              "str-lists-not-match": {
                "list-ids": [
                  "string", ...
                ]
              }
            },
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
                "defined": "boolean",
                "exact-match": "string",
                "exact-not-match": "string",
                "lists-matchers": {
                  "reg-exp-lists-match": {
                    "list-ids": [
                      "string", ...
                    ]
                  },
                  "reg-exp-lists-not-match": {
                    "list-ids": [
                      "string", ...
                    ]
                  },
                  "str-lists-match": {
                    "list-ids": [
                      "string", ...
                    ]
                  },
                  "str-lists-not-match": {
                    "list-ids": [
                      "string", ...
                    ]
                  }
                },
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
        "asn-lists-match": {
          "list-ids": [
            "string", ...
          ]
        },
        "asn-lists-not-match": {
          "list-ids": [
            "string", ...
          ]
        },
        "asn-ranges-match": {
          "asn-ranges": [
            "integer", ...
          ]
        },
        "asn-ranges-not-match": {
          "asn-ranges": [
            "integer", ...
          ]
        },
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
        "ip-lists-match": {
          "list-ids": [
            "string", ...
          ]
        },
        "ip-lists-not-match": {
          "list-ids": [
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
      },
      "verified-bot": {
        "verified": {
          "match": "boolean"
        }
      }
    },
    "description": "string",
    "exclude-rules": {
      "exclude-all": "boolean",
      "rule-ids": [
        "string", ...
      ]
    },
    "log-excluded": "boolean",
    "name": "string",
    "request-condition": {
      "body-matcher": {
        "body-values": [
          {
            "case-sensitive": "boolean",
            "value": "string"
          }, ...
        ]
      },
      "cookie-matcher": {
        "cookie-names": [
          {
            "case-sensitive": "boolean",
            "value": "string"
          }, ...
        ]
      },
      "header-matcher": {
        "header-names": [
          {
            "case-sensitive": "boolean",
            "value": "string"
          }, ...
        ]
      },
      "param-matcher": {
        "param-names": [
          {
            "case-sensitive": "boolean",
            "value": "string"
          }, ...
        ]
      }
    }
  }, ...
]
```

{% endcut %} ||
|| `--analyze-request-body` | `shorthand/json`

Parameters for request body analyzer.

{% cut "Description" %}

> - is-enabled (boolean)\
Possible to turn analyzer on and turn if off.
> - size-limit (integer)\
Maximum size of body to pass to analyzer. In kilobytes.
> - size-limit-action (structure)\
Action to perform if maximum size of body exceeded.

{% endcut %}

{% cut "Shorthand Syntax" %}

```hcl
{
  is-enabled = boolean,
  size-limit = integer,
  size-limit-action = IGNORE|DENY
}
```

{% endcut %}

{% cut "JSON Syntax" %}

```json
{
  "is-enabled": "boolean",
  "size-limit": "integer",
  "size-limit-action": "IGNORE|DENY"
}
```

{% endcut %} ||
|| `--rule-sets` | `shorthand/json`

List of rule sets. See documentation.

{% cut "Description" %}

> - priority (integer)\
Priority of rule set.
> - is-enabled (boolean)\
Determines is it rule set enabled or not.
> - action (structure)\
Action to perfome on rule set match.
> - rule-set (oneof)\
Oneof rule-set field
>> - core-rule-set (structure)\
Core rule set settings. See documentation for details.
>>> - rule-set (structure)\
Rule set.
>>>> - name (string)\
Name of rule set.
>>>> - version (string)\
Version of rule set.
>>>> - type (structure)\
Type of rule set.
>>>> - id (string)\
ID of rule set.
>>> - inbound-anomaly-score (integer)\
Anomaly score. Enter an integer within the range of 2 and 10000. The higher this value, the more likely it is that the request that satisfies the rule is an attack. See documentation for more details.
>>> - paranoia-level (integer)\
Paranoia level. Enter an integer within the range of 1 and 4. Paranoia level classifies rules according to their aggression. The higher the paranoia level, the better your protection, but also the higher the probability of WAF false positives. See documentation for more details. NOTE: this option has no effect on enabling or disabling rules. it is used only as recommendation for user to enable all rules with paranoia_level <= this value.
>> - ya-rule-set (structure)\
Yandex rule set settings.
>>> - rule-set (structure)\
Rule set.
>>>> - name (string)\
Name of rule set.
>>>> - version (string)\
Version of rule set.
>>>> - type (structure)\
Type of rule set.
>>>> - id (string)\
ID of rule set.
>>> - rule-groups ([]structure)\
List of rule groups.
>>>> - id (string)\
ID of the rule group.
>>>> - action (structure)\
Action to perfome on rule group match.
>>>> - inbound-anomaly-score (integer)\
Anomaly score.
>>>> - is-enabled (boolean)\
Determines is it rule group enabled or not.
>> - ml-rule-set (structure)\
Yandex Machine learning rule set settings.
>>> - rule-set (structure)\
Rule set.
>>>> - name (string)\
Name of rule set.
>>>> - version (string)\
Version of rule set.
>>>> - type (structure)\
Type of rule set.
>>>> - id (string)\
ID of rule set.
>>> - rule-groups ([]structure)\
List of rule groups.
>>>> - id (string)\
ID of the rule group.
>>>> - action (structure)\
Action to perfome on rule group match.
>>>> - inbound-anomaly-score (integer)\
Anomaly score.
>>>> - is-enabled (boolean)\
Determines is it rule group enabled or not.

{% endcut %}

{% cut "Shorthand Syntax" %}

```hcl
[
  {
    action = DENY|CAPTCHA,
    is-enabled = boolean,
    priority = integer,
    rule-set = core-rule-set={
      inbound-anomaly-score = integer,
      paranoia-level = integer,
      rule-set = {
        id = string,
        name = string,
        type = CORE|YA|ML,
        version = string
      }
    } | ml-rule-set={
      rule-groups = [
        {
          action = DENY|LOG|IGNORE,
          id = string,
          inbound-anomaly-score = integer,
          is-enabled = boolean
        }, ...
      ],
      rule-set = {
        id = string,
        name = string,
        type = CORE|YA|ML,
        version = string
      }
    } | ya-rule-set={
      rule-groups = [
        {
          action = DENY|LOG|IGNORE,
          id = string,
          inbound-anomaly-score = integer,
          is-enabled = boolean
        }, ...
      ],
      rule-set = {
        id = string,
        name = string,
        type = CORE|YA|ML,
        version = string
      }
    }
  }, ...
]
```

{% endcut %}

{% cut "JSON Syntax" %}

```json
[
  {
    "action": "DENY|CAPTCHA",
    "is-enabled": "boolean",
    "priority": "integer",
    "rule-set": {
      "core-rule-set": {
        "inbound-anomaly-score": "integer",
        "paranoia-level": "integer",
        "rule-set": {
          "id": "string",
          "name": "string",
          "type": "CORE|YA|ML",
          "version": "string"
        }
      },
      "ml-rule-set": {
        "rule-groups": [
          {
            "action": "DENY|LOG|IGNORE",
            "id": "string",
            "inbound-anomaly-score": "integer",
            "is-enabled": "boolean"
          }, ...
        ],
        "rule-set": {
          "id": "string",
          "name": "string",
          "type": "CORE|YA|ML",
          "version": "string"
        }
      },
      "ya-rule-set": {
        "rule-groups": [
          {
            "action": "DENY|LOG|IGNORE",
            "id": "string",
            "inbound-anomaly-score": "integer",
            "is-enabled": "boolean"
          }, ...
        ],
        "rule-set": {
          "id": "string",
          "name": "string",
          "type": "CORE|YA|ML",
          "version": "string"
        }
      }
    }
  }, ...
]
```

{% endcut %} ||
|| `--match-all-rule-sets` | Parameter determines should all rule sets be matched. ||
|| `--core-rule-set` | `shorthand/json`

Core rule set settings. See documentation for details.

{% cut "Description" %}

> - inbound-anomaly-score (integer)\
Anomaly score. Enter an integer within the range of 2 and 10000. The higher this value, the more likely it is that the request that satisfies the rule is an attack. See documentation for more details.
> - paranoia-level (integer)\
Paranoia level. Enter an integer within the range of 1 and 4. Paranoia level classifies rules according to their aggression. The higher the paranoia level, the better your protection, but also the higher the probability of WAF false positives. See documentation for more details. NOTE: this option has no effect on enabling or disabling rules. it is used only as recommendation for user to enable all rules with paranoia_level <= this value.
> - rule-set (structure)\
Rule set.
>> - name (string)\
Name of rule set.
>> - version (string)\
Version of rule set.
>> - type (structure)\
Type of rule set.
>> - id (string)\
ID of rule set.

{% endcut %}

{% cut "Shorthand Syntax" %}

```hcl
{
  inbound-anomaly-score = integer,
  paranoia-level = integer,
  rule-set = {
    id = string,
    name = string,
    type = CORE|YA|ML,
    version = string
  }
}
```

{% endcut %}

{% cut "JSON Syntax" %}

```json
{
  "inbound-anomaly-score": "integer",
  "paranoia-level": "integer",
  "rule-set": {
    "id": "string",
    "name": "string",
    "type": "CORE|YA|ML",
    "version": "string"
  }
}
```

{% endcut %} ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request. ||
|| `-e`, `--example-yaml` | Generates a YAML template of the request.

The template can be customized and used as input for the command.

Usage example:

1. Generate template:
yc smartwebsecurity waf waf-profile create --example-json > request.json
or
yc smartwebsecurity waf waf-profile create --example-yaml > request.yaml

2. Edit the template file

3. Run with template:
yc smartwebsecurity waf waf-profile create -r request.json
or
yc smartwebsecurity waf waf-profile create -r request.yaml ||
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
|| `--no-pager` | Do not pipe help output through a pager. ||
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
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#