---
title: Getting started with {{ alb-full-name }}
description: In this tutorial, you will create and test the {{ alb-name }} infrastructure.
---

# Getting started with {{ alb-full-name }}


{{ alb-full-name }} is a cloud service terminating TLS connections and routing requests to backend applications. {{ alb-name }} operates at Layer 7 of the [OSI model](https://ru.wikipedia.org/wiki/OSI_model), supporting HTTP and HTTPS protocols.

In this tutorial, you will deploy the {{ alb-name }} infrastructure and configure traffic routing to the test application backend.

This infrastructure includes:

* [Target group](concepts/target-group.md)
* [Backend group](concepts/backend-group.md)
* [HTTP router](concepts/http-router.md)
* [L7 load balancer](concepts/application-load-balancer.md)

Below we explain how to create each component individually. Alternatively, you can [use the wizard](quickstart-wizard.md) to create all components at once.

## Getting started {#before-begin}

1. Log in to the [management console]({{ link-console-main }}) or sign up. If not signed up yet, navigate to the management console and follow the on-screen instructions.
1. On the [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) page, make sure you have a linked [billing account](../billing/concepts/billing-account.md) with the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not have a billing account yet, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you do not have a folder yet, [create one](../resource-manager/operations/folder/create.md). While creating a folder, you can also create a default virtual network with subnets in all availability zones.


## Create a VM and set up a test web server on it {#create-vm}

{% include [create-web-server](../_includes/application-load-balancer/create-web-server.md) %}

## Create a target group {#create-target-group}

The system will deploy your application backends on the [target group](concepts/target-group.md) VM. The load balancer will distribute requests to your application backend endpoints via the target group.

In our example, the target group will consist of a single VM.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create your target group.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand menu, select **{{ ui-key.yacloud.alb.label_target-groups }}**.
  1. Click **{{ ui-key.yacloud.alb.button_target-group-create }}**.
  1. Specify the target group name: `test-target-group`.
  1. Select `test-vm1`.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../_includes/cli-install.md) %}

  Run this command:

  ```bash
  yc alb target-group create test-target-group \
    --target subnet-name=<VM_subnet_name>,ip-address=<VM_internal_IP_address>
  ```

{% endlist %}

## Create a backend group {#create-backend-group}

[Backend groups](concepts/backend-group.md) contain traffic distribution rules and health check configurations for targets. Create a group and add a backend to it.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the left-hand menu, select **{{ ui-key.yacloud.alb.label_backend-groups }}**.
  1. Click **{{ ui-key.yacloud.alb.button_backend-group-create }}**.
  1. Specify the backend group name: `test-backend-group`.
  1. Under **{{ ui-key.yacloud.alb.label_backends }}**, click **{{ ui-key.yacloud.common.add }}**. Specify the backend settings:
      1. Specify the backend name: `backend-1`.
      1. From the **{{ ui-key.yacloud.alb.label_target-group }}** list, select `test-target-group`.
      1. Specify the port: `8080`.
  1. Expand **{{ ui-key.yacloud.alb.label_protocol-settings }}**:
      1. Select the `{{ ui-key.yacloud.alb.label_proto-http-plain }}` type.
  1. Click **{{ ui-key.yacloud.alb.button_add-healthcheck }}** and configure health checks:
      1. **{{ ui-key.yacloud.alb.label_timeout }}**: `1`.
      1. **{{ ui-key.yacloud.alb.label_interval }}**: `3`.
      1. **{{ ui-key.yacloud.alb.label_healthy }}**: `2`.
      1. **{{ ui-key.yacloud.alb.label_unhealthy }}**: `2`.
      1. **{{ ui-key.yacloud.alb.label_port }}**: `8080`.
      1. **{{ ui-key.yacloud.common.type }}**: `{{ ui-key.yacloud.alb.label_hc-type-http }}`.
      1. **{{ ui-key.yacloud.alb.label_path }}**: `/`.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  1. Create a backend group:

      ```bash
      yc alb backend-group create test-backend-group
      ```

  1. Create a backend and a health check:

      ```bash
      yc alb backend-group add-http-backend \
        --backend-group-name test-backend-group \
        --name backend-1 \
        --port 8080 \
        --target-group-name test-target-group \
        --target-group-id <target_group_ID> \
        --http-healthcheck healthy-threshold=2,unhealthy-threshold=2,timeout=1s,interval=3s,path=/
      ```

