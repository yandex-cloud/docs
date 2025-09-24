# WAF profiles

A web application firewall (WAF) filters and blocks malicious traffic directed to your web apps and websites. It protects against common attacks such as SQL injections, XSS, web vulnerabilities, and prevents data breaches and service outages.

WAF analyzes a web app's incoming HTTP requests according to pre-configured rules. Based on the analysis results, certain [actions](rules.md#rule-action) are applied to HTTP requests: the request can be allowed, blocked, or forwarded to {{ captcha-name }}.

Rules for analyzing requests are configured in a WAF profile. A WAF profile is attached to a [security profile](profiles.md) as a separate [WAF rule](rules.md).

For more information about connecting to a security profile, see [this section](../quickstart.md#waf).

The following settings are available in the WAF profile:
* [Rule sets](#rules-set)
* [Exclusion rules](#exclusion-rules)

## Rule sets {#rules-set}

A WAF profile supports the following rule sets: ML WAF (Yandex Malicious Score), Yandex Ruleset, [OWASP Core Rule Set](https://coreruleset.org/).

### ML WAF (Yandex Malicious Score) {#yandex-ml-ruleset}

This rule set was developed by Yandex using machine learning (ML) algorithms. ML WAF detects and blocks attacks that evade the signature-based method. The rules automatically adjust to new attack tactics. By default, only the `Malicious attacks` rule group is enabled. To extend ML WAF coverage to other attack groups, enable them separately.

We recommend using this rule set in addition to the OWASP or Yandex Ruleset.

For the full list and description of Yandex rules, see the section dedicated to [configuring a rule set](../operations/configure-set-rules.md) in the [management console]({{ link-console-main }}/link/smartwebsecurity).

{% include [ruleset-preview](../../_includes/smartwebsecurity/ruleset-preview.md) %}

### Yandex Ruleset {#yandex-ruleset}

Yandex developed this rule set based on real-world experience of protecting company services. It includes rules to detect known attack patterns (signatures), such as code injections (SQLi, XSS), CVE vulnerabilities, and remote code execution. The rule set is continuously updated to protect against new threats as they emerge.

The Yandex Ruleset is divided into individual rule groups that you can manage separately:

  * **Attack XSS**. Detects [cross-site scripting (XSS)](https://en.wikipedia.org/wiki/Cross-site_scripting), i.e., injection of malicious JavaScript code through server-side vulnerabilities (reflected and stored XSS), e.g., injections in HTTP request parameters or script injection into UI elements.
  * **Attack SQLI**. Detects [SQL injections](https://en.wikipedia.org/wiki/SQL_injection), i.e., malicious SQL code fragments in HTTP request parameters used to manipulate SQL databases.
  * **Attack LFI**. Blocks local [file inclusion](https://en.wikipedia.org/wiki/File_inclusion_vulnerability) (LFI) attempts aimed at unauthorized reading or execution of local server files via path traversal vulnerabilities (e.g., using `../` or absolute paths).
  * **Attack RFI**. Blocks remote file inclusion (RFI) aimed at executing malicious code from external resources by injecting URLs into file inclusion parameters (e.g., `include`, `require`).
  * **Attack Tool**. Detects activity from automated tools: vulnerability scanners, exploit frameworks, brute-force utilities, and other software used for [penetration testing](https://en.wikipedia.org/wiki/Penetration_test) and attacks (based on User-Agent signatures and request patterns).
  * **Attack RCE**. Protects against remote code execution (RCE) and prevents running server OS commands via vulnerable parameters (e.g., system call injections).

### OWASP Core Rule Set {#owasp-core-rule-set}

The set was developed by the Open Worldwide Application Security Project (OWASP) to ensure protection against vulnerabilities listed in the [OWASP TOP‑10](https://owasp.org/www-project-top-ten/). The OWASP Core Rule Set consists of rules aimed to detect malicious actions, including malicious file uploads, potential SQL injection attacks, DoS attempts, code injection attempts, and many more. For more information, see the [OWASP Core Rule Set repository on GitHub](https://github.com/coreruleset/coreruleset).

You can add one or multiple rule sets to a WAF profile. When adding multiple rule sets, remember to configure the following:

* _Priority_: Sequence of rule sets employed to determine the final verdict.
* _Profile trigger condition_: Whether a request must be identified as a threat by all added rule sets or by at least one of them.

When configuring rule sets, you can select specific rules for request checking and customize their triggering parameters. Each rule has an [anomaly](#anomaly) value and a [paranoia](#paranoia) level assigned.

{% note tip %}

To protect resources with different security requirements, create multiple WAF profiles. Each profile can have its own unique rule set and triggering parameters.

{% endnote %}

## Rule settings {#rules-settings}

### Anomaly {#anomaly}

Each rule from the set is assigned a numeric _anomaly_ value, i.e., a potential attack indicator. The higher this value, the more likely it is that the request that satisfies this rule is in fact an attack.

For the OWASP Core Rule Set , you can set an _anomaly threshold_ for the entire rule set, i.e., the cumulative anomaly score at which a request will be blocked. The possible threshold values are from `2` to `10,000`. We recommend that you start with an anomaly threshold of `25` and gradually reduce it to `5`.

For the Yandex Ruleset, you can set the anomaly threshold individually for each rule group. We recommend setting the anomaly threshold to `7`.

To reduce the anomaly threshold, address WAF false positives triggered by legitimate requests. To do so, select rules from the basic set and configure [exclusion rules](#exclusion-rules). Additionally, use the **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}** mode in your security profile to test different anomaly thresholds.

You can configure any rule in the set to be a _blocking_ one. Requests matching such a rule get blocked regardless of the anomaly threshold you set. If the **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}** mode is enabled in the security profile, requests will not be blocked even when if they match the blocking rules.

### Paranoia level {#paranoia}

The _paranoia level_ is an OWASP-specific feature that classifies rules based on how aggressive they are. The higher the paranoia level, the better the protection, but also the greater the risk of WAF false positives.

In the basic rule set settings, you can configure the overall paranoia level and thus quickly engage a collection of rules with this or lower paranoia level.

## Exclusion rules {#exclusion-rules}

_Exclusion rules_ are intended to prevent WAF false positives triggered by legitimate requests.

You can configure skipping checks for specific rules within a particular rule set or across all rules in all rule sets simultaneously. The search covers all SWS rule sets, including inactive ones. To exclude specific rules, use filters.

You can configure [trigger conditions](conditions.md) for each exclusion rule. If you use several conditions of different types, they all must be satisfied for the exclusion rule to trigger. If no conditions are specified, the exclusion rule will apply to all traffic.

WAF configuration should be tailored to each application; there are no universal WAF configurations. During real-world deployment, false positives are expected; this is part of training the WAF to adapt to your traffic. Configure rules in **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}** mode and analyze [logs](../operations/configure-logging.md). On average, the overall setup process takes about a week, but we still recommend regularly reviewing logs and adjusting rules as needed.

## See also {#see-also}

* [{#T}](../quickstart.md#waf)
* [{#T}](../tutorials/sws-basic-protection.md)