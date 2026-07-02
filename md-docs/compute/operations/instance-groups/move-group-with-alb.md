[Документация Yandex Cloud](../../../index.md) > [Yandex Compute Cloud](../../index.md) > [Пошаговые инструкции](../index.md) > Управление группой виртуальных машин > Перенести группу ВМ с L7-балансировщиком в другую зону доступности

# Перенести группу виртуальных машин с L7-балансировщиком в другую зону доступности


Чтобы перенести [группу ВМ](../../concepts/instance-groups/index.md) с [L7-балансировщиком](../../../application-load-balancer/concepts/application-load-balancer.md) [Yandex Application Load Balancer](../../../application-load-balancer/index.md):

1. [Создайте](../../../vpc/operations/subnet-create.md) [подсеть](../../../vpc/concepts/network.md#subnet) в [зоне доступности](../../../overview/concepts/geo-scope.md), в которую вы хотите перенести группу [ВМ](../../concepts/vm.md).
1. Включите для L7-балансировщика прием трафика в новой зоне доступности:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится балансировщик.
      1. Перейдите в сервис **Application Load Balancer**.
      1. В строке с нужным балансировщиком нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
      1. В открывшемся окне в блоке **Размещение** включите прием трафика в той зоне доступности, в которую хотите перенести группу ВМ.
      1. Нажмите кнопку **Сохранить**.

    - CLI {#cli}

      Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

      1. Включите прием трафика:

          ```bash
          yc application-load-balancer load-balancer enable-traffic <имя_балансировщика> \
            --zone <зона_доступности>
          ```

          Где `--zone` — зона, в которую вы хотите перенести группу ВМ.

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

      Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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
         * `zone_id` — зоны доступности, в которых L7-балансировщик будет принимать трафик.
         * `subnet_id` — идентификаторы подсетей в зонах доступности.

         Более подробную информацию о параметрах ресурсов в Terraform читайте в [документации провайдера](../../../terraform/resources/alb_load_balancer.md).

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

         Новая зона доступности включится для приема трафика в L7-балансировщике. Проверить это можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/index.md):

         ```bash
         yc alb load-balancer get <имя_L7-балансировщика>
         ```

   - API {#api}

     Воспользуйтесь методом REST API [update](../../../application-load-balancer/api-ref/LoadBalancer/update.md) для ресурса [LoadBalancer](../../../application-load-balancer/api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/Update](../../../application-load-balancer/api-ref/grpc/LoadBalancer/update.md).

   {% endlist %}

1. Добавьте ВМ группы в новую зону доступности:

   {% list tabs group=instructions %}
   
   - Консоль управления {#console}
   
     1. В [консоли управления](https://console.yandex.cloud) откройте [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужная [группа виртуальных машин](../../concepts/instance-groups/index.md).
     1. Перейдите в сервис **Compute Cloud**.
     1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **Группы виртуальных машин**.
     1. Выберите группу ВМ, которую хотите изменить.
     1. В правом верхнем углу нажмите ![image](../../../_assets/console-icons/pencil.svg) **Редактировать**.
     1. В блоке **Распределение** добавьте [зону доступности](../../../overview/concepts/geo-scope.md), в которую вы хотите перенести группу ВМ. 
     1. Если у вас группа ВМ с [ручным масштабированием](../../concepts/instance-groups/scale.md#fixed-scale), в блоке **Масштабирование** укажите размер группы, достаточный для размещения во всех выбранных зонах доступности.
   
        Вернуть изначальное количество ВМ можно будет после воссоздания всех ВМ группы в новой зоне доступности и удаления всех ВМ в старой.
     1. Если у вас [автоматически масштабируемая](../../concepts/instance-groups/scale.md#auto-scale) группа ВМ с ручной (`OPPORTUNISTIC`) [стратегией остановки](../../concepts/instance-groups/policies/deploy-policy.md#strategy), в поле **Останавливать машины по стратегии** измените стратегию на автоматическую (`PROACTIVE`).
   
        Вернуть ручную стратегию остановки можно будет после воссоздания всех ВМ группы в новой зоне доступности и удаления всех ВМ в старой.
     1. Нажмите **Сохранить**.
   
   - CLI {#cli}
   
     Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).
   
     По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
   
     1. Откройте файл со [спецификацией](../../concepts/instance-groups/specification.md) [группы виртуальных машин](../../concepts/instance-groups/index.md) и измените [шаблон ВМ](../../concepts/instance-groups/instance-template.md):
        * В секции `allocation_policy` добавьте новую [зону доступности](../../../overview/concepts/geo-scope.md).
        * В секции `network_interface_specs` добавьте идентификатор [подсети](../../../vpc/concepts/network.md#subnet), созданной ранее.
        * Если у вас группа ВМ с [ручным масштабированием](../../concepts/instance-groups/scale.md#fixed-scale), в секции `scale_policy` укажите размер группы, достаточный для размещения во всех выбранных зонах доступности.
   
          Вернуть изначальное количество ВМ можно будет после воссоздания всех ВМ группы в новой зоне доступности и удаления всех ВМ в старой.
        * Если у вас [автоматически масштабируемая](../../concepts/instance-groups/scale.md#auto-scale) группа ВМ с ручной (`OPPORTUNISTIC`) [стратегией остановки](../../concepts/instance-groups/policies/deploy-policy.md#strategy), в секции `deploy_policy` измените стратегию на автоматическую (`PROACTIVE`).
   
          Вернуть ручную стратегию остановки можно будет после воссоздания всех ВМ группы в новой зоне доступности и удаления всех ВМ в старой.
     1. Посмотрите описание команды CLI для изменения группы ВМ:
   
        ```bash
        yc compute instance-group update --help
        ```
   
     1. Получите список всех групп ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:
   
        ```bash
        yc compute instance-group list
        ```
   
        Результат:
   
        ```text
        +----------------------+---------------------------------+--------+--------+
        |          ID          |              NAME               | STATUS |  SIZE  |
        +----------------------+---------------------------------+--------+--------+
        | cl15sjqilrei******** | first-fixed-group-with-balancer | ACTIVE |      3 |
        | cl19s7dmihgm******** | test-group                      | ACTIVE |      2 |
        +----------------------+---------------------------------+--------+--------+
        ```
   
     1. Измените группу ВМ:
   
        ```bash
        yc compute instance-group update \
          --id <идентификатор_группы_ВМ> \
          --file <файл_со_спецификацией_ВМ>
        ```
   
        Где:
        * `--id` — идентификатор группы ВМ.
        * `--file` — путь к файлу со спецификацией группы ВМ.
   
        Результат:
   
        ```text
        id: cl15sjqilrei********
        ...
        allocation_policy:
        zones:
        - zone_id: <старая_зона_доступности>
        - zone_id: <новая_зона_доступности>
        ...
        ```
   
   - Terraform {#tf}
   
     Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
     1. Откройте файл конфигурации Terraform для [группы виртуальных машин](../../concepts/instance-groups/index.md) и добавьте в блоке `allocation_policy` новую [зону доступности](../../../overview/concepts/geo-scope.md), а в блоке `network_interface` идентификатор [подсети](../../../vpc/concepts/network.md#subnet), созданной ранее.
   
        ```hcl
        ...
        network_interface {
          subnet_ids = [
            "<идентификатор_подсети_в_старой_зоне_доступности>",
            "<идентификатор_подсети_в_новой_зоне_доступности>"
          ]
        }
        ...
        allocation_policy {
          zones = [
            "<старая_зона_доступности>",
            "<новая_зона_доступности>"
          ]
        }
        ...
        ```
   
        Где:
        * `zones` — зоны доступности, в которых будет размещена группа ВМ — новая и старая.
        * `subnet_ids` — идентификаторы подсетей в зонах доступности, в которых будет размещена группа ВМ.
   
        Если у вас группа ВМ с [ручным масштабированием](../../concepts/instance-groups/scale.md#fixed-scale), в секции `scale_policy` укажите размер группы, достаточный для размещения во всех выбранных зонах доступности.
   
        ```hcl
        ...
        scale_policy {
          fixed_scale {
            size = <количество_ВМ_в_группе>
          }
        }
        ...
        ```
   
        Вернуть изначальное количество ВМ можно будет после воссоздания всех ВМ группы в новой зоне доступности и удаления всех ВМ в старой.
   
        Если у вас [автоматически масштабируемая](../../concepts/instance-groups/scale.md#auto-scale) группа ВМ с ручной (`OPPORTUNISTIC`) [стратегией остановки](../../concepts/instance-groups/policies/deploy-policy.md#strategy), измените стратегию на автоматическую (`PROACTIVE`):
   
        ```hcl
        ...
        deploy_policy {
          strategy = "proactive" 
        }
        ...
        ```
   
        Вернуть ручную стратегию остановки можно будет после воссоздания всех ВМ группы в новой зоне доступности и удаления всех ВМ в старой.
   
        Более подробную информацию о параметрах ресурсов в Terraform читайте в [документации провайдера](../../../terraform/resources/compute_instance_group.md).
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
   
        Добавится новая зона доступности для группы ВМ. Проверить изменения можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):
   
        ```bash
        yc compute instance-group get <имя_группы_ВМ>
        ```
   
   - API {#api}
   
     Воспользуйтесь методом REST API [update](../../instancegroup/api-ref/InstanceGroup/update.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/Update](../../instancegroup/api-ref/grpc/InstanceGroup/update.md).
   
     Если у вас группа ВМ с [ручным масштабированием](../../concepts/instance-groups/scale.md#fixed-scale), задайте размер группы, достаточный для размещения ВМ во всех выбранных зонах доступности. Вернуть изначальное количество ВМ можно будет после воссоздания всех ВМ группы в новой зоне доступности и удаления всех ВМ в старой.
   
     Если у вас [автоматически масштабируемая](../../concepts/instance-groups/scale.md#auto-scale) группа ВМ с ручной (`OPPORTUNISTIC`) [стратегией остановки](../../concepts/instance-groups/policies/deploy-policy.md#strategy), измените стратегию на автоматическую (`PROACTIVE`). Вернуть ручную стратегию остановки можно будет после воссоздания всех ВМ группы в новой зоне доступности и удаления всех ВМ в старой.
   
   {% endlist %}
   
   Дождитесь пока ВМ создадутся в новой зоне доступности и перейдут в статус `Running Actual`.

1. Удалите ВМ группы из старой зоны доступности:

   {% list tabs group=instructions %}
   
   - Консоль управления {#console}
   
     1. В [консоли управления](https://console.yandex.cloud) откройте [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужная [группа виртуальных машин](../../concepts/instance-groups/index.md).
     1. Перейдите в сервис **Compute Cloud**.
     1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **Группы виртуальных машин**.
     1. Выберите группу ВМ, которую хотите изменить.
     1. В правом верхнем углу нажмите ![image](../../../_assets/console-icons/pencil.svg) **Редактировать**.
     1. В блоке **Распределение** отключите старую [зону доступности](../../../overview/concepts/geo-scope.md).
     1. Нажмите **Сохранить**.
   
   - CLI {#cli}
   
     1. Откройте файл со [спецификацией](../../concepts/instance-groups/specification.md) [группы виртуальных машин](../../concepts/instance-groups/index.md) и измените [шаблон ВМ](../../concepts/instance-groups/instance-template.md):
        * В секции `allocation_policy` удалите старую зону доступности.
        * В секции `network_interface_specs` удалите идентификатор [подсети](../../../vpc/concepts/network.md#subnet) в старой зоне доступности.
     1. Измените группу ВМ:
   
        ```bash
        yc compute instance-group update \
          --id <идентификатор_группы_ВМ> \
          --file <файл_со_спецификацией_ВМ>
        ```
   
        Где:
        * `--id` — идентификатор группы ВМ.
        * `--file` — путь к файлу со спецификацией группы ВМ.
   
        Результат:
   
        ```text
        id: cl15sjqilrei********
        ...
        allocation_policy:
        zones:
        - zone_id: <новая_зона_доступности>
        ...
        ```
   
   - Terraform {#tf}
   
     1. Откройте файл конфигурации Terraform для [группы виртуальных машин](../../concepts/instance-groups/index.md) и удалите в блоке `allocation_policy` старую [зону доступности](../../../overview/concepts/geo-scope.md), а в блоке `network_interface` идентификатор [подсети](../../../vpc/concepts/network.md#subnet) в старой зоне:
   
        ```hcl
        ...
        network_interface {
          subnet_ids = ["<идентификатор_подсети_в_новой_зоне_доступности>"]
        }
        ...
        allocation_policy {
          zones = ["<новая_зона_доступности>"]
        }
        ...
        ```
   
        Где:
        * `zones` — зона доступности, в которую вы хотите переместить группу ВМ. Можно указать несколько зон.
        * `subnet_ids` — идентификатор подсети в той зоне доступности, в которую вы хотите перенести группу ВМ.
   
        Более подробную информацию о параметрах ресурсов в Terraform читайте в [документации провайдера](../../../terraform/resources/compute_instance_group.md).
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
   
        ВМ группы будут удалены в старой зоне доступности. Проверить изменения можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):
   
        ```bash
        yc compute instance-group get <имя_группы_ВМ>
        ```
   
   - API {#api}
   
     Воспользуйтесь методом REST API [update](../../instancegroup/api-ref/InstanceGroup/update.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/Update](../../instancegroup/api-ref/grpc/InstanceGroup/update.md).
   
   {% endlist %}