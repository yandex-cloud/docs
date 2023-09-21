# Getting started with {{ alb-full-name }}

This guide will help you create your first L7 load balancer, connect a target group to it, and set up traffic to the test application back end.

## Getting started {#before-begin}

1. Log in to or register in the [management console]({{ link-console-main }}). If you do not have an account yet, go to the management console and follow the guide.
   1. On the [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not yet have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you do not have any folder, [create one](../resource-manager/operations/folder/create.md). While creating a folder, you can also create a default virtual network with subnets in all availability zones.

## Create a VM and launch a test web server on it {#create-vm}

1. [Create](../compute/operations/vm-create/create-linux-vm.md) a VM named `test-vm1` in the `{{ region-id }}-a` availability zone.
1. [Connect to the VM](../compute/operations/vm-connect/ssh.md) and start a test web server on it to respond to requests at port `80`:

   ```bash
   sudo python3 -m http.server 80
   ```

1. Make sure the web server returns a list of folders in the directory. Open the terminal on your computer and run this command:

   ```bash
   curl -v <public IP address of the test VM>
   ```

## Create a target group {#create-target-group}

Your application back ends will be deployed on the VM instance of the [target group](concepts/target-group.md). The target group will be connected to the load balancer so that requests might be sent to the backend endpoints of your application.

In this example, we will assume there is only one VM in the target group.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to create your target group in.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
   1. In the left-hand menu, select **{{ ui-key.yacloud.alb.label_target-groups }}**.
   1. Click **{{ ui-key.yacloud.alb.button_target-group-create }}**.
   1. Give your target group a name, e.g., `test-target-group`.
   1. Select the `test-vm1` VM.
   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI

   {% include [cli-install](../_includes/cli-install.md) %}

   Run the following command:

   ```bash
   yc alb target-group create test-target-group \
     --target subnet-name=<VM subnet name>,ip-address=<VM internal IP address>
   ```

{% endlist %}

## Create a backend group {#create-backend-group}

[Backend groups](concepts/backend-group.md) contain settings for traffic balancing and target resource health check. Create a group and add one backend to it.

{% list tabs %}

- Management console

   1. In the left-hand menu, select **{{ ui-key.yacloud.alb.label_backend-groups }}**.
   1. Click **{{ ui-key.yacloud.alb.button_backend-group-create }}**.
   1. Enter the backend group name: `test-backend-group`.
   1. Under **{{ ui-key.yacloud.alb.label_backends }}**, click **{{ ui-key.yacloud.common.add }}**. Specify the backend settings:
      1. Enter the backend name: `backend-1`.
      1. In the **{{ ui-key.yacloud.alb.label_target-group }}** list, select `test-target-group`.
      1. Specify the **{{ ui-key.yacloud.alb.label_port }}**: `80`.
   1. Expand the **{{ ui-key.yacloud.alb.label_protocol-settings }}** field and set the parameters:
      1. Select the `{{ ui-key.yacloud.alb.label_proto-http-plain }}` type.
   1. Click **{{ ui-key.yacloud.alb.button_add-healthcheck }}** and set up the check:
      1. **{{ ui-key.yacloud.alb.label_timeout }}**: `1`
      1. **{{ ui-key.yacloud.alb.label_interval }}**: `3`
      1. **{{ ui-key.yacloud.alb.label_healthy }}**: `2`
      1. **{{ ui-key.yacloud.alb.label_unhealthy }}**: `2`
      1. **{{ ui-key.yacloud.common.type }}**: `{{ ui-key.yacloud.alb.label_hc-type-http }}`
      1. **{{ ui-key.yacloud.alb.label_path }}**: `/`
   1. Click **{{ ui-key.yacloud.common.create }}**

- CLI

   1. Create a backend group:

      ```bash
      yc alb backend-group create test-backend-group
      ```

   1. Create a backend and health check:

      ```bash
      yc alb backend-group add-http-backend \
        --backend-group-name test-backend-group \
        --name backend-1 \
        --port 80 \
        --target-group-name test-target-group \
        --target-group-id <target group ID> \
        --http-healthcheck healthy-threshold=2,unhealthy-threshold=2,timeout=1s,interval=3s,path=/
      ```

{% endlist %}

## Create an HTTP router {#create-http-router}

[HTTP routers](concepts/http-router.md) define the rules for routing requests sent to backends and allow you to modify requests directly in the balancer.

{% list tabs %}

- Management console

   1. In the left-hand menu, select **{{ ui-key.yacloud.alb.label_http-routers }}**.
   1. Click **{{ ui-key.yacloud.alb.button_http-router-create }}**.
   1. Enter the router name: `test-http-router`.
   1. Under **{{ ui-key.yacloud.alb.label_virtual-hosts }}**, click **{{ ui-key.yacloud.alb.button_virtual-host-add }}**.
   1. Enter the host name: `test-virtual-host`.
   1. Click **{{ ui-key.yacloud.alb.button_add-route }}**.
   1. Enter the **{{ ui-key.yacloud.common.name }}**: `test-route`.
   1. In the **{{ ui-key.yacloud.alb.label_path }}** field, select `{{ ui-key.yacloud.alb.label_match-prefix }}` and specify the path `/`.
   1. In the **{{ ui-key.yacloud.alb.label_route-action }}** field, keep `{{ ui-key.yacloud.alb.label_route-action-route }}`.
   1. In the **{{ ui-key.yacloud.alb.label_backend-group }}** list, select `test-backend-group`.
   1. Leave all other settings unchanged and click **{{ ui-key.yacloud.common.create }}**.

- CLI

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

The balancer accepts requests and distributes them across target group VMs according to the rules specified in the HTTP router. Load balancers use listeners to receive traffic.

As an example, let's create a balancer with a node in the same subnet and same availability zone.

{% list tabs %}

- Management console

   1. In the left-hand menu, select **{{ ui-key.yacloud.alb.label_load-balancers }}**.
   1. Click **{{ ui-key.yacloud.alb.button_load-balancer-create }}**.
   1. Enter the load balancer name: `test-load-balancer`.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select the network whose subnets will host the load balancer nodes.
   1. Under **{{ ui-key.yacloud.alb.section_allocation-settings }}**, select the subnets for the load balancer nodes in each availability zone and enable traffic.
   1. Under **{{ ui-key.yacloud.alb.label_listeners }}**, click **{{ ui-key.yacloud.alb.button_add-listener }}**. Set the listener settings:
      1. Enter the listener name: `test-listener`.
      1. Under **{{ ui-key.yacloud.alb.section_external-address-specs }}**, enable traffic.
      1. Set the port to `80`.
      1. Select the **{{ ui-key.yacloud.alb.label_address-auto }}** type.
   1. In the **{{ ui-key.yacloud.alb.label_http-router }}** field, select `test-http-router`.
   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI

   1. Create a load balancer with a node in the same subnet:

      ```bash
      yc alb load-balancer create test-load-balancer \
        --network-name <network name> \
        --location subnet-name=<name of subnet in {{ region-id }}-a>,zone={{ region-id }}-a \
        --location subnet-name=<name of subnet in {{ region-id }}-b>,zone={{ region-id }}-b \
        --location subnet-name=<name of subnet in {{ region-id }}-c>,zone={{ region-id }}-c
      ```

   1. Add a listener:

      ```bash
      yc alb load-balancer add-listener test-load-balancer \
        --listener-name test-listener \
        --http-router-id <HTTP router ID> \
        --external-ipv4-endpoint port=80
      ```

{% endlist %}

## Test the load balancer {#test}

In the terminal, run the following command:

```bash
curl -v <public IP address of the load balancer>:80
```

The response must include an HTTP response with the code `200` and a list of folders from the root directory of the test VM in HTML markup.

After that, you can add other VMs to the target group, create new backends for your application, and build routes to the application endpoints.
