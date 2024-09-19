---
title: "How to get information about an L7 load balancer in {{ alb-full-name }}"
---

# Getting information about an L7 load balancer

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder containing your [L7 load balancer](../concepts/application-load-balancer.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Select your L7 load balancer.
  1. The **{{ ui-key.yacloud.common.overview }}** page will present details about the load balancer.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to get information about a [L7 load balancer](../concepts/application-load-balancer.md):

      ```bash
      yc alb load-balancer get --help
      ```

  1. Get information about your load balancer by specifying its name or ID:

      ```bash
      yc alb load-balancer get <load_balancer_name>
      ```

      Result:

      ```text
      id: a5d88ep483cm********
      name: test-balancer2
      folder_id: aoe197919j8e********
      status: ACTIVE
      region_id: {{ region-id }}
      network_id: c64l1c06d151********
      allocation_policy:
        locations:
        - zone_id: {{ region-id }}-a
          subnet_id: buc4gsmpj8hv********
      log_group_id: eolul9ap0bv0********
      created_at: "2021-04-26T12:12:13.624832586Z"
      log_options:
        log_group_id: e23ujjda632o********
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To get information about an [L7 load balancer](../concepts/application-load-balancer.md) using {{ TF }}:

  1. Add the `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_alb_load_balancer" "tf-alb" {
        load_balancer_id = "<load_balancer_ID>"
      }

      output "tf-alb-listener" {
        value = data.yandex_alb_load_balancer.tf-alb.allocation_policy
      }
      ```

      Where:

      * `data "yandex_alb_load_balancer"`: Description of the L7 load balancer as a data source:
         * `load_balancer_id`: L7 load balancer ID.
      * `output "allocation_policy"`: Output variable that contains information about the L7 load balancer placement policy:
         * `value`: Returned value.

     You can replace `allocation_policy` with any other parameter to get the information you need. For more information about the `yandex_alb_load_balancer` data source parameters, see the [relevant provider documentation]({{ tf-provider-datasources-link }}/datasource_alb_load_balancer).

  1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create the required resources and display the output variable values in the terminal. To check the results, run:

      ```bash
      terraform output
      ```

      Result:

      ```text
      tf-alb-listener = tolist([
        {
          "location" = toset([
            {
              "disable_traffic" = false
              "subnet_id" = "buc4gsmpj8hv********"
              "zone_id" = "{{ region-id }}-a"
            },
            ...
      ```

- API {#api}

  To get detailed information about an [L7 load balancer](../concepts/application-load-balancer.md), use the [get](../api-ref/LoadBalancer/get.md) REST API method for the [LoadBalancer](../api-ref/LoadBalancer/index.md) resource or the [LoadBalancerService/Get](../api-ref/grpc/load_balancer_service.md#Get) gRPC API call.

{% endlist %}