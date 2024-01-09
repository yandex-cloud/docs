# Остановить и запустить сетевой балансировщик

При необходимости вы можете остановить сетевой балансировщик и запустить его заново.

## Остановить сетевой балансировщик {#stop}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется остановить балансировщик.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
  1. В строке балансировщика, который требуется остановить, нажмите на значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_stop }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_stop }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы остановить балансировщик, находящийся в статусе `ACTIVE`, выполните команду:

  ```bash
  yc load-balancer network-load-balancer stop <имя_или_идентификатор_балансировщика>
  ```

  Идентификатор и имя балансировщика можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list).

- API {#api}

  Чтобы остановить сетевой балансировщик, воспользуйтесь методом REST API [stop](../api-ref/NetworkLoadBalancer/stop.md) для ресурса [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/Stop](../api-ref/grpc/network_load_balancer_service.md#Stop).

  Идентификатор балансировщика можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list).

{% endlist %}

## Запустить сетевой балансировщик {#start}

Сетевой балансировщик в статусе `Stopped` можно запустить заново.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется запустить балансировщик.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
  1. В строке балансировщика, который требуется запустить, нажмите на значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_start }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_start }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы запустить балансировщик, находящийся в статусе `STOPPED`, выполните команду:

  ```bash
  yc load-balancer network-load-balancer start <имя_или_идентификатор_балансировщика>
  ```

  Идентификатор и имя балансировщика можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list).

- API {#api}

  Чтобы запустить сетевой балансировщик, воспользуйтесь методом REST API [start](../api-ref/NetworkLoadBalancer/start.md) для ресурса [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/Start](../api-ref/grpc/network_load_balancer_service.md#Start).

  Идентификатор балансировщика можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list).

{% endlist %}
