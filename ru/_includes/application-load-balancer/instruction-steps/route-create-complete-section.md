{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете создавать маршрут для виртуального хоста.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![route](../../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}** и выберите [HTTP-роутер](../../../application-load-balancer/concepts/http-router.md), в котором находится виртуальный хост, для которого требуется создать маршрут.
  1. На открывшейся странице в секции **{{ ui-key.yacloud.alb.label_virtual-hosts }}** в блоке с нужным виртуальным хостом нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  
      При необходимости [создайте](../../../application-load-balancer/operations/manage-virtual-hosts.md#create-vh) новый виртуальный хост.
  
      В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.alb.button_add-route }}** и в появившейся форме **{{ ui-key.yacloud.alb.label_new-route }}**, в зависимости от [типа](../../../application-load-balancer/concepts/http-router.md#routes-types) создаваемого маршрута:

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
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../cli-install.md) %}

  {% include [default-catalogue](../../default-catalogue.md) %}

  С помощью {{ yandex-cloud }} CLI вы можете добавлять в виртуальный хост разные [типы](../../../application-load-balancer/concepts/http-router.md#routes-types) маршрутов:

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

  1. Опишите в конфигурационном файле параметры маршрута как ресурса, вложенного в ресурс типа [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host). С помощью {{ TF }} вы можете добавлять в виртуальный хост разные [типы](../../../application-load-balancer/concepts/http-router.md#routes-types) маршрутов:

      {% list tabs group=alb_route_type%}

      - HTTP {#http}

        {% include [tf-route-http-hcl-code](./tf-route-http-hcl-code.md) %}

        Где:

        * `route` — описание маршрута виртуального хоста:

            {% include [tf-vh-create-legend-route-general](./tf-vh-create-legend-route-general.md) %}

            {% include [tf-vh-create-legend-route-http](./tf-vh-create-legend-route-http.md) %}

      - gRPC {#grpc}

        {% include [tf-route-grpc-hcl-code](./tf-route-grpc-hcl-code.md) %}

        Где:

        * `route` — описание маршрута виртуального хоста:

            {% include [tf-vh-create-legend-route-general](./tf-vh-create-legend-route-general.md) %}

            {% include [tf-vh-create-legend-route-grpc](./tf-vh-create-legend-route-grpc.md) %}

      {% endlist %}

      Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера: [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).
  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
      
      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/index.yaml):

      ```bash
      yc alb virtual-host get <имя_виртуального_хоста> \
        --http-router-name <имя_HTTP-роутера>
      ```

      {% include [Terraform timeouts](../terraform-timeout-router-and-host.md) %}

- API {#api}

  Воспользуйтесь методом REST API [update](../../../application-load-balancer/api-ref/VirtualHost/update.md) для ресурса [VirtualHost](../../../application-load-balancer/api-ref/VirtualHost/index.md) или вызовом gRPC API [VirtualHostService/Update](../../../application-load-balancer/api-ref/grpc/VirtualHost/update.md).

  {% include [api-route-application-order-notice](./api-route-application-order-notice.md) %}

{% endlist %}