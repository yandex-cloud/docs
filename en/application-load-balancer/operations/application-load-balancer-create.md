# Create an L7 load balancer

To create an L7 load balancer:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder where the load balancer will be created.
  1. In the list of services, select **{{ alb-name }}**.
  1. In the menu on the left, select **Load balancers**.
  1. Click **Create load balancer**.
  1. Enter the load balancer name: `test-load-balancer`.
  1. Under **Network settings**, select the network whose subnets will host the balancer's nodes.
  1. Under **Allocation**, select three subnets for the load balancer's nodes and enable traffic to these subnets.
  1. Click **Add listener** under **Listeners**. Set the listener settings:
     1. Enter the listener name: `test-listener`.
     1. Under **Public IP address settings**, enable traffic.
     1. Set the port to `80`.
     1. In the **Assign IP address** field, select **Automatically**.
  1. In the **HTTP router** field, select [HTTP router](http-router-create.md).
  1. Click **Create**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command to create an L7 load balancer:

     ```
     yc alb load-balancer create --help
     ```

  1. Run the command, specifying the network and subnets to host the load balancer nodes:

     ```
     yc alb load-balancer create test-load-balancer \
     --network-name <network name> \
     --location subnet-name=<subnet 1 name>,zone=ru-central1-a
     --location subnet-name=<subnet 1 name>,zone=ru-central1-b
     --location subnet-name=<subnet 1 name>,zone=ru-central1-c
     ```

  1. Add a listener:

     ```
     yc alb load-balancer add-listener test-load-balancer \
     --listener-name test-listener \
     --http-router-id a5dcsselagj4o2v4a6e7 \
     --external-ipv4-endpoint port=80
     ```

{% endlist %}

