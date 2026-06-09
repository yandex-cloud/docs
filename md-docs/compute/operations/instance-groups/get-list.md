# Получить список групп виртуальных машин

Чтобы получить список групп виртуальных машин:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится нужная группа ВМ.
  1. Перейдите в сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для работы с группой виртуальных машин:

      ```bash
      {{ yc-compute-ig }} --help
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

- API {#api}

  Воспользуйтесь методом REST API [list](../../instancegroup/api-ref/InstanceGroup/list.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/List](../../instancegroup/api-ref/grpc/InstanceGroup/list.md).

  Список доступных групп запрашивайте методом REST API [listInstances](../../instancegroup/api-ref/InstanceGroup/listInstances.md) или вызовом gRPC API [InstanceGroupService/ListInstances](../../instancegroup/api-ref/grpc/InstanceGroup/listInstances.md).

{% endlist %}