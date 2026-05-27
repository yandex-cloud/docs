# Переместить виртуальную машину в целевую группу в новой зоне доступности


Чтобы перенести [ВМ](../../compute/concepts/vm.md) за [L7-балансировщиком](../concepts/application-load-balancer.md) в [целевую группу](../concepts/target-group.md) в новой [зоне доступности](../../overview/concepts/geo-scope.md):

1. Включите для балансировщика прием трафика в новой зоне доступности:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится балансировщик.
      1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Application Load Balancer**.
      1. В строке с нужным балансировщиком нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
      1. В открывшемся окне в блоке **Размещение** включите прием трафика в той зоне доступности, в которую хотите перенести ВМ.
      1. Нажмите кнопку **Сохранить**.

    - CLI {#cli}

      Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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
          | ds732hi8pn9n******** |      sample-alb1      | ru-central1 |              1 |  ACTIVE |
          | f3da23i86n2v******** |      sample-alb2      | ru-central1 |              1 |  ACTIVE |
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
          region_id: ru-central1
          network_id: enpn46stivv8********
          allocation_policy:
            locations:
              - zone_id: ru-central1-a
                subnet_id: e9bavnqlbiuk********
                disable_traffic: true
              - zone_id: ru-central1-b
                  subnet_id: e2lgp8o00g06********
              - zone_id: ru-central1-d
                  subnet_id: b0cv501fvp13********
          log_group_id: ckgah4eo2j0r********
          security_group_ids:
            - enpdjc5bitmj********
          created_at: "2023-08-09T08:34:24.887765763Z"
          log_options: {}
          ```

    - Terraform {#tf}

      Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

      1. Откройте файл конфигурации Terraform для L7-балансировщика и укажите в блоке `allocation_policy` новую зону доступности и идентификатор подсети, созданной ранее:

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

         Более подробную информацию о параметрах ресурсов в Terraform см. в [документации провайдера](../../terraform/resources/alb_load_balancer.md).

      1. Примените изменения:

         1. В терминале перейдите в директорию с конфигурационным файлом.
         1. Проверьте корректность конфигурации с помощью команды:
         
            ```bash
            terraform validate
            ```
         
            Если конфигурация является корректной, появится сообщение:
         
            ```bash
            Success! The configuration is valid.
            ```
         
         1. Выполните команду:
         
            ```bash
            terraform plan
            ```
         
            В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
         1. Примените изменения конфигурации:
         
            ```bash
            terraform apply
            ```
         
         1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

         Новая зона доступности включится для приема трафика в балансировщике. Проверить это можно в [консоли управления](https://console.yandex.cloud) или с помощью команды CLI:

         ```bash
         yc alb load-balancer get <имя_балансировщика>
         ```

         {% note warning "Ограничения по времени" %}
         
         Провайдер Terraform ограничивает время на выполнение операций с балансировщиками Application Load Balancer 10 минутами.
         
         Операции, которые длятся дольше указанного времени, прерываются.
         
         {% cut "Как изменить эти ограничения?" %}
         
         Добавьте к описанию балансировщика блок `timeouts`, например:
         
         ```hcl
         resource "yandex_alb_load_balancer" "<имя_балансировщика>" {
           ...
           timeouts {
             create = "60m"
             update = "60m"
             delete = "60m"
           }
         }
         ```
         
         {% endcut %}
         
         {% endnote %}

   - API {#api}

     Воспользуйтесь методом REST API [update](../api-ref/LoadBalancer/update.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/Update](../api-ref/grpc/LoadBalancer/update.md).

   {% endlist %}

1. При необходимости [настройте](../../vpc/operations/security-group-add-rule.md) [группу безопасности](../../vpc/concepts/security-groups.md) балансировщика. Для корректной работы балансировщика его группы безопасности должны разрешать исходящие соединения на адреса подсети, соответствующей новой зоне доступности ВМ.
1. [Перенесите](../../compute/operations/vm-control/vm-change-zone.md) ВМ в новую зону доступности.
1. [Добавьте](target-group-update.md#add-targets) в целевую группу балансировщика новые ВМ и [удалите](target-group-update.md#remove-targets) старые.
1. Убедитесь, что состояние ВМ определяется балансировщиком как `HEALTHY`:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится балансировщик.
     1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Application Load Balancer**.
     1. Выберите нужный балансировщик.
     1. Перейдите на вкладку ![image](../../_assets/console-icons/heart-pulse.svg) **Проверки состояния**.
     1. Раскройте список целевых ресурсов. ВМ, привязанные к целевой группе, должны иметь [статус](../../compute/concepts/vm-statuses.md) `HEALTHY`.

   - API {#api}

     Воспользуйтесь методом REST API [getTargetStates](../api-ref/LoadBalancer/getTargetStates.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/GetTargetStates](../api-ref/grpc/LoadBalancer/getTargetStates.md).

   {% endlist %}

   [Статус](../../compute/concepts/vm-statuses.md) `HEALTHY` определяется для ВМ не сразу после подключения их к целевой группе. Для этого может потребоваться несколько минут, в зависимости от настроек бэкенда.

   Если состояние ВМ в течение длительного времени определяется балансировщиком как `UNHEALTHY`, убедитесь, что группы безопасности балансировщика настроены [правильно](../concepts/application-load-balancer.md#security-groups).