{% endlist %}

## Create an HTTP router {#create-http-router}

[HTTP routers](concepts/http-router.md) implement rules for client-to-backend traffic and allow you to modify requests at the load balancer layer.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the left-hand menu, select **{{ ui-key.yacloud.alb.label_http-routers }}**.
  1. Click **{{ ui-key.yacloud.alb.button_http-router-create }}**.
  1. Specify the router name: `test-http-router`.
  1. Under **{{ ui-key.yacloud.alb.label_virtual-hosts }}**, click **{{ ui-key.yacloud.alb.button_virtual-host-add }}**.
  1. Specify the host name: `test-virtual-host`.
  1. Click **{{ ui-key.yacloud.alb.button_add-route }}**.
  1. Enter `test-route` as the **{{ ui-key.yacloud.common.name }}**.
  1. In the **{{ ui-key.yacloud.alb.label_path }}** field, select `{{ ui-key.yacloud.alb.label_match-prefix }}` and specify the `/` path.
  1. In the **{{ ui-key.yacloud.alb.label_route-action }}** field, keep `{{ ui-key.yacloud.alb.label_route-action-route }}`.
  1. From the **{{ ui-key.yacloud.alb.label_backend-group }}** list, select `test-backend-group`.
  1. Do not change other settings. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  1. Create an HTTP router:

      ```bash
      yc alb http-router create test-http-router
      ```

  1. Create a virtual host:

      ```bash
      yc alb virtual-host create test-virtual-host --http-router-name test-http-router
      ```

  1. Add a route:

      ```bash
      yc alb virtual-host append-http-route test-route \
        --http-router-name test-http-router \
        --prefix-path-match / \
        --backend-group-name test-backend-group \
        --virtual-host-name test-virtual-host
      ```

{% endlist %}

## Create an L7 load balancer {#create-load-balancer}

A [load balancer](concepts/application-load-balancer.md) distributes incoming requests across target group VMs according to the rules specified in the HTTP router. Load balancers use [listeners](concepts/application-load-balancer.md#listener) to receive traffic.

In the following example, we will deploy a load balancer and its backend node in the same subnet and availability zone.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the left-hand menu, select **{{ ui-key.yacloud.alb.label_load-balancers }}**.
  1. Click **{{ ui-key.yacloud.alb.button_load-balancer-create }}**.
  1. Specify the load balancer name: `test-load-balancer`.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select the network containing the subnet where you want to place your load balancer node.
  1. Under **{{ ui-key.yacloud.alb.section_allocation-settings }}**, select a subnet in your preferred [availability zone](../overview/concepts/geo-scope.md) and configure it to enable incoming traffic.

      Remove other availability zones by clicking ![xmark](../_assets/console-icons/xmark.svg) in each zone’s row.


  1. Under **{{ ui-key.yacloud.alb.label_listeners }}**, click **{{ ui-key.yacloud.alb.button_add-listener }}** and specify listener settings:
      1. Specify the listener name: `test-listener`.
      1. Under **{{ ui-key.yacloud.alb.section_external-address-specs }}**, enable traffic.
      1. Specify the `80` port.
      1. Select the **{{ ui-key.yacloud.alb.label_address-auto }}** type.
  1. In the **{{ ui-key.yacloud.alb.label_http-router }}** field, select `test-http-router`.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  1. Create a load balancer and its backend node in the same subnet:

      ```bash
      yc alb load-balancer create test-load-balancer \
        --network-name <network_name> \
        --location subnet-name=<subnet_name_in_{{ region-id }}-a_zone>,zone={{ region-id }}-a
      ```

  1. Add a listener:

      ```bash
      yc alb load-balancer add-listener test-load-balancer \
        --listener-name test-listener \
        --http-router-id <HTTP_router_ID> \
        --external-ipv4-endpoint port=80
      ```

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
