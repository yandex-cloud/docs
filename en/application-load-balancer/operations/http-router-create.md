---
title: How to create an HTTP router for HTTP traffic in {{ alb-full-name }}
description: In this tutorial, you will learn how to create an HTTP router for HTTP traffic.
---

# Creating an HTTP router for HTTP traffic

To create an [HTTP router](../concepts/http-router.md) and add a [route](../concepts/http-router.md#routes) to it:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your HTTP router.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}**.
  1. Click **{{ ui-key.yacloud.alb.button_http-router-create }}**.
  1. Specify your HTTP router name.
  1. Under **{{ ui-key.yacloud.alb.label_virtual-hosts }}**, click **{{ ui-key.yacloud.alb.button_virtual-host-add }}**.
  1. {% include [console-name-vh](../../_includes/application-load-balancer/instruction-steps/console-name-vh.md) %}
  1. Optionally, in the **{{ ui-key.yacloud.alb.label_authority }}** field, specify the HTTP/1.1 `Host` (HTTP/2 `:authority`) header value for virtual host selection.

      {% include [console-no-authority-notice](../../_includes/application-load-balancer/instruction-steps/console-no-authority-notice.md) %}
  1. {% include [console-vh-form-sws-step](../../_includes/application-load-balancer/instruction-steps/console-vh-form-sws-step.md) %}
  1. {% include [console-vh-form-albnative-rl-step](../../_includes/application-load-balancer/instruction-steps/console-vh-form-albnative-rl-step.md) %}
  1. {% include [console-vh-form-header-mods-step](../../_includes/application-load-balancer/instruction-steps/console-vh-form-header-mods-step.md) %}
  1. Click **{{ ui-key.yacloud.alb.button_add-route }}** and do the following in the **{{ ui-key.yacloud.alb.label_new-route }}** form that opens:

      1. {% include [console-update-http-route-naming-step](../../_includes/application-load-balancer/instruction-steps/console-update-http-route-naming-step.md) %}
      1. {% include [console-update-http-route-ss1](../../_includes/application-load-balancer/instruction-steps/console-update-http-route-ss1.md) %}
      1. {% include [console-update-http-route-ss2](../../_includes/application-load-balancer/instruction-steps/console-update-http-route-ss2.md) %}
      1. {% include [console-update-http-route-ss3](../../_includes/application-load-balancer/instruction-steps/console-update-http-route-ss3.md) %}
      1. {% include [console-update-http-route-ss4](../../_includes/application-load-balancer/instruction-steps/console-update-http-route-ss4.md) %}
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../cli/) command for creating an HTTP router:

      ```bash
      yc alb http-router create --help
      ```
  1. Run this command:

      ```bash
      yc alb http-router create <HTTP_router_name>
      ```

      Result:

      ```text
      id: a5dcsselagj4********
      name: test-http-router
      folder_id: aoerb349v3h4********
      created_at: "2021-02-11T21:04:59.438292069Z"
      ```
  1. {% include [cli-vh-create-help](../../_includes/application-load-balancer/instruction-steps/cli-vh-create-help.md) %}
  1. {% include [cli-vh-create](../../_includes/application-load-balancer/instruction-steps/cli-vh-create.md) %}
  1. {% include [cli-vh-append-http-route-help](../../_includes/application-load-balancer/instruction-steps/cli-vh-append-http-route-help.md) %}
  1. {% include [cli-vh-append-http-route-code](../../_includes/application-load-balancer/instruction-steps/cli-vh-append-http-route-code.md) %}

      Where:

      {% include [cli-http-route-creation-legend](../../_includes/application-load-balancer/instruction-steps/cli-http-route-creation-legend.md) %}

      {% include [cli-vh-append-http-route-output](../../_includes/application-load-balancer/instruction-steps/cli-vh-append-http-route-output.md) %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. In the configuration file, specify your HTTP router and virtual host settings:

      ```hcl
      resource "yandex_alb_http_router" "tf-router" {
        name          = "<HTTP_router_name>"
        labels        = {
          tf-label    = "tf-label-value"
          empty-label = ""
        }
      }

      resource "yandex_alb_virtual_host" "my-virtual-host" {
        name           = "<virtual_host_name>"
        http_router_id = yandex_alb_http_router.tf-router.id

        rate_limit {
          all_requests {
            per_second = <requests_per_second>
            # or per_minute = <requests_per_minute>
          }
          requests_per_ip {
            per_second = <requests_per_second>
            # or per_minute = <requests_per_minute>
          }
        }

        route {
          name                      = "<route_name>"
          disable_security_profile  = true|false

          http_route {
            http_match {
              http_method = ["<HTTP_method_1>","<HTTP_method_2>",...,"<HTTP_method_n>"]
              path {
                prefix = "/<request_path_prefix>/"
                # or exact = "<request_path>"
                # or regex = "<regular_expression>"
              }
            }

            http_route_action {
              backend_group_id  = "<backend_group_ID>"
              host_rewrite      = "<Host_header_value>"
              timeout           = "<connection_timeout>s"
              idle_timeout      = "<idle_timeout>s"
              prefix_rewrite    = "<new_request_path_prefix>/"
              rate_limit {
                all_requests {
                  per_second = <requests_per_second>
                  # or per_minute = <requests_per_minute>
                }
                requests_per_ip {
                  per_second = <requests_per_second>
                  # or per_minute = <requests_per_minute>
                }
              }
            }
          }
        }

        authority        = ["<domain_1>","<domain_2>",...,"<domain_n>"]

        modify_request_headers {
          name           = "<header_name>"
          append         = "<string_added_to_header_content>"
          # or replace  = "<new_header_content>"
          # or remove   = true|false
        }

        modify_response_headers {
          name           = "<header_name>"
          append         = "<string_added_to_header_content>"
          # or replace  = "<new_header_content>"
          # or remove   = true|false
        }

        route_options {
          security_profile_id = "<security_profile_ID>"
        }
      }
      ```

      Where:

      * `yandex_alb_http_router`: HTTP router description.
          * `name`: HTTP router name. Follow these naming requirements:

              {% include [name-format](../../_includes/name-format.md) %}

          * `labels`: HTTP router [labels](../../resource-manager/concepts/labels.md). Specify a key-value pair.
      * `yandex_alb_virtual_host`: Virtual host description:

          {% include [tf-vh-create-legend-part1](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-part1.md) %}

          * `route`: Virtual host route description:

              {% include [tf-vh-create-legend-route-general](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-route-general.md) %}

              {% include [tf-vh-create-legend-route-http](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-route-http.md) %}

          {% include [tf-vh-create-legend-last-part](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-last-part.md) %}

      Learn more about the properties of {{ TF }} resources in the relevant provider guides:
      * [yandex_alb_http_router]({{ tf-provider-resources-link }}/alb_http_router)
      * [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host)
  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
        
      {{ TF }} will create all the required resources. You can check your new resources and their settings in the [management console]({{ link-console-main }}) or using this [CLI](../../cli/) command:

      ```bash
      yc alb http-router get <HTTP_router_name>
      ```

      {% include [Terraform timeouts](../../_includes/application-load-balancer/terraform-timeout-router-and-host.md) %}

- API {#api}

  Use the [create](../api-ref/HttpRouter/create.md) REST API method for the [HttpRouter](../api-ref/HttpRouter/index.md) resource or the [HttpRouterService/Create](../api-ref/grpc/HttpRouter/create.md) gRPC API call.

{% endlist %}