---
title: "Configuring a basic WAF rule set"
description: "Follow this guide to configure a basic rule set for a WAF profile."
---

# Configuring a basic WAF rule set

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the WAF profile.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Go to the ![image](../../_assets/smartwebsecurity/waf.svg) **WAF profiles** tab.
  1. Select the profile to configure a basic rule set in.
  1. Click **Configure a basic rule set**.
  1. Set the **Anomaly threshold**, which is the sum of [anomaly values](../concepts/waf.md#anomaly) of the triggered rules that will block the request.

      We recommend that you start with the anomaly threshold of `25` and gradually bring it down to `5`. To reduce the anomaly threshold, address WAF false positives triggered by legitimate requests. To do so, select rules from the basic set and configure [exclusion rules](exclusion-rule-add.md).

      Use the **Logging only (Dry run)** mode to test anomaly thresholds. The mode is activated when you add a WAF rule to the security profile.

  1. Set the **Paranoia level**.

      [Paranoia level](../concepts/waf.md#paranoia) classifies rules according to their aggression. The higher the paranoia level, the better your protection, but also the higher the probability of WAF false positives.
  1. Check the rules you included in the set. Add or delete them as needed. When using rules, pay attention to their anomaly values and paranoia levels.

      You can turn any rule from the set into a blocking rule. A request that satisfies such a rule will be blocked regardless of the anomaly threshold you specified. To turn a rule into a blocking rule, click ![image](../../_assets/console-icons/ban.svg) to the right of it. If the **Logging only (Dry run)** mode is enabled in the security profile, requests will not get blocked.
  1. Click **Save changes**.

{% endlist %}


### See also {#see-also}

* [{#T}](exclusion-rule-add.md)
* [{#T}](rule-add.md)
