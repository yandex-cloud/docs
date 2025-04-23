---
title: How to move an L7 load balancer backend VM to a target group in a new availability zone
description: In this tutorial, you will learn how to move an L7 load balancer backend VM to a target group in a new availability zone.
---

# Moving a VM to a target group in a new availability zone


To move an [L7 load balancer](../concepts/application-load-balancer.md) backend [VM](../../compute/concepts/vm.md) to a [target group](../concepts/target-group.md) in a new [availability zone](../../overview/concepts/geo-scope.md):

1. Enable load balancer traffic in the new availability zone:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder with your load balancer.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
      1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the load balancer you need, then select **{{ ui-key.yacloud.common.edit }}**.
      1. In the window that opens, under **{{ ui-key.yacloud.alb.section_allocation-settings }}**, enable traffic in the availability zone where you plan to move your VM.
      1. Click **{{ ui-key.yacloud.common.save }}**.

    - CLI {#cli}

      {% include [cli-install.md](../../_includes/cli-install.md) %}

      {% include [default-catalogue.md](../../_includes/default-catalogue.md) %}

      1. See the description of the CLI command for enabling load balancer traffic:

          ```bash
          yc application-load-balancer load-balancer enable-traffic --help
          ```

      1. Get a list of all L7 load balancers in the default folder:

          ```bash
          yc application-load-balancer load-balancer list
          ```

          Result:

          ```text
          +----------------------+-----------------------+-------------+----------------+---------+
          |          ID          |         NAME          |  REGION ID  | LISTENER COUNT | STATUS  |
          +----------------------+-----------------------+-------------+----------------+---------+
          | ds732hi8pn9n******** |      sample-alb1      | {{ region-id }} |              1 |  ACTIVE |
          | f3da23i86n2v******** |      sample-alb2      | {{ region-id }} |              1 |  ACTIVE |
          +----------------------+-----------------------+-------------+----------------+---------+
          ```

      1. Enable traffic in the new availability zone:

          ```bash
          yc application-load-balancer load-balancer enable-traffic <load_balancer_name> \
            --zone <availability_zone>
          ```

          Where `--zone` is the availability zone where you plan to move your VMs.

          Result:

          ```text
          id: ds7pmslal3km********
          name: sample-alb1
          folder_id: b1gmit33ngp3********
          status: ACTIVE
          region_id: {{ region-id }}
          network_id: enpn46stivv8********
          allocation_policy:
            locations:
              - zone_id: {{ region-id }}-a
                subnet_id: e9bavnqlbiuk********
                disable_traffic: true
              - zone_id: {{ region-id }}-b
                  subnet_id: e2lgp8o00g06********
              - zone_id: {{ region-id }}-d
                  subnet_id: b0cv501fvp13********
          log_group_id: ckgah4eo2j0r********
          security_group_ids:
            - enpdjc5bitmj********
          created_at: "2023-08-09T08:34:24.887765763Z"
          log_options: {}
          ```

    - {{ TF }} {#tf}

      If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

      1. Open the {{ TF }} L7 load balancer configuration file and, under `allocation_policy`, specify the new availability zone and the ID of the previously created subnet:

         ```hcl
         ...
           allocation_policy {
             location {
               zone_id   = [
                 "<previous_availability_zone>",
                 "<new_availability_zone>"
               ]
               subnet_id = [
                 "<subnet_ID_in_previous_availability_zone>",
                 "<ID_of_subnet_in_new_availability_zone>"
               ]
             }
           }
         }
         ...
         ```

         Where:
         * `zone_id`: Availability zones where the load balancer will receive traffic.
         * `subnet_id`: IDs of the subnets in these availability zones.

         For more information about resource properties in {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/alb_load_balancer).

      1. Apply the changes:

         {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

         The load balancer will start receiving traffic in the new availability zone. You can check this in the [management console]({{ link-console-main }}) or using this CLI command:

         ```bash
         yc alb load-balancer get <load_balancer_name>
         ```

   - API {#api}

     Use the [update](../api-ref/LoadBalancer/update.md) REST API method for the [LoadBalancer](../api-ref/LoadBalancer/index.md) resource or the [LoadBalancerService/Update](../api-ref/grpc/LoadBalancer/update.md) gRPC API call.

   {% endlist %}

1. [Set up](../../vpc/operations/security-group-add-rule.md) a [security group](../../vpc/concepts/security-groups.md) for the load balancer if needed. For proper load balancer operation, its security groups must allow outbound connections to the subnet addresses in your VM’s new availability zone.
1. [Move](../../compute/operations/vm-control/vm-change-zone.md) your VM to the new availability zone.
1. [Add](../../application-load-balancer/operations/target-group-update.md#add-targets) your VM to the load balancer target group and [delete](../../application-load-balancer/operations/target-group-update.md#remove-targets) its old entry.
1. Make sure the load balancer identifies your VM status as `HEALTHY`:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the folder with your load balancer.
     1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
     1. Select the load balancer you need.
     1. Navigate to the ![image](../../_assets/console-icons/heart-pulse.svg) **{{ ui-key.yacloud.alb.label_healthchecks }}** tab.
     1. Expand the list of targets. Make sure the target group VMs have the `HEALTHY` [status](../../compute/concepts/vm-statuses.md).

   - API {#api}

     Use the [getTargetStates](../api-ref/LoadBalancer/getTargetStates.md) REST API method for the [LoadBalancer](../api-ref/LoadBalancer/index.md) resource or the [LoadBalancerService/GetTargetStates](../api-ref/grpc/LoadBalancer/getTargetStates.md) gRPC API call.

   {% endlist %}

   The load balancer will not recognize a VM [status](../../compute/concepts/vm-statuses.md) as `HEALTHY` immediately after adding it to the target group. This may take a few minutes depending on your backend settings.

   If the load balancer consistently identifies your VM status as `UNHEALTHY` over an extended period, check its [security group](../concepts/application-load-balancer.md#security-groups) configuration.
