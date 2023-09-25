# Getting started with {{ sws-full-name }}

{{ sws-name }} allows you to protect your infrastructure from DDoS attacks at the application level (L7).

The service is at the [Preview stage](../overview/concepts/launch-stages.md).

{% include [ask-for-turning-on](../_includes/smartwebsecurity/ask-for-turning-on.md) %}

Create your first [security profile](./concepts/profiles.md), connect it to the {{ alb-full-name }} [L7 load balancer](../application-load-balancer/concepts/application-load-balancer.md), and test your security rules.

To get started with the service:
1. [Prepare your cloud](#before-you-begin).
1. [Prepare your infrastructure](#infrastructure-prepare).
1. [Create a security profile](#profile-create).
1. [Connect the security profile to a virtual host](#profile-connect).
1. [Test the security profile](#test).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

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

The security profile is the main {{ sws-name }} component, which consists of a set of rules, each containing conditions for filtering user requests arriving to the L7 load balancer.

To create a security profile:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to create your profile in.
   1. In the list of services, select **{{ sws-name }}**.
   1. Click **Create security profile** and select **From a template with a preconfigured profile**.

      Preconfigured profiles include:
      * [Basic default rule](./concepts/rules.md#base-rules), enabled for all traffic.
      * [Smart Protection rule](./concepts/rules.md#smart-protection-rules), enabled for all traffic, with the **Full protection** type.

      {% include [smart-protection-tip](../_includes/smartwebsecurity/smart-protection-tip.md) %}

   1. Enter the profile name, e.g., `test-sp1`.
   1. In the **Action of the basic default rule** field, select **Deny**. Thus, if no other rules are set, all traffic to the protected resource will be denied.
   1. Click ![plus-sign](../_assets/plus-sign.svg) **Add rule**.
   1. In the rule creation window:
      1. Enter the rule name, e.g., `test-rule1`.
      1. Set the rule priority, e.g., `999800`. The rule will have higher priority than preconfigured rules.

         {% include [preconfigured-rules-priority](../_includes/smartwebsecurity/preconfigured-rules-priority.md) %}

      1. Select the rule type: **Basic**.
      1. Select the action: **Allow**.

         The rule will describe conditions under which requests will be directed to the backend of the test application.
      1. Expand the **Conditions** field.
      1. In the **IP** field, select the **matches** option and set the public IP address of the device that will be sending requests to the L7 load balancer, e.g., `158.160.100.200`.
      1. Click **Save rule**.

         The rule you created will appear in the table on the **Security rules** tab.
   1. Click **Create**.

{% endlist %}

## Connect the security profile to the virtual host {#profile-connect}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to connect a security profile to a {{ alb-name }} virtual host.
   1. In the list of services, select **{{ sws-name }}**.
   1. Next to the `test-sp1` profile, click ![options](../_assets/options.svg) and select ![pencil](../_assets/pencil.svg) **Edit profile data**.
   1. Click ![plug](../_assets/smartwebsecurity/plug.svg) **Connect profile to host**.
   1. In the window that opens, select:
      * L7 load balancer named `test-load-balancer`.
      * HTTP router named `test-http-router`.
      * Virtual host named `test-virtual-host`.
   1. Click **Connect**.

      The connected virtual host will appear on the **Profile connected to hosts** tab.
   1. Click **Save**.

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
1. [Delete](operations/profile-delete.md) the security profile.
1. [Delete](../application-load-balancer/operations/application-load-balancer-delete.md) the L7 load balancer.
1. [Delete](../application-load-balancer/operations/http-router-delete.md) the HTTP router.
1. [Delete](../application-load-balancer/operations/backend-group-delete.md) the backend group.
1. [Delete](../application-load-balancer/operations/target-group-delete.md) the target group.
1. [Delete](../compute/operations/vm-control/vm-delete.md) the VM.
