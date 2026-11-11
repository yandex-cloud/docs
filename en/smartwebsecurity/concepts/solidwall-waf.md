---
title: SolidWall WAF in {{ sws-full-name }}
description: How a SolidWall WAF profile, application, and domain work together in {{ sws-name }}, how to configure protection, and how to get started.
---

# SolidWall WAF

{% include [solidwall-waf-preview](../../_includes/smartwebsecurity/solidwall-waf-preview.md) %}

SolidWall WAF is a {{ sws-name }} component that protects web applications against application-layer attacks. Service analysts handle protection setup and ongoing maintenance. The available analysis features depend on the plan you use:

* **{{ ui-key.yacloud.smart-web-security.solidWallBasicTariff_hB5xS }}**: For applications handling up to 1,000 RPS. Uses a negative security model, checking each request individually against attack signatures.
* **{{ ui-key.yacloud.smart-web-security.solidWallAdvancedTariff_6mLtW }}**: For applications with any traffic load. Uses both negative and positive security models to analyze requests, responses, and user sessions based on the application’s business logic.

Benefits of SolidWall WAF:

* Protects applications against sophisticated and targeted attacks.
* Accounts for the application-specific business logic.
* Reduces the risk of false positives through tailored configuration.
* Reduces the risk of sensitive data leaks by monitoring application responses.
* Protects applications against brute-force and resource exhaustion attacks.

For more on available features, see [this SolidWall WAF guide](https://docs.solidwall.yandex.cloud/ru/overview/capabilities).

## How SolidWall WAF differs from Cloud WAF {#features}

[Cloud WAF](waf.md) analyzes individual HTTP requests using rule sets and machine learning methods. SolidWall WAF also supports response and user session analysis based on the application’s business logic. The scope of available features depends on the selected [plan](#tariffs).

Cloud WAF and SolidWall WAF operate independently of each other. You can enable both for the same domain or use them for different domains. Cloud WAF is connected to a [security profile](profiles.md) through a WAF rule, while SolidWall WAF is connected by adding the domain to an application in its profile.

The table below lists the key differences between the security solutions.

#|
|| **Feature** | **Cloud WAF** | **SolidWall WAF** ||
|| Security model | Negative: Searches for signs of attacks using rules and ML. | Negative; the Advanced plan also supports a positive security model that validates allowed parameters and user actions. ||
|| API security via a positive security model | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) Configured based on the application’s API. ||
|| Request body analysis | Analyzes request bodies up to 8 KB in size. | Parses nested JSON and XML and decodes Base64 and GZIP. By default, analyzes up to 64 KB. ||
|| Server response analysis | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) Detects sensitive data leaks and application errors. ||
|| Virtual patches | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) Blocks attempts to exploit vulnerabilities before application fixes are released. ||
|| Rule configuration | Users configure rule sets and exclusions. | Analysts configure rules, including those for request body parameters. ||
|| WebSocket message analysis | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) ||
|| Session analysis | Analyzes each request separately. | Considers the sequence of user actions. ||
|| False positive management | Users create exclusion rules. | Analysts adjust the protection settings upon a support request. ||
|| Sophisticated bot protection | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) Analyzes the application’s business logic and user behavior. ||
|| Incident investigation | Uses individual request logs. | Analyzes requests, responses, and user actions in the context of a session. ||
|#

## Connection requirements and limitations {#requirements}

Account roles:

