{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you are going to create a virtual host route.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, click ![route](../../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}** and select the [HTTP router](../../../application-load-balancer/concepts/http-router.md) containing the virtual host for which you need to create a route.
  1. On the page that opens, under **{{ ui-key.yacloud.alb.label_virtual-hosts }}**, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) next to the virtual host and select ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  
      [Create](../../../application-load-balancer/operations/manage-virtual-hosts.md#create-vh) a new virtual host if needed.
  
      In the window that opens, click **{{ ui-key.yacloud.alb.button_add-route }}** and proceed as follows in the **{{ ui-key.yacloud.alb.label_new-route }}** form that appears, depending on the new route [type](../../../application-load-balancer/concepts/http-router.md#routes-types):

      {% list tabs group=alb_route_type%}

      - HTTP {#http}

        1. {% include [console-update-http-route-naming-step](./console-update-http-route-naming-step.md) %}
        1. {% include [console-update-http-route-ss1](./console-update-http-route-ss1.md) %}
        1. {% include [console-update-http-route-ss2](./console-update-http-route-ss2.md) %}
        1. {% include [console-update-http-route-ss3](./console-update-http-route-ss3.md) %}
        1. {% include [console-update-http-route-ss4](./console-update-http-route-ss4.md) %}

      - gRPC {#grpc}

        1. {% include [console-update-http-route-naming-step](./console-update-http-route-naming-step.md) %}
        1. {% include [console-update-grpc-route-ss1](./console-update-grpc-route-ss1.md) %}
        1. {% include [console-update-grpc-route-ss2](./console-update-grpc-route-ss2.md) %}
        1. {% include [console-update-grpc-route-ss3](./console-update-grpc-route-ss3.md) %}

      {% endlist %}

  1. {% include [console-reorder-routes](./console-reorder-routes.md) %}
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../cli-install.md) %}

  {% include [default-catalogue](../../default-catalogue.md) %}

  With the {{ yandex-cloud }} CLI, you can add different [types](../../../application-load-balancer/concepts/http-router.md#routes-types) of routes to the virtual host:

  {% list tabs group=alb_route_type%}

  - HTTP {#http}

    {% include [cli-create-http-route](./cli-create-http-route.md) %}

  - gRPC {#grpc}

    {% include [cli-create-grpc-route](./cli-create-grpc-route.md) %}

  {% endlist %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../terraform-install.md) %}

  {% include [tf-route-application-order-notice](./tf-route-application-order-notice.md) %}

  1. In the configuration file, describe the parameters of the route as a resource nested in a [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host) resource. With {{ TF }}, you can add different [types](../../../application-load-balancer/concepts/http-router.md#routes-types) of routes to the virtual host:

      {% list tabs group=alb_route_type%}

      - HTTP {#http}

        {% include [tf-route-http-hcl-code](./tf-route-http-hcl-code.md) %}

        Where:

        * `route`: Virtual host route description:

            {% include [tf-vh-create-legend-route-general](./tf-vh-create-legend-route-general.md) %}

            {% include [tf-vh-create-legend-route-http](./tf-vh-create-legend-route-http.md) %}

      - gRPC {#grpc}

        {% include [tf-route-grpc-hcl-code](./tf-route-grpc-hcl-code.md) %}

        Where:

        * `route`: Virtual host route description:

            {% include [tf-vh-create-legend-route-general](./tf-vh-create-legend-route-general.md) %}

            {% include [tf-vh-create-legend-route-grpc](./tf-vh-create-legend-route-grpc.md) %}

      {% endlist %}

      Learn more about the properties of {{ TF }} resources in the relevant provider guide: [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).
  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
      
      {{ TF }} will create all the required resources. You can check the new resources and their settings using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/index.yaml) command:

      ```bash
      yc alb virtual-host get <virtual_host_name> \
        --http-router-name <HTTP_router_name>
      ```

      {% include [Terraform timeouts](../terraform-timeout-router-and-host.md) %}

- API {#api}

  Use the [update](../../../application-load-balancer/api-ref/VirtualHost/update.md) REST API method for the [VirtualHost](../../../application-load-balancer/api-ref/VirtualHost/index.md) resource or the [VirtualHostService/Update](../../../application-load-balancer/api-ref/grpc/VirtualHost/update.md) gRPC API call.

  {% include [api-route-application-order-notice](./api-route-application-order-notice.md) %}

{% endlist %}