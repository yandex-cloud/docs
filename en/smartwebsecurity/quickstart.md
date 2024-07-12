# Getting started with a security profile

Create your first [security profile](./concepts/profiles.md) and connect it to an existing [virtual host](../application-load-balancer/concepts/http-router.md#virtual-host) of an L7 load balancer in {{ alb-full-name }}.

If you have no L7 load balancer configured, you can try {{ sws-name }} out on the test infrastructure. For more information, see [{#T}](./tutorials/balancer-with-sws-profile.md).

To get started with a security profile:
1. [Create a security profile](#profile-create).
1. [Check your security profile settings](#profile-check).
1. [Connect the security profile to a virtual host](#profile-connect).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Create a security profile {#profile-create}

The security profile is the main {{ sws-name }} component, which consists of a set of rules, each containing conditions for filtering user requests arriving to the resource being protected.

To create a security profile:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a folder you want to create the profile in.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
   1. Click **{{ ui-key.yacloud.smart-web-security.action_empty }}** and select **{{ ui-key.yacloud.smart-web-security.title_default-template }}**.

      Preset profiles include:
      * [Basic default rule](concepts/rules.md#base-rules) enabled for all traffic with the `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}` [action type](concepts/rules.md#rule-action).
      * [Smart Protection rule](concepts/rules.md#smart-protection-rules) enabled for all traffic with the `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}` action type.

      {% include [smart-protection-tip](../_includes/smartwebsecurity/smart-protection-tip.md) %}

   1. Enter the profile name, e.g., `test-sp1`.
   1. In the **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}** field, select `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}`.
   1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Check your security profile settings {#profile-check}

{% list tabs group=instructions %}

- Management console {#console}

   1. Select the `test-sp1` profile that you created earlier.
   1. Make sure the **{{ ui-key.yacloud.smart-web-security.overview.title_security-rules }}** tab contains a rule with the following parameters:
      * **{{ ui-key.yacloud.smart-web-security.overview.column_type }}**: `{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}`
      * **{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}**: `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}`
      * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}**: `{{ ui-key.yacloud.component.condition-column.condition_full-trafic }}`

      This rule sends all incoming traffic of the protected resource for automatic analysis using ML and behavioral analysis algorithms. As a result of automatic analysis:
      * Legitimate requests are routed to the protected resource.
      * Illegitimate requests and attacks are blocked.
      * Suspicious requests are sent to [{{ captcha-name }}](../smartcaptcha/) for additional verification.

   You can also connect these to your security profile:

   * [WAF profile](./concepts/waf.md) (for more information, see [{#T}](./quickstart/quickstart-waf.md)).
   * [ARL profile](./concepts/arl.md) (for more information, see [{#T}](./quickstart/quickstart-arl.md)).

   {% include [note-preview-waf](../_includes/smartwebsecurity/note-preview-waf-arl.md) %}

{% endlist %}

## Connect the security profile to the virtual host {#profile-connect}

{% list tabs group=instructions %}

- Management console {#console}

   1. At the top right, click ![plug](../_assets/smartwebsecurity/plug.svg) **{{ ui-key.yacloud.smart-web-security.overview.action_attach-to-host }}**.
   1. In the window that opens, select:
      * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_balancer }}**](../application-load-balancer/concepts/application-load-balancer.md).
      * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_http-router }}**](../application-load-balancer/concepts/http-router.md).
      * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_virtual-host }}**](../application-load-balancer/concepts/http-router.md#virtual-host). You can connect the security profile to multiple virtual hosts at once.

         To connect the profile to another L7 load balancer, click **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_add-balancer }}**.
   1. Click **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_connect }}**.

      You will see the connected virtual host in the **{{ ui-key.yacloud.smart-web-security.overview.title_connected-to-the-hosts }}** tab.

{% endlist %}

### See also {#see-also}

* [{#T}](./quickstart/quickstart-waf.md)
* [{#T}](./quickstart/quickstart-arl.md)
* [{#T}](./concepts/profiles.md)
* [{#T}](./operations/profile-create.md)
* [Creating an L7 load balancer with a security profile](./tutorials/balancer-with-sws-profile.md)
