# Rules

Using rules, you can define [conditions](conditions.md) for selecting HTTP request, specify [actions](#rule-action) for requests that match these conditions, and prioritize rules.

The rule priority is set as a numeric parameter from `1` to `1000000`.

{% include [preconfigured-rules-priority](../../_includes/smartwebsecurity/preconfigured-rules-priority.md) %}

You can also log information about the traffic matching your conditions, without applying any action to it.

{{ sws-full-name }} provides the following rule types:
* [Basic](#base-rules)
* [Smart Protection](#smart-protection-rules)
* [Web Application Firewall](#waf-rules)
* [Advanced Rate Limiter](#arl-rules)

You can learn more in [Managing rules](../operations/#rules).

## Basic rules {#base-rules}

_Basic rule_ is a rule that allows, denies, or directs traffic to [{{ captcha-full-name }}](../../smartcaptcha/) based on specified conditions. It is used for simple traffic filtering based on specific parameters.

Each [security profile](profiles.md) includes a _basic default rule_ with the lowest priority (`1000000`) that allows or denies all traffic.

## Smart Protection rules {#smart-protection-rules}

_Smart Protection_ is a rule that sends traffic, based on specified conditions, for automatic analysis using machine learning and behavioral analysis algorithms. Depending on the selected [action](#rule-action), suspicious requests are sent to {{ captcha-name }} for additional verification or get blocked.

## Web Application Firewall rules {#waf-rules}

Web Application Firewall rules engage a [WAF profile](waf.md) to analyze traffic for compliance with the [WAF basic rule sets](waf.md#rules-set). Depending on the selected [action](#rule-action), suspicious requests are sent to [{{ captcha-name }}](../../smartcaptcha/) for additional verification or get blocked.

You can use the following {{ captcha-name }} CAPTCHA options to verify requests compliant with the Smart Protection and Web Application Firewall rules:

{% include [captcha-integration](../../_includes/smartwebsecurity/captcha-integration.md) %}

## Advanced Rate Limiter rules {#arl-rules}

An [Advanced Rate Limiter](arl.md) rule calculates the number of requests received over a certain period of time. Requests are counted after they are allowed by the Smart Protection and Web Application Firewall rules, meaning that ARL rules have their own priority independent of other rules.

ARL rules allow you to set limits on either all traffic or its particular segments.

Unlike Smart Protection and WAF rules, ARL rules are configured in an ARL profile.

## Rule actions {#rule-action}

Actions for basic rules:
* _Deny_ traffic whose parameters match the conditions.
* _Allow_ traffic whose parameters match the conditions.

Actions for Smart Protection and Web Application Firewall rules:
* _Full Protection_: Traffic is checked by ML models and behavioral analysis algorithms. Suspicious requests are sent to {{ captcha-name }}.
* _API Protection_: Traffic is checked by ML models and behavioral analysis algorithms. Suspicious requests are denied.

Action for Advanced Rate Limiter rules: _Block requests when exceeding the limit_. Requests above the specified limit over a period of time will be blocked. The requesting client will get error `429`.

The requests that were allowed by all rules and passed on to the protected resource are called _legitimate_.