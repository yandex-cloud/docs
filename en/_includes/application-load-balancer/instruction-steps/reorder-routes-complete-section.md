{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) in which you are going to reorder virtual host.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, click ![route](../../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}** and select the [HTTP router](../../../application-load-balancer/concepts/http-router.md) that contains the virtual host.
  1. On the page that opens, under **{{ ui-key.yacloud.alb.label_virtual-hosts }}**, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) next to the virtual host and select ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. If you want to change the route order, click **{{ ui-key.yacloud.alb.button_routes-sort }}** and in the window that opens:
  
      1. Drag and drop routes to arrange them in desired order.
      1. Click **{{ ui-key.yacloud.common.save }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  The {{ yandex-cloud }} CLI currently does not have a dedicated command for reordering routes in a virtual host.
  
  To reorder routes via the CLI, follow these steps:
  1. [Delete](../../../application-load-balancer/operations/manage-routes.md#delete-route) the route in question from the virtual host.
  1. [Add](../../../application-load-balancer/operations/manage-routes.md#create-route) the route again to the appropriate place in the route list.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../terraform-install.md) %}

  {% include [tf-route-application-order-notice](./tf-route-application-order-notice.md) %}

  1. In the configuration file, reorder the routes as resources nested in a [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host) resource.

      {% include [tf-route-reorder-delete-route](./tf-route-reorder-delete-route.md) %}

      Learn more about the properties of {{ TF }} resources in the relevant provider guide: [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).
  1. Update the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
      
      {{ TF }} will create all the required resources. You can check the new resources as well as their order and settings using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/index.yaml) command:

      ```bash
      yc alb virtual-host get <virtual_host_name> \
        --http-router-name <HTTP_router_name>
      ```

      {% include [Terraform timeouts](../terraform-timeout-router-and-host.md) %}

- API {#api}

  Use the [update](../../../application-load-balancer/api-ref/VirtualHost/update.md) REST API method for the [VirtualHost](../../../application-load-balancer/api-ref/VirtualHost/index.md) resource or the [VirtualHostService/Update](../../../application-load-balancer/api-ref/grpc/VirtualHost/update.md) gRPC API call.

  {% include [api-route-application-order-notice](./api-route-application-order-notice.md) %}

{% endlist %}