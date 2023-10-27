# Conditions

You can set the following rule [conditions](rules.md):

#|
|| **Type** | **Match criteria** | **Values** | **Example** | **Logical Operator** ||
|| `{{ ui-key.yacloud.smart-web-security.overview.condition_name-ip-range }}` |
* Matches or falls within the range
* Mismatches or lies outside the range
* IP belongs to the region
* IP does not belong to region
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
|| `{{ ui-key.yacloud.smart-web-security.overview.condition_name-header }}` |
* Matches
* Mismatches
* Starts with
* Does not start with
* Matches regular expression
* Mismatches regular expression
|
Format `key: value`, where key is the HTTP header,
value is a specific header value, value
prefix or [regular expression](https://en.wikipedia.org/wiki/Regular_expression) of the [PIRE](https://github.com/yandex/pire) library
|
* `User-Agent: curl/7.55.1`
| _and_ ||
|| `{{ ui-key.yacloud.smart-web-security.overview.condition_name-requestUri }}` |
* Matches
* Mismatches
* Starts with
* Does not start with
* Matches regular expression
* Mismatches regular expression
|
Request path, beginning of request path, or regular
expression of PIRE library
|
* `/`
| _Not used_ ||
|| `Query Match` |
* Matches
* Mismatches
* Starts with
* Does not start with
* Matches regular expression
* Mismatches regular expression
|
Format `key: value`, where key is the request
parameter, value is a specific parameter value,
value prefix, or regular expression of the
PIRE library
|
* `a: 1`
* `A: 2`
| _and_ ||
|| `{{ ui-key.yacloud.smart-web-security.overview.condition_name-authority }}` |
* Matches
* Mismatches
* Starts with
* Does not start with
* Matches regular expression
* Mismatches regular expression
|
Values of the `Host` header for HTTP/1.1 or
the `authority` pseudoheader for HTTP/2 by which a virtual
host, value prefix, or PIRE library
regular expression is selected
|
* `example.com`
| _or_ ||
|| `{{ ui-key.yacloud.smart-web-security.overview.condition_name-httpMethod }}` |
* Matches
* Mismatches
* Starts with
* Does not start with
* Matches regular expression
* Mismatches regular expression
|
[HTTP request method](https://en.wikipedia.org/wiki/HTTP#Request_methods) in the upper case,
with an arbitrary value, value prefix, or PIRE library
regular expression allowed
|
* `GET`
* `POST`
* `DELETE`
| _or_ ||
|#