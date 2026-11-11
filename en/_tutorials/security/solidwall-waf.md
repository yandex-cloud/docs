---
title: Connecting SolidWall WAF to a web application in {{ sws-full-name }}
description: 'Connect your web application to SolidWall WAF via {{ sws-name }}: create a profile and app, add domain, and test traffic analysis.'
---

# Connecting SolidWall WAF to a web application

{% include [solidwall-waf-preview](../../_includes/smartwebsecurity/solidwall-waf-preview.md) %}

[SolidWall WAF](../../smartwebsecurity/concepts/solidwall-waf.md) analyzes traffic and detects attacks. Service analysts configure protection for applications with complex business logic and sensitive data to reduce the risk of false positives.

You will connect a running application to SolidWall WAF and test traffic analysis in monitoring mode, without blocking. The example uses an online store with domains `shop.example.com` and `auth.shop.example.com` for the main site and authentication. Replace them with your own; for an application with a single domain, follow the steps for that domain only.

## Steps {#steps}

To connect an application:

1. [Prepare resources and check access](#before-you-begin).
1. [Create a SolidWall WAF profile](#create-profile).
1. [Add the application](#create-application).
1. [Connect domains](#connect-domains).
1. [Test traffic handling](#check-traffic).

If data does not appear, perform [diagnostics](#troubleshooting). If you no longer need the resources you created for the test, [delete them](#clear-out).

## Required paid resources {#paid-resources}

The cost includes:

* Fee for [request processing and {{ sws-name }} proxy server resources](../../smartwebsecurity/pricing.md).
* Fee for infrastructure your web application runs in.

## Prepare resources and check access {#before-you-begin}

1. Make sure your account has the following roles:

    * [smart-web-security.editor](../../smartwebsecurity/security/index.md#smart-web-security-editor) for the folder with SolidWall WAF resources.
    * [iam.serviceAccounts.admin](../../iam/security/index.md#iam-serviceAccounts-admin) for the folder to create a proxy server.
    * [smart-web-security.admin](../../smartwebsecurity/security/index.md#smart-web-security-admin) for at least one cloud in the organization to accept the HTTP request data usage agreement. The agreement is accepted once per organization when creating the first SolidWall WAF profile. To revoke consent, contact [support](../../support/overview.md).

1. Select or [create](../../smartwebsecurity/operations/proxy-create.md) a proxy server. Make sure its status is `Active`.
1. [Add](../../smartwebsecurity/operations/domain-create.md) the `shop.example.com` and `auth.shop.example.com` domains to the proxy server.
1. Select or [create](../../smartwebsecurity/operations/profile-create.md) a security profile with a Smart Protection rule.
1. [Connect](../../smartwebsecurity/operations/host-connect.md#domain) a security profile to the each domain.
1. Open the **{{ ui-key.yacloud.smart-web-security.label_domain-protection-domains }}** tab on the proxy server page and check the settings for each domain:

    * A single target resource (IP address and port) is specified; the domains serve a single backend with shared business logic.
    * The connection to the target resource uses `HTTP/1.1`; HTTP/2 is not supported.
    * A security profile with a Smart Protection rule is connected.
    * The connection to the target resource is in the **{{ ui-key.yacloud.smart-web-security.target-state.healthy_4tpQh }}** status.

    To change the domain settings, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.

1. [Configure the infrastructure](../../smartwebsecurity/operations/setup-infrastructure.md): The A record of each domain must point to the proxy server IP address.
1. [Verify resource availability](../../smartwebsecurity/operations/validate-availability.md) and make sure the application opens in a browser via its domain name.

SolidWall WAF supports HTTP traffic and WebSocket (WSS).

## Create a SolidWall WAF profile {#create-profile}

When creating a profile, you will need to select a service plan:

* `{{ ui-key.yacloud.smart-web-security.solidWallBasicTariff_hB5xS }}`: Up to 1,000 RPS, negative security model, single request analysis.
* `{{ ui-key.yacloud.smart-web-security.solidWallAdvancedTariff_6mLtW }}`: Positive and negative models, request, response, and session analysis tailored to business logic. We recommend selecting this plan to explore all available features.

Learn more about security models in [this SolidWall WAF guide](https://docs.solidwall.yandex.cloud/ru/concepts/positive-vs-negative).

To create a SolidWall WAF profile:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the proxy server and domains.
  1. [Navigate]({{ link-console-main }}/link/smartwebsecurity) to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. If you do not have access to SolidWall WAF, fill out and submit the request form.
  1. When creating the first profile, accept the HTTP request data usage agreement.
  1. Click **{{ ui-key.yacloud.smart-web-security.WafCreateProfileAction.createWafOrSolidWallProfileButton_6J5WK }}** and select **{{ ui-key.yacloud.smart-web-security.solidWallProfile_jVUUm }}**.
  1. Enter `solidwall-demo` as the profile name and a description, e.g., `Online store protection`.
  1. Under **{{ ui-key.yacloud.smart-web-security.SolidWallProfileForm.titleRpsLimit_b67eQ }}**, select the total load for all applications in the profile. Specify `100 RPS` for testing or a tier that covers the peak daily load of your production application.
  1. Under **{{ ui-key.yacloud.smart-web-security.SolidWallProfileForm.titleTariff_6j471 }}**, select `{{ ui-key.yacloud.smart-web-security.solidWallAdvancedTariff_6mLtW }}`.
  1. Review the plan, load, and cost in the calculator to the right of the form. Leave the **{{ ui-key.yacloud.smart-web-security.SolidWallProfileForm.titleApplications_rKJfh }}** section empty.
  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. In the **{{ ui-key.yacloud.smart-web-security.SolidWallProfileForm.ConfirmPurchaseDialog.dialogTitle_fomvt }}** window, read the terms and click **{{ ui-key.yacloud.common.continue }}**.

{% endlist %}

Open the `solidwall-demo` profile and check the service plan and load. To view the SolidWall WAF settings, click **{{ ui-key.yacloud.smart-web-security.controlPanel_nsbwt }}**.

## Add the application {#create-application}

Combine the store domains into an application named `shop`. For web applications with different business logic, create separate applications within the profile.

{% list tabs group=instructions %}

- Management console {#console}

  1. On the `solidwall-demo` profile page, click **{{ ui-key.yacloud.smart-web-security.SolidWall.SolidWallProfileOverviewPage.label_add-application_4pETp }}**.
  1. Enter `shop` as the application name and a description, e.g., `Main store site and authentication`.
  1. Click **{{ ui-key.yacloud.smart-web-security.Application.CreateApplicationPage.actionCreate_pi4Bb }}**.

{% endlist %}

On the application page, you can see a support ticket with the application parameters, created automatically on your behalf. Use it to configure rules and analyze false positives.

Analysts configure the model based on real traffic: this usually takes two weeks, or up to a month for complex applications. Do not delete the application until configuration is complete to preserve statistics. Transactions become available after domains are connected and traffic appears.

## Connect domains {#connect-domains}

Within a single profile, a domain can be connected to only one application.

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the `shop` application and click **{{ ui-key.yacloud.smart-web-security.SolidWallApplicationActions.label_connect-domain_cAaqD }}**.
  1. In the **{{ ui-key.yacloud.smart-web-security.ConnectDomainSolidWallDialog.FormFieldDomainSelect.title_domain_aHoh1 }}** field, select `shop.example.com`.
  1. In the **{{ ui-key.yacloud.smart-web-security.ConnectDomainSolidWallDialog.FormFieldSecurityProfileSelect.title_security-profile_v6r5o }}** field, select a security profile with a Smart Protection rule you previously connected to the domain.

  1. Click **{{ ui-key.yacloud.smart-web-security.ConnectDomainSolidWallDialog.DomainsFieldArray.button_add-domain_cVb2C }}**. Select `auth.shop.example.com` and its security profile.
  1. Click **{{ ui-key.yacloud.smart-web-security.ConnectDomainSolidWallDialog.button_connect_8BBRL }}**.

{% endlist %}

Check the connection result:

1. On the `shop` application page, make sure that both domains are listed with the correct IP addresses, ports, proxy server, and security profiles.
1. On the `solidwall-demo` profile page, find the `shop` application in the **{{ ui-key.yacloud.smart-web-security.SolidWall.SolidWallProfileOverviewPage.section-title_applications_5DnfM }}** table. Both addresses must be displayed in the domains column.
1. Under **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}**, open the proxy server and its **{{ ui-key.yacloud.smart-web-security.label_domain-protection-domains }}** tab. Each domain in the **{{ ui-key.yacloud.smart-web-security.solidWallProfile_jVUUm }}** column must have the `solidwall-demo` profile specified.

Records of resource creation and domain connection are available on the **{{ ui-key.yacloud.common.operations }}** tabs of the profile and the application.

The **{{ ui-key.yacloud.smart-web-security.solid-wall.domain_session-bindings_t5Jor }}** column specifies the session binding to the SolidWall WAF server. By default, binding is set to **{{ ui-key.yacloud.smart-web-security.solid-wall.domain_session-bindings_by-ip_pRD7K }}**; contact support to change it.

## Test traffic handling {#check-traffic}

Send requests to the application and locate them in the SolidWall WAF console:

1. Open the main site via its domain name. Navigate through several pages, use the search feature and the login form. Make about 20-30 requests, including calls to both domains.

    Use domain names so that traffic passes through the proxy server. After changing the DNS, verify the IP address using the `nslookup <domain>` command: it must match the proxy server address.

1. In the {{ sws-name }} console, open the `solidwall-demo` profile and click **{{ ui-key.yacloud.smart-web-security.controlPanel_nsbwt }}**.
1. In the new tab, under **Overview**, find the application and select the **Hour** period.

    In the SolidWall WAF console, the application name looks like `webapp-<profile_id>-<application_id>`. Match it with the IDs in the {{ sws-name }} console. Learn more about [selecting applications and configuring the overview](https://docs.solidwall.yandex.cloud/ru/monitoring/overview#nabory-prilozhenij).

1. Check the application measures:

    #|
    || **Measure** | **Expected result** ||
    || Chart on the **Statuses** tab | There is data available for the verification period. Green represents `1xx`, `2xx`, and `3xx` responses; yellow represents `4xx`, and unanswered requests; red represents `5xx`. ||
    || **Transactions** counter | The value is greater than zero and increases with new requests. ||
    || Status | **Monitoring** — WAF analyzes traffic and logs rule matches but does not block requests. ||
    |#

    Learn more about [charts and measures](https://docs.solidwall.yandex.cloud/ru/monitoring/overview#grafiki) and [monitoring mode](https://docs.solidwall.yandex.cloud/ru/concepts/detection-modes#rezhim-monitoringa).

1. In the **Applications** section, open the required application and go to the **Transactions** tab. Select the verification period and, if required, filter requests by domain. Double-click a transaction to view the request, response, and analysis result. Learn more about [viewing transactions](https://docs.solidwall.yandex.cloud/ru/monitoring/inspect-transaction#kak-najti-tranzakciyu).
1. Return to the {{ sws-name }} console and make sure that the `shop` application status has changed to `Active`. The `Active` status in the console does not mean that request blocking is enabled in SolidWall WAF.

Static requests might not appear on charts, and regular transactions are saved using sampling: their count may be less than the number of sent requests.

If anomalies are detected, [security events](https://docs.solidwall.yandex.cloud/ru/monitoring/security-events) will appear under **Overview**. Handle them by submitting a support ticket for the application.

Once traffic appears, check the **{{ ui-key.yacloud.smart-web-security.solid-wall.5j7yt }}** measure on the profile page in the {{ sws-name }} console. If the actual load regularly exceeds the selected tier, review the RPS value in the profile.

### Result {#result}

Connection is complete if the following conditions are met:

* Both domains are connected to the `shop` application within the `solidwall-demo` profile.
* The application is active, and its transactions and charts are displayed in the SolidWall WAF console.
* The application is running in monitoring mode.
* A support ticket to configure protection is available on the application page.

Continue routing normal traffic through the WAF to calibrate the model. After verifying rules and analyzing false positives, coordinate enabling [active protection](https://docs.solidwall.yandex.cloud/ru/concepts/detection-modes#rezhim-aktivnoj-zashity) via an application support ticket.

## If data does not appear {#troubleshooting}

#|
|| **Issue** | **What to check** ||
|| The domain opens, but there are no transactions | A records must point to the {{ sws-name }} proxy server. Make sure requests are not served from the cache or sent directly to the target resource. ||
|| DNS is configured correctly, but there are no transactions | Check the domain connection to the application and ensure a Smart Protection rule exists in the security profile. ||
|| The application is not displayed in the SolidWall WAF console | Wait a few minutes after creation and refresh the page. Match the technical name with the application ID in the {{ sws-name }} console. ||
|| Charts are empty | Check the selected application and period. Try selecting the **Day** period. Make requests to the dynamic pages of the application. ||
|| The charts show `5xx` responses | Verify [target resource availability](../../smartwebsecurity/operations/validate-availability.md), its IP address, and its port. Ensure the server accepts traffic from the {{ sws-name }} proxy server. ||
|#

Learn more about [reasons for missing data on charts](https://docs.solidwall.yandex.cloud/ru/monitoring/overview#tipichnye-problemy) and [searching for transactions](https://docs.solidwall.yandex.cloud/ru/monitoring/inspect-transaction#tipichnye-problemy).

## How to delete the resources you created {#clear-out}

If you no longer need the `solidwall-demo` profile, delete it. If the service analysts are still working with the application, wait for the configuration to complete or contact support.

Delete the resources in the following order:

1. [Disconnect domains and delete the `shop` application](../../smartwebsecurity/operations/solidwall-waf-application-delete.md). Repeat for other applications if they exist in the profile.
1. [Delete](../../smartwebsecurity/operations/solidwall-waf-profile-delete.md) the `solidwall-demo` profile.

Domains, their security profiles, and the web application infrastructure will be preserved and will continue to run and be billed according to their terms.

#### Useful links {#see-also}

* [{#T}](../../smartwebsecurity/operations/solidwall-waf-profile-create.md)
* [{#T}](../../smartwebsecurity/operations/solidwall-waf-application-create.md)
* [{#T}](../../smartwebsecurity/operations/solidwall-waf-profile-delete.md)
* [{#T}](../../smartwebsecurity/concepts/solidwall-waf.md)
* [SolidWall WAF guides](https://docs.solidwall.yandex.cloud/ru/)
