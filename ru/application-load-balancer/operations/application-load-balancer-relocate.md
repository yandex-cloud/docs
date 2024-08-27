---
title: "Как переместить ВМ в целевую группу в новой зоне доступности"
description: "Следуя данной инструкции, вы сможете перенести виртуальные машины за L7-балансировщиком в целевую группу в новой зоне доступности."
---

# Переместить виртуальную машину в целевую группу в новой зоне доступности


Чтобы перенести [ВМ](../../compute/concepts/vm.md) за [L7-балансировщиком](../concepts/application-load-balancer.md) в [целевую группу](../concepts/target-group.md) в новой [зоне доступности](../../overview/concepts/geo-scope.md):

1. Включите для балансировщика прием трафика в новой зоне доступности:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится балансировщик.
      1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
      1. В строке с нужным балансировщиком нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
      1. В открывшемся окне в блоке **{{ ui-key.yacloud.alb.section_allocation-settings }}** включите прием трафика в той зоне доступности, в которую хотите перенести ВМ.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

    - CLI {#cli}

      {% include [cli-install.md](../../_includes/cli-install.md) %}

      {% include [default-catalogue.md](../../_includes/default-catalogue.md) %}

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

      1. Включите прием трафика в новой зоне доступности:

          ```bash
          yc application-load-balancer load-balancer enable-traffic <имя_балансировщика> \
            --zone <зона_доступности>
          ```

          Где `--zone` — зона, в которую вы хотите перенести виртуальные машины.

          Результат:

          ```text
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

      Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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
         * `zone_id` — зоны доступности, в которых балансировщик будет принимать трафик.
         * `subnet_id` — идентификаторы подсетей в зонах доступности.

         Более подробную информацию о параметрах ресурсов в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/alb_load_balancer).

      1. Примените изменения:

         {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

         Новая зона доступности включится для приема трафика в балансировщике. Проверить это можно в [консоли управления]({{ link-console-main }}) или с помощью команды CLI:

         ```bash
         yc alb load-balancer get <имя_балансировщика>
         ```

   - API {#api}

     Воспользуйтесь методом REST API [update](../api-ref/LoadBalancer/update.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/Update](../api-ref/grpc/load_balancer_service.md#Update).

   {% endlist %}

1. При необходимости [настройте](../../vpc/operations/security-group-add-rule.md) [группу безопасности](../../vpc/concepts/security-groups.md) балансировщика. Для корректной работы балансировщика его группы безопасности должны разрешать исходящие соединения на адреса подсети, соответствующей новой зоне доступности ВМ.
1. [Перенесите](../../compute/operations/vm-control/vm-change-zone.md) ВМ в новую зону доступности.
1. [Добавьте](../../application-load-balancer/operations/target-group-update.md#add-targets) в целевую группу балансировщика новые ВМ и [удалите](../../application-load-balancer/operations/target-group-update.md#remove-targets) старые.
1. Убедитесь, что состояние ВМ определяется балансировщиком как `HEALTHY`:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится балансировщик.
     1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
     1. Выберите нужный балансировщик.
     1. Перейдите на вкладку ![image](../../_assets/console-icons/heart-pulse.svg) **{{ ui-key.yacloud.alb.label_healthchecks }}**.
     1. Раскройте список целевых ресурсов. ВМ, привязанные к целевой группе, должны иметь [статус](../../compute/concepts/vm-statuses.md) `HEALTHY`.

   - API {#api}

     Воспользуйтесь методом REST API [getTargetStates](../api-ref/LoadBalancer/getTargetStates.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/GetTargetStates](../api-ref/grpc/load_balancer_service.md#GetTargetStates).

   {% endlist %}

   [Статус](../../compute/concepts/vm-statuses.md) `HEALTHY` определяется для ВМ не сразу после подключения их к целевой группе. Для этого может потребоваться несколько минут, в зависимости от настроек бэкенда.

   Если состояние ВМ в течение длительного времени определяется балансировщиком как `UNHEALTHY`, убедитесь, что группы безопасности балансировщика настроены [правильно](../concepts/application-load-balancer.md#security-groups).
