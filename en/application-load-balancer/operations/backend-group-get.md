---
title: "How to get information about a backend group in {{ alb-full-name }}"
---

# Getting information about a backend group

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where the [backend group](../concepts/backend-group.md) is located.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}**.
   1. Select a backend group.
   1. The **{{ ui-key.yacloud.common.overview }}** page will display detailed information about the group.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View the description of the CLI command to get information about a [backend group](../concepts/backend-group.md):

      ```bash
      yc alb backend-group get --help
      ```

   1. Get information about a backend group by specifying its name or ID:

      ```bash
      yc alb backend-group get <backend_group_name>
      ```

      Result:

      ```bash
      id: ds7maho6c4or********
      name: alb-bg
      folder_id: b1geoelk7fld********
      http:
        backends:
          - name: backend-1
            backend_weight: "1"
            port: "80"
            target_groups:
              target_group_ids:
                - ds7cjrs15ero********
            healthchecks:
              - timeout: 10s
                interval: 2s
                healthcheck_port: "80"
                http:
                  path: /
      created_at: "2023-10-24T12:22:20.870326850Z"
      ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To get information about a [backend group](../concepts/backend-group.md) using {{ TF }}:

   1. Add the `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_alb_backend_group" "my_bg" {
        backend_group_id = "<backend_group_ID>"
      }

      output "backend_group" {
        value = data.yandex_alb_backend_group.my_bg.http_backend
      }
      ```

      Where:
      * `data "yandex_alb_backend_group"`: Description of the backend group as a data source:
         * `backend_group_id`: Backend group ID
      * `output "backend_group"`: Output variable that contains information about the connected HTTP backend:
         * `value`: Returned value.

      You can replace `http_backend` with any other parameter to get the information you need. For more information about the `yandex_alb_backend_group` data source parameters, see the [provider documentation]({{ tf-provider-datasources-link }}/datasource_alb_backend_group).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create the required resources and display the output variable values in the terminal. To check the results, run:

      ```bash
      terraform output
      ```

      Result:

      ```text
      backend_group = tolist([
        {
          "healthcheck" = tolist([
            {
              "grpc_healthcheck" = tolist([])
              "healthcheck_port" = 80
              "healthy_threshold" = 1
              "http_healthcheck" = tolist([
                {
                  "host" = ""
                  "http2" = false
                  "path" = "/health"
                },
              ])
              "interval" = "1s"
              "interval_jitter_percent" = 0
              "stream_healthcheck" = tolist([])
              "timeout" = "1s"
              "unhealthy_threshold" = 1
            },
            ...
      ```

- API {#api}

   To get detailed information about a [backend group](../concepts/backend-group.md), use the [get](../api-ref/BackendGroup/get.md) REST API method for the [BackendGroup](../api-ref/BackendGroup/index.md) resource or the [BackendGroupService/Get](../api-ref/grpc/backend_group_service.md#Get) gRPC API call.

{% endlist %}
