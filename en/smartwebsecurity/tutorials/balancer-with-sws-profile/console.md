# Creating an L7 load balancer in {{ alb-name }} with a {{ sws-name }} profile from the management console

To create an [L7 load balancer with a {{ sws-name }} profile](index.md) from the {{ yandex-cloud }} management console:

1. [Get your cloud ready](#before-you-begin).
1. [Set up your infrastructure](#infrastructure-prepare).
1. [Create a security profile](#profile-create).
1. [Associate the security profile with a virtual host](#profile-connect).
1. [Test the security profile](#test).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/balancer-with-sws-profile/paid-resources.md) %}


## Set up your infrastructure {#infrastructure-prepare}

[Deploy](../../../application-load-balancer/quickstart.md) an {{ alb-name }} infrastructure and a VM with a test web server.

You will create the following resources:
* [VM](../../../compute/concepts/vm.md) named `test-vm1` with a test web server.
* [Target group](../../../application-load-balancer/concepts/target-group.md) named `test-target-group`.
* [Backend group](../../../application-load-balancer/concepts/backend-group.md) named `test-backend-group`.
* [HTTP router](../../../application-load-balancer/concepts/http-router.md) named `test-http-router` with a [virtual host](../../../application-load-balancer/concepts/http-router.md#virtual-host) named `test-virtual-host`.
* [L7 load balancer](../../../application-load-balancer/concepts/application-load-balancer.md) named `test-load-balancer`.

Save the public IP address of the L7 load balancer: you will need it to test your security profile.


{% include [auto-scaling-tip](../../../_includes/smartwebsecurity/auto-scaling-tip.md) %}

## Create a security profile {#profile-create}

The security profile is the central {{ sws-name }} component that includes a set of rules, each containing conditions for filtering user requests arriving to the resource being protected.

To create a security profile:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a profile.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Click **{{ ui-key.yacloud.smart-web-security.action_empty }}** and select **{{ ui-key.yacloud.smart-web-security.title_default-template }}**.

      A preset profile includes:
      * [Basic default rule](../../../smartwebsecurity/concepts/rules.md#base-rules) enabled for all traffic with the `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}` [action type](../../../smartwebsecurity/concepts/rules.md#rule-action).
      * [Smart protection rule](../../../smartwebsecurity/concepts/rules.md#smart-protection-rules) enabled for all traffic with the `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}` action type.

      {% include [smart-protection-tip](../../../_includes/smartwebsecurity/smart-protection-tip.md) %}

  1. Enter a name for the profile, e.g., `test-sp1`.
  1. In the **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}** field, select `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}`. Therefore, if no other rules are set, all traffic to the protected resource will be denied.
  1. Click ![plus-sign](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
  1. In the rule creation window:
      1. Enter a name for the rule, e.g., `test-rule1`.
      1. Set the rule priority, e.g., `999800`. The rule will have higher priority than the preset ones.

          {% include [preconfigured-rules-priority](../../../_includes/smartwebsecurity/preconfigured-rules-priority.md) %}

      1. Select the `{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}` rule type.
      1. Select the `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-allow }}` action.

          The rule will describe conditions under which requests will be routed to the test application backend.
      1. In the **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** field, select {{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}.
      1. In the **IP conditions** field that appears, select `Matches or belongs to range` and set the public IP address of the device from which you are going to send requests to the L7 load balancer, e.g., `158.160.100.200`.
      1. Click **{{ ui-key.yacloud.common.add }}**.

          The rule you created will appear under **{{ ui-key.yacloud.smart-web-security.form.section_security-rules }}** in the table.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Associate the security profile with the virtual host {#profile-connect}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to associate a security profile with an {{ alb-name }} virtual host.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Select the `test-sp1` profile.
  1. Click ![plug](../../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.smart-web-security.overview.action_attach-to-host }}**.
  1. In the window that opens, select:
      * **{{ ui-key.yacloud.smart-web-security.attach-dialog.label_balancer }}** `test-load-balancer`.
      * **{{ ui-key.yacloud.smart-web-security.attach-dialog.label_http-router }}** `test-http-router`.
      * **{{ ui-key.yacloud.smart-web-security.attach-dialog.label_virtual-host }}** `test-virtual-host`.
  1. Click **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_connect }}**.

      You will see the associated virtual host under **{{ ui-key.yacloud.smart-web-security.overview.title_connected-to-the-hosts }}**.

{% endlist %}

## Test the security profile {#test}

{% include [test](../_tutorials_includes/balancer-with-sws-profile/test.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. [Delete](../../../smartwebsecurity/operations/profile-delete.md) the security profile.
1. [Delete](../../../application-load-balancer/operations/application-load-balancer-delete.md) the L7 load balancer.
1. [Delete](../../../application-load-balancer/operations/http-router-delete.md) the HTTP router.
1. [Delete](../../../application-load-balancer/operations/backend-group-delete.md) the backend group.
1. [Delete](../../../application-load-balancer/operations/target-group-delete.md) the target group.
1. [Delete](../../../compute/operations/vm-control/vm-delete.md) the VM.

#### See also {#see-also}

* [{#T}](terraform.md)
