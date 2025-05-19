---
title: Creating {{ alb-full-name }} infrastructure through a wizard
description: In this tutorial, you will create an {{ alb-name }} infrastructure through a wizard.
---

# Creating {{ alb-name }} infrastructure through a wizard


{{ alb-full-name }} is a cloud service terminating TLS connections and routing requests to backend applications. {{ alb-name }} operates at Layer 7 of the [OSI model](https://ru.wikipedia.org/wiki/OSI_model), supporting HTTP and HTTPS protocols.

This guide will help you deploy the {{ alb-name }} infrastructure and configure traffic routing to your test application backend.

Below, you can see how to create an infrastructure using a [wizard](concepts/index.md#alb-wizard). Alternatively, you can create its components [one by one](quickstart.md).

## Getting started {#before-begin}

1. Log in to the [management console]({{ link-console-main }}) or sign up. If not signed up yet, navigate to the management console and follow the on-screen instructions.
1. On the [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) page, check whether you have a [billing account](../billing/concepts/billing-account.md) with `ACTIVE` or `TRIAL_ACTIVE` status. If you do not have a billing account yet, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you do not have a folder yet, [create one](../resource-manager/operations/folder/create.md). While creating a folder, you can also create a default virtual network with subnets in all availability zones.


## Create a VM and set up a test web server on it {#create-vm}

{% include [create-web-server](../_includes/application-load-balancer/create-web-server.md) %}

## Create the {{ alb-name }} infrastructure {#create-alb-infrastructure}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a load balancer.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Click **{{ ui-key.yacloud.alb.button_load-balancer-create }}** and select **{{ ui-key.yacloud.alb.label_alb-create-wizard }}**.

{% endlist %}

### Target group settings {#settings-target-group}

The system will deploy your application backends on the [target group](concepts/target-group.md) VM. The load balancer will distribute requests to your application backend endpoints via the target group.

In our example, the target group will consist of a single VM.

{% list tabs group=instructions %}

- Management console {#console}

  1. Specify the target group name: `test-target-group`.
  1. Select `test-vm1`.
  1. Do not change other settings. Click **{{ ui-key.yacloud.alb.button_wizard-create-tg }}**.

{% endlist %}

### Backend group settings {#settings-backend-group}

[Backend groups](concepts/backend-group.md) contain traffic distribution rules and health check configurations for targets. The wizard will automatically create one backend and one health check group. It will also use your previously created group as the target group.

{% list tabs group=instructions %}

- Management console {#console}

  1. Specify the backend group name: `test-backend-group`.
   
  1. To open backend and health check group settings, toggle **{{ ui-key.yacloud.alb.label_detailed-settings }}** on.

  1. Specify the backend name: `backend-1`.
  1. Configure health check settings:
      1. **{{ ui-key.yacloud.alb.label_interval }}**: `3`.
      1. **{{ ui-key.yacloud.alb.label_healthy }}**: `2`.
  
  1. Do not change other settings. Click **{{ ui-key.yacloud.alb.button_wizard-create-tg }}**.

{% endlist %}

### HTTP router settings {#settings-http-router}

[HTTP routers](concepts/http-router.md) implement rules for client-to-backend traffic and allow you to modify requests at the load balancer layer. The wizard will automatically create a virtual host and a routing rule. It will also use your previously created group as the backend group.

{% list tabs group=instructions %}

- Management console {#console}

  1. Specify the router name: `test-http-router`.
  1. Toggle **{{ ui-key.yacloud.alb.label_detailed-settings }}** on.
  1. Under **{{ ui-key.yacloud.alb.label_virtual-hosts }}**, specify the following:
     1. Host name: `test-virtual-host`.
     1. Route name: `test-route`.
  1. Do not change other settings. Click **{{ ui-key.yacloud.alb.button_wizard-create-tg }}**.

{% endlist %}

### L7 load balancer settings {#create-load-balancer}

A [load balancer](concepts/application-load-balancer.md) uses [listeners](concepts/application-load-balancer.md#listener) to receive incoming requests which it then distributes across target group VMs according to the rules specified in the HTTP router. The wizard will create a listener automatically. It will also use your previously created router as the HTTP router in this configuration.

In the following example, we will deploy a load balancer and its backend node in the same subnet and availability zone.

{% list tabs group=instructions %}

- Management console {#console}

  1. Specify the load balancer name: `test-load-balancer`.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select the network containing the subnet where you want to place your load balancer node.
  1. Toggle **{{ ui-key.yacloud.alb.label_detailed-settings }}** on.
  1. Under **{{ ui-key.yacloud.alb.section_allocation-settings }}**, select a subnet in your preferred [availability zone](../overview/concepts/geo-scope.md) and configure it to enable incoming traffic.

      Remove other availability zones by clicking ![xmark](../_assets/console-icons/xmark.svg) in each zone’s row.


  1. Under **{{ ui-key.yacloud.alb.label_listeners }}**, specify the listener name: `test-listener`.
   
  1. Do not change other settings. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Test the load balancer {#test}

In the terminal, run this command:

```bash
curl --verbose <load_balancer_public_IP_address>:80
```

The response must return HTTP `200` with an HTML list of test VM web root subdirectories.

Next, you can expand your target group by adding more VMs, create additional application backends, and set up routes to their endpoints.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created, delete them in the following order:

{% list tabs group=instructions %}

- Management console {#console}

  1. [Delete](operations/application-load-balancer-delete.md) the `test-load-balancer` L7 load balancer.
  1. [Delete](operations/http-router-delete.md) the `test-http-router` HTTP router.
  1. [Delete](operations/backend-group-delete.md) the `test-backend-group` backend group.
  1. [Delete](operations/target-group-delete.md) the `test-target-group` target group.

{% endlist %}