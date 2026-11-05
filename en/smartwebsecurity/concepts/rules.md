---
title: Rules {{ sws-name }}
description: Learn about the available rule types in {{ sws-name }}, how they apply actions to HTTP requests, and how rule priority is enforced.
---

# Rules

A _rule_ sets the [conditions](conditions.md) for selection of HTTP requests and the [action](#rule-action) applied to them. If a request satisfies several rules, the resulting action is determined by their [priorities](#rules-order).

For setup instructions, see [Rule management](../operations/index.md#rules).

## Types of rules {#rule-types}

{{ sws-full-name }} provides the following rule types:

* [Basic](#base-rules)
* [Smart Protection](#smart-protection-rules)
* [Web Application Firewall](#waf-rules)
* [Advanced Rate Limiter](#arl-rules)

There is also an internal [service rule](#service-rule) which can trigger during attacks.

### Basic rules {#base-rules}

A _basic rule_ allows you to manage access based on HTTP request parameters, e.g., client's IP address, request path, or headers. Requests can be allowed, denied, or sent to a [CAPTCHA](#captcha-settings) page. For example, you can allow requests from trusted IP addresses or activate a CAPTCHA check for the login page.

Each [security profile](profiles.md) has a _basic default rule_ with the lowest priority. It allows or denies requests not covered by the conditions of the other rules of the profile.

### Smart Protection rules {#smart-protection-rules}

_Smart Protection_ analyzes traffic based on specified criteria using machine learning algorithms and behavioral analysis. This rule provides Layer 7 DDoS protection and supports [full protection and API protection](#smart-protection-actions).

### WAF + Smart Protection rules {#waf-rules}

The _Web Application Firewall_ (WAF) rule connects a [WAF profile](waf.md) with [basic rule sets](waf.md#rules-set) for traffic analysis. It also includes Smart Protection and supports the same [actions](#smart-protection-actions). With WAF connected, no separate Smart Protection rule for the same traffic is required.

### Advanced Rate Limiter rules {#arl-rules}

An _Advanced Rate Limiter_ (ARL) rule limits the number of requests over a specific time period. You can set the limit for all traffic or its specific segments.

Rules are configured in a separate [ARL profile](arl.md), which is linked to the security profile. Available [actions](#arl-rule-actions) apply to requests in excess of the limit.

## Rule actions {#rule-action}

Available actions depend on the rule type. Requests permitted by all rules and allowed to reach the protected resource are called _legitimate_.

You can create custom [response templates](response-templates.md) to ensure a consistent format of responses triggered by rules.

### Basic rules {#base-rule-actions}

For basic rules, you can select the following actions:

* _{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}_: Block requests.
* _{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-allow }}_: Skip requests.
* _{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-captcha }}_: Redirect the client to a [CAPTCHA](#captcha-settings).

### Smart Protection and WAF {#smart-protection-actions}

There are two modes available for Smart Protection and WAF rules:

* _{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}_: Suspicious requests are sent for one of the following [checks](#client-checks): JS challenge, cookie challenge, or CAPTCHA. Smart Protection automatically selects a check based on its request analysis.
* _{{ ui-key.yacloud.smart-web-security.overview.cell_mode-api }}_: Requests are not sent for additional checks, but protection policies block obvious attack attempts. In this mode, a request that would be sent for a check in full protection mode can be allowed to access the resource.

Use the _API protection_ mode for endpoints:

* Of mobile apps.
* With automated calls.
* With dynamic content loading (`ajax`, `xhr`, `iframe`).

### Advanced Rate Limiter {#arl-rule-actions}

For requests exceeding the limit, you can select the following actions:

* _{{ ui-key.yacloud.smart-web-security.arl.label_rule-action-deny_3kenc }}_: Block requests until the end of the limit period.
* _Temporarily block all requests_: Block requests for a fixed period from 1 second to 24 hours after the limit is exceeded.
* _{{ ui-key.yacloud.smart-web-security.arl.label_rule-action-captcha }} requests exceeding the limit_: Redirect the client to {{ captcha-name }}.

On blocking, the client gets the `429` error. [CAPTCHA](#captcha-settings) allows you to check requests in excess of the limit without immediate blocking.

{% note warning %}

Do not use CAPTCHA for HTTP requests with dynamic content loading (`ajax`, `xhr`, `iframe`) and requests to mobile applications.

{% endnote %}

## JS challenge, cookie challenge, and CAPTCHA {#client-checks}

In [full protection](#smart-protection-actions) mode, Smart Protection either allows the request to reach the resource or automatically selects a check for suspicious traffic.

* _JS Challenge_: Automatically checks the execution of JavaScript code on the client side.
* _Cookie challenge_: Automatically checks whether the client can save a cookie and provide it in the next request.
* _CAPTCHA_: Redirects the user to [{{ captcha-name }}](../../smartcaptcha/), where they may be required to complete a [challenge](../../smartcaptcha/concepts/tasks.md).

In [normal](profiles.md#protection-mode) mode, only unmistakably robotic requests go to CAPTCHA, which Smart Protection can see by their high [Bot score](conditions.md). The rest of the requests are either redirected to a JS or cookie challenge or allowed through without any additional check.

A successful JS or cookie challenge does not prove that the request was sent by a human: automated browsers also support JavaScript and cookies. Moreover, if JavaScript or cookies are disabled, even a legitimate client may fail the check.


### Configuring CAPTCHA {#captcha-settings}

All rules that forward requests to a CAPTCHA use the CAPTCHA from the security profile. The following options are available:

{% include [captcha-integration](../../_includes/smartwebsecurity/captcha-integration.md) %}

{% include [allow-path-captcha](../../_includes/smartwebsecurity/allow-patch-captcha.md) %}

## Rule application modes {#protection-modes}

For each security profile rule, you select a set of [protection modes](profiles.md#protection-mode) it operates in:

* **All modes** (default).
* **_Enhanced protection_ and _Under attack_**.
* **_Under attack_**.

When you switch the profile mode, the selected rule set becomes active.

Application modes are set when [adding](../operations/rule-add.md) or [modifying](../operations/rule-update.md) a rule and displayed in the profile rule table.

## General principles of rules {#rules-order}

First, requests are processed by the security profile rules. Then, the allowed requests are checked by the ARL profile rules, if there is an ARL. The priorities in these profiles are independent of each other.

### Security profile {#security-profile-rules-order}

Set the rule priority using a number from `1` to `1000000`. Rules active in the current [protection mode](profiles.md#protection-mode) will trigger simultaneously. One request may be subject to several rules. The final action is determined by the highest priority rule.

{% include [preconfigured-rules-priority](../../_includes/smartwebsecurity/preconfigured-rules-priority.md) %}

Assign higher priority to:

* Rules that allow requests.
* Rules with filtering conditions based on specific parameters.

Otherwise, general rules with broader conditions may apply.

{% include [waf-priority-rules](../../_includes/smartwebsecurity/waf-priority-rules.md) %}

### ARL profile {#arl-profile-rules-order}

ARL rules can block requests permitted by the security profile. If this traffic needs not be limited, exclude it from the [ARL rule conditions](arl.md#traffic-conditions).

The lower the number, the higher the ARL rule priority. You can choose any priority values​ at will. Rule order example:

Priority | Rule name | Action | Rule description
--- | --- | --- | ---
1,000 | arl-rule-1 | Block requests in excess of the limit | Limits general load on resource
2,000 | arl-rule-2 | Temporarily block all requests | Protects against bots, parsers, brute-force attacks, spam
3,000 | arl-rule-3 | Send requests in excess of limit to captcha | Checks browser clients if the limit is exceeded

### _Logging only_ mode {#dry-run}

The `Logging only` mode allows you to check rule conditions and priorities prior to enabling protection. This rule logs information about matching requests but does not apply an action to them. For ARL rules, limit violations are logged.

Such rules do not affect traffic processing: the next suitable highest priority rule applies for which protection is enabled. Thus, a Smart Protection rule in the `Logging only` mode does not protect against DDoS attacks.

For security profile rules, the `dry_run_matched_rule_verdict` field contains the expected rule action in the `Logging only` mode. The actual action performed with the request is in the `action` field. Learn more about [log fields](logging.md#log-contents) and [rule filters in logging mode](../operations/configure-logging.md#dry-run-filters).

## Service rule {#service-rule}

For enhanced protection from attacks, {{ sws-name }} can block malicious requests even if the security profile allows them. The rest of the requests are processed according to the profile settings.

Service rule trigger events get [logged](logging.md) with the `sws_service_rule` label. Log examples:

* In {{ sws-name }}:

    ```text
    matched_rule_name: "sws_service_rule",
    matched_rule_type: "SMART_PROTECTION",
    matched_rule_verdict: "DENY",
    ```

* In [{{ alb-full-name }}](../../application-load-balancer/):

    ```json
    "matched_rule": {
      "dry_run": "false",
      "rule_name": "sws_service_rule",
      "rule_type": "SMART_PROTECTION",
      "verdict": "DENY"
    }
    ```
