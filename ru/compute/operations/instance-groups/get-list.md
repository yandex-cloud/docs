# Получить список групп виртуальных машин

Чтобы получить список групп виртуальных машин:

{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится нужная группа ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/vm-group-pic.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  
- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для работы с группой виртуальных машин:
  
      ```
      {{ yc-compute-ig }} --help
      ```
  
  1. Получите список групп виртуальных машин в каталоге по умолчанию:
  
      {% include [instance-group-list](../../../_includes/instance-groups/instance-group-list.md) %}
  
- API

  Воспользуйтесь методом REST API [list](../../api-ref/InstanceGroup/list.md) для ресурса [InstanceGroup](../../api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/List](../../api-ref/grpc/instance_group_service.md#List).

  Список доступных групп запрашивайте методом REST API [listInstances](../../api-ref/InstanceGroup/listInstances.md) или вызовом gRPC API [InstanceGroupService/ListInstances](../../api-ref/grpc/instance_group_service.md#ListInstances).

{% endlist %}
