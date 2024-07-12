# Advanced Rate Limiter

{% include [note-preview-waf](../../_includes/smartwebsecurity/note-preview-arl.md) %}

{% include [briefly-about-arl](../../_includes/smartwebsecurity/briefly-about-arl.md) %}

ARL pros and features:

* Backend protection against sharp load increases and backend health preservation.
* Additional API protection by controlling HTTP parameters.
* Flexible configuration of limits depending on traffic parameters.
* Limit for single requests or a group of requests.
* Dry Run mode for rule testing and traffic analysis.
* ARL logging.

You can configure ARL using profiles. A profile consists of rules that impose limits on requests of a certain type. ARL uses these rules to analyze incoming HTTP requests and blocks them when their number exceeds the specified limits.

An ARL profile is connected to a [security profile](profiles.md). ARL rules apply to the traffic that already passed the SWS and WAF rules check. This allows analyzing only the allowed incoming traffic instead of analyzing it all, which improves the ARL module's fault tolerance.

For more information about connecting to a security profile, see [{#T}](../quickstart/quickstart-arl.md).

An ARL rule has these settings available:
* [Traffic conditions](#traffic-conditions)
* [Request counting](#requests-counting)

## Traffic conditions {#traffic-conditions}

An ARL rule may impose a limit on incoming HTTP requests for all traffic or traffic satisfying certain conditions.

[Conditions](conditions.md) are defined by the following parameters:

* `IP`: IP address, address range, or address region of clients subject to the rule.
* `Request path`: Path or a portion of the path the request was sent to.
* `Host`: Domain name the request was sent to.
* `HTTP method`: Method or set of methods the request belongs to.
* `HTTP header`: Request header parameters.
* `Cookie`: String in cookie files.

## Request counting {#requests-counting}

You can count the requests for the limit purposes in one of the following ways:

* Counting each request individually.
* Grouping requests by a certain attribute and limiting the number of groups.

You can group requests:
* Automatically based on the `Request path`, `HTTP method`, `IP address`, `Region`, and `Host` attributes.
* Based on a key match in the `Query params`, `HTTP header`, and `HTTP cookie` attributes.

   You can configure flexible match/no match conditions for the parameters you specify for traffic. You can look for case-sensitive or case-insensitive string matches. Parameters can be represented by single values, ranges, or regular expressions.

You can also select a time interval from 1 second to 60 minutes.

All requests in excess of the limit received within the specified time interval will be blocked. In which case the client will get the `429` error.

You can use the **Logging only (Dry run)** mode to calculate limits and test ARL rules. Requests will not be blocked in this mode. This allows you to evaluate backend capabilities and find the optimum limit values.

## See also {#see-also}

* [{#T}](../quickstart/quickstart-arl.md)