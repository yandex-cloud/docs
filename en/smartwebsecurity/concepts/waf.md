# WAF profiles

{% include [realized-waf-glossary](../../_includes/smartwebsecurity/realized-waf-glossary.md) %}

WAF analyzes a web app's incoming HTTP requests according to pre-configured rules. Based on the analysis results, certain [actions](rules.md#rule-action) are applied to HTTP requests.

You can manage WAF using a _WAF profile_, which connects to the [security profile](profiles.md) as a separate [rule](rules.md).

For more information about connecting to a security profile, see [{#T}](../quickstart.md#waf).

The following settings are available in the WAF profile:
* [Basic rule set](#rules-set)
* [Exclusion rules](#exclusion-rules)
* [Request analysis parameters](#request-analysis-parameters)

## Basic rule set {#rules-set}

The WAF profile offers a basic rule set called [OWASP Core Rule Set](https://coreruleset.org/). The set was developed by the Open Worldwide Application Security Project (OWASP) to ensure protection against vulnerabilities listed in the [OWASP TOP‑10](https://owasp.org/www-project-top-ten/). The OWASP Core Rule Set consists of rules aimed to detect malicious actions, including malicious file uploads, potential SQL injection attacks, DoS attempts, code injection attempts, and many more. For more information, see the [OWASP Core Rule Set repository on GitHub](https://github.com/coreruleset/coreruleset).

_Other basic rule sets will become available soon._

In the basic rule set settings, you can select specific request analysis rules. Each rule has an [anomaly](#anomaly) value and a [paranoia](#paranoia) level assigned.

### Anomaly {#anomaly}

Each rule from the set is assigned a numeric _anomaly_ value, i.e., a potential attack indicator. The higher this value, the more likely it is that the request that satisfies this rule is in fact an attack.

You can set an _anomaly threshold_ for the whole set of rules, i.e., the sum of anomaly values of the triggered rules that will block the request. The possible threshold values are from `2` to `10,000`.

We recommend to start with the anomaly threshold of `25` and gradually reduce it to `5`. To reduce the anomaly threshold, address WAF false positives triggered by legitimate requests. To do so, select rules from the basic set and configure [exclusion rules](#exclusion-rules). You can use the **Only logging (dry-run)** mode in the security profile to test various anomaly thresholds.

You can turn any rule from the set into a _blocking_ one. A request that satisfies such a rule will be blocked regardless of the anomaly threshold you specified. If the **Only logging (dry-run)** mode is enabled in the security profile, requests will not be blocked even when if they satisfy the blocking rules.

### Paranoia level {#paranoia}

_Paranoia level_ classifies rules according to their aggression. The higher the paranoia level, the better your protection, but also the higher the probability of WAF false positives.

In the basic rule set settings, you can configure the overall paranoia level and thus quickly engage a collection of rules with this or lower paranoia level.

## Exclusion rules {#exclusion-rules}

_Exclusion rules_ are intended to prevent WAF false positives triggered by legitimate requests.

You can configure skipping specific rules or all rules in a given set.

You can configure [trigger conditions](conditions.md) for each exclusion rule. If you use several conditions of different types, they all must be satisfied for the exclusion rule to trigger. If no conditions are specified, the exclusion rule will apply to all traffic.

## Request analysis parameters {#request-analysis-parameters}

When you configure a WAF profile, you can enable request body inspection and specify the following parameters:

* Maximum request body size: from 8 KB (_you can customize it later_).
  
  The maximum request body size affects the web application's performance and security. Limiting the size helps prevent excessive resource consumption. It also helps mitigate the effects of DoS/DDoS attacks, where attackers submit large requests in order to exhaust the server's resources.
  
* Actions if maximum request body size is exceeded:
  * Do not analyze (skip). You can use it when a legitimate application frequently sends large requests.
  * Block. This is a more universal and secure approach. Any requests exceeding the specified limit will be blocked, thus reducing the risk of attacks.

## See also {#see-also}

* [{#T}](../quickstart.md#waf)