* [smart-web-security.editor](../security/index.md#smart-web-security-editor) for the folder to create and edit a profile or application. 
* [smart-web-security.admin](../security/index.md#smart-web-security-admin) for at least one cloud in the organization to accept the HTTP request data usage agreement. The agreement is accepted once per organization. To revoke it, [contact support](../../support/overview.md).

Requirements for connecting SolidWall WAF:

* Traffic goes through the {{ sws-name }} [proxy server](domain-protect.md#proxy).
* The domain has one configured target and uses `HTTP/1.1` for connection.
* The domain has an associated security profile with at least one Smart Protection rule.

For SolidWall WAF traffic limits, see [Quotas and limits](limits.md#solidwall-waf-limits).

## Profile and applications {#resources}

_SolidWall WAF profile_ is an isolated group of applications, also known as a _tenant_. The profile defines common protection settings, plan, and RPS capacity. Each application also supports its own rules.

An _application_ maps to a single backend with common business logic and brings together one or more [domains](domain-protect.md#domain). Independent web applications require separate objects. Within a profile, each domain is unique and can be assigned to only one application.

A new application runs in [monitoring mode](https://docs.solidwall.yandex.cloud/ru/concepts/detection-modes#rezhim-monitoringa): SolidWall WAF analyzes traffic and logs rule matches but does not block requests. To enable active protection for your application, contact support.

When traffic is proxied through SolidWall WAF, user sessions are bound by IP address by default. To change the session binding method, contact support.

### Plans and RPS capacity {#tariffs}

The `{{ ui-key.yacloud.smart-web-security.solidWallBasicTariff_hB5xS }}` plan uses a _negative model_, checking each request individually against attack signatures. It supports traffic load of up to 1,000 RPS.

The `{{ ui-key.yacloud.smart-web-security.solidWallAdvancedTariff_6mLtW }}` plan also uses a _positive model_ to analyze requests, responses, and sessions while accounting for allowed parameters and sequences of user actions. Learn more about [security models](https://docs.solidwall.yandex.cloud/ru/concepts/positive-vs-negative).

_RPS capacity_ is the selected number of requests per second for the total traffic across all applications in a profile. Choose a capacity based on peak daily traffic. For example, if traffic reaches 600 requests per second, select a tier that covers that load. Actual traffic is calculated using the 95th percentile of average RPS measured over five-minute intervals for the past 30 days. RPS capacity determines the billable load and is separate from the [traffic limits](limits.md#solidwall-waf-limits) for a SolidWall WAF profile.

Before traffic starts flowing, you can switch between plans freely, with changes taking effect immediately. After traffic appears, switching to another service plan takes effect on the first day of the following month.


## Traffic metrics and logs {#monitoring}

To view traffic metrics, open the **SolidWall WAF** tab in [monitoring](../operations/monitoring.md) section.

Detailed analysis logs are available in the SolidWall WAF dashboard. A summary of each analysis result is added to the proxy server log if [logging is enabled](../operations/configure-logging.md) for that server.

The `solidwall_waf` section of the proxy server log contains the following fields:

* `x-solidwall-support-id`: Transaction ID that can be used to find the transaction in the SolidWall WAF dashboard.
* `x-solidwall-webapp-id`: SolidWall WAF application ID.
* `x-solidwall-decision`: WAF verdict, analysis mode (active protection or monitoring), and application ID.

For more on viewing transactions, see [this SolidWall WAF guide](https://docs.solidwall.yandex.cloud/ru/monitoring/inspect-transaction).

## Dashboard and configuration steps {#setup}

Use the {{ sws-name }} console to configure your profile, applications, and added domains. The SolidWall WAF dashboard is available from the profile page. Authentication uses SSO; no additional registration is required. The dashboard is read-only. Learn more about the dashboard in [this SolidWall WAF guide](https://docs.solidwall.yandex.cloud/ru/get-started/interface-overview).

SolidWall WAF configuration steps:

1. [Configure the domain](../operations/solidwall-waf-profile-create.md#setup) to route requests through the {{ sws-name }} proxy server and associate a security profile containing at least one Smart Protection rule.
1. [Create a SolidWall WAF profile](../operations/solidwall-waf-profile-create.md#create-profile) with the required service plan and RPS capacity.
1. [Create an application in the profile and add the domains to it](../operations/solidwall-waf-application-create.md).

     Creating an application automatically opens a support ticket for app configuration. Configuration typically takes about two weeks, or up to a month for complex applications. Configuring the positive security model requires actual application traffic.

1. Verify request processing in [monitoring](../tutorials/solidwall-waf.md#check-traffic) mode.
1. Agree on the final rules and enabling active protection with the support team.
     
To further fine-tune the settings and reduce false positives, contact support.

#### Useful links {#see-also}

SolidWall WAF guides:

* [Security models](https://docs.solidwall.yandex.cloud/ru/concepts/positive-vs-negative)
* [Transactions](https://docs.solidwall.yandex.cloud/ru/monitoring/inspect-transaction)
* [Security events](https://docs.solidwall.yandex.cloud/ru/monitoring/security-events)

{{ sws-name }} guides:

* [{#T}](../tutorials/solidwall-waf.md)
* [{#T}](../operations/solidwall-waf-profile-create.md)
* [{#T}](../operations/solidwall-waf-application-create.md)
* [{#T}](domain-protect.md)
* [SolidWall WAF guides](https://docs.solidwall.yandex.cloud/ru/)
