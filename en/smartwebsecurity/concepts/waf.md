---
title: WAF profiles
description: How Web Application Firewall (WAF) profiles analyze HTTP requests and use rule sets and exceptions to protect web applications.
---

# WAF profiles

web application firewall (WAF) filters and blocks malicious traffic directed to your web apps and websites. It protects against common attacks such as SQL injections, XSS, web vulnerabilities, and prevents data breaches and service outages.

WAF analyzes a web app's incoming HTTP requests according to pre-configured rules. Based on the analysis results, certain [actions](rules.md#rule-action) are applied to HTTP requests: the request can be allowed, blocked, or forwarded to {{ captcha-name }}.

Rules for analyzing requests are configured in a WAF profile. A WAF profile is attached to a [security profile](profiles.md) as a separate [WAF rule](rules.md).

For more information about connecting to a security profile, see [this section](../quickstart.md#waf).

The following settings are available in the WAF profile:
* [Rule sets](#rules-set)
* [Exclusion rules](#exclusion-rules)

## Rule sets {#rules-set}

A WAF profile supports the following rule sets: ML WAF (Yandex Malicious Score), Yandex Ruleset, [OWASP Core Rule Set](https://coreruleset.org/).

For the full list and description of the rules included in each rule set, see the section dedicated to [configuring a rule set](../operations/configure-set-rules.md) in the [management console]({{ link-console-main }}/link/smartwebsecurity).

{% include [ruleset-preview](../../_includes/smartwebsecurity/ruleset-preview.md) %}

### ML WAF (Yandex Malicious Score) {#yandex-ml-ruleset}

This rule set was developed by Yandex using machine learning (ML) algorithms. ML WAF detects and blocks attacks that evade the signature-based method. The rules automatically adjust to new attack tactics. By default, only the `Malicious attacks` rule group is enabled. To extend ML WAF coverage to other attack groups, enable them separately.

We recommend using this rule set in addition to the OWASP or Yandex Ruleset.

How to set up:

* Each rule has its own [anomaly threshold](#anomaly). Requests exceeding this threshold are blocked. The recommended initial value is `90`.
* The [paranoia level](#paranoia) is not used.

### Yandex Ruleset {#yandex-ruleset}

Yandex developed this rule set based on real-world experience of protecting company services. It includes rules to detect known attack patterns (signatures), such as code injections (SQLi, XSS), CVE vulnerabilities, and remote code execution. The rule set is continuously updated to protect against new threats as they emerge.

Yandex Ruleset is divided into individual rule groups that you can manage separately:

  * **Attack XSS**. Detects [cross-site scripting (XSS)](https://en.wikipedia.org/wiki/Cross-site_scripting), i.e., injection of malicious JavaScript code through server-side vulnerabilities (reflected and stored XSS), e.g., injections in HTTP request parameters or script injection into UI elements.
  * **Attack SQLI**. Detects [SQL injections](https://en.wikipedia.org/wiki/SQL_injection), i.e., malicious SQL code fragments in HTTP request parameters used to manipulate SQL databases.
  * **Attack LFI**. Blocks local [file inclusion](https://en.wikipedia.org/wiki/File_inclusion_vulnerability) (LFI) attempts aimed at unauthorized reading or execution of local server files via path traversal vulnerabilities (e.g., using `../` or absolute paths).
  * **Attack RFI**. Blocks remote file inclusion (RFI) aimed at executing malicious code from external resources by injecting URLs into file inclusion parameters (e.g., `include`, `require`).
  * **Attack Tool**. Detects activity from automated tools: vulnerability scanners, exploit frameworks, brute-force utilities, and other software used for [penetration testing](https://en.wikipedia.org/wiki/Penetration_test) and attacks (based on User-Agent signatures and request patterns).
  * **Attack RCE**. Protects against remote code execution (RCE) and prevents running server OS commands via vulnerable parameters (e.g., system call injections).

How to set up:

* Rule groups can be turned on and off independently of each other.
* Each rule group gets its own [anomaly threshold](#anomaly) and action if this threshold is exceeded.
* Rules within a group can be filtered by type: basic rules or rules related to CVE vulnerabilities.
* The [paranoia level](#paranoia) is not used.

#### Available versions {#yandex-ruleset-versions}

##### Version 0.1.1 {#version-0-1-1}

This rule set contains 129 rules created in collaboration with SolidSoft, developers of the [SolidWall WAF](https://www.solidwall.ru/features.html) intelligent firewall. This version offers superior attack prevention and threat detection compared to the previous release.

Key changes:

* Added 40 new rules, including 34 rules for detecting critical CVEs in popular technologies and products, such as Bitrix, Log4j, React, and {{ PG }}.
* Extended coverage of LFI, RCE, and SQLi attacks.
* Revised some of the version 0.1.0 rules to reduce the false positive rate.

##### Version 0.1.0 {#version-0-1-0}

The first Yandex Ruleset version contains 90 rules for detecting basic types of attacks.

### OWASP Core Rule Set {#owasp-core-rule-set}

The set was developed by the Open Worldwide Application Security Project (OWASP) to ensure protection against vulnerabilities listed in the [OWASP TOP‑10](https://owasp.org/www-project-top-ten/). The OWASP Core Rule Set consists of rules aimed to detect malicious actions, including malicious file uploads, potential SQL injection attacks, DoS attempts, code injection attempts, and many more. For more information, see [this OWASP Core Rule Set repository on GitHub](https://github.com/coreruleset/coreruleset).

How to set up:

* You set a common [anomaly threshold](#anomaly) for the whole rule set. If the threshold is exceeded, the request gets blocked.
* You set a [paranoia level](#paranoia) for the whole rule set.
* Rules are organized into groups (Method Enforcement, Scanner Detection, Protocol Enforcement, etc.). For each rule, an anomaly value and a blocking rule attribute are specified.

#### Available versions {#owasp-versions}

OWASP Core Rule Set versions 4.0.0 and 4.8.0 are available in {{ sws-name }}.

## Rule settings {#rules-settings}

You can add one or multiple rule sets to a WAF profile. When adding multiple rule sets, remember to configure the following:

* _Priority_: Sequence of rule sets employed to determine the final verdict.
* _Profile trigger condition_: Whether a request must be identified as a threat by all added rule sets or by at least one of them.

When configuring rule sets, you can select specific rules for request checking and customize their triggering parameters. Each rule has an [anomaly](#anomaly) value and a [paranoia](#paranoia) level assigned.

{% note tip %}

To protect resources with different security requirements, create multiple WAF profiles. Each profile can have its own unique rule set and triggering parameters.

{% endnote %}

### Anomaly {#anomaly}

Each rule from the set is assigned a numeric _anomaly_ value, i.e., a potential attack indicator. The higher this value, the more likely it is that the request that satisfies this rule is in fact an attack.

The _anomaly threshold_ is the total anomaly score of triggered rules that results in blocking the request. The anomaly threshold level depends on the rule set:

* In the OWASP Core Rule Set, you specify a threshold for the whole rule set. The possible values range ​​from `2` to `10 000`. We recommend that you start with a threshold of `25` and gradually reduce it to `5`.
* In Yandex Ruleset, you specify a threshold individually for each rule group. The recommend value is `7`.
* In ML WAF, you specify a threshold individually for each rule. The recommended initial value is `90`.

To reduce the anomaly threshold, address WAF false positives triggered by legitimate requests. To do so, select rules from the basic set and configure [exclusion rules](#exclusion-rules). Additionally, use the **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}** mode in your security profile to test different anomaly thresholds.

You can configure any rule in the set to be a _blocking_ one. Requests matching such a rule get blocked regardless of the anomaly threshold you set. If the **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}** mode is enabled in the security profile, requests will not be blocked even when if they match the blocking rules.

### Paranoia level {#paranoia}

The _paranoia level_ is an OWASP-specific feature that classifies rules based on how aggressive they are. The higher the paranoia level, the better the protection, but also the greater the risk of WAF false positives.

In the basic rule set settings, you can configure the overall paranoia level and thus quickly engage a collection of rules with this or lower paranoia level.

## Exclusion rules {#exclusion-rules}

An _exclusion rule_ disables selected WAF rules for requests or parts of requests that satisfy the specified conditions. Use exclusion rules to get rid of false positives on legitimate traffic without disabling the WAF profile altogether.

An exclusion rule offers these blocks of settings:

* **{{ ui-key.yacloud.smart-web-security.waf.field_logging }}**: Logs requests to which the exclusion rule was applied. Use logging to make sure that the exclusion is triggered by expected traffic only and does not expand the scope of excluded WAF checks. We recommend enabling this after you create or update a rule.

* **{{ ui-key.yacloud.smart-web-security.WafProfileExclusionRuleForm.RulesSection.title_exclusion-rule-rules-section_cdWEW }}**: Sets WAF rules that will not apply to traffic covered by the exclusion. To keep your application protected, we recommended disabling only rules that cause false positives.

* **Exclusion condition**: Decides which part of the HTTP request to exclude from WAF rule analysis:

  * **Whole request**: Selected WAF rules will ignore the request entirely. Use this option if false positives cannot be localized within a particular part of the request.

  * **Part of request**: Selected WAF rules will ignore only specified parts of the request. The rest of the request will continue to be monitored as per the WAF profile settings.

    Available request parts:

    * `HTTP body`: HTTP request body. Use if you get a false positive when parsing the request body, e.g., JSON, XML, forms, or other playloads.
    * `Cookie`: `Cookie` header values.
    * `HTTP header`: HTTP header. Use if you get a false positive in a specific header's value, e.g., `User-Agent`, `Referer`, `Authorization`, or a custom header.
    * `Query params`: Query string parameters.

    You can set one or more value for each parameter except `HTTP body`. Value matching can be either case-sensitive or insensitive.

* [Traffic conditions](conditions.md): Decides which requests are subject to the exclusion. If you set several conditions of different types, the exclusion will apply only if all conditions are met at the same time. If no conditions are set, the exclusion will apply to all traffic.

## WAF setup recommendations {#waf-tuning-recommendation}

{% include [waf-tuning-recommendation](../../_includes/smartwebsecurity/waf-tuning-recommendation.md) %}

#### Useful links {#see-also}

* [{#T}](../quickstart.md#waf)
* [{#T}](../tutorials/sws-basic-protection.md)
