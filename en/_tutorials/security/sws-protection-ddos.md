# Emergency DDoS protection in {{ alb-name }}, L7


This guide will help you stop a live [DDoS attack](https://ru.wikipedia.org/wiki/DoS-атака).

## Conditions to implement the described solution {#tutorial-conditions}

* Your services are hosted in {{ yandex-cloud }} or connected to [{{ alb-name }}](../../application-load-balancer/) via [{{ interconnect-name }}](../../interconnect/).
* You used an L7 {{ alb-name }} to publish your services online.
* The DDoS attack targets the application layer (L7) by flooding it with HTTP requests (GET/POST).

{% note tip %}

Estimate your standard service load. You can do this in {{ alb-name }} under **{{ ui-key.yacloud_billing.common.monitoring }}**. The **RPS** chart displays the total number of incoming requests per second the load balancer receives. To analyze the normal load, select a period before the DDoS attack.

{% endnote %}

## Steps to set up protection {#setup-stages}

To stop a DDoS attack, you need to connect [{{ sws-name }}](../../smartwebsecurity/) and set up rules to block malicious traffic.

1. [Create a security profile](#setup-security-profile).
1. [Associate the security profile](#connect-profile) with a virtual host.
   
   If you have an existing security profile associated with a host, [check the profile settings](#setup-existing-profile).

1. [Test the security profile](#check-the-result).
1. [Set up additional DDoS protection rules](#anti-ddos).

After you stop the attack, you can set up dedicated protection for your service in [{{ sws-name }}](../../smartwebsecurity/concepts/). If you no longer need the resources you created, [delete them](#clear-out).

## Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/sws-protection-ddos/paid-resources.md) %}

## Create a security profile {#setup-security-profile}

_Security profiles_ are the main component of {{ sws-name }}. A profile consists of rules for handling HTTP traffic. Such rules define filtering conditions and actions to apply to the traffic flowing through a virtual host of an L7 load balancer.

To quickly deploy protection, you can use the preset template. The template contains optimal settings for basic protection of web services.

To create a security profile:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the protected resources are in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/profiles.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
  1. Click **{{ ui-key.yacloud.smart-web-security.action_empty }}** and select **{{ ui-key.yacloud.smart-web-security.title_default-template }}**.
  1. Enter a name for the profile, e.g., `anti-ddos`.
  1. In the **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}** field, select `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}`.
  1. In the **{{ ui-key.yacloud.smart-web-security.form.label_smartcaptcha }}** list, leave the `{{ ui-key.yacloud.smart-web-security.label_default-smartcaptcha-name }}` value.
  1. Click **{{ ui-key.yacloud.common.create }}**.


{% endlist %}

## Associate the security profile with the virtual host {#connect-profile}

If the load balancer is managed by an {{ alb-name }} [ingress controller](../../application-load-balancer/tools/k8s-ingress-controller/index.md), use the [ingress resource annotation](../../application-load-balancer/k8s-ref/ingress.md#annot-security-profile-id).

{% list tabs group=instructions %}

- Management console {#console}

  1. At the top right of the page with security profile properties, click ![plug](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.smart-web-security.overview.action_attach-to-host }}**.
  1. Select the following in the given order:
      * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_balancer }}**](../../application-load-balancer/concepts/application-load-balancer.md).
      * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_http-router }}**](../../application-load-balancer/concepts/http-router.md).

      * **{{ ui-key.yacloud.smart-web-security.attach-dialog.label_virtual-host }}**. You can associate the security profile with multiple virtual hosts at once.

        To connect another L7 load balancer, click **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_add-balancer }}**.
  1. Click **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_connect }}**.

      In the **{{ ui-key.yacloud.smart-web-security.overview.title_connected-to-the-hosts }}** tab, you will see the connected virtual hosts.

{% endlist %}

## Configure an existing security profile {#setup-existing-profile}

If you have an existing security profile, check and adjust its parameters:

1. **{{ ui-key.yacloud.smart-web-security.form.label_smartcaptcha }}**: `{{ ui-key.yacloud.smart-web-security.label_default-smartcaptcha-name }}`

1. Make sure there is a rule named `sp-rule-1` with the following parameters:
   * **{{ ui-key.yacloud.smart-web-security.overview.column_type }}**: `{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}`
   * **{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}**: `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}` for website protection with suspicious requests redirected to {{ captcha-name }} or `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-api }}` to block suspicious requests.
   * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}**: `{{ ui-key.yacloud.component.condition-column.condition_full-trafic }}`
   * **{{ ui-key.yacloud.smart-web-security.overview.column_priority }}**: `999900`

1. Make sure there is a basic rule with the following parameters:
   * **{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}**: `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}`
   * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}**: `{{ ui-key.yacloud.component.condition-column.condition_full-trafic }}`
   * **{{ ui-key.yacloud.smart-web-security.overview.column_priority }}**: `1000000`
   
## Test the security profile {#check-the-result}

To test your security profile, use information from monitoring charts and logs.

### Monitoring {#monitoring}

{% list tabs group=instructions %}

