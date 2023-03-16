# Получить информацию о группе виртуальных машин

После создания группы виртуальных машин вы можете получить основную информацию о группе.

Пользовательские [метаданные](../../concepts/vm-metadata.md), которые были переданы при создании или изменении группы, можно получить только с помощью CLI или API.

Чтобы получить информацию о группе виртуальных машин:

{% list tabs %}

- Консоль управления

  1. Откройте страницу каталога в [консоли управления]({{ link-console-main }}).
  1. Выберите сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/vm-group-pic.svg) **Группы виртуальных машин**.
  1. Нажмите на имя нужной группы.

- CLI

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о группе виртуальных машин:

      ```
      {{ yc-compute-ig }} get --help
      ```

  1. Получите список групп виртуальных машин в каталоге по умолчанию:

      {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной группы, например `first-instance-group`.
  1. Получите информацию о группе виртуальных машин:

      ```
      {{ yc-compute-ig }} get --name first-instance-group
      ```

- API

  Воспользуйтесь методом REST API [get](../../api-ref/InstanceGroup/get.md) для ресурса [InstanceGroup](../../api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/Get](../../api-ref/grpc/instance_group_service.md#Get).

  Список доступных групп запрашивайте методом REST API [listInstances](../../api-ref/InstanceGroup/listInstances.md) или вызовом gRPC API [InstanceGroupService/ListInstances](../../api-ref/grpc/instance_group_service.md#ListInstances).


{% endlist %}
