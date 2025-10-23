{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете изменять порядок маршрутов виртуального хоста.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![route](../../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}** и выберите [HTTP-роутер](../../../application-load-balancer/concepts/http-router.md), в котором находится нужный виртуальный хост.
  1. На открывшейся странице в секции **{{ ui-key.yacloud.alb.label_virtual-hosts }}** в блоке с нужным виртуальным хостом нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Чтобы изменить порядок маршрутов, нажмите кнопку **{{ ui-key.yacloud.alb.button_routes-sort }}** и в открывшемся окне:
  
      1. С помощью мышки методом перетаскивания выстройте нужный порядок маршрутов.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  В {{ yandex-cloud }} CLI в настоящий момент нет отдельной команды, позволяющей изменять порядок маршрутов в виртуальном хосте.
  
  Чтобы изменить порядок маршрутов с помощью CLI, воспользуйтесь следующим порядком действий:
  1. [Удалите](../../../application-load-balancer/operations/manage-routes.md#delete-route) нужный маршрут из виртуального хоста.
  1. Заново [добавьте](../../../application-load-balancer/operations/manage-routes.md#create-route) маршрут в нужное место в списке маршрутов.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../terraform-install.md) %}

  {% include [tf-route-application-order-notice](./tf-route-application-order-notice.md) %}

  1. Измените в конфигурационном файле порядок маршрутов как ресурсов, вложенных в ресурс типа [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).

      {% include [tf-route-reorder-delete-route](./tf-route-reorder-delete-route.md) %}

      Информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера: [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).
  1. Обновите ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
      
      {{ TF }} создаст все требуемые ресурсы. Проверить появление, порядок ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/index.yaml):

      ```bash
      yc alb virtual-host get <имя_виртуального_хоста> \
        --http-router-name <имя_HTTP-роутера>
      ```

      {% include [Terraform timeouts](../terraform-timeout-router-and-host.md) %}

- API {#api}

  Воспользуйтесь методом REST API [update](../../../application-load-balancer/api-ref/VirtualHost/update.md) для ресурса [VirtualHost](../../../application-load-balancer/api-ref/VirtualHost/index.md) или вызовом gRPC API [VirtualHostService/Update](../../../application-load-balancer/api-ref/grpc/VirtualHost/update.md).

  {% include [api-route-application-order-notice](./api-route-application-order-notice.md) %}

{% endlist %}