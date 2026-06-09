# Создать группу виртуальных машин по спецификации в формате YAML

Все операции в Instance Groups выполняются от имени сервисного аккаунта. Если сервисного аккаунта нет, [создайте его](../../../iam/operations/sa/create.md).

Чтобы иметь возможность создавать, обновлять и удалять ВМ в группе [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роль [compute.editor](../../security/index.md#compute-editor).

Если вы хотите интегрировать группу ВМ с сетевым балансировщиком [Yandex Network Load Balancer](../../../network-load-balancer/index.md), дополнительно назначьте сервисному аккаунту роль [load-balancer.editor](../../../network-load-balancer/security/index.md#load-balancer-editor).

Чтобы интегрировать группу ВМ с L7-балансировщиком [Yandex Application Load Balancer](../../../application-load-balancer/index.md), назначьте сервисному аккаунту роль [alb.editor](../../../application-load-balancer/security/index.md#alb-editor).

Чтобы создать [группу виртуальных машин](../../concepts/instance-groups/index.md) по [спецификации](../../concepts/instance-groups/specification.md) в формате YAML:

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Выполните следующую команду:

  ```bash
  yc compute instance-group create --file specification.yaml
  ```

  Подробнее о команде `yc compute instance-group create` см. в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/instance-group/create.md).

- API {#api}

  Используйте вызов [InstanceGroupService/CreateFromYaml](../../instancegroup/api-ref/grpc/InstanceGroup/createFromYaml.md) gRPC API или метод [createFromYaml](../../instancegroup/api-ref/InstanceGroup/createFromYaml.md) ресурса `InstanceGroup` REST API.

{% endlist %}