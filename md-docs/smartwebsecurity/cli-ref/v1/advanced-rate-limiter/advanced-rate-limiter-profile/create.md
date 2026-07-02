[Документация Yandex Cloud](../../../../../index.md) > [Yandex Smart Web Security](../../../../index.md) > [Справочник CLI (англ.)](../../../index.md) > [v1](../../index.md) > [advanced-rate-limiter](../index.md) > [advanced-rate-limiter-profile](index.md) > create

# yc smartwebsecurity v1 advanced-rate-limiter advanced-rate-limiter-profile create

Creates a ARL profile in the specified folder using the data specified in the request.

#### Command Usage

Syntax:

`yc smartwebsecurity v1 advanced-rate-limiter advanced-rate-limiter-profile create <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--folder-id` | `string`

ID of the folder to create a ARL profile in. ||
|| `--labels` | `map<string><string>`

Labels as '' key:value '' pairs. Maximum of 64 per resource. ||
|| `--name` | `string`

Name of the ARL profile. The name is unique within the folder. 1-50 characters long. ||
|| `--description` | `string`

Optional description of the ARL profile. ||
|| `--advanced-rate-limiter-rules` | `shorthand/json`

List of rules.

{% cut "Description" %}

> - name (string)\
Name of the rule. The name is unique within the ARL profile. 1-50 characters long.
> - priority (integer)\
Determines the priority in case there are several matched rules. Enter an integer within the range of 1 and 999999. The rule priority must be unique within the entire ARL profile. A lower numeric value means a higher priority.
> - description (string)\
Optional description of the rule. 0-512 characters long.
> - dry-run (boolean)\
This allows you to evaluate backend capabilities and find the optimum limit values. Requests will not be blocked in this mode.
> - rule-specifier (oneof)\
Oneof rule-specifier field
>> - static-quota (structure)\
Static quota. Counting each request individually.
>>> - action (structure)\
Action in case of exceeding this quota.
>>> - condition (structure)\
The condition for matching the quota.
>>>> - authority (structure)\
Match authority (Host header).
>>>>> - authorities ([]structure)\
List of authorities. OR semantics implied.
>>>>>> - match (oneof)\
Oneof match field
>>>>>>> - exact-match (string)\
Exact match condition.
>>>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>>>> - prefix-match (string)\
Prefix match condition.
>>>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>> - authority-matcher (structure)\
Authority matcher.
>>>>>> - match (oneof)\
Oneof match field
>>>>>>> - exact-match (string)\
Exact match condition.
>>>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>>>> - prefix-match (string)\
Prefix match condition.
>>>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>> - http-method (structure)\
Match HTTP method.
>>>>> - http-methods ([]structure)\
List of HTTP methods. OR semantics implied.
>>>>>> - match (oneof)\
Oneof match field
>>>>>>> - exact-match (string)\
Exact match condition.
>>>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>>>> - prefix-match (string)\
Prefix match condition.
>>>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>> - http-method-matcher (structure)\
HTTP method matcher.
>>>>>> - match (oneof)\
Oneof match field
>>>>>>> - exact-match (string)\
Exact match condition.
>>>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>>>> - prefix-match (string)\
Prefix match condition.
>>>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>> - request-uri (structure)\
Match Request URI.
>>>>> - path (structure)\
Path of the URI RFC3986.
>>>>>> - match (oneof)\
Oneof match field
>>>>>>> - exact-match (string)\
Exact match condition.
>>>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>>>> - prefix-match (string)\
Prefix match condition.
>>>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>> - queries ([]structure)\
List of query matchers. AND semantics implied.
>>>>>> - key (string)\
Key of the query parameter.
>>>>>> - value (structure)\
Value of the query parameter.
>>>>>>> - match (oneof)\
Oneof match field
>>>>>>>> - exact-match (string)\
Exact match condition.
>>>>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>>>>> - prefix-match (string)\
Prefix match condition.
>>>>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>> - headers ([]structure)\
Match HTTP headers.
>>>>> - name (string)\
Name of header (case insensitive).
>>>>> - value (structure)\
Value of the header.
>>>>>> - match (oneof)\
Oneof match field
>>>>>>> - exact-match (string)\
Exact match condition.
>>>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>>>> - prefix-match (string)\
Prefix match condition.
>>>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>> - source-ip (structure)\
Match IP.
>>>>> - ip-ranges-match (structure)\
IP ranges to match with.
>>>>>> - ip-ranges ([]string)\
List of IP ranges. OR semantics implied.
>>>>> - ip-ranges-not-match (structure)\
IP ranges to not match with.
>>>>>> - ip-ranges ([]string)\
List of IP ranges. OR semantics implied.
>>>>> - geo-ip-match (structure)\
Geo locations to match with.
>>>>>> - locations ([]string)\
ISO 3166-1 alpha 2. OR semantics implied.
>>>>> - geo-ip-not-match (structure)\
Geo locations to not match with.
>>>>>> - locations ([]string)\
ISO 3166-1 alpha 2. OR semantics implied.
>>>>> - ip-lists-match (structure)\
IP lists to match with.
>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>> - ip-lists-not-match (structure)\
IP lists to not match with.
>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>> - asn-ranges-match (structure)\
ASN ranges to match with.
>>>>>> - asn-ranges ([]integer)\
List of ASN values to match against. OR semantics implied.
>>>>> - asn-ranges-not-match (structure)\
ASN ranges to not match with.
>>>>>> - asn-ranges ([]integer)\
List of ASN values to match against. OR semantics implied.
>>>>> - asn-lists-match (structure)\
ASN lists to match with.
>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>> - asn-lists-not-match (structure)\
ASN lists to not match with.
>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>> - cookies ([]structure)\
Match cookies.
>>>>> - name (string)\
Name of the cookie parametr.
>>>>> - value (structure)\
Value of the cookie parametr.
>>>>>> - match (oneof)\
Oneof match field
>>>>>>> - exact-match (string)\
Exact match condition.
>>>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>>>> - prefix-match (string)\
Prefix match condition.
>>>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>> - bot-category (structure)\
Match bot category.
>>>>> - bot-category-lists-match (structure)\
Bot category lists to match with.
>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>> - bot-category-lists-not-match (structure)\
Bot category lists to not match with.
>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>> - bot-name (structure)\
Match bot name.
>>>>> - bot-name-lists-match (structure)\
Bot name lists to match with.
>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>> - bot-name-lists-not-match (structure)\
Bot name lists to not match with.
>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>> - bot-score (structure)\
Match bot score.
>>>>> - value ([]structure)\
List of integer matchers for bot score. OR semantics implied.
>>>>>> - match (oneof)\
Oneof match field
>>>>>>> - le-match (structure)\
Less than or equal condition.
>>>>>>>> - value (integer)\
Upper bound value (inclusive).
>>>>>>> - ge-match (structure)\
Greater than or equal condition.
>>>>>>>> - value (integer)\
Lower bound value (inclusive).
>>>>>>> - eq-match (structure)\
Equal condition.
>>>>>>>> - value (integer)\
Value to match against.
>>>>>>> - ne-match (structure)\
Not equal condition.
>>>>>>>> - value (integer)\
Value to not match against.
>>>> - verified-bot (structure)\
Match verified bot.
>>>>> - verified (structure)\
Matches if the bot is verified or not.
>>>>>> - match (boolean)\
Boolean value to match against.
>>>> - finger-print (structure)\
Match fingerprint.
>>>>> - ja3-ranges ([]structure)\
List of JA3 fingerprint matchers. OR semantics implied.
>>>>>> - match (oneof)\
Oneof match field
>>>>>>> - exact-match (string)\
Exact match condition.
>>>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>>>> - prefix-match (string)\
Prefix match condition.
>>>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>> - ja4-ranges ([]structure)\
List of JA4 fingerprint matchers. OR semantics implied.
>>>>>> - match (oneof)\
Oneof match field
>>>>>>> - exact-match (string)\
Exact match condition.
>>>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>>>> - prefix-match (string)\
Prefix match condition.
>>>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>> - ja3-matcher (structure)\
JA3 fingerprint matcher.
>>>>>> - match (oneof)\
Oneof match field
>>>>>>> - exact-match (string)\
Exact match condition.
>>>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>>>> - prefix-match (string)\
Prefix match condition.
>>>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>> - ja4-matcher (structure)\
JA4 fingerprint matcher.
>>>>>> - match (oneof)\
Oneof match field
>>>>>>> - exact-match (string)\
Exact match condition.
>>>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>>>> - prefix-match (string)\
Prefix match condition.
>>>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>> - limit (integer)\
Desired maximum number of requests per period. Enter an integer within the range of 1 and 9999999999999.
>>> - period (integer)\
Period of time in seconds.
>> - dynamic-quota (structure)\
Dynamic quota. Grouping requests by a certain attribute and limiting the number of groups.
>>> - action (structure)\
Action in case of exceeding this quota.
>>> - condition (structure)\
The condition for matching the quota.
>>>> - authority (structure)\
Match authority (Host header).
>>>>> - authorities ([]structure)\
List of authorities. OR semantics implied.
>>>>>> - match (oneof)\
Oneof match field
>>>>>>> - exact-match (string)\
Exact match condition.
>>>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>>>> - prefix-match (string)\
Prefix match condition.
>>>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>> - authority-matcher (structure)\
Authority matcher.
>>>>>> - match (oneof)\
Oneof match field
>>>>>>> - exact-match (string)\
Exact match condition.
>>>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>>>> - prefix-match (string)\
Prefix match condition.
>>>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>> - http-method (structure)\
Match HTTP method.
>>>>> - http-methods ([]structure)\
List of HTTP methods. OR semantics implied.
>>>>>> - match (oneof)\
Oneof match field
>>>>>>> - exact-match (string)\
Exact match condition.
>>>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>>>> - prefix-match (string)\
Prefix match condition.
>>>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>> - http-method-matcher (structure)\
HTTP method matcher.
>>>>>> - match (oneof)\
Oneof match field
>>>>>>> - exact-match (string)\
Exact match condition.
>>>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>>>> - prefix-match (string)\
Prefix match condition.
>>>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>> - request-uri (structure)\
Match Request URI.
>>>>> - path (structure)\
Path of the URI RFC3986.
>>>>>> - match (oneof)\
Oneof match field
>>>>>>> - exact-match (string)\
Exact match condition.
>>>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>>>> - prefix-match (string)\
Prefix match condition.
>>>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>> - queries ([]structure)\
List of query matchers. AND semantics implied.
>>>>>> - key (string)\
Key of the query parameter.
>>>>>> - value (structure)\
Value of the query parameter.
>>>>>>> - match (oneof)\
Oneof match field
>>>>>>>> - exact-match (string)\
Exact match condition.
>>>>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>>>>> - prefix-match (string)\
Prefix match condition.
>>>>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>> - headers ([]structure)\
Match HTTP headers.
>>>>> - name (string)\
Name of header (case insensitive).
>>>>> - value (structure)\
Value of the header.
>>>>>> - match (oneof)\
Oneof match field
>>>>>>> - exact-match (string)\
Exact match condition.
>>>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>>>> - prefix-match (string)\
Prefix match condition.
>>>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>> - source-ip (structure)\
Match IP.
>>>>> - ip-ranges-match (structure)\
IP ranges to match with.
>>>>>> - ip-ranges ([]string)\
List of IP ranges. OR semantics implied.
>>>>> - ip-ranges-not-match (structure)\
IP ranges to not match with.
>>>>>> - ip-ranges ([]string)\
List of IP ranges. OR semantics implied.
>>>>> - geo-ip-match (structure)\
Geo locations to match with.
>>>>>> - locations ([]string)\
ISO 3166-1 alpha 2. OR semantics implied.
>>>>> - geo-ip-not-match (structure)\
Geo locations to not match with.
>>>>>> - locations ([]string)\
ISO 3166-1 alpha 2. OR semantics implied.
>>>>> - ip-lists-match (structure)\
IP lists to match with.
>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>> - ip-lists-not-match (structure)\
IP lists to not match with.
>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>> - asn-ranges-match (structure)\
ASN ranges to match with.
>>>>>> - asn-ranges ([]integer)\
List of ASN values to match against. OR semantics implied.
>>>>> - asn-ranges-not-match (structure)\
ASN ranges to not match with.
>>>>>> - asn-ranges ([]integer)\
List of ASN values to match against. OR semantics implied.
>>>>> - asn-lists-match (structure)\
ASN lists to match with.
>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>> - asn-lists-not-match (structure)\
ASN lists to not match with.
>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>> - cookies ([]structure)\
Match cookies.
>>>>> - name (string)\
Name of the cookie parametr.
>>>>> - value (structure)\
Value of the cookie parametr.
>>>>>> - match (oneof)\
Oneof match field
>>>>>>> - exact-match (string)\
Exact match condition.
>>>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>>>> - prefix-match (string)\
Prefix match condition.
>>>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>> - bot-category (structure)\
Match bot category.
>>>>> - bot-category-lists-match (structure)\
Bot category lists to match with.
>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>> - bot-category-lists-not-match (structure)\
Bot category lists to not match with.
>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>> - bot-name (structure)\
Match bot name.
>>>>> - bot-name-lists-match (structure)\
Bot name lists to match with.
>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>> - bot-name-lists-not-match (structure)\
Bot name lists to not match with.
>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>> - bot-score (structure)\
Match bot score.
>>>>> - value ([]structure)\
List of integer matchers for bot score. OR semantics implied.
>>>>>> - match (oneof)\
Oneof match field
>>>>>>> - le-match (structure)\
Less than or equal condition.
>>>>>>>> - value (integer)\
Upper bound value (inclusive).
>>>>>>> - ge-match (structure)\
Greater than or equal condition.
>>>>>>>> - value (integer)\
Lower bound value (inclusive).
>>>>>>> - eq-match (structure)\
Equal condition.
>>>>>>>> - value (integer)\
Value to match against.
>>>>>>> - ne-match (structure)\
Not equal condition.
>>>>>>>> - value (integer)\
Value to not match against.
>>>> - verified-bot (structure)\
Match verified bot.
>>>>> - verified (structure)\
Matches if the bot is verified or not.
>>>>>> - match (boolean)\
Boolean value to match against.
>>>> - finger-print (structure)\
Match fingerprint.
>>>>> - ja3-ranges ([]structure)\
List of JA3 fingerprint matchers. OR semantics implied.
>>>>>> - match (oneof)\
Oneof match field
>>>>>>> - exact-match (string)\
Exact match condition.
>>>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>>>> - prefix-match (string)\
Prefix match condition.
>>>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>> - ja4-ranges ([]structure)\
List of JA4 fingerprint matchers. OR semantics implied.
>>>>>> - match (oneof)\
Oneof match field
>>>>>>> - exact-match (string)\
Exact match condition.
>>>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>>>> - prefix-match (string)\
Prefix match condition.
>>>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>> - ja3-matcher (structure)\
JA3 fingerprint matcher.
>>>>>> - match (oneof)\
Oneof match field
>>>>>>> - exact-match (string)\
Exact match condition.
>>>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>>>> - prefix-match (string)\
Prefix match condition.
>>>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>> - ja4-matcher (structure)\
JA4 fingerprint matcher.
>>>>>> - match (oneof)\
Oneof match field
>>>>>>> - exact-match (string)\
Exact match condition.
>>>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>>>> - prefix-match (string)\
Prefix match condition.
>>>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>>>>>> - defined (boolean)\
Matches if the field is defined.
>>>>>>> - lists-matchers (structure)\
Matches against string and regular expression lists.
>>>>>>>> - str-lists-match (structure)\
String lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - str-lists-not-match (structure)\
String lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-match (structure)\
Regular expression lists to match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>>>>>>> - reg-exp-lists-not-match (structure)\
Regular expression lists to not match with.
>>>>>>>>> - list-ids ([]string)\
List of list IDs to match against. OR semantics implied.
>>> - limit (integer)\
Desired maximum number of requests per period. Enter an integer within the range of 1 and 9999999999999.
>>> - period (integer)\
Period of time in seconds.
>>> - characteristics ([]structure)\
List of characteristics.
>>>> - case-insensitive (boolean)\
Determines case-sensitive or case-insensitive keys matching.
>>>> - characteristic-specifier (oneof)\
Oneof characteristic-specifier field
>>>>> - simple-characteristic (structure)\
Characteristic automatically based on the Request path, HTTP method, IP address, Region, and Host attributes. See documentation for more details.
>>>>>> - type (structure)\
Type of simple characteristic.
>>>>> - key-characteristic (structure)\
Characteristic based on key match in the Query params, HTTP header, and HTTP cookie attributes. See documentation for more details.
>>>>>> - type (structure)\
Type of key characteristic.
>>>>>> - value (string)\
String value of the key.

