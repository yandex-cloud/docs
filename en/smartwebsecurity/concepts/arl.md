# Advanced Rate Limiter

{% include [briefly-about-arl](../../_includes/smartwebsecurity/briefly-about-arl.md) %}

ARL pros and features:

* Backend protection against sharp load increases and backend health preservation.
* Additional API protection by controlling HTTP parameters.
* Flexible configuration of limits depending on traffic parameters.
* Limit for single or multiple requests.
* Dry Run mode for rule testing and traffic analysis.
* ARL logging.

You can configure ARL using profiles. A profile consists of rules that impose limits on requests of a certain type. ARL uses these rules to analyze incoming HTTP requests and blocks them when their number exceeds the specified limits.

An ARL profile is connected to a [security profile](profiles.md). ARL rules are applied to the traffic that has already been through the security profile's rules check. This makes it possible to analyze only the allowed instead of all incoming traffic and makes the ARL module more fault tolerant.

For more information about connecting to a security profile, see [{#T}](../quickstart.md#arl).

An ARL rule has these settings available:
* [Traffic conditions](#traffic-conditions)
* [Request counting](#requests-counting)
* [Actions on exceeding the limit](#over-limit-actions)

## Traffic conditions {#traffic-conditions}

An ARL rule may impose a limit on incoming HTTP requests for all traffic or traffic satisfying certain conditions.

[Conditions](conditions.md) are defined by the following parameters:

* `IP`: IP address, address range, or address region of clients, list of addresses, or [ASNs](https://en.wikipedia.org/wiki/Autonomous_system_(Internet)) subject to the rule.
* `Request path`: Path or part of the path the request was sent to.
* `Host`: Domain name the request was sent to.
* `HTTP method`: Method or set of methods the request belongs to.
* `HTTP header`: Request header parameters.
* `Cookie`: String in cookie files.

## Request counting {#requests-counting}

You can count the requests for the limit purposes in one of the following ways:

* Count each request separately.
* Grouping requests by a certain attribute and limiting the number of groups.
  
You can group requests:
* Automatically, by `Request path`, `HTTP method`, `IP address`, `Region`, and `Host` attributes.
* Based on key match in the `Query params`, `HTTP header`, and `HTTP cookie` attributes.
  
  You can configure flexible match/no match conditions for the parameters you specify for traffic. You can search for both case-sensitive or case-insensitive string matches. Parameters can be represented by single values, ranges, or regular expressions.

You can also select a time interval from 1 second to 60 minutes and [configure actions](#over-limit-actions) to trigger for requests exceeding the limit in that interval.

You can use the **Logging only (Dry run)** mode to calculate limits and test ARL rules. Requests will not be blocked in this mode. This allows you to evaluate backend capabilities and find the optimum limit values.

## Actions on exceeding the limit {#over-limit-actions}

When the number of requests within the set interval goes over the limit, you can block them or send them for CAPTCHA verification. When a request is blocked, the client gets the `429` error (`Too Many Requests`).

You can opt for the following actions:

* Block over-limit requests: All requests will be denied until the end of the current limit period.

   Use this option if you need to limit peak load while maintaining maximum application availability. This action does not require request grouping.

* Temporarily block all requests: All requests will be denied for the period you specify, from 1 second to 60 minutes. The block duration is fixed, regardless of the remaining limit period. Access is automatically restored after the block expires.

   Use this action to provide enhanced protection against bots, scrapers, brute-force attacks, or spam, prioritizing reliability over availability. For example, it is a good fit for login pages or message submission forms. This action requires request grouping.

* Send over-limit requests for CAPTCHA verification: Requests that exceed the limit will be sent to [{{ captcha-name }}](../../smartcaptcha/). You can configure CAPTCHA through the security profile associated with the ARL profile. This action helps differentiate legitimate users from bots, ensuring requests are not fully blocked and that the application remains available.

   Use this action as a softer restriction on pages with registration, login, feedback, search, or similar forms.

## See also {#see-also}

* [{#T}](../quickstart.md#arl)
* [{#T}](../operations/arl-profile-create.md)
* [{#T}](../operations/arl-rule-add.md)
