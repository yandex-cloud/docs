# Getting started with {{ alb-full-name }}

This guide will help you create your first L7 load balancer, connect a target group to it, and set up traffic to the test application back end.

## Getting started {#before-begin}

1. Sign in or sign up to the [management console]({{ link-console-main }}). If you do not yet have an account, go to the management console and follow the instructions.
   {% if product == "yandex-cloud" %}
1. [On the billing page]({{ link-console-billing }}), make sure you have a [billing account](../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not yet have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
   {% endif %}
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
   1. In the list of services, select **{{ alb-name }}**.
   1. In the left menu, select **Target groups**.
   1. Click **Create target group**.
   1. Enter a name for the target group: `test-target-group`.
   1. Select the `test-vm1` VM.
   1. Click **Create**.

- CLI

   {% include [cli-install](../_includes/cli-install.md) %}

   Run the command:

   ```bash
   yc alb target-group create test-target-group \
     --target subnet-name=<VM subnet name>,ip-address=<VM internal IP address>
   ```

{% endlist %}

## Create a backend group {#create-backend-group}

[Backend groups](concepts/backend-group.md) contain settings for traffic balancing and target resource health check. Create a group and add one backend to it.

{% list tabs %}

- Management console

   1. In the left menu, select **Backend groups**.
   1. Click **Create backend group**.
   1. Enter the backend group name: `test-backend-group`.
   1. Under **Backends**, click **Add**. Specify the backend settings:
      1. Enter the backend name: `backend-1`.
      1. In the **Target group** list, select `test-target-group`.
      1. Set the **Port**: `80`.
   1. Expand the **Protocol settings** field and set the parameters:
      1. Select the type: `HTTP`.
   1. Click **Add health check** and configure the check:
      1. **Timeout**: `1`.
      1. **Interval**: `3`.
      1. **Healthy threshold**: `2`.
      1. **Unhealthy threshold**: `2`.
      1. **Type**: `HTTP`.
      1. **Path**: `/`.
   1. Click **Create**.

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

   1. In the menu on the left, select **HTTP routers**.
   1. Click **Create HTTP router**.
   1. Enter the router name: `test-http-router`.
   1. Under **Virtual hosts**, click **Add virtual host**.
   1. Enter the host name: `test-virtual-host`.
   1. Click **Add route**.
   1. Enter **Name**: `test-route`.
   1. In the **Path** field, select `Starts with` and specify the path `/`.
   1. In the **Action** field, leave the `Routing` value.
   1. In the **Backend group** list, select `test-backend-group`.
   1. Leave the other settings as they are and click **Create**.

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

   1. In the menu on the left, select **Load balancers**.
   1. Click **Create load balancer**.
   1. Enter the name of the load balancer: `test-load-balancer`.
   1. Under **Network settings**, select the network whose subnets will host the balancer's nodes.
   1. Under **Allocation**, select the subnets for the load balancer's nodes in each availability zone and enable traffic.
   1. Click **Add listener** under **Listeners**. Set the listener settings:
      1. Enter the listener name: `test-listener`.
      1. Under **Public IP address settings**, enable traffic.
      1. Set the port to `80`.
      1. Select the **Auto** type.
   1. In the **HTTP router** field, select `test-http-router`.
   1. Click **Create**.

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
