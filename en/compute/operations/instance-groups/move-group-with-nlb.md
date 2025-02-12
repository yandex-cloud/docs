---
title: Moving an instance group with a network load balancer to a different availability zone
description: In this article, you will learn how to move a {{ compute-full-name }} instance group with a network load balancer from one availability zone to another.
---

# Moving an instance group with a network load balancer to a different availability zone


To move an [instance group](../../concepts/instance-groups/index.md) with a [network load balancer](../../../network-load-balancer/concepts/index.md) created using [{{ network-load-balancer-full-name }}](../../../network-load-balancer/):
1. [Create](../../../vpc/operations/subnet-create.md) a [subnet](../../../vpc/concepts/network.md#subnet) in the [availability zone](../../../overview/concepts/geo-scope.md) you want to move your instance group to.
1. Add the group instances to the new availability zone:

   {% include [ig-create-in-another-zone](../../../_includes/compute/ig-create-in-another-zone.md) %}

1. Based on the [load balancer type](../../../network-load-balancer/concepts/nlb-types.md), follow these steps:
   * **External load balancer** (`EXTERNAL`):
     1. Wait until the resources of the target group in the new availability zone pass a [health check](../../../network-load-balancer/concepts/health-check.md) and get the `HEALTHY` status. See [{#T}](../../../network-load-balancer/operations/check-resource-health.md).

        After that, the load balancer will start routing traffic through the new availability zone. This may take up to two minutes. See [Achieving routing convergence in the availability zone](../../../network-load-balancer/concepts/specifics.md#nlb-zone-converge).
     1. Delete the group instances from the previous availability zone:

        {% include [ig-delete-in-zone.md](../../../_includes/compute/ig-delete-in-zone.md) %}

   * **Internal load balancer** (`INTERNAL`):
     1. Move the resources requiring access to the internal load balancer to the previously created subnet.
     1. Switch to a new [listener](../../../network-load-balancer/concepts/listener.md):

        {% list tabs group=instructions %}

        - Management console {#console}

          1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) containing the load balancer.
          1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
          1. Click the name of the load balancer in question.
          1. Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.section_listeners }}**, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_delete-listener }}**.
          1. At the top right, click ![image](../../../_assets/plus-sign.svg) **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_add-listener }}** and [create](../../../network-load-balancer/operations/listener-add.md) a new listener.

             When creating a new listener, select a subnet in the availability zone you want to move the load balancer to.
          1. Click **{{ ui-key.yacloud.common.add }}**.

        - CLI {#cli}

          1. See the description of the [CLI](../../../cli/) command for deleting a listener:

             ```bash
             yc load-balancer network-load-balancer remove-listener --help
             ```

          1. Get a list of all network load balancers in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

             ```bash
             yc load-balancer network-load-balancer list
             ```

             Result:

             ```text
             +----------------------+---------------+-----------------+----------+----------------+------------------------+----------+
             |          ID          |     NAME      |    REGION ID    |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS |  STATUS  |
             +----------------------+---------------+-----------------+----------+----------------+------------------------+----------+
             | enp2btm6uvdr******** | nlb-34aa5-db1 | {{ region-id }} | INTERNAL |              0 |                        |  ACTIVE  |
             | enpvg9o73hqh******** | test-balancer | {{ region-id }} | EXTERNAL |              0 |                        |  ACTIVE  |
             +----------------------+---------------+-----------------+----------+----------------+------------------------+----------+
             ```

          1. Get the listener name:

             ```bash
             yc load-balancer network-load-balancer get <load_balancer_name>
             ```

             Result:

             ```text
             id: enp2btm6uvdr********
             folder_id: b1gmit33ngp3********
             ...
             listeners:
               - name: listener-980ee-af3
                 address: 172.17.0.36
             ```

          1. Delete the listener:

             ```bash
             yc load-balancer network-load-balancer remove-listener <load_balancer_name> \
               --listener-name <listener_name>
             ```

             Where `--listener-name` is the name of the listener to delete.

             Result:

             ```text
             done (1s)
             id: enpvg9o73hqh********
             folder_id: b1gmit33ngp3********
             created_at: "2023-08-09T13:44:57Z"
             name: nlb-34aa5-db1
             region_id: {{ region-id }}
             status: INACTIVE
             type: INTERNAL
             ```

          1. See the description of the CLI command for adding a listener:

             ```bash
             yc load-balancer network-load-balancer add-listener --help
             ```

          1. Add a listener:

             ```bash
             yc load-balancer network-load-balancer add-listener <load_balancer_name> \
               --listener name=<listener_name>,`
                          `port=<port>,`
                          `target-port=<target_port>,`
                          `internal-subnet-id=<subnet_ID>
             ```

             Where:
             * `name`: Listener name.
             * `port`: Port the load balancer will listen to incoming traffic on.
             * `target-port`: Target port the load balancer will route traffic to.
             * `internal-subnet-id`: ID of the subnet in the availability zone you want to move your load balancer to.

             Result:

             ```text
             done (1s)
             id: enp2btm6uvdr********
             folder_id: b1gmit33ngp3********
             created_at: "2023-08-09T08:37:03Z"
             name: nlb-34aa5-db1
             region_id: {{ region-id }}
             status: ACTIVE
             type: INTERNAL
             listeners:
               - name: new-listener
                 address: 10.0.0.16
                 port: "22"
                 protocol: TCP
                 target_port: "22"
                 subnet_id: e2lgp8o00g06********
                 ip_version: IPV4
             ```

        - {{ TF }} {#tf}

          1. Open the {{ TF }} file that contains the load balancer configuration and edit the `name` and `subnet_id` field values under `listener`:

             ```hcl
             listener { 
               name = "<new_listener_name>" 
               port = 80 
               target_port = 81 
               protocol = "tcp" 
               internal_address_spec { 
                 subnet_id = "<ID_of_subnet_in_target_availability_zone>" 
                 ip_version = "ipv4" 
               } 
             }
             ```

             Where:
             * `name`: Listener name.
             * `port`: Port the load balancer will listen to incoming traffic on.
             * `target_port`: Target port the load balancer will route traffic to. 
             * `subnet_id`: ID of the subnet in the availability zone you want to move your instance group to.

             For more information about resource parameters in {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/lb_network_load_balancer).
          1. Apply the changes:

             {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

             This will add the new listener to the new availability zone. You can check the new listener using the [management console]({{ link-console-main }}).

        - API {#api}

          1. To remove a network load balancer's listener, use the [removeListener](../../../network-load-balancer/api-ref/NetworkLoadBalancer/removeListener.md) REST API method for the [NetworkLoadBalancer](../../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) resource or the [NetworkLoadBalancerService/RemoveListener](../../../network-load-balancer/api-ref/grpc/NetworkLoadBalancer/removeListener.md) gRPC API call, and provide the following in your request:
             * Load balancer ID in the `networkLoadBalancerId` parameter.
             * Name of the listener in the `listenerName` parameter.

             You can get the load balancer ID with a [list of network load balancers in the folder](../../../network-load-balancer/operations/load-balancer-list.md#list), and the listener name with [network load balancer details](../../../network-load-balancer/operations/load-balancer-list.md#get).
          1. To add a network load balancer's listener, use the [addListener](../../../network-load-balancer/api-ref/NetworkLoadBalancer/addListener.md) API method for the [NetworkLoadBalancer](../../../network-load-balancer/api-ref/NetworkLoadBalancer/index.md) resource or the [NetworkLoadBalancerService/AddListener](../../../network-load-balancer/api-ref/grpc/NetworkLoadBalancer/addListener.md) gRPC API call, and provide the following in your request:

             ```json
             {
               "listenerSpec": {
                 "name": "<listener_name>",
                 "port": "<incoming_port>",
                 "targetPort": "<target_port>",
                 "internalAddressSpec": {
                   "subnetId": "<subnet_ID>"
                 }
               }
             }
             ```

             Where:
             * `name`: Listener name.
             * `port`: Port the load balancer will listen to incoming traffic on.
             * `targetPort`: Target port the load balancer will route traffic to.
             * `subnetId`: ID of the subnet in the availability zone you want to move your load balancer to.

        {% endlist %}

        {% note warning %}

        Your listener [IP address](../../../vpc/concepts/address.md) will change. Make sure to specify the new listener IP address in the settings of the resources sending traffic through the load balancer.

        {% endnote %}

     1. Delete the group instances from the previous availability zone:

        {% include [ig-delete-in-zone.md](../../../_includes/compute/ig-delete-in-zone.md) %}

     1. Make sure the subnet in the previous availability zone has no resources left.
     1. [Delete](../../../vpc/operations/subnet-delete.md) the subnet in the previous availability zone.