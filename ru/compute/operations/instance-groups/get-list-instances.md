# Получить список виртуальных машин в группе

После создания группы виртуальных машин вы можете получить список машин в группе.

Чтобы получить список виртуальных машин:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится нужная группа ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
  1. Выберите нужную группу.
  1. Перейдите на вкладку **{{ ui-key.yacloud.compute.group.switch_instances }}**.

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения списка виртуальных машин:

      ```
      {{ yc-compute-ig }} list-instances --help
      ```

  1. Получите список групп виртуальных машин в каталоге по умолчанию:

      {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной группы, например `first-instance-group`.
  1. Получите информацию о группе виртуальных машин:

      ```
      {{ yc-compute-ig }} list-instances --name first-instance-group
      ```

- API {#api}

  Воспользуйтесь методом REST API [listInstances](../../instancegroup/api-ref/InstanceGroup/listInstances.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/ListInstances](../../instancegroup/api-ref/grpc/InstanceGroup/listInstances.md).

{% endlist %}
