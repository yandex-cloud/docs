---
title: Managing traffic sources
description: How to configure traffic processing rules based on preset IP address lists and regions in {{ sws-name }}.
---

# Managing traffic sources

{{ sws-name }} allows you to configure request processing rules according to the source of traffic. For example, you can separately process requests from the Tor network, VPNs, anonymous networks, public proxies, or from individual countries.

All this is done with the help of preset {{ yandex-cloud }} [IP address lists](../../smartwebsecurity/concepts/lists.md). These lists group IP addresses and networks together based on a particular characteristic, e.g., being Tor or VPN. The service maintains and regularly updates the lists.

This guide describes how to set up common traffic filtering rules based on source.

## Setup steps {#steps}

1. [Create a security profile](#profile-create).
1. [Set up a rule for Tor, proxy, and anonymous networks](#configure-source-rules).
1. [Set up a rule for VPN traffic](#configure-vpn-rules).
1. [Set up a rule based on regions](#configure-geo-rules).
1. [Check the order of executing the rules](#rules-order).
1. [Connect a security profile to the resources](#profile-connect).
1. [Test the rules in logging mode](#dry-run).
1. [Activate the production mode](#production).

## Required paid resources {#paid-resources}

* Fee for the number of requests to {{ sws-name }} based on plans detailed in [{#T}](../../smartwebsecurity/pricing.md).
* Fee for the infrastructure of the protected resource depending on its location.

This guide assumes that you already have a configured web resource in your {{ yandex-cloud }} infrastructure. If your web resource is located in a different infrastructure, connect it to a proxy server as per [{#T}](../../smartwebsecurity/tutorials/sws-basic-protection.md).

## Create a security profile {#profile-create}

This guide uses a ready-made security profile template.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the protected resources are in.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/profiles.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
  1. Click **{{ ui-key.yacloud.smart-web-security.action_empty }}** and select **{{ ui-key.yacloud.smart-web-security.title_default-template }}**.

      {% include [pre-configured-profile](../../_includes/smartwebsecurity/pre-configured-profile.md) %}
   
  1. Enter a name for the profile, e.g., `sources-manage`.

  1. Enable test mode for the `sp-rule-1` Smart Protection rule:
     1. For **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}**, select `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}`.
     1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to `sp-rule-1` and select **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**.
     1. Enable **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**.
     1. Click **{{ ui-key.yacloud.common.save-changes }}**.

  1. Under **{{ ui-key.yacloud.component.disallow-data-processing.title_ml-model-training }}**, do not withdraw your consent to the use of HTTP request info to improve your machine learning models. Otherwise, {{ sws-name }} will not be getting the data it needs to investigate security incidents.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}


## Set up a rule for Tor, proxy, and anonymous networks {#configure-source-rules}

Such traffic is identified with the help of the `is_tor`, `is_proxy`, and `is_anonymous` lists.

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the security profile you created earlier.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
  1. Enter a name for the rule, e.g., `traffic-sources-rule`.
  1. Enable **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**.
  1. Set a higher priority than the Smart Protection rules, e.g., `9100`.
  1. Specify the rule settings:
     * **{{ ui-key.yacloud.smart-web-security.overview.column_type }}**: `{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}`.
     * **Traffic**: `On condition`.
     * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}**: `{{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}`.
     * **Conditions for IP**: `IP belongs to the list`.
  1. For the `is_tor` list, select `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}`.
  1. Create a separate rule or add an additional condition for the `is_proxy` and `is_anonymous` lists with the `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-captcha }}` action.
  1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

This set of rules helps block traffic from Tor immediately and, separately, check requests from public proxies and anonymous networks via {{ captcha-name }}.

## Set up a rule for VPN traffic {#configure-vpn-rules}

VPN traffic is identified with the help of the `is_vpn` and `is_ml_vpn` lists.

You can set separate processing rules for such traffic as per your security policy: allow, block, require CAPTCHA, or apply further restrictions in the ARL profile.

{% note warning %}

VPN traffic detection is based on {{ yandex-cloud }} IP addresses and does not guarantee complete accuracy. False positives and false negatives are a possibility. Your decision to block VPN traffic should align with your business scenarios, as some of your real users may be using VPN.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the security profile, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
  1. Enter a name for the rule, e.g., `vpn-traffic-rule`.
  1. Enable **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**.
  1. Set up priority for the rule to be executed in the right order relative to other rules in the lists.
  1. Specify the rule settings:
     * **{{ ui-key.yacloud.smart-web-security.overview.column_type }}**: `{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}`.
     * **Traffic**: `On condition`.
     * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}**: `{{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}`.
     * **Conditions for IP**: `IP belongs to the list`.
  1. Select the list: `is_vpn` or `is_ml_vpn`.
  1. Select the VPN traffic action:
     * `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}`: If VPN traffic is allowed.
     * `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}`: If VPN traffic has to be blocked.
     * `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-captcha }}`: If further verification is required.
  1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

To limit the request rate for VPN traffic, [create an ARL profile](../../smartwebsecurity/operations/arl-profile-create.md) and add to it a [rule](../../smartwebsecurity/operations/arl-rule-add.md) with conditions for the `is_vpn` and `is_ml_vpn` lists.

## Set up a rule based on regions {#configure-geo-rules}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the security profile, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
  1. Enter a name for the rule, e.g., `geo-traffic-rule`.
  1. Enable **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**.
  1. Set a higher priority than the Smart Protection rules but with due consideration for existing list-based rules.
  1. Specify the rule settings:
     * **{{ ui-key.yacloud.smart-web-security.overview.column_type }}**: `{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}`.
     * **Traffic**: `On condition`.
     * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}**: `{{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}`.
     * **IP conditions**: `IP belongs to region` or `IP does not belong to region`.
  1. Select the countries of interest using the two-letter code, e.g., `RU`, `KZ`, `BY`.
  1. Select an action:
     * `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}`: To allow traffic.
     * `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}`: To bock traffic.
     * `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-captcha }}`: To send requests to {{ captcha-name }}.
  1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

If your service targets only a few countries, it is best to use the `IP does not belong to region` condition. Then you can explicitly specify allowed regions and restrict the rest of the traffic.

## Check the order of executing the rules {#rules-order}

Security profile rules are applied on first-to-trigger basis. Therefore, specify the processing order ahead of time:

* First come the _allowing_ rules for trusted traffic.
* Then, rules for high-risk sources.
* Then, rules based on regions.
* After that, the Smart Protection rules and other general rules.

For more on the order of executing the rules, click [here](../../smartwebsecurity/concepts/rules.md#rules-order).

## Test the rules in logging mode {#dry-run}

Keep the new rules in the **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}** mode for a few days. During which period:

* Analyze which requests are covered by the rules.
* Estimate the share of legitimate traffic.
* Update your lists, regions, and actions.

Use logs and the service's monitoring capabilities for your analysis. For more information, see [{#T}](../../smartwebsecurity/operations/configure-logging.md) and [{#T}](../../smartwebsecurity/operations/monitoring.md).

## Activate the production mode {#production}

After testing, disable **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}** for the rules. Keep on monitoring and updating the rules as needed.

#### See also {#see-also}

* [{#T}](../../smartwebsecurity/concepts/lists.md)
* [{#T}](../../smartwebsecurity/concepts/conditions.md)
* [{#T}](../../smartwebsecurity/concepts/botes.md)
* [{#T}](../../smartwebsecurity/tutorials/sws-basic-protection.md)