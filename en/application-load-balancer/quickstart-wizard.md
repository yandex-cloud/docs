---
title: Creating {{ alb-full-name }} infrastructure through a wizard
description: Follow this guide to create an {{ alb-name }} infrastructure through a wizard.
---

# Creating {{ alb-name }} infrastructure through a wizard


{{ alb-full-name }} enables distributing requests across backends of your network applications and terminating TLS encryption. {{ alb-name }} runs at Layer 7 of the [OSI model](https://ru.wikipedia.org/wiki/OSI_model) using HTTP and HTTPS.

This guide will help you deploy the {{ alb-name }} infrastructure and set up traffic to the test application backend.

Below, you can see how to create an infrastructure using a [wizard](concepts/index.md#alb-wizard). You can also create [all components one by one](quickstart.md).

## Getting started {#before-begin}

1. Log in or sign up to the [management console]({{ link-console-main }}). If not signed up yet, navigate to the management console and follow the on-screen instructions.
1. On the [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../billing/concepts/billing-account.md) linked and its status is `ACTIVE` or `TRIAL_ACTIVE`. If you do not have a billing account yet, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you do not have a folder yet, [create one](../resource-manager/operations/folder/create.md). While creating a folder, you can also create a default virtual network with subnets in all availability zones.


## Create a VM and launch a test web server on it {#create-vm}

{% include [create-web-server](../_includes/application-load-balancer/create-web-server.md) %}

## Create {{ alb-name }} infrastructure {#create-alb-infrastructure}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a load balancer.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Click **{{ ui-key.yacloud.alb.button_load-balancer-create }}** and select **{{ ui-key.yacloud.alb.label_alb-create-wizard }}**.

{% endlist %}

### Target group settings {#settings-target-group}

Your application backends will be deployed on the VM instance of the [target group](concepts/target-group.md). The target group will be connected to the load balancer so that requests might be sent to the backend endpoints of your application.

In this example, we will assume there is only one VM in the target group.

{% list tabs group=instructions %}

- Management console {#console}

  1. Enter the target group name: `test-target-group`.
  1. Select the VM named `test-vm1`.
  1. Leave all other settings unchanged and click **{{ ui-key.yacloud.alb.button_wizard-create-tg }}**.

{% endlist %}

### Backend group settings {#settings-backend-group}

[Backend groups](concepts/backend-group.md) contain settings for traffic balancing and target resource health check. The wizard automatically creates one backend and one health check group. It will also select the group you created at the previous step as target group.

{% list tabs group=instructions %}

- Management console {#console}

  1. Enter the backend group name: `test-backend-group`.
   
  1. To open backend and health check group settings, toggle **{{ ui-key.yacloud.alb.label_detailed-settings }}** on.

  1. Enter the backend name: `backend-1`.
  1. Configure health check settings:
      1. **{{ ui-key.yacloud.alb.label_interval }}**: `3`.
      1. **{{ ui-key.yacloud.alb.label_healthy }}**: `2`.
  
  1. Leave all other settings unchanged and click **{{ ui-key.yacloud.alb.button_wizard-create-tg }}**.

{% endlist %}

### HTTP router settings {#settings-http-router}

[HTTP routers](concepts/http-router.md) define the rules for routing requests sent to backends and allow you to modify requests directly in the balancer. The wizard will automatically create a virtual host and routing rule. It will also select the group you created at the previous step as backend group.

{% list tabs group=instructions %}

- Management console {#console}

  1. Enter the router name: `test-http-router`.
  1. Toggle **{{ ui-key.yacloud.alb.label_detailed-settings }}** on.
  1. Under **{{ ui-key.yacloud.alb.label_virtual-hosts }}**, enter:
     1. Host name: `test-virtual-host`.
     1. Route name: `test-route`.
  1. Leave all other settings unchanged and click **{{ ui-key.yacloud.alb.button_wizard-create-tg }}**.

{% endlist %}

### L7 load balancer settings {#create-load-balancer}

A [load balancer](concepts/application-load-balancer.md) receives requests and distributes them across target group VMs according to the rules specified in the HTTP router. Load balancers use [listeners](concepts/application-load-balancer.md#listener) to receive traffic. The wizard will create a listener automatically. It will also select the router you created at the previous step as HTTP router.

As an example, let's create a balancer with a node in the same subnet and same availability zone.

{% list tabs group=instructions %}

- Management console {#console}

  1. Enter the load balancer name: `test-load-balancer`.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select the network whose subnet will host the load balancer node.
  1. Toggle **{{ ui-key.yacloud.alb.label_detailed-settings }}** on.
  1. Under **{{ ui-key.yacloud.alb.section_allocation-settings }}**, select a subnet in one [availability zone](../overview/concepts/geo-scope.md) and enable incoming traffic in this subnet.

      Remove the other availability zones by clicking ![xmark](../_assets/console-icons/xmark.svg) in the relevant row.


  1. Under **{{ ui-key.yacloud.alb.label_listeners }}**, enter the listener name: `test-listener`.
   
  1. Leave all other settings unchanged and click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Test the load balancer {#test}

In the terminal, run the following command:

```bash
curl --verbose <load_balancer_public_IP_address>:80
```

The response must return the HTTP status code `200` and an HTML list of folders from the test VM folder.

After that, you can add other VMs to the target group, create new backends for your application, and build routes to the application endpoints.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created, delete them in the following order:

{% list tabs group=instructions %}

- Management console {#console}

  1. [Delete](operations/application-load-balancer-delete.md) the `test-load-balancer` L7 load balancer.
  1. [Delete](operations/http-router-delete.md) the `test-http-router` HTTP router.
  1. [Delete](operations/backend-group-delete.md) the `test-backend-group` backend group.
  1. [Delete](operations/target-group-delete.md) the `test-target-group` target group.

{% endlist %}