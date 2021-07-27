---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Create an L7 load balancer

To create an L7 load balancer:

{% list tabs %}

- Management console
  1. In the [management console]({{ link-console-main }}), select the folder where the load balancer will be created.
  1. In the list of services, select **{{ alb-name }}**.
  1. In the menu on the left, select **Load balancers**.
  1. Click **Create load balancer**.
  1. Enter the name of the load balancer: `test-load-balancer`.
  1. Under **Network Settings**, select the network whose subnets will host the load balancer's nodes and the [appropriate security groups](../concepts/application-load-balancer.md#security-groups) (if there is no corresponding field, all incoming and outgoing traffic will be allowed for the load balancer).
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

  1. Run the following command, specifying the network and subnets that will host the load balancer's nodes and the [appropriate security groups](../concepts/application-load-balancer.md#security-groups):

     ```
     yc alb load-balancer create <load balancer name> \
     --network-name <network name> \
     --location subnet-name=<subnet 1 name>,zone=<availability zone> \
     --location subnet-name=<subnet 2 name>,zone=<availability zone> \
     --location subnet-name=<subnet 3 name>,zone=<availability zone>
     ```

     Command execution result:

     ```
     done (1m40s)
     id: a5d88ep483cmbfm63g9t
     name: test-balancer2
     folder_id: aoe197919j8elpeg1lkp
     status: ACTIVE
     region_id: ru-central1
     network_id: c64l1c06d15178sa87k0
     allocation_policy:
       locations:
       - zone_id: ru-central1-a
         subnet_id: buc4gsmpj8hvramg61g8
       - zone_id: ru-central1-b
         subnet_id: blt6pcatjje62sqvjq5b
       - zone_id: ru-central1-c
         subnet_id: fo2ap2nrhjk9vpfdnno8
     log_group_id: eolul9ap0bv02i8bsp87
     created_at: "2021-04-26T12:12:13.624832586Z"
     ```

  1. View a description of the CLI command for adding a listener for an L7 load balancer:

     ```
     yc alb load-balancer add-listener --help
     ```

  1. Add a listener by running the command:

     ```
     yc alb load-balancer add-listener <load balancer name> \
     --listener-name <listener name> \
     --http-router-id <HTTP router ID> \
     --external-ipv4-endpoint port=<listener port>
     ```

     Command execution result:

     ```
     done (25s)
     id: a5d88ep483cmbfm63g9t
     name: test-balancer2
     folder_id: aoe197919j8elpeg1lkp
     status: ACTIVE
     region_id: ru-central1
     network_id: c64l1c06d15178sa87k0
     listeners:
     - name: test-listener
       endpoints:
       - addresses:
         - external_ipv4_address:
             address: 130.193.32.206
         ports:
         - "80"
       http:
         handler:
           http_router_id: a5dv7tjdo9gt2pq5l906
     allocation_policy:
       locations:
       - zone_id: ru-central1-a
         subnet_id: buc4gsmpj8hvramg61g8
       - zone_id: ru-central1-b
         subnet_id: blt6pcatjje62sqvjq5b
       - zone_id: ru-central1-c
         subnet_id: fo2ap2nrhjk9vpfdnno8
     log_group_id: eolul9ap0bv02i8bsp87
     created_at: "2021-04-26T12:12:13.624832586Z"
     ```

{% endlist %}

