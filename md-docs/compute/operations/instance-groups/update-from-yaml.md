# Изменить группу виртуальных машин по спецификации в формате YAML

Чтобы изменить [группу виртуальных машин](../../concepts/instance-groups/index.md) по [спецификации](../../concepts/instance-groups/specification.md) в формате YAML:

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Выполните следующую команду, указав имя или идентификатор группы ВМ и путь к файлу YAML-спецификации:
  
  ```bash
  yc compute instance-group update <имя_или_идентификатор_группы_ВМ> --file specification.yaml
  ```

  Подробнее о команде `yc compute instance-group update` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/instance-group/update.md).

- API {#api}

  Воспользуйтесь методом REST API [updateFromYaml](../../instancegroup/api-ref/InstanceGroup/updateFromYaml.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/UpdateFromYaml](../../instancegroup/api-ref/grpc/InstanceGroup/updateFromYaml.md).

  Список доступных групп запрашивайте методом REST API [listInstances](../../instancegroup/api-ref/InstanceGroup/listInstances.md) или вызовом gRPC API [InstanceGroupService/ListInstances](../../instancegroup/api-ref/grpc/InstanceGroup/listInstances.md).

{% endlist %}