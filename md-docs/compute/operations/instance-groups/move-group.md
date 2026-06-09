# Перенести группу виртуальных машин в другую зону доступности


Если группа ВМ подключена к балансировщику нагрузки, воспользуйтесь следующими инструкциями:
* [{#T}](move-group-with-nlb.md)
* [{#T}](move-group-with-alb.md)

Чтобы перенести группу ВМ в другую зону доступности:
1. [Создайте](../../../vpc/operations/subnet-create.md) подсеть в зоне доступности, в которую вы хотите перенести группу ВМ.
1. Добавьте ВМ группы в новую зону доступности:

    {% list tabs group=instructions %}
    
    - Консоль управления {#console}
    
      1. В [консоли управления]({{ link-console-main }}) откройте [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужная [группа виртуальных машин](../../concepts/instance-groups/index.md).
      1. Перейдите в сервис **{{ compute-name }}**.
      1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
      1. Выберите группу ВМ, которую хотите изменить.
      1. В правом верхнем углу нажмите ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
      1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_allocation }}** добавьте [зону доступности](../../../overview/concepts/geo-scope.md), в которую вы хотите перенести группу ВМ. 
      1. Если у вас группа ВМ с [ручным масштабированием](../../concepts/instance-groups/scale.md#fixed-scale), в блоке **{{ ui-key.yacloud.compute.groups.create.section_scale }}** укажите размер группы, достаточный для размещения во всех выбранных зонах доступности.
    
         Вернуть изначальное количество ВМ можно будет после воссоздания всех ВМ группы в новой зоне доступности и удаления всех ВМ в старой.
      1. Если у вас [автоматически масштабируемая](../../concepts/instance-groups/scale.md#auto-scale) группа ВМ с ручной (`OPPORTUNISTIC`) [стратегией остановки](../../concepts/instance-groups/policies/deploy-policy.md#strategy), в поле **{{ ui-key.yacloud.compute.groups.create.field_deploy-strategy }}** измените стратегию на автоматическую (`PROACTIVE`).
    
         Вернуть ручную стратегию остановки можно будет после воссоздания всех ВМ группы в новой зоне доступности и удаления всех ВМ в старой.
      1. Нажмите **{{ ui-key.yacloud.common.save }}**.
    
    - CLI {#cli}
    
      Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).
    
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
    
    - {{ TF }} {#tf}
    
      Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
      1. Откройте файл конфигурации {{ TF }} для [группы виртуальных машин](../../concepts/instance-groups/index.md) и добавьте в блоке `allocation_policy` новую [зону доступности](../../../overview/concepts/geo-scope.md), а в блоке `network_interface` идентификатор [подсети](../../../vpc/concepts/network.md#subnet), созданной ранее.
    
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
    
         Более подробную информацию о параметрах ресурсов в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_instance_group).
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
         
            В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
         1. Примените изменения конфигурации:
         
            ```bash
            terraform apply
            ```
         
         1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.
    
         Добавится новая зона доступности для группы ВМ. Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):
    
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
    
      1. В [консоли управления]({{ link-console-main }}) откройте [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужная [группа виртуальных машин](../../concepts/instance-groups/index.md).
      1. Перейдите в сервис **{{ compute-name }}**.
      1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
      1. Выберите группу ВМ, которую хотите изменить.
      1. В правом верхнем углу нажмите ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
      1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_allocation }}** отключите старую [зону доступности](../../../overview/concepts/geo-scope.md).
      1. Нажмите **{{ ui-key.yacloud.common.save }}**.
    
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
    
    - {{ TF }} {#tf}
    
      1. Откройте файл конфигурации {{ TF }} для [группы виртуальных машин](../../concepts/instance-groups/index.md) и удалите в блоке `allocation_policy` старую [зону доступности](../../../overview/concepts/geo-scope.md), а в блоке `network_interface` идентификатор [подсети](../../../vpc/concepts/network.md#subnet) в старой зоне:
    
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
    
         Более подробную информацию о параметрах ресурсов в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_instance_group).
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
         
            В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
         1. Примените изменения конфигурации:
         
            ```bash
            terraform apply
            ```
         
         1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.
    
         ВМ группы будут удалены в старой зоне доступности. Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):
    
         ```bash
         yc compute instance-group get <имя_группы_ВМ>
         ```
    
    - API {#api}
    
      Воспользуйтесь методом REST API [update](../../instancegroup/api-ref/InstanceGroup/update.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/Update](../../instancegroup/api-ref/grpc/InstanceGroup/update.md).
    
    {% endlist %}

### См. также {#see-also}

* [{#T}](move-group-with-nlb.md)
* [{#T}](move-group-with-alb.md)