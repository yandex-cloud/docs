# Creating an {{ alb-name }} L7 load balancer with a {{ sws-name }} security profile

With {{ sws-full-name }}, you can protect your infrastructure from DDoS attacks and bots at the application level (L7).

You will create a test web server, deploy an {{ alb-name }} [L7 load balancer](../application-load-balancer/concepts/application-load-balancer.md) for distributing traffic to the test web server, and protect the created infrastructure using a {{ sws-name }} [security profile](../smartwebsecurity/concepts/profiles.md) .

To create an L7 load balancer with a security profile:
1. [Prepare your cloud](#before-you-begin).
1. [Prepare your infrastructure](#infrastructure-prepare).
1. [Create a security profile](#profile-create).
1. [Connect the security profile to a virtual host](#profile-connect).
1. [Test the security profile](#test).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](./_tutorials_includes/before-you-begin.md) %}

## Prepare the infrastructure {#infrastructure-prepare}

[Deploy](../application-load-balancer/quickstart.md) an {{ alb-name }} infrastructure as well as a VM with a test web server.

The following resources will be created:
* [VM](../compute/concepts/vm.md) named `test-vm1` with a test web server.
* [Target group](../application-load-balancer/concepts/target-group.md) named `test-target-group`.
* [Backend group](../application-load-balancer/concepts/backend-group.md) named `test-backend-group`.
* [HTTP router](../application-load-balancer/concepts/http-router.md) named `test-http-router` with a [virtual host](../application-load-balancer/concepts/http-router.md#virtual-host) named `test-virtual-host`.
* [L7 load balancer](../application-load-balancer/concepts/application-load-balancer.md) named `test-load-balancer`.

Save the public IP addresses of the L7 load balancer: you will need it for testing your security profile.

{% include [auto-scaling-tip](../_includes/smartwebsecurity/auto-scaling-tip.md) %}

## Create a security profile {#profile-create}

The security profile is the main {{ sws-name }} component, which consists of a set of rules, each containing conditions for filtering user requests arriving to the resource being protected.

To create a security profile:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder to create your profile in.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
   1. Click **{{ ui-key.yacloud.smart-web-security.action_empty }}** and select **{{ ui-key.yacloud.smart-web-security.title_default-template }}**.

      A preset profile includes:
      * [Basic default rule](../smartwebsecurity/concepts/rules.md#base-rules) enabled for all traffic with the [`{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}` action type](../smartwebsecurity/concepts/rules.md#rule-action).
      * [Smart Protection rule](../smartwebsecurity/concepts/rules.md#smart-protection-rules) enabled for all traffic with the `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}` action type.

      {% include [smart-protection-tip](../_includes/smartwebsecurity/smart-protection-tip.md) %}

   1. Enter the profile name, e.g., `test-sp1`.
   1. In the **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}** field, select `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}`. Thus, if no other rules are set, all traffic to the protected resource will be denied.
   1. Click ![plus-sign](../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
   1. In the rule creation window:
      1. Enter the rule name, e.g., `test-rule1`.
      1. Set the rule priority, e.g., `999800`. The rule will have higher priority than the preconfigured ones.

         {% include [preconfigured-rules-priority](../_includes/smartwebsecurity/preconfigured-rules-priority.md) %}

      1. Select the `{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}` rule type.
      1. Select the `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-allow }}` action.

         The rule will describe conditions under which requests will be directed to the backend of the test application.
      1. In the **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** field, select {{ ui-key.yacloud.smart-web-security.overview.condition_name-ip-range }}.
      1. In the **IP conditions** field that appears, select `Matches or belongs to range` and set the public IP address of the device from which to send requests to the L7 load balancer, e.g., `158.160.100.200`.
      1. Click **{{ ui-key.yacloud.common.add }}**.

         The rule you created will appear under **{{ ui-key.yacloud.smart-web-security.form.section_security-rules }}** in the table.
   1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Connect the security profile to the virtual host {#profile-connect}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), choose the folder where you want to connect a security profile to an {{ alb-name }} virtual host.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
   1. Select the `test-sp1` profile.
   1. Click ![plug](../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.smart-web-security.overview.action_attach-to-host }}**.
   1. In the window that opens, select:
      * **{{ ui-key.yacloud.smart-web-security.attach-dialog.label_balancer }}** `test-load-balancer`
      * **{{ ui-key.yacloud.smart-web-security.attach-dialog.label_http-router }}** `test-http-router`
      * **{{ ui-key.yacloud.smart-web-security.attach-dialog.label_virtual-host }}** `test-virtual-host`
   1. Click **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_connect }}**.

      You will see the connected virtual host under **{{ ui-key.yacloud.smart-web-security.overview.title_connected-to-the-hosts }}**.

{% endlist %}

## Test the security profile {#test}

1. Open the terminal on the device whose IP you specified in the allow rule.
1. Send a request to the backend of the test application:

   ```bash
   curl -v <public_IP-address_of_L7-load_balancer>
   ```

   This command should list the contents of the directory with your test web server.

1. Repeat the request from a different IP address. As a result, you should see a message about a failure to establish a connection to the server.

{% note info %}

Smart Protection rules are usually not tested. Such tests would add the parameters of suspicious requests, e.g., IP addresses, to a blacklist.

{% endnote %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. [Delete](../smartwebsecurity/operations/profile-delete.md) the security profile.
1. [Delete](../application-load-balancer/operations/application-load-balancer-delete.md) the L7 load balancer.
1. [Delete](../application-load-balancer/operations/http-router-delete.md) the HTTP router.
1. [Delete](../application-load-balancer/operations/backend-group-delete.md) the backend group.
1. [Delete](../application-load-balancer/operations/target-group-delete.md) the target group.
1. [Delete](../compute/operations/vm-control/vm-delete.md) the VM.
