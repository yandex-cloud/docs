---
title: How to update HTTP router settings in {{ alb-full-name }}
description: In this tutorial, you will learn how to update HTTP router settings.
---

# Updating HTTP router settings

To update HTTP router parameters:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with your HTTP router.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}**.
  1. Click your router name.
  1. Click **{{ ui-key.yacloud.common.edit }}**.
  1. Edit your router, header, virtual host, or route settings.
  1. Click **{{ ui-key.yacloud.common.save }}** at the bottom of the page.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command to update a load balancer:

     ```bash
     yc alb http-router update --help
     ```

  1. Run this command with new router settings specified:

     ```bash
     yc alb http-router update <HTTP_router_name> --new-name <new_name_for_HTTP_router>
     ```

     Result:

     ```text
     id: a5dld80l32ed********
     name: new-http-router
     folder_id: aoe197919j8e********
     virtual_hosts:
     - name: test-virtual-host
       authority:
       - your-domain.foo.com
       routes:
       - name: test-route
         http:
           match:
             path:
               prefix_match: /
           route:
             backend_group_id: a5d4db973944********
             timeout: 2s
             idle_timeout: 3s
       modify_request_headers:
       - name: Accept-Language
         append: ru-RU
     created_at: "2021-02-11T21:31:01.676592016Z"
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and edit the fragment describing your HTTP router.

     ```hcl
     ...
     resource "yandex_alb_http_router" "tf-router" {
       name   = "my-http-router"
       labels = {
         tf-label    = "tf-label-value"
         empty-label = ""
       }
     }
     ...
     ```

     For more information about `yandex_alb_http_router` properties, see [this {{ TF }} article]({{ tf-provider-resources-link }}/alb_http_router).

  1. To add, update, or delete HTTP router virtual hosts, use the `yandex_alb_virtual_host` resource with your router ID specified in its `http_router_id` field:

     ```hcl
     resource "yandex_alb_virtual_host" "my-virtual-host" {
       name           = "my-virtual-host"
       http_router_id = "${yandex_alb_http_router.tf-router.id}"
       route {
         name                     = "my-route"
         disable_security_profile = true|false
         http_route {
           http_route_action {
             backend_group_id = "${yandex_alb_backend_group.backend-group.id}"
             timeout          = "3s"
           }
         }
       }
     }
     ```

     For more information about `yandex_alb_virtual_host` properties, see [this {{ TF }} article]({{ tf-provider-resources-link }}/alb_virtual_host).

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will update all required resources. You can check the HTTP router update using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

     ```bash
     yc alb http-router get <HTTP_router_ID>
     ```

     {% include [Terraform timeouts](../../_includes/application-load-balancer/terraform-timeout-router-and-host.md) %}

- API {#api}

  Use the [update](../api-ref/HttpRouter/update.md) REST API method for the [HttpRouter](../api-ref/HttpRouter/index.md) resource or the [HttpRouterService/Update](../api-ref/grpc/HttpRouter/update.md) gRPC API call.

{% endlist %}

## Adding a route to a virtual host {#add-virtual-host}

To add a new route to your HTTP router's [virtual host](../concepts/http-router.md#virtual-host):

{% include [route-create-complete-section](../../_includes/application-load-balancer/instruction-steps/route-create-complete-section.md) %}

## Change your virtual host’s route order {#change-route-order}

To change route order in the [virtual host](../concepts/http-router.md#virtual-host) of the HTTP router:

{% include [reorder-routes-complete-section](../../_includes/application-load-balancer/instruction-steps/reorder-routes-complete-section.md) %}

## Changing a route timeout {#route-timeout}

You can only change the timeout for routes with the `{{ ui-key.yacloud.alb.label_route-action-route }}` action type.

To change the route timeout for an HTTP router:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with your HTTP router.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}**.
  1. Click your router name.
  1. Click **{{ ui-key.yacloud.common.edit }}**.
  1. Under **{{ ui-key.yacloud.alb.label_virtual-hosts }}**, change the **{{ ui-key.yacloud.alb.label_timeout }}** field value for the route you need.
  1. Click **{{ ui-key.yacloud.common.save }}** at the bottom of the page.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for changing a route:

      ```bash
        yc alb virtual-host update-http-route --help
      ```

  1. Run this command:

      ```bash
      yc alb virtual-host remove-http-route <route_name> \
        --virtual-host-name <virtual_host_name> \
        --http-router-name <router_name> \
        --request-timeout <timeout>
      ```

      Where `--request-timeout` is the new timeout value with the time unit, e.g., `120s`.

      Result:

      ```text
      name: host-one
      routes:
        - name: route-one
          http:
            match:
              path:
                prefix_match: /
            route:
              backend_group_id: ds7d6hg1dg24********
              timeout: 120s
              auto_host_rewrite: false
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and edit the value of the `timeout` parameter for the route in question:

     ```hcl
     resource "yandex_alb_virtual_host" "my-virtual-host" {
       name           = "my-virtual-host"
       http_router_id = "${yandex_alb_http_router.tf-router.id}"
       route {
         name = "my-route"
         http_route {
           http_route_action {
             backend_group_id = "${yandex_alb_backend_group.backend-group.id}"
             timeout          = "3s"
           }
         }
       }
     }
     ```

     For more information about `yandex_alb_virtual_host` properties, see [this {{ TF }} article]({{ tf-provider-resources-link }}/alb_virtual_host).

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will update all required resources. You can check virtual host updates in the [management console]({{ link-console-main }}) or using this [CLI](../../cli/quickstart.md) command:

      ```bash
      yc alb virtual-host get <virtual_host_ID>
      ```

      {% include [Terraform timeouts](../../_includes/application-load-balancer/terraform-timeout-router-and-host.md) %}

- API {#api}

  Use the [update](../api-ref/VirtualHost/update.md) REST API method for the [VirtualHost](../api-ref/VirtualHost/index.md) resource or the [VirtualHostService/Update](../api-ref/grpc/VirtualHost/update.md) gRPC API call.

{% endlist %}