- Management console {#console}

  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Navigate to **{{ ui-key.yacloud.common.monitoring }}**.
  1. Examine the data displayed on the charts:
     * **Denied by Security Profile RPS**: Number of incoming requests per second the security profile has checked and blocked.
     * **Redirected to SmartCaptcha RPS**: Number of incoming requests per second routed to {{ captcha-name }} for additional verification.
     * **Denied by ARL Profile RPS**: Number of incoming requests per second exceeding the ARL profile limit and blocked.

{% endlist %}

For detailed description of charts, see [{#T}](../../smartwebsecurity/operations/monitoring.md).

### Logging {#logs}

{% list tabs group=instructions %}

- Management console {#console}

  1. Make sure you have configured [logging](../../smartwebsecurity/operations/configure-logging.md) for the L7 load balancer.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Select the load balancer with an associated security profile.
  1. Navigate to **{{ ui-key.yacloud.common.logs }}**.
  1. Select the number of messages per page and the period, e.g., `1 hour`.
  1. In the **Query** field, specify you query using the [filter expression language](../../logging/concepts/filter.md) and click **Run**.

      Request examples:

      * Show requests which triggered a Smart Protection rule with a CAPTCHA challenge:
        ```
        json_payload.smartwebsecurity.matched_rule.rule_type = SMART_PROTECTION and json_payload.smartwebsecurity.matched_rule.verdict = CAPTCHA
        ```

      * Show requests blocked by the ARL profile rules:
        ```
        json_payload.smartwebsecurity.advanced_rate_limiter.verdict = DENY
        ```

{% endlist %}

For more information about working with logs, see [{#T}](../../smartwebsecurity/operations/configure-logging.md).

## Set up additional DDoS protection rules {#anti-ddos}

To protect your service against load bursts, set a request limit in the [ARL (Advanced Rate Limiter)](../../smartwebsecurity/concepts/arl.md) profile.

### Set a request limit {#setup-arl}

{% list tabs group=instructions %}

- Management console {#console}

  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/arl.svg) **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}**.
  1. Click **{{ ui-key.yacloud.smart-web-security.arl.label_create-profile }}**.
  1. Enter a name for the profile, e.g., `anti-ddos-arl`.
  1. Click ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}** and specify:
        
     {% include [arl-rule-properties](../_tutorials_includes/sws-protection-ddos/arl-rule-properties.md) %}

  1. Click **{{ ui-key.yacloud.smart-web-security.arl.label_save-rule }}**.
  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/profiles.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
  1. Click ![options](../../_assets/console-icons/ellipsis.svg) next to the `anti-ddos` profile and select **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**.
  1. From the list of ARL profiles, select `anti-ddos-arl`.
  1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### Configure blocking by IP address lists {#block-by-list}

{{ sws-name }} has pre-configured [lists](../../smartwebsecurity/concepts/lists.md) of untrusted addresses, which get updated on a regular basis. You can [create your own lists](../../smartwebsecurity/operations/list-create.md) of trusted or untrusted addresses and add them to request filtering conditions.

{% list tabs group=instructions %}

- Management console {#console}

   1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
   1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/profiles.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
   1. Select the `anti-ddos` security profile.
   1. Click ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
   1. Enter the **{{ ui-key.yacloud_billing.common.name }}**, e.g., `block-by-list`.
   1. Specify the rule settings:
      * **{{ ui-key.yacloud.smart-web-security.overview.column_priority }}**: Higher than that of `sp-rule-1`, e.g., `1000`.
      * **{{ ui-key.yacloud.smart-web-security.overview.column_type }}**: `{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}`.
      * **{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}**: `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}` or `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-captcha }}`.
      * **Traffic**: `On condition`.
      * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}**: `{{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}`.
      * **Conditions for IP**: `IP belongs to the list`.
      * Select the address lists. Requests from these addresses will be blocked.
         * `is_ddoser`: List of IP addresses used in DDoS attacks.
         * Click **+ or** and select `is_tor`: IP addresses of the Tor network used for traffic anonymization.
         * Click **+ or** and select `is_anonimous`: IP addresses of anonymous networks frequently used to hide one’s identity.
    1. Click **{{ ui-key.yacloud_billing.common.add }}**.

{% endlist %}

### Configure blocking by IP address region {#block-by-geo}

{% list tabs group=instructions %}

- Management console {#console}

    Block all requests from the region the attack is coming from. If your service does not operate in certain regions, you can block traffic from those regions in advance. DDoS attacks often come from IP addresses of non-target countries.

   1. Select the `anti-ddos` security profile.
   1. Click ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
   1. Enter the **{{ ui-key.yacloud_billing.common.name }}**, e.g., `block-by-geo`.
   1. Specify the rule settings:
      * **{{ ui-key.yacloud.smart-web-security.overview.column_priority }}**: Higher than that of `sp-rule-1` but lower than that of `block-by-list`, e.g., `2000`.
      * **{{ ui-key.yacloud.smart-web-security.overview.column_type }}**: `{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}`.
      * **{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}**: `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}` or `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-captcha }}`.
      * **Traffic**: `On condition`.
      * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}**: `{{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}`.
      * **Conditions for IP**: `IP belongs to the region`.
      * Select the region the attack is coming from, e.g., `CN`, `US`, or `IN`.
  
         To add another region, click **+ or**.

      {% note tip %}

      If your service operates only in certain regions, select the `IP does not belong to the region` condition. In the list, specify the target region, e.g., `RU`. Traffic from other regions will be blocked.

      You can check the region of an IP address at [ipinfo.io](https://ipinfo.io/) or with an [ASN provider](https://en.wikipedia.org/wiki/Autonomous_system_(Internet)).

      {% endnote %}

   1. Click **{{ ui-key.yacloud_billing.common.add }}**.

{% endlist %}

Use information from monitoring charts and logs to test the rules. If necessary, adjust the request limit in the ARL profile.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created, do one of the following:

1. [Disassociate the security profile](../../smartwebsecurity/operations/host-delete.md) from the virtual host.
1. [Delete the security profile](../../smartwebsecurity/operations/profile-delete.md).