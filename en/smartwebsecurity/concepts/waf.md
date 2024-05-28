# WAF profiles

{% include [note-preview-waf](../../_includes/smartwebsecurity/note-preview-waf.md) %}

To protect your web apps from external threats, {{ sws-full-name }} implements a Web Application Firewall (WAF).

WAF analyzes a web app's incoming HTTP requests according to pre-configured rules. Based on the analysis results, certain [actions](rules.md#rule-action) are applied to HTTP requests.

You can manage the firewall using a _WAF profile_ that connects to the [security profile](profiles.md) as a separate [rule](rules.md).

For more information about connecting to a security profile, see [{#T}](../quickstart/quickstart-waf.md).

The following settings are available in the WAF profile:
* [Basic rule set](#rules-set)
* [Exception rules](#exclusion-rules)

_Configuring request body analysis parameters will become available at a later time._

## Basic rule set {#rules-set}

The WAF profile offers a basic rule set called [OWASP Core Rule Set](https://coreruleset.org/). The set was developed by the Open Worldwide Application Security Project (OWASP) to ensure protection from vulnerabilities listed in [OWASP TOP‑10](https://owasp.org/www-project-top-ten/). The OWASP Core Rule Set consists of rules aimed to detect malicious actions, including malicious file uploads, potential SQL injection attacks, DoS attempts, code injection attempts, and many more. For more information, see the [OWASP Core Rule Set repository on GitHub](https://github.com/coreruleset/coreruleset).

_Other basic rule sets will become available soon._

In the basic rule set settings, you can select specific request analysis rules. Each rule has an [anomaly](#anomaly) value and a [paranoia](#paranoia) level assigned.

### Anomaly {#anomaly}

Each rule from the set is assigned a numeric _anomaly_ value — a potential attack indicator. The higher this value, the more likely it is that the request that satisfies this rule is in fact an attack.

You can set an _anomaly threshold_ for the whole set of rules, i.e., the sum of anomaly values of the triggered rules that will block the request. Possible threshold values: from `2` to `10,000`.

We recommend that you start with the anomaly threshold of `25` and gradually bring it down to `5`. To reduce the anomaly threshold, address WAF false positives triggered by legitimate requests. To do so, select rules from the basic set and configure [exception rules](#exclusion-rules). You can use the **Logging only (dry-run)** mode in the security profile to test various anomaly thresholds.

You can turn any rule from your set into a _blocking_ rule. A request that satisfies such a rule will be blocked regardless of the anomaly threshold you specified. If the **Logging only (dry-run)** mode is enabled in the security profile, requests will not be blocked even when if they satisfy the blocking rules.

### Paranoia level {#paranoia}

_Paranoia level_ classifies rules according to their aggression. The higher the paranoia level, the better your protection, but also the higher the probability of WAF false positives.

In the basic rule set settings, you can configure the overall paranoia level and thus quickly engage a collection of rules with this or lower paranoia level.

## Exception rules {#exclusion-rules}

_Exception rules_ are intended to prevent WAF false positives triggered by legitimate requests.

You can configure skipping specific rules or all rules in a given set.

You can configure [trigger conditions](conditions.md) for each exception rule. If you use several conditions of different types, they all must be satisfied for the exception rule to trigger. If no conditions are specified, the exception rule will apply to the whole traffic.

## See also {#see-also}

* [{#T}](../quickstart/quickstart-waf.md)