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

You can learn more in [Managing rules](../operations/index.md#rules).

## Basic rules {#base-rules}

_Basic rule_ is a rule that allows, denies, or directs traffic to [{{ captcha-full-name }}](../../smartcaptcha/) based on specified conditions. It is used for simple traffic filtering based on specific parameters.

Each [security profile](profiles.md) includes a _basic default rule_ with the lowest priority (`1000000`) that allows or denies all traffic.

{% include [allow-path-captcha](../../_includes/smartwebsecurity/allow-patch-captcha.md) %}

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
* _Full Protection_: Traffic is checked by ML models and behavioral analysis algorithms. Redirect suspicious requests to {{ captcha-name }}.

     {% note warning %}

     To ensure your application works correctly, apply _API protection_ to HTTP requests with dynamic content loading.

     {% endnote %}

* Use _API protection_ for endpoints that:
     
     * Belong to mobile apps.
     * Receive automated calls.
     * Process requests with dynamic content loading, such as `ajax`, `xhr`, `iframe`, etc.
          
  Traffic is checked by ML models and behavioral analysis algorithms. Requests are not sent to {{ captcha-name }}, which allows making legitimate API calls to the protected resources. Special DDoS protection policies block only overt attack attempts. If, in full protection mode, a request was redirected to a CAPTCHA challenge, the API protection mode may let it through to the protected resource.

Actions for Advanced Rate Limiter rules:

* _Block requests when exceeding the limit_: Requests above the specified limit over a period of time will be blocked until the limit period expires. The requesting client will get error `429`.

* _Temporarily block all requests_: Requests above the specified limit over a period of time will be blocked for a fixed period of time, rather than until the end of the limit period. The requesting client will get error `429`. You can block requests for the period from 1 second to 24 hours.

* _Send over-limit requests for CAPTCHA verification_: Requests above the specified limit over a period of time will be sent to {{ captcha-name }}. 

    Requests exceeding the limit will be sent to CAPTCHA. You can configure CAPTCHA in the security profile to which the ARL profile is connected. This helps differentiate legitimate users from bots, ensuring that requests are not fully blocked and the application remains available.

    {% note warning %}

    Do not use CAPTCHA for HTTP requests with dynamic content loading (`ajax`, `xhr`, `iframe`) and requests to mobile applications.

    {% endnote %}
    
    
The requests that were allowed by all rules and let through to the protected resource are called _legitimate_.
