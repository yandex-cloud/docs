# Включить защиту от удаления для группы виртуальных машин Compute Cloud

Защита от удаления предотвращает случайное удаление [группы виртуальных машин](../../concepts/instance-groups/index.md) (ВМ). Пока опция включена, группу ВМ удалить невозможно. Чтобы удалить группу с включенной защитой, сначала необходимо отключить защиту.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) откройте каталог, в котором находится нужная группа ВМ.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **Группы виртуальных машин**.
  1. Выберите группу, для которой хотите включить защиту от удаления.
  1. В правом верхнем углу страницы нажмите **Редактировать**.
  1. Включите опцию **Защита от удаления**.
  1. Нажмите **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения группы ВМ:

     ```bash
     yc compute instance-group update --help
     ```

  1. Получите список групп ВМ в каталоге по умолчанию:

     ```bash
     yc compute instance-group list
     ```
     
     Результат:
     
     ```text
     +----------------------+----------------------+--------+------+
     |          ID          |          NAME        | STATUS | SIZE |
     +----------------------+----------------------+--------+------+
     | cl15b3mrkk88******** | first-instance-group | ACTIVE |    3 |
     +----------------------+----------------------+--------+------+
     ```

  1. Выберите идентификатор (`ID`) нужной группы.
  1. Укажите в YAML-файле, по которому создавалась группа, параметр `deletion_protection: true`. Если YAML-файл не сохранился, [получите информацию](get-info.md) о группе виртуальных машин и создайте новый, например `specification.yaml`. Подробнее читайте в разделе [Создать группу виртуальных машин фиксированного размера](create-fixed-group.md).
  1. Обновите группу виртуальных машин в каталоге по умолчанию:

      ```bash
      yc compute instance-group update \
        --id <идентификатор_группы_ВМ> \
        --file specification.yaml
      ```

     Instance Groups запустит операцию изменения группы виртуальных машин.

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

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Откройте файл конфигурации Terraform и добавьте параметр `deletion_protection` в описание группы ВМ:

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

     Более подробную информацию о параметрах ресурса `yandex_compute_instance_group` в Terraform см. в [документации провайдера](../../../terraform/resources/compute_instance_group.md).

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

  1. Проверьте изменение группы ВМ в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/index.md):

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

  1. В [консоли управления](https://console.yandex.cloud) откройте каталог, в котором находится нужная группа ВМ.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **Группы виртуальных машин**.
  1. Выберите группу, для которой хотите отключить защиту от удаления.
  1. В правом верхнем углу страницы нажмите **Редактировать**.
  1. Отключите опцию **Защита от удаления**.
  1. Нажмите **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения группы ВМ:

     ```bash
     yc compute instance-group update --help
     ```

  1. Получите список групп ВМ в каталоге по умолчанию:

     ```bash
     yc compute instance-group list
     ```
     
     Результат:
     
     ```text
     +----------------------+----------------------+--------+------+
     |          ID          |          NAME        | STATUS | SIZE |
     +----------------------+----------------------+--------+------+
     | cl15b3mrkk88******** | first-instance-group | ACTIVE |    3 |
     +----------------------+----------------------+--------+------+
     ```

  1. Выберите идентификатор (`ID`) нужной группы.
  1. Укажите в YAML-файле, по которому создавалась группа, параметр `deletion_protection: false`. Если YAML-файл не сохранился, [получите информацию](get-info.md) о группе виртуальных машин и создайте новый, например `specification.yaml`. Подробнее читайте в разделе [Создать группу виртуальных машин фиксированного размера](create-fixed-group.md).
  1. Отключите защиту от удаления:

     ```bash
      yc compute instance-group update \
        --id <идентификатор_группы_ВМ> \
        --file specification.yaml
     ```

     Instance Groups запустит операцию изменения группы ВМ.

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Откройте файл конфигурации Terraform и измените значение параметра `deletion_protection` на `false` в описании группы ВМ:

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

     Более подробную информацию о параметрах ресурса `yandex_compute_instance_group` в Terraform см. в [документации провайдера](../../../terraform/resources/compute_instance_group.md).

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

  1. Проверьте изменение группы ВМ в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/index.md):

     ```bash
     yc compute instance-group get <имя_группы_ВМ>
     ```

- API {#api}

  Воспользуйтесь методом REST API [update](../../instancegroup/api-ref/InstanceGroup/update.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/Update](../../instancegroup/api-ref/grpc/InstanceGroup/update.md).

  Список доступных групп запрашивайте методом REST API [listInstances](../../instancegroup/api-ref/InstanceGroup/listInstances.md) или вызовом gRPC API [InstanceGroupService/ListInstances](../../instancegroup/api-ref/grpc/InstanceGroup/listInstances.md).

{% endlist %}

#### См. также {#see-also}

* [Удалить группу виртуальных машин](delete.md)