{% endcut %}

{% cut "Shorthand Syntax" %}

```hcl
[
  {
    description = string,
    dry-run = boolean,
    name = string,
    priority = integer,
    rule-specifier = dynamic-quota={
      action = DENY,
      characteristics = [
        {
          case-insensitive = boolean,
          characteristic-specifier = key-characteristic={
            type = COOKIE_KEY|HEADER_KEY|QUERY_KEY,
            value = string
          } | simple-characteristic={
            type = REQUEST_PATH|HTTP_METHOD|IP|GEO|HOST
          }
        }, ...
      ],
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
      limit = integer,
      period = integer
    } | static-quota={
      action = DENY,
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
      limit = integer,
      period = integer
    }
  }, ...
]
```

{% endcut %}

{% cut "JSON Syntax" %}

```json
[
  {
    "description": "string",
    "dry-run": "boolean",
    "name": "string",
    "priority": "integer",
    "rule-specifier": {
      "dynamic-quota": {
        "action": "DENY",
        "characteristics": [
          {
            "case-insensitive": "boolean",
            "characteristic-specifier": {
              "key-characteristic": {
                "type": "COOKIE_KEY|HEADER_KEY|QUERY_KEY",
                "value": "string"
              },
              "simple-characteristic": {
                "type": "REQUEST_PATH|HTTP_METHOD|IP|GEO|HOST"
              }
            }
          }, ...
        ],
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
        "limit": "integer",
        "period": "integer"
      },
      "static-quota": {
        "action": "DENY",
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
        "limit": "integer",
        "period": "integer"
      }
    }
  }, ...
]
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
yc smartwebsecurity v1 advanced-rate-limiter advanced-rate-limiter-profile create --example-json > request.json
or
yc smartwebsecurity v1 advanced-rate-limiter advanced-rate-limiter-profile create --example-yaml > request.yaml

2. Edit the template file

3. Run with template:
yc smartwebsecurity v1 advanced-rate-limiter advanced-rate-limiter-profile create -r request.json
or
yc smartwebsecurity v1 advanced-rate-limiter advanced-rate-limiter-profile create -r request.yaml ||
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