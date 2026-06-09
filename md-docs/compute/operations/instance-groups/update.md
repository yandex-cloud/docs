# Изменить группу виртуальных машин

После создания группы виртуальных машин вы можете:

* [Изменить имя и описание](#change-name).
* [Изменить вычислительные ресурсы](#change-compute-resources).
* [Увеличить размер диска](#change-disk-size).

## Изменить имя и описание {#change-name}

Чтобы изменить имя и описание группы виртуальных машин:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится нужная группа ВМ.
  1. Перейдите в сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
  1. Выберите группу, которую хотите изменить.
  1. В правом верхнем углу страницы нажмите **{{ ui-key.yacloud.common.edit }}**.
  1. Заполните поля **{{ ui-key.yacloud.compute.groups.create.field_name }}** и **{{ ui-key.yacloud.compute.groups.create.field_description }}**.
  1. Нажмите **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения группы:

     ```bash
     {{ yc-compute-ig }} update --help
     ```

  1. Получите список групп виртуальных машин в каталоге по умолчанию:

      ```bash
      {{ yc-compute-ig }} list
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
  1. Укажите нужное имя и описание в YAML-файле, по которому создавалась группа, например `specification.yaml`. Если YAML-файл не сохранился, [получите информацию](get-info.md) о группе виртуальных машин и создайте новый. Подробнее читайте в разделе [{#T}](create-fixed-group.md).
  1. Обновите группу виртуальных машин в каталоге по умолчанию:

      ```bash
      {{ yc-compute-ig }} update --id <идентификатор_группы_ВМ> --file specification.yaml
      ```

     {{ ig-name }} запустит операцию изменения группы виртуальных машин.

- API {#api}

  Изменить имя и описание группы можно с помощью метода REST API [update](../../instancegroup/api-ref/InstanceGroup/update.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызова gRPC API [InstanceGroupService/Update](../../instancegroup/api-ref/grpc/InstanceGroup/update.md).

  Список доступных групп запрашивайте методом REST API [listInstances](../../instancegroup/api-ref/InstanceGroup/listInstances.md) или вызовом gRPC API [InstanceGroupService/ListInstances](../../instancegroup/api-ref/grpc/InstanceGroup/listInstances.md).

{% endlist %}

## Изменить вычислительные ресурсы {#change-compute-resources}

После создания группы виртуальных машин вы можете изменить:

* гарантированную долю vCPU;
* количество vCPU и объем RAM.

{% note warning %}

Если группа виртуальных машин останавливается или остановлена, изменения будут применены только после запуска группы.

{% endnote %}

Чтобы изменить вычислительные ресурсы группы виртуальных машин:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится нужная группа ВМ.
  1. Перейдите в сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
  1. Выберите группу, которую хотите изменить.
  1. В правом верхнем углу страницы нажмите **{{ ui-key.yacloud.common.edit }}**.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_instance }}**:
     * В правом верхнем углу нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**, чтобы удалить текущий шаблон ВМ.
     * Нажмите **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}**, чтобы создать новый шаблон с нужными параметрами ВМ.
     * Нажмите **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
  1. Нажмите **{{ ui-key.yacloud.common.save }}** на странице **{{ ui-key.yacloud.compute.group.edit.label_title }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения группы:

     ```bash
     {{ yc-compute-ig }} update --help
     ```

  1. Получите список групп виртуальных машин в каталоге по умолчанию:

      ```bash
      {{ yc-compute-ig }} list
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
  1. Укажите нужные параметры виртуальной машины в YAML-файле (ключ `resources_spec`), по которому создавалась группа, например `specification.yaml`. Если YAML-файл не сохранился, [получите информацию](get-info.md) о группе виртуальных машин и создайте новый. Подробнее читайте в разделе [{#T}](create-fixed-group.md).
  1. Обновите группу виртуальных машин в каталоге по умолчанию:

      ```bash
      {{ yc-compute-ig }} update --id <идентификатор_группы_ВМ> --file specification.yaml
      ```

     {{ ig-name }} запустит операцию изменения группы виртуальных машин.

- API {#api}

  Изменить вычислительные ресурсы можно с помощью метода REST API [update](../../instancegroup/api-ref/InstanceGroup/update.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызова gRPC API [InstanceGroupService/Update](../../instancegroup/api-ref/grpc/InstanceGroup/update.md).

  Список доступных групп запрашивайте методом REST API [listInstances](../../instancegroup/api-ref/InstanceGroup/listInstances.md) или вызовом gRPC API [InstanceGroupService/ListInstances](../../instancegroup/api-ref/grpc/InstanceGroup/listInstances.md).

{% endlist %}

## Увеличить размер диска {#change-disk-size}

{% note warning %}

Если группа виртуальных машин останавливается или остановлена, изменения будут применены только после запуска группы.

{% endnote %}

Чтобы увеличить размер диска группы виртуальных машин:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится нужная группа ВМ.
  1. Перейдите в сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
  1. Выберите группу, которую хотите изменить.
  1. В правом верхнем углу страницы нажмите **{{ ui-key.yacloud.common.edit }}**.
  1. В правом верхнем углу блока **{{ ui-key.yacloud.compute.groups.create.section_instance }}** нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** укажите нужный размер диска.
  1. Нажмите **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
  1. Нажмите **{{ ui-key.yacloud.common.save }}** на странице **{{ ui-key.yacloud.compute.group.edit.label_title }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения группы:

     ```bash
     {{ yc-compute-ig }} update --help
     ```

  1. Получите список групп виртуальных машин в каталоге по умолчанию:

      ```bash
      {{ yc-compute-ig }} list
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
  1. Укажите нужный размер хранилища в YAML-файле (ключ `boot_disk_spec`), по которому создавалась группа, например `specification.yaml`. Если YAML-файл не сохранился, [получите информацию](get-info.md) о группе виртуальных машин и создайте новый. Подробнее читайте в разделе [{#T}](create-fixed-group.md).
  1. Обновите группу виртуальных машин в каталоге по умолчанию:

      ```bash
      {{ yc-compute-ig }} update --id <идентификатор_группы_ВМ> --file specification.yaml
      ```

     {{ ig-name }} запустит операцию изменения группы виртуальных машин.

- API {#api}

  Изменить размер диска можно с помощью метода REST API [update](../../instancegroup/api-ref/InstanceGroup/update.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызова gRPC API [InstanceGroupService/Update](../../instancegroup/api-ref/grpc/InstanceGroup/update.md).

  Список доступных групп запрашивайте методом REST API [listInstances](../../instancegroup/api-ref/InstanceGroup/listInstances.md) или вызовом gRPC API [InstanceGroupService/ListInstances](../../instancegroup/api-ref/grpc/InstanceGroup/listInstances.md).

{% endlist %}