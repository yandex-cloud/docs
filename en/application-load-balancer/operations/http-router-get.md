---
title: How to get HTTP router information in {{ alb-full-name }}
---

# Getting HTTP router information

You can get the router ID, its hosts, and their routes.

To get HTTP router information:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your router.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}**.
  1. Select your HTTP router.
  1. You will see your router details on the **{{ ui-key.yacloud.common.overview }}** page.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for getting HTTP router information:

      ```bash
      yc alb http-router get --help
      ```

  1. To get HTTP router information, run this command with its ID or name specified:

      ```bash
      yc alb http-router get <HTTP_router_name>
      ```

      Result:

      ```text
      id: ds7u8nv8gl2s********
      name: alb-router
      folder_id: b1geoelk7fld********
      virtual_hosts:
        - name: alb-host
          authority:
            - www.first-site.ru
            - first-site.ru
          route_options:
            security_profile_id: fevcifh6tr**********
          rate_limit:
            all_requests:
              per_second: "100"
          routes:
            - name: route-1
              http:
                route:
                  backend_group_id: ds7maho6c4or********
      created_at: "2024-12-12T12:20:44.091821711Z"
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To get HTTP router information using {{ TF }}:

  1. Add `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_alb_http_router" "tf-router" {
        http_router_id = "<HTTP_router_ID>"
      }

      output "tf-router-name" {
        value = data.yandex_alb_http_router.tf-router.name
      }
      ```

      Where:

      * `data "yandex_alb_http_router"`: Description of the HTTP router as a data source:
         * `http_router_id`: HTTP router ID.
      * `output "tf-router-name"`: Output variable with the HTTP router name:
         * `value`: Return value.

     You can replace `name` with another variable to get the information you need. For more information about the `yandex_alb_http_router` data source variables, see the [relevant provider documentation]({{ tf-provider-datasources-link }}/alb_http_router).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create the HTTP router and display its output variable. To check the results, run this command:

      ```bash
      terraform output
      ```

      Result:

      ```text
      tf-router-name = "myrouter"
      ```

- API {#api}

  To get HTTP router details, use the [get](../api-ref/HttpRouter/get.md) REST API method for the [Origin](../api-ref/HttpRouter/index.md) resource or the [HttpRouterService/Get](../api-ref/grpc/HttpRouter/get.md) gRPC API call.

{% endlist %}
