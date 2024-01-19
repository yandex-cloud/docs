# Исключить группу виртуальных машин из группы размещения

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения группы:

      ```
      {{ yc-compute-ig }} update --help
      ```

  1. Получите список групп виртуальных машин в каталоге по умолчанию:

      ```bash
      yc compute instance-group list
      ```

      Результат:

      ```bash
      {{ yc-compute-ig }} list
      +----------------------+-----------------------+------+
      |          ID          |         NAME          | SIZE |
      +----------------------+-----------------------+------+
      | amc65sbgfqeq******** | first-instance-group  |    2 |
      +----------------------+-----------------------+------+
      ```

  1. Выберите идентификатор (`ID`) нужной группы.
  1. Удалите блок `placement_policy` из YAML-файла, по которому создавалась группа, например `specification.yaml`. Если YAML-файл не сохранился, [получите информацию](../instance-groups/get-info.md) о группе виртуальных машин и создайте новый. Подробнее читайте в разделе [{#T}](../instance-groups/create-fixed-group.md).
  1. Обновите группу виртуальных машин в каталоге по умолчанию:

      ```
      {{ yc-compute-ig }} update --id <идентификатор_группы_ВМ> --file specification.yaml
      ```

  {{ ig-name }} запустит операцию удаления группы виртуальных машин из группы размещения.

- API {#api}

  Удалить группу ВМ из группы размещения можно с помощью метода REST API [update](../../api-ref/InstanceGroup/update.md) для ресурса [InstanceGroup](../../api-ref/InstanceGroup/index.md) или вызова gRPC API [InstanceGroupService/Update](../../api-ref/grpc/instance_group_service.md#Update).

  Список доступных групп запрашивайте методом REST API [listInstances](../../api-ref/InstanceGroup/listInstances.md) или вызовом gRPC API [InstanceGroupService/ListInstances](../../api-ref/grpc/instance_group_service.md#ListInstances).

{% endlist %}
