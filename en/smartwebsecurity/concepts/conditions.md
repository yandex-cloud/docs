---
title: Conditions
description: Conditions available for use in {{ sws-name }} rules to filter HTTP requests based on IP addresses, headers, URIs, cookies, and bot-related signals.
---

# Conditions

{% include [lists-preview](../../_includes/smartwebsecurity/lists-preview.md) %}

Conditions define which HTTP requests the {{ sws-name }} [rule](rules.md) applies to. The following table lists matching options and value formats for each condition. If multiple values are supported, a logical operator is used.

#|
|| **Match type and options** {width=50%} | **Value and example** ||
|| `{{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}`

* Matches or falls within the range
* Mismatches or lies outside the range
* IP belongs to the region
* IP does not belong to the region
* IP belongs to the list
* IP does not belong to the list
* IP belongs to the ASN
* IP does not belong to the ASN
* IP belongs to the ASN list
* IP does not belong to the ASN list
|
* IP address: `1.2.33.44`
* [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing): `2001:0db8:85a3:0000:0000:8a2e:0370:7334`
* [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing): `10::1234:1abc:1/64`
* Address range: `1.2.0.0-1.2.1.1`
* Two-letter country code as per [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2): `ru`, `kz`
* [ASN](https://wikipedia.org/wiki/Autonomous_system_(Internet)) value as an integer without the `as` prefix: `12345` ||
|| `{{ ui-key.yacloud.component.condition-column.condition_name-header }}`

* Matches
* Mismatches
* Starts with
* Does not start with
* Matches regular expression
* Does not match regular expression
* Belongs to the list
* Does not belong to the list
* Belongs to the list of regular expressions
* Does not belong to the list of regular expressions
|
Format: `key: value`, where _key_ is an HTTP header and  _value_ is a specific header value, value prefix, or [PIRE](https://github.com/yandex/pire) library [regular expression](https://en.wikipedia.org/wiki/Regular_expression), e.g., `User-Agent: curl/7.55.1`

Logical operator: _and_ ||
|| `{{ ui-key.yacloud.component.condition-column.condition_name-requestUri }}`

* Matches
* Mismatches
* Starts with
* Does not start with
* Matches regular expression
* Does not match regular expression
* Belongs to the list
* Does not belong to the list
* Belongs to the list of regular expressions
* Does not belong to the list of regular expressions
|
Request path, initial part of the request path, or PIRE library regular expression: `/` ||
|| `Query Match`

* Matches
* Mismatches
* Starts with
* Does not start with
* Matches regular expression
* Does not match regular expression
* Belongs to the list
* Does not belong to the list
* Belongs to the list of regular expressions
* Does not belong to the list of regular expressions
| Format: `key: value`, where _key_ is a request parameter and  _value_ is a specific value for the parameter, value prefix, or PIRE library regular expression, e.g., `a: 1` or `A: 2`

Logical operator: _and_ ||
|| `{{ ui-key.yacloud.component.condition-column.condition_name-authority }}`

* Matches
* Mismatches
* Starts with
* Does not start with
* Matches regular expression
* Does not match regular expression
* Belongs to the list
* Does not belong to the list
* Belongs to the list of regular expressions
* Does not belong to the list of regular expressions
|
Values of the `Host` header for HTTP/1.1 or the `authority` pseudo-header for HTTP/2 used to select a virtual host, value prefix, or PIRE library regular expression, e.g., `example.com` ||
|| `{{ ui-key.yacloud.component.condition-column.condition_name-httpMethod }}`

* Matches
* Mismatches
* Starts with
* Does not start with
* Matches regular expression
* Does not match regular expression
* Belongs to the list
* Does not belong to the list
* Belongs to the list of regular expressions
* Does not belong to the list of regular expressions
| [HTTP request method](https://en.wikipedia.org/wiki/HTTP#Request_methods) in the upper case; you can use an arbitrary value, value prefix, or PIRE library regular expression, e.g., `GET`, `POST`, or `DELETE`. ||

|| `{{ ui-key.yacloud.component.condition-column.condition_name-cookie }}`

* Matches
* Mismatches
* Starts with
* Does not start with
* Matches regular expression
* Does not match regular expression
* Belongs to the list
* Does not belong to the list
* Belongs to the list of regular expressions
* Does not belong to the list of regular expressions
|
Format: `key: value`, where _key_ is a Cookie header and _value_ is a specific Cookie value, value prefix, or PIRE library regular expression, e.g., `csrftoken=u32t4o3tb`

Logical operator: _and_ ||


|| `Bot name`

* Belongs to the list
* Does not belong to the list
|
List of names of legitimate bots owned by various companies and services: `YandexBot`, `SEMrushBot` ||
|| `Bot category`

* Belongs to the list
* Does not belong to the list
|
List of bots of a certain category: `AccessibilityBot`, `SearchEngineCrawlerBot` ||
|| `Verified bot`

* Yes
* No
| Whether this bot is verified and approved: `Yes`, `No` ||
|| `Bot score` |
Score value or range from `0` to `100` with the `>=`, `<=`, `=`, or `!=` operators.

Score ranges: 
* `up to 20`: Human
* `20–40`: Likely human
* `40–60`: Undetermined
* `60–80`: Likely bot
* `over 80`: Bot

Logical operator: _and_ ||
|| `FingerPrint`

* Matches
* Mismatches
* Starts with
* Does not start with
* Matches regular expression
* Does not match regular expression
* Belongs to the list
* Does not belong to the list
* Belongs to the list of regular expressions
* Does not belong to the list of regular expressions
| SSL/TLS connection's [JA3](https://github.com/salesforce/ja3) or [JA4](https://github.com/FoxIO-LLC/ja4) [fingerprint](botes.md#fingerprint). It is generated based on TLS version, cipher sets, extensions, signature algorithms, and other parameters.
* `6734f37431670b3ab4292b8f60f29984` (TrickBot JA3 fingerprint)
* `4d7a28d6f2263ed61de88ca66eb011e3` (Emotet JA3 fingerprint)
* `t13d3812h2_8a4b5c6d_7e8f9a0b` (JA4) ||
|#

## Regular expression format {#regular-expressions}

You can use regular expressions in conditions that support the following match types:

* Matches regular expression
* Does not match regular expression
* Matches the list of regular expressions
* Does not match the list of regular expressions

These conditions include: `{{ ui-key.yacloud.component.condition-column.condition_name-header }}`, `{{ ui-key.yacloud.component.condition-column.condition_name-requestUri }}`, `Query Match`, `{{ ui-key.yacloud.component.condition-column.condition_name-authority }}`, `{{ ui-key.yacloud.component.condition-column.condition_name-httpMethod }}`, `{{ ui-key.yacloud.component.condition-column.condition_name-cookie }}`.

### Regular expression operators {#regular-expressions-operators}

* Quantifiers. These set the allowed number of element repetitions.

  * `*`: Zero or more occurrences of any characters. `a*`: Zero or more occurrences of the `a` character. `a*b`: Any occurrence of `a` before `b`.

    For example, `a*` means an empty string, `a`, `aa`, `aaa`, etc.

  * `a+`: One or more occurrences of `a`.

    For example, `a+`: `a`, `aa`, `aaa`, etc.

  * `a?`: Zero or one occurrence of `a`.
    
    For example, `https?://` means `http://` and `https://`.

  * `{n}`: n occurrences. For example, `a{3}`: `aaa`.

  * `{n,m}`: From n through m occurrences. For example, `a{3,5}`: `aaa`, `aaaa`, and `aaaaa`.

  * `{n,}`: At least n occurrences. For example, `a{3,}`: `aaa`, `aaaa`, `aaaaa`, etc.

* Characters and operations.
  
    * `.`: Any single character, but for line break one.
  
      For example, `a.b` means `aab` and `acb`, but not `ab`.

    * `[abc]`: One of the characters between the square brackets.
      
      For example, `[abc]` means `a`, `b`, and `c`.

    * `[^abc]`: Any character, but for those between the square brackets.
      
      For example, `[^abc]` means any character other than `a`, `b`, or `c`.

    * `[a-z]`: Any character from `a` through `z`.
  
      For example, `[a-z]` means any lowercase letter from `a` through `z`.
    
    * `a|b`: Mutually exclusive options, either `a` or `b`.
    
      For example, `example|domain` means either `example` or `domain`.

    * `\\w`: Any letter.
    * `\\W`: Non-letter (digit, underscore, punctuation marks, space, etc).
    * `\\d`: Digit. `\\D`: Non-digit.
    * `\\s`: Space. `\\S`: Non-space.

{% note info %}

To use a character not as a regular expression operator or special character, escape it with `\`. For example, you need to escape such characters as `. + * [ ] ( ) { } ^ $ ?`.

{% endnote %}

### Case in regular expressions {#regular-expressions-case}

* Case sensitive. Enter a regular expression in required case.
  
  For example, `exaMple` will represent the `exaMple` string.

* Case insensitive. Add `(?i)` to the beginning of the expression.
  
  For example, `(?i)example` will represent strings like `example`, `EXaMple`, `EXAMPLE`, etc.

### Examples of regular expressions

* `User-Agent:\s*`: Block requests with empty or space-only `User-Agent` header value.
    
    In this expression, `\s*` is zero or more spaces.

* `\\[\'\"\.\;]`: Block requests containing `\` before a suspicious character (backslash injections).

    In this expression, `\\` is backslash, and `[\'\"\.\;]` is any character from between the square brackets.

* `a{100,}`: Block requests containing long sequences of identical characters, as this may be a sign of an attack.
    
    In this expression, `a{100,}` stands for 100 or more `a` in a row.

* `--.*`: Block requests containing comments in SQL queries, as this may be a sign of an SQL injection.

    In this expression, `--` is the beginning of an SQL comment, and `.*` is zero or more of any characters.
