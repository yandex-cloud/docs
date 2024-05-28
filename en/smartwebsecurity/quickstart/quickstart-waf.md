# Getting started with a WAF profile

{% include [note-preview-waf](../../_includes/smartwebsecurity/note-preview-waf.md) %}

To protect your web apps from external threats, {{ sws-full-name }} implements a Web Application Firewall (WAF).

Create your first [WAF profile](../concepts/waf.md) and connect it to an existing {{ sws-full-name }} [security profile](../concepts/profiles.md).

If you have not configured a security profile yet, create it and connect it to a [virtual host](../../application-load-balancer/concepts/http-router.md#virtual-host) of an L7 {{ alb-full-name }}. For more information, see [{#T}](../quickstart.md).

To get started with WAF:
1. [Create a WAF profile](#profile-create).
1. [Configure a basic rule set](#configure-rules).
1. [Create an exception rule](#create-exclusion).
1. [Connect the WAF profile to a security profile](#profile-connect).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Create a WAF profile {#profile-create}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a folder you want to create your WAF profile in.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
   1. Go to the ![image](../../_assets/smartwebsecurity/waf.svg) **WAF profiles** tab and click **Create WAF profile**.
   1. Describe a scenario of using WAF features in your projects and click **Submit request**.

      Once your request is approved, you can proceed to create a WAF profile.
   1. Enter a name for the profile, e.g., `test-waf-profile-1`.
   1. The WAF profile's default basic rule set is called [OWASP Core Rule Set](https://coreruleset.org/). To view the rules it includes, click the line with its description.
   1. Click **Create**.

{% endlist %}

## Configure a basic rule set {#configure-rules}

{% list tabs group=instructions %}

- Management console {#console}

   1. On the WAF profile's review page that opens, click **Configure a basic rule set**.
   1. Set the preferred **Anomaly threshold**, which is the sum of [anomaly values](../concepts/waf.md#anomaly) of the triggered rules that will block the request, e.g., `Moderate: 25 or higher`.

      We recommend that you start with the anomaly threshold of `25` and gradually bring it down to `5`. To reduce the anomaly threshold, address WAF false positives triggered by legitimate requests. To do so, select rules from the basic set and configure [exception rules](#create-exclusion). You can use the **Logging only (dry-run)** mode in the security profile to test various anomaly thresholds.

   1. Set the preferred **Paranoia level**, e.g., `2 and lower`.

      [Paranoia level](../concepts/waf.md#paranoia) classifies rules according to their aggression. The higher the paranoia level, the better your protection, but also the higher the probability of WAF false positives.
   1. Check the rules you included in the set. Add or delete them as needed. When using rules, pay attention to their anomaly values and paranoia levels.

   You can turn any rule from the set into a blocking rule. A request that satisfies such a rule will be blocked regardless of the anomaly threshold you specified. To turn a rule into a blocking rule, click ![image](../../_assets/console-icons/ban.svg) to the right of it. If the **Logging only (dry-run)** mode is enabled in the security profile, requests will not be blocked even when if they satisfy the blocking rules.

{% endlist %}

## Create an exception rule {#create-exclusion}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the ![image](../../_assets/console-icons/file-xmark.svg) **Exception rules** tab and click **Create exception rule**.
   1. Enter a name for the [exception rule](../concepts/waf.md#exclusion-rules), e.g., `exception-rule1`.
   1. Under **Scope of use**, specify the basic set rules covered by the exception. You can select **All rules** or specific ones.
   1. Under **Conditions for traffic**, select the exception rule trigger [conditions](../concepts/conditions.md).

      If you leave the **Conditions** field empty, the exception rule will apply to the whole traffic.
   1. Click **Create**.

{% endlist %}

## Connect the WAF profile to a security profile {#profile-connect}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the ![image](../../_assets/console-icons/shield-check.svg) **Security profiles** tab.
   1. From the list, select the security profile you want to connect your WAF profile to, e.g., `test-sp1`.
   1. Click ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
   1. Enter rule name, e.g., `waf-rule-1`.
   1. In the **Priority** field, set a value higher than that of the Smart Protection rules already existing in the security profile, e.g., `888800`.
   1. (Optional) To test your WAF profile and address false positives triggered by legitimate requests, use the **Logging only (dry-run)** mode in the security profile.
   1. In the **Rule type** field, select **Web Application Firewall**.
   1. In the **WAF profile** field, select the `test-waf-profile-1` profile you created earlier.
   1. In the **Action** field, select **Full protection**.
   1. If required, set the [conditions](../concepts/conditions.md) for traffic mapping.
   1. Click **Add**.

{% endlist %}

### See also {#see-also}

* [{#T}](../quickstart.md)
* [{#T}](../concepts/waf.md)
