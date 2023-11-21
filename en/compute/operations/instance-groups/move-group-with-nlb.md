---
title: "Moving an instance group with a network load balancer to a different availability zone"
description: "In this article, you will learn how to move a {{ compute-name }} instance group with a network load balancer across availability zones."
---

# Moving an instance group with a network load balancer to a different availability zone


{% note info %}

{% include [zone-c-deprecation](../../../_includes/vpc/zone-c-deprecation.md) %}

{% endnote %}


To move an instance group with a {{ network-load-balancer-full-name }} [network load balancer](../../../network-load-balancer/concepts):
1. [Create](../../../vpc/operations/subnet-create.md) a subnet in the availability zone to move the instance group to.
1. Add the group instances to the new availability zone:

   {% include [ig-create-in-another-zone](../../../_includes/compute/ig-create-in-another-zone.md) %}

1. Depending on the load balancer [type](../../../network-load-balancer/concepts/nlb-types.md), follow these steps:

   * **External load balancer** (`EXTERNAL` type):

      1. Wait until the resources of the target group in the new availability zone pass a [health check](../../../network-load-balancer/concepts/health-check.md) and switch to the `HEALTHY` status. For more information, refer to [{#T}](../../../network-load-balancer/operations/check-resource-health.md).

         After this, the load balancer will start routing traffic through the new availability zone. This may take up to 2 minutes. For more information, refer to [Achieving routing convergence in the availability zone](../../../network-load-balancer/concepts/specifics.md#nlb-zone-converge).

      1. Delete the group instances from the old availability zone:

         {% include [ig-delete-in-zone.md](../../../_includes/compute/ig-delete-in-zone.md) %}

   * **Internal load balancer** (`INTERNAL` type):

      1. Move the resources that need access to the internal load balancer to the previously created subnet.
      1. Delete the group instances from the old availability zone:

         {% include [ig-delete-in-zone.md](../../../_includes/compute/ig-delete-in-zone.md) %}
      1. Make sure the subnet in the old availability zone has no resources left.
      1. Move the subnet to the new availability zone:

         {% list tabs %}

         - CLI

            {% include [cli-install.md](../../../_includes/cli-install.md) %}

            {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

            1. Get a list of all subnets in the folder:

               ```bash
               yc vpc subnet list
               ```

               Result:

               ```text
               +----------------------+-----------------------+----------------------+----------------------+---------------+-----------------+
               |          ID          |         NAME          |      NETWORK ID      |    ROUTE TABLE ID    |     ZONE      |      RANGE      |
               +----------------------+-----------------------+----------------------+----------------------+---------------+-----------------+
               | b0c1eb4nbv47******** | default-{{ region-id }}-c | enpgf5vu9dd7******** |                      | {{ region-id }}-c | [10.130.0.0/24] |
               | e2lube0qahmf******** | default-{{ region-id }}-b | enpgf5vu9dd7******** |                      | {{ region-id }}-b | [10.129.0.0/24] |
               | e9bj3s90g9hm******** | default-{{ region-id }}-a | enpgf5vu9dd7******** | enpckj4hqdid******** | {{ region-id }}-a | [10.128.0.0/24] |
               +----------------------+-----------------------+----------------------+----------------------+---------------+-----------------+
               ```

               Save the `ID` of the subnet to be moved to a different availability zone.

            1. To move the subnet to another availability zone, run the command below specifying the subnet ID and the new availability zone:

               ```bash
               yc vpc subnet relocate <subnet_ID> \
                 --destination-zone-id <new_availability_zone>
               ```

               Result:

               ```yaml
               id: b0c5nguttpcq********
               folder_id: b1gsm0k26v1l********
               created_at: "2023-10-25T07:43:59Z"
               name: default-{{ region-id }}-c
               network_id: b0c1eb4nbv47********
               zone_id: {{ region-id }}-b
               v4_cidr_blocks:
                 - 10.130.0.0/24
               hcp_options: {}
               ```

         {% endlist %}

         The subnet will be moved to the new availability zone together with the internal load balancer's listeners.

         After this, the load balancer will start routing traffic through the new availability zone. This may take up to 2 minutes. For more information, refer to [Achieving routing convergence in the availability zone](../../../network-load-balancer/concepts/specifics.md#nlb-zone-converge).

      1. Move the resources that need access to the internal load balancer to the subnet that you moved from the old availability zone or [set up](../../../vpc/operations/static-route-create.md) static routing to the load balancer.
