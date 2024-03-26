---
title: "Как получить информацию об L7-балансировщике в {{ alb-full-name }}"
---

# Получить информацию об L7-балансировщике

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [L7-балансировщик](../concepts/application-load-balancer.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Выберите L7-балансировщик.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о балансировщике.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации об [L7-балансировщике](../concepts/application-load-balancer.md):

      ```bash
      yc alb load-balancer get --help
      ```

  1. Получите информацию о балансировщике, указав его имя или идентификатор:

      ```bash
      yc alb load-balancer get <имя_балансировщика>
      ```

      Результат:

      ```bash
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
        - zone_id: {{ region-id }}-b
          subnet_id: blt6pcatjje6********
        - zone_id: {{ region-id }}-d
          subnet_id: fo2ap2nrhjk9********
      log_group_id: eolul9ap0bv0********
      created_at: "2021-04-26T12:12:13.624832586Z"
      log_options:
        log_group_id: e23ujjda632o********
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы получить информацию об [L7-балансировщике](../concepts/application-load-balancer.md) с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

      ```hcl
      data "yandex_alb_load_balancer" "tf-alb" {
        load_balancer_id = "<идентификатор_балансировщика>"
      }

      output "tf-alb-listener" {
        value = data.yandex_alb_load_balancer.tf-alb.allocation_policy
      }
      ```

      Где:

      * `data "yandex_alb_load_balancer"` — описание L7-балансировщика в качестве источника данных:
         * `load_balancer_id` — идентификатор L7-балансировщика.
      * `output "allocation_policy"` — выходная переменная, которая содержит информацию о политике размещения L7-балансировщика:
         * `value` — возвращаемое значение.
      
     Вместо `allocation_policy` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_alb_load_balancer` см. в [документации провайдера]({{ tf-provider-datasources-link }}/datasource_alb_load_balancer).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```bash
      tf-alb-listener = tolist([
        {
          "location" = toset([
            {
              "disable_traffic" = false
              "subnet_id" = "buc4gsmpj8hv********"
              "zone_id" = "{{ region-id }}-a"
            },
            {
              "disable_traffic" = false
              "subnet_id" = "blt6pcatjje6********"
              "zone_id" = "{{ region-id }}-b"
            },
            ...
      ```

- API {#api}

  Чтобы получить подробную информацию об [L7-балансировщике](../concepts/application-load-balancer.md), воспользуйтесь методом REST API [get](../api-ref/LoadBalancer/get.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/Get](../api-ref/grpc/load_balancer_service.md#Get).

{% endlist %}