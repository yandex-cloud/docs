# Изменить группу виртуальных машин

После создания группы виртуальных машин вы можете:

* [Изменить имя и описание](#change-name).
* [Изменить вычислительные ресурсы](#change-compute-resources).
* [Увеличить размер диска](#change-disk-size).

## Изменить имя и описание {#change-name}

Чтобы изменить имя и описание группы виртуальных машин:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится нужная группа ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/vm-group-pic.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. Выберите группу, которую хотите изменить.
  1. В правом верхнем углу страницы нажмите **{{ ui-key.yacloud.compute.groups.button_action-edit }}**.
  1. Заполните поля **{{ ui-key.yacloud.compute.groups.create.field_name }}** и **{{ ui-key.yacloud.compute.groups.create.field_description }}**.
  1. Нажмите **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.

- CLI

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения группы:

     ```
     {{ yc-compute-ig }} update --help
     ```

  1. Получите список групп виртуальных машин в каталоге по умолчанию:

      {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

  1. Выберите идентификатор (`ID`) нужной группы.
  1. Укажите нужное имя и описание в YAML-файле, по которому создавалась группа, например `specification.yaml`. Если YAML-файл не сохранился, [получите информацию](get-info.md) о группе виртуальных машин и создайте новый. Подробнее читайте в разделе [{#T}](create-fixed-group.md).
  1. Обновите группу виртуальных машин в каталоге по умолчанию:

      ```
      {{ yc-compute-ig }} update --id <ID_группы_ВМ> --file specification.yaml
      ```

     {{ ig-name }} запустит операцию изменения группы виртуальных машин.

- API

  Изменить имя и описание группы можно с помощью метода REST API [update](../../api-ref/InstanceGroup/update.md) для ресурса [InstanceGroup](../../api-ref/InstanceGroup/index.md) или вызова gRPC API [InstanceGroupService/Update](../../api-ref/grpc/instance_group_service.md#Update).

  Список доступных групп запрашивайте методом REST API [listInstances](../../api-ref/InstanceGroup/listInstances.md) или вызовом gRPC API [InstanceGroupService/ListInstances](../../api-ref/grpc/instance_group_service.md#ListInstances).

{% endlist %}

## Изменить вычислительные ресурсы {#change-compute-resources}

После создания группы виртуальных машин вы можете изменить:

* гарантированную долю vCPU;
* количество vCPU и объем RAM.

{% include [include](../../../_includes/instance-groups/update-stopped-group-disclaimer.md) %}

Чтобы изменить вычислительные ресурсы группы виртуальных машин:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится нужная группа ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/vm-group-pic.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. Выберите группу, которую хотите изменить.
  1. В правом верхнем углу страницы нажмите **{{ ui-key.yacloud.compute.groups.button_action-edit }}**.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_instance }}**:
     * В правом верхнем углу нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**, чтобы удалить текущий шаблон ВМ.
     * Нажмите **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}**, чтобы создать новый шаблон с нужными параметрами ВМ.
     * Нажмите **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
  1. Нажмите **{{ ui-key.yacloud.common.save }}** на странице **{{ ui-key.yacloud.compute.group.edit.label_title }}**.

- CLI

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения группы:

     ```
     {{ yc-compute-ig }} update --help
     ```

  1. Получите список групп виртуальных машин в каталоге по умолчанию:

      {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

  1. Выберите идентификатор (`ID`) нужной группы.
  1. Укажите нужные параметры виртуальной машины в YAML-файле (ключ `resources_spec`), по которому создавалась группа, например `specification.yaml`. Если YAML-файл не сохранился, [получите информацию](get-info.md) о группе виртуальных машин и создайте новый. Подробнее читайте в разделе [{#T}](create-fixed-group.md).
  1. Обновите группу виртуальных машин в каталоге по умолчанию:

      ```
      {{ yc-compute-ig }} update --id <ID_группы_ВМ> --file specification.yaml
      ```

     {{ ig-name }} запустит операцию изменения группы виртуальных машин.

- API

  Изменить вычислительные ресурсы можно с помощью метода REST API [update](../../api-ref/InstanceGroup/update.md) для ресурса [InstanceGroup](../../api-ref/InstanceGroup/index.md) или вызова gRPC API [InstanceGroupService/Update](../../api-ref/grpc/instance_group_service.md#Update).

  Список доступных групп запрашивайте методом REST API [listInstances](../../api-ref/InstanceGroup/listInstances.md) или вызовом gRPC API [InstanceGroupService/ListInstances](../../api-ref/grpc/instance_group_service.md#ListInstances).

{% endlist %}

## Увеличить размер диска {#change-disk-size}

{% include [include](../../../_includes/instance-groups/update-stopped-group-disclaimer.md) %}

Чтобы увеличить размер диска группы виртуальных машин:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится нужная группа ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/vm-group-pic.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. Выберите группу, которую хотите изменить.
  1. В правом верхнем углу страницы нажмите **{{ ui-key.yacloud.compute.groups.button_action-edit }}**.
  1. В правом верхнем углу блока **{{ ui-key.yacloud.compute.groups.create.section_instance }}** нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_disk }}** укажите нужный размер диска.
  1. Нажмите **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
  1. Нажмите **{{ ui-key.yacloud.common.save }}** на странице **{{ ui-key.yacloud.compute.group.edit.label_title }}**.

- CLI

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения группы:

     ```
     {{ yc-compute-ig }} update --help
     ```

  1. Получите список групп виртуальных машин в каталоге по умолчанию:

      {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

  1. Выберите идентификатор (`ID`) нужной группы.
  1. Укажите нужный размер хранилища в YAML-файле (ключ `boot_disk_spec`), по которому создавалась группа, например `specification.yaml`. Если YAML-файл не сохранился, [получите информацию](get-info.md) о группе виртуальных машин и создайте новый. Подробнее читайте в разделе [{#T}](create-fixed-group.md).
  1. Обновите группу виртуальных машин в каталоге по умолчанию:

      ```
      {{ yc-compute-ig }} update --id <ID_группы_ВМ> --file specification.yaml
      ```

     {{ ig-name }} запустит операцию изменения группы виртуальных машин.

- API

  Изменить размер диска можно с помощью метода REST API [update](../../api-ref/InstanceGroup/update.md) для ресурса [InstanceGroup](../../api-ref/InstanceGroup/index.md) или вызова gRPC API [InstanceGroupService/Update](../../api-ref/grpc/instance_group_service.md#Update).

  Список доступных групп запрашивайте методом REST API [listInstances](../../api-ref/InstanceGroup/listInstances.md) или вызовом gRPC API [InstanceGroupService/ListInstances](../../api-ref/grpc/instance_group_service.md#ListInstances).

{% endlist %}

