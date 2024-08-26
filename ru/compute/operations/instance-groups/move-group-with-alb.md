---
title: "Перенос группы виртуальных машин с L7-балансировщиком в другую зону доступности"
description: "Из статьи вы узнаете, как можно перенести группу ВМ {{ compute-full-name }} с L7-балансировщиком из одной зоны доступности в другую."
---

# Перенести группу виртуальных машин с L7-балансировщиком в другую зону доступности


{% note info %}

{% include [zone-c-deprecation](../../../_includes/vpc/zone-c-deprecation.md) %}

{% endnote %}

Чтобы перенести [группу ВМ](../../concepts/instance-groups/index.md) с [L7-балансировщиком](../../../application-load-balancer/concepts/application-load-balancer.md) [{{ alb-full-name }}](../../../application-load-balancer/):

1. [Создайте](../../../vpc/operations/subnet-create.md) [подсеть](../../../vpc/concepts/network.md#subnet) в [зоне доступности](../../../overview/concepts/geo-scope.md), в которую вы хотите перенести группу [ВМ](../../concepts/vm.md).
1. Включите для L7-балансировщика прием трафика в новой зоне доступности:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится балансировщик.
      1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
      1. В строке с нужным балансировщиком нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
      1. В открывшемся окне в блоке **{{ ui-key.yacloud.alb.section_allocation-settings }}** включите прием трафика в той зоне доступности, в которую хотите перенести группу ВМ.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

    - CLI {#cli}

      {% include [cli-install.md](../../../_includes/cli-install.md) %}

      {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

      1. Посмотрите описание команды CLI для включения трафика балансировщика:

          ```bash
          yc application-load-balancer load-balancer enable-traffic --help
          ```

      1. Получите список всех L7-балансировщиков в каталоге по умолчанию:

          ```bash
          yc application-load-balancer load-balancer list
          ```

          Результат:

          ```text
          +----------------------+-----------------------+-------------+----------------+---------+
          |          ID          |         NAME          |  REGION ID  | LISTENER COUNT | STATUS  |
          +----------------------+-----------------------+-------------+----------------+---------+
          | ds732hi8pn9n******** |      sample-alb1      | {{ region-id }} |              1 |  ACTIVE |
          | f3da23i86n2v******** |      sample-alb2      | {{ region-id }} |              1 |  ACTIVE |
          +----------------------+-----------------------+-------------+----------------+---------+
          ```

      1. Включите прием трафика:

          ```bash
          yc application-load-balancer load-balancer enable-traffic <имя_балансировщика> \
            --zone <зона_доступности>
          ```

          Где `--zone` — зона, в которую вы хотите перенести группу ВМ.

          Результат:

          ```bash
          id: ds7pmslal3km********
          name: sample-alb1
          folder_id: b1gmit33ngp3********
          status: ACTIVE
          region_id: {{ region-id }}
          network_id: enpn46stivv8********
          allocation_policy:
            locations:
              - zone_id: {{ region-id }}-a
                subnet_id: e9bavnqlbiuk********
                disable_traffic: true
              - zone_id: {{ region-id }}-b
                  subnet_id: e2lgp8o00g06********
              - zone_id: {{ region-id }}-d
                  subnet_id: b0cv501fvp13********
          log_group_id: ckgah4eo2j0r********
          security_group_ids:
            - enpdjc5bitmj********
          created_at: "2023-08-09T08:34:24.887765763Z"
          log_options: {}
          ```

    - {{ TF }} {#tf}

      Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

      1. Откройте файл конфигурации {{ TF }} для L7-балансировщика и укажите в блоке `allocation_policy` новую зону доступности и идентификатор подсети, созданной ранее:

         ```hcl
         ...
           allocation_policy {
             location {
               zone_id   = [
                 "<старая_зона_доступности>",
                 "<новая_зона_доступности>"
               ]
               subnet_id = [
                 "<идентификатор_подсети_в_старой_зоне_доступности>",
                 "<идентификатор_подсети_в_новой_зоне_доступности>"
               ]
             }
           }
         }
         ...
         ```

         Где:
         * `zone_id` — зоны доступности, в которых L7-балансировщик будет принимать трафик.
         * `subnet_id` — идентификаторы подсетей в зонах доступности.

         Более подробную информацию о параметрах ресурсов в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/alb_load_balancer).

      1. Примените изменения:

         {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

         Новая зона доступности включится для приема трафика в L7-балансировщике. Проверить это можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

         ```bash
         yc alb load-balancer get <имя_L7-балансировщика>
         ```

   - API {#api}

     Воспользуйтесь методом REST API [update](../../../application-load-balancer/api-ref/LoadBalancer/update.md) для ресурса [LoadBalancer](../../../application-load-balancer/api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/Update](../../../application-load-balancer/api-ref/grpc/load_balancer_service.md#Update).

   {% endlist %}

1. Добавьте ВМ группы в новую зону доступности:

   {% include [ig-create-in-another-zone](../../../_includes/compute/ig-create-in-another-zone.md) %}

1. Удалите ВМ группы из старой зоны доступности:

   {% include [ig-delete-in-zone.md](../../../_includes/compute/ig-delete-in-zone.md) %}
