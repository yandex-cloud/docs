---
title: Как включить защиту от удаления группы виртуальных машин
description: Следуя данной инструкции, вы сможете включить защиту от удаления группы виртуальных машин.
---

# Включить защиту от удаления для группы виртуальных машин {{ compute-name }}

Защита от удаления предотвращает случайное удаление [группы виртуальных машин](../../concepts/instance-groups/index.md) (ВМ). Пока опция включена, группу ВМ удалить невозможно. Чтобы удалить группу с включенной защитой, сначала необходимо отключить защиту.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится нужная группа ВМ.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
  1. Выберите группу, для которой хотите включить защиту от удаления.
  1. В правом верхнем углу страницы нажмите **{{ ui-key.yacloud.common.edit }}**.
  1. Включите опцию **{{ ui-key.yacloud.compute.groups.create.field_deletion-protection }}**.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения группы ВМ:

     ```bash
     {{ yc-compute-ig }} update --help
     ```

  1. Получите список групп ВМ в каталоге по умолчанию:

     {% include [instance-group-list](../../../_includes/instance-groups/instance-group-list.md) %}

  1. Выберите идентификатор (`ID`) нужной группы.
  1. Укажите в YAML-файле, по которому создавалась группа, параметр `deletion_protection: true`. Если YAML-файл не сохранился, [получите информацию](get-info.md) о группе виртуальных машин и создайте новый, например `specification.yaml`. Подробнее читайте в разделе [{#T}](create-fixed-group.md).
  1. Обновите группу виртуальных машин в каталоге по умолчанию:

      ```bash
      {{ yc-compute-ig }} update \
        --id <идентификатор_группы_ВМ> \
        --file specification.yaml
      ```

     {{ ig-name }} запустит операцию изменения группы виртуальных машин.

     Результат:

      ```yaml
      done (4m55s)
      id: cl15b3mrkk88********
      folder_id: b1g07hj5r6i4********
      created_at: "2025-12-10T10:51:35.963Z"
      name: vm-grup
      description: Эта группа ВМ создана с помощью YAML-файла конфигурации.
      instance_template:
        platform_id: standard-v3
        resources_spec:
          memory: "2147483648"
          cores: "2"
        boot_disk_spec:
          mode: READ_WRITE
          disk_spec:
            type_id: network-ssd
            size: "21474836480"
            image_id: fd8fhpd6j1ea********
        network_interface_specs:
          - network_id: enp1djcrd94k********
            primary_v4_address_spec: {}
        scheduling_policy: {}
      scale_policy:
        fixed_scale:
          size: "3"
      deploy_policy:
        max_unavailable: "1"
        strategy: PROACTIVE
      allocation_policy:
        zones:
          - zone_id: ru-central1-b
      load_balancer_state: {}
      managed_instances_state:
        target_size: "3"
      service_account_id: ajeb9l33h6mu********
      status: ACTIVE
      deletion_protection: true
      application_load_balancer_state: {}
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и добавьте параметр `deletion_protection` в описание группы ВМ:

     ```hcl
     ...
     resource "yandex_compute_instance_group" "ig-1" {
       name                = "fixed-ig"
       folder_id           = "<идентификатор_каталога>"
       service_account_id  = "<идентификатор_сервисного_аккаунта>"
       deletion_protection = true
       depends_on          = [yandex_resourcemanager_folder_iam_member.compute_editor]
       instance_template {
         platform_id = "standard-v3"
         resources {
           memory = 2
           cores  = 2
         }
         ...
       }
     }
     ```

     Где `deletion_protection` — защита группы ВМ от удаления: `true` или `false`. Пока опция включена, группу ВМ удалить невозможно. Значение по умолчанию — `false`.

     Более подробную информацию о параметрах ресурса `yandex_compute_instance_group` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_instance_group).

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  1. Проверьте изменение группы ВМ в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

     ```bash
     yc compute instance-group get <имя_группы_ВМ>
     ```


- API {#api}

  Воспользуйтесь методом REST API [update](../../instancegroup/api-ref/InstanceGroup/update.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/Update](../../instancegroup/api-ref/grpc/InstanceGroup/update.md).

  Список доступных групп запрашивайте методом REST API [listInstances](../../instancegroup/api-ref/InstanceGroup/listInstances.md) или вызовом gRPC API [InstanceGroupService/ListInstances](../../instancegroup/api-ref/grpc/InstanceGroup/listInstances.md).

{% endlist %}

## Отключить защиту от удаления {#disable}

Чтобы отключить защиту от удаления группы ВМ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится нужная группа ВМ.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
  1. Выберите группу, для которой хотите отключить защиту от удаления.
  1. В правом верхнем углу страницы нажмите **{{ ui-key.yacloud.common.edit }}**.
  1. Отключите опцию **{{ ui-key.yacloud.compute.groups.create.field_deletion-protection }}**.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения группы ВМ:

     ```bash
     {{ yc-compute-ig }} update --help
     ```

  1. Получите список групп ВМ в каталоге по умолчанию:

     {% include [instance-group-list](../../../_includes/instance-groups/instance-group-list.md) %}

  1. Выберите идентификатор (`ID`) нужной группы.
  1. Укажите в YAML-файле, по которому создавалась группа, параметр `deletion_protection: false`. Если YAML-файл не сохранился, [получите информацию](get-info.md) о группе виртуальных машин и создайте новый, например `specification.yaml`. Подробнее читайте в разделе [{#T}](create-fixed-group.md).
  1. Отключите защиту от удаления:

     ```bash
      {{ yc-compute-ig }} update \
        --id <идентификатор_группы_ВМ> \
        --file specification.yaml
     ```

     {{ ig-name }} запустит операцию изменения группы ВМ.

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и измените значение параметра `deletion_protection` на `false` в описании группы ВМ:

     ```hcl
     ...
     resource "yandex_compute_instance_group" "ig-1" {
       name                = "fixed-ig"
       folder_id           = "<идентификатор_каталога>"
       service_account_id  = "<идентификатор_сервисного_аккаунта>"
       deletion_protection = false
       depends_on          = [yandex_resourcemanager_folder_iam_member.compute_editor]
       instance_template {
         platform_id = "standard-v3"
         resources {
           memory = 2
           cores  = 2
         }
         ...
       }
     }
     ```

     Более подробную информацию о параметрах ресурса `yandex_compute_instance_group` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_instance_group).

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  1. Проверьте изменение группы ВМ в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

     ```bash
     yc compute instance-group get <имя_группы_ВМ>
     ```

- API {#api}

  Воспользуйтесь методом REST API [update](../../instancegroup/api-ref/InstanceGroup/update.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/Update](../../instancegroup/api-ref/grpc/InstanceGroup/update.md).

  Список доступных групп запрашивайте методом REST API [listInstances](../../instancegroup/api-ref/InstanceGroup/listInstances.md) или вызовом gRPC API [InstanceGroupService/ListInstances](../../instancegroup/api-ref/grpc/InstanceGroup/listInstances.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](delete.md)