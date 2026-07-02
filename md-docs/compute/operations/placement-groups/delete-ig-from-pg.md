[Документация Yandex Cloud](../../../index.md) > [Yandex Compute Cloud](../../index.md) > [Пошаговые инструкции](../index.md) > Группы размещения > Исключить группу виртуальных машин из группы размещения

# Исключить группу виртуальных машин из группы размещения

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения группы:

      ```bash
      yc compute instance-group update --help
      ```

  1. Получите список групп виртуальных машин в каталоге по умолчанию:

      ```bash
      yc compute instance-group list
      ```

      Результат:

      ```text
      yc compute instance-group list
      +----------------------+-----------------------+------+
      |          ID          |         NAME          | SIZE |
      +----------------------+-----------------------+------+
      | amc65sbgfqeq******** | first-instance-group  |    2 |
      +----------------------+-----------------------+------+
      ```

  1. Выберите идентификатор (`ID`) нужной группы.
  1. Удалите блок `placement_policy` из YAML-файла, по которому создавалась группа, например `specification.yaml`. Если YAML-файл не сохранился, [получите информацию](../instance-groups/get-info.md) о группе виртуальных машин и создайте новый. Подробнее читайте в разделе [Создать группу виртуальных машин фиксированного размера](../instance-groups/create-fixed-group.md).
  1. Обновите группу виртуальных машин в каталоге по умолчанию:

      ```bash
      yc compute instance-group update --id <идентификатор_группы_ВМ> --file specification.yaml
      ```

  Instance Groups запустит операцию удаления группы виртуальных машин из группы размещения.

- API {#api}

  Удалить группу ВМ из группы размещения можно с помощью метода REST API [update](../../instancegroup/api-ref/InstanceGroup/update.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызова gRPC API [InstanceGroupService/Update](../../instancegroup/api-ref/grpc/InstanceGroup/update.md).

  Список доступных групп запрашивайте методом REST API [listInstances](../../instancegroup/api-ref/InstanceGroup/listInstances.md) или вызовом gRPC API [InstanceGroupService/ListInstances](../../instancegroup/api-ref/grpc/InstanceGroup/listInstances.md).

{% endlist %}