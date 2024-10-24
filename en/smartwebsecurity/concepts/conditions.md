---
title: Conditions in {{ sws-full-name }}
description: You can set up conditions for your security rules. For more information, read this article.
---

# Conditions

You can set the following rule [conditions](rules.md):

#|
|| **Type** | **Match options** | **Values** | **Example** | **Logical operator** ||
|| `{{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}` |
* Matches or falls within the range
* Mismatches or lies outside the range
* IP belongs to the region
* IP does not belong to the region
|
* IP address
* [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing)
* Address range
* Two-letter country code as per [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)
|
* `1.2.33.44`
* `2001:0db8:85a3:0000:0000:8a2e:0370:7334`
* `10::1234:1abc:1/64`
* `1.2.0.0-1.2.1.1`
* `ru`
* `kz`
| _or_ ||
|| `{{ ui-key.yacloud.component.condition-column.condition_name-header }}` |
* Matches
* Mismatches
* Starts with
* Does not start with
* Matches regular expression
* Does not match regular expression
|
Format: `key: value`, where key is an HTTP header,
value is a specific header value, value
prefix, or [regular expression](https://en.wikipedia.org/wiki/Regular_expression) of
[PIRE](https://github.com/yandex/pire) library
|
* `User-Agent: curl/7.55.1`
| _and_ ||
|| `{{ ui-key.yacloud.component.condition-column.condition_name-requestUri }}` |
* Matches
* Mismatches
* Starts with
* Does not start with
* Matches regular expression
* Does not match regular expression
|
Request path, initial part of the request path, or PIRE library
regular expression
|
* `/`
| _N/A_ ||
|| `Query Match` |
* Matches
* Mismatches
* Starts with
* Does not start with
* Matches regular expression
* Does not match regular expression
|
Format: `key: value`, where key is a request
parameter, value is a specific value for the parameter,
value prefix, or PIRE library regular expression
|
* `a: 1`
* `A: 2`
| _and_ ||
|| `{{ ui-key.yacloud.component.condition-column.condition_name-authority }}` |
* Matches
* Mismatches
* Starts with
* Does not start with
* Matches regular expression
* Does not match regular expression
|
Values of the `Host` header for HTTP/1.1 or
the `authority` pseudoheader for HTTP/2 used to
select a virtual host, value prefix, or
PIRE library regular expression
|
* `example.com`
| _or_ ||
|| `{{ ui-key.yacloud.component.condition-column.condition_name-httpMethod }}` |
* Matches
* Mismatches
* Starts with
* Does not start with
* Matches regular expression
* Does not match regular expression
|
[HTTP request method](https://en.wikipedia.org/wiki/HTTP#Request_methods) in the upper case; you can use
an arbitrary value, value prefix,
or PIRE library regular expression
|
* `GET`
* `POST`
* `DELETE`
| _or_ ||

|| `{{ ui-key.yacloud.component.condition-column.condition_name-cookie }}` |
* Matches
* Mismatches
* Starts with
* Does not start with
* Matches regular expression
* Does not match regular expression
|
Format: `key: value`, where key is a Cookie header,
value is a specific Cookie value, value
prefix, or PIRE library regular expression
|
* `csrftoken=u32t4o3tb`
| _and_ ||

|| `{{ ui-key.yacloud.component.condition-column.condition_name-body }}` |
* Matches
* Mismatches
* Starts with
* Does not start with
* Matches regular expression
* Does not match regular expression
|
String in the HTTP packet body or
PIRE library regular expression
|
* `<br><input type='submit'>`
| _or_ ||
|#

## Regular expression format {#regular-expressions}

You can use regular expressions in such conditions as `{{ ui-key.yacloud.component.condition-column.condition_name-header }}`, `{{ ui-key.yacloud.component.condition-column.condition_name-requestUri }}`, `Query Match`, `{{ ui-key.yacloud.component.condition-column.condition_name-authority }}`, `{{ ui-key.yacloud.component.condition-column.condition_name-httpMethod }}`, `{{ ui-key.yacloud.component.condition-column.condition_name-cookie }}`, or `{{ ui-key.yacloud.component.condition-column.condition_name-body }}`. These conditions support the match types _Matches regular expression_ and _Does not match regular expression_.

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

* `^User-Agent:\s*$`: Block requests with empty or space-only `User-Agent` header value.
    
    In this expression, `^` is the beginning of the string, `\s*` is zero or more spaces, and `$` is the end of the string.

* `\\[\'\"\.\;]`: Block requests containing `\` before a suspicious character (backslash injections).

    In this expression, `\\` is backslash, and `[\'\"\.\;]` is any character from between the square brackets.

* `a{100,}`: Block requests containing unusually long sequences of identical characters, as this may be a sign of a DDoS attack.
    
    In this expression, `a{100,}` stands for 100 or more `a` in a row.

* `--.*`: Block requests containing comments in SQL queries, as this may be a sign of an SQL injection.

    In this expression, `--` is the beginning of an SQL comment, and `.*` is zero or more of any characters.
