# Challenge options

{% include [note-preview-captcha-variants](../../_includes/smartcaptcha/note-preview-captcha-variants.md) %}

_Challenge options_ include various CAPTCHAs you can show depending on the basic properties of incoming requests. To flexibly split requests, you can use different combinations of [traffic conditions](#traffic-conditions).

If you do not need to create multiple separate CAPTCHAs, configure only the [default](../operations/create-captcha.md) option. For all options, you can select the main and additional challenges and the CAPTCHA difficulty. The visual design is consistent for all CAPTCHA options.

With multiple challenge options available, you can customize CAPTCHA based on threat likelihood for better user experience.

## Benefits of using CAPTCHA options {#why-use-variants}

* Segmented threat protection.
  
  Different users and traffic sources pose different levels of threat. Bots and attackers may use odd-looking IP addresses or send requests with specific attributes in the header. By taking this into account, you can apply more complex checks to suspicious traffic.

* Improved user experience.
  
  Hard-to-solve CAPTCHA challenges negatively impact user experience and overall impression of your website. Instead, you can choose to show the CAPTCHA that is better suited to the user's platform. For example, you can use a slider for mobile platforms and a checkbox for desktop ones. This improves convenience and user loyalty.

## CAPTCHA show rules {#captcha-view-rules}

The list of rules already includes the default rule to display the default CAPTCHA. It applies to traffic that does not match any other rules. You cannot delete the default rule.

In a CAPTCHA show rule, you can configure the following:

* _Challenge option_: CAPTCHA to show to the user.
  
  You cannot delete a challenge option if it is used in a rule.
  
* _Rule priority_: Order for checking rules. The values range from `1` to `999999`. The default rule priority is set to `1000000` and cannot be changed.
  
  Rules are checked in ascending priority order, starting from `1`, `2`, and up to `1000000`. If traffic matches multiple rules, the first rule to trigger will apply.
  
* _Conditions for incoming traffic_: Incoming traffic properties, which include:
  * `IP`: IP address, IP address range, or IP address region. 
    
    You can add or remove an IP address, IP address range, or IP address region to or from a CAPTCHA show rule. For example, you can specify trusted IP addresses of your customers or regions accounting for the most of attacks on your website.

  * `HTTP header`: HTTP header parameter.

    You can select various CAPTCHA options depending on the user device or browser sending the request. Also, you can use `HTTP header` to find out the referral source, authorization details, and other data.
  
  * `URI`: Path of an incoming request to your website.

    You can configure a difficult CAPTCHA for critical pages, e.g., those used for authentication or payment.

  * `Host`: Domain receiving the request.

You can set one or more different conditions in a rule. You can also add multiple conditions of the same type using the `AND` or `OR` operators.

## Traffic conditions {#traffic-conditions}

#|
|| **Match type and options** | **Values (example)** | **Operator** ||
|| `{{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}` 
* Matches or falls within the range
* Mismatches or lies outside the range
* IP belongs to the region
* IP does not belong to the region
|
* IP address (`1.2.33.44`)
* [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) (`10::1234:1abc:1/64`)
* Address range (`1.2.0.0-1.2.1.1`)
* Two-letter country code as per [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) (`ru`, `kz`)
| _or_ ||
|| `{{ ui-key.yacloud.component.condition-column.condition_name-header }}` 
* Matches
* Mismatches
* Starts with
* Does not start with
* Matches regular expression
* Does not match regular expression
|
`key: value` format, where:
* `key`: HTTP header
* `value`: Specific header value, value prefix, or [PIRE](https://github.com/yandex/pire) library [regular expression](https://en.wikipedia.org/wiki/Regular_expression)

For example, `User-Agent: curl/7.55.1`
| _and_ ||
|| `URI` 
* Matches
* Mismatches
* Starts with
* Does not start with
* Matches regular expression
* Does not match regular expression
| 
Request path, initial part of the request path, or PIRE library regular expression

For example, `/`
| N/A ||
|| `{{ ui-key.yacloud.component.condition-column.condition_name-authority }}` 
* Matches
* Mismatches
* Starts with
* Does not start with
* Matches regular expression
* Does not match regular expression
|
Values of the `Host` header for HTTP/1.1 or the `authority` pseudoheader for HTTP/2 used to select a virtual host, value prefix, or PIRE library regular expression

For example, `example.com`
| _or_ ||
|#