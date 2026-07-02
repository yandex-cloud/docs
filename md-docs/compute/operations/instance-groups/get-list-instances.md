[Документация Yandex Cloud](../../../index.md) > [Yandex Compute Cloud](../../index.md) > [Пошаговые инструкции](../index.md) > Получение информации о группе виртуальных машин > Получить список ВМ в группе

# Получить список виртуальных машин в группе

После создания группы виртуальных машин вы можете получить список машин в группе.

Чтобы получить список виртуальных машин:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) откройте каталог, в котором находится нужная группа ВМ.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **Группы виртуальных машин**.
  1. Выберите нужную группу.
  1. Перейдите на вкладку **Виртуальные машины**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения списка виртуальных машин:

      ```
      yc compute instance-group list-instances --help
      ```

  1. Получите список групп виртуальных машин в каталоге по умолчанию:

      ```bash
      yc compute instance-group list
      ```
      
      Результат:
      
      ```text
      +----------------------+----------------------+--------+------+
      |          ID          |          NAME        | STATUS | SIZE |
      +----------------------+----------------------+--------+------+
      | cl15b3mrkk88******** | first-instance-group | ACTIVE |    3 |
      +----------------------+----------------------+--------+------+
      ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной группы, например `first-instance-group`.
  1. Получите информацию о группе виртуальных машин:

      ```
      yc compute instance-group list-instances --name first-instance-group
      ```

- API {#api}

  Воспользуйтесь методом REST API [listInstances](../../instancegroup/api-ref/InstanceGroup/listInstances.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/ListInstances](../../instancegroup/api-ref/grpc/InstanceGroup/listInstances.md).

{% endlist %}