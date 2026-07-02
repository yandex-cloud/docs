[Документация Yandex Cloud](../../../index.md) > [Yandex Compute Cloud](../../index.md) > [Пошаговые инструкции](../index.md) > Управление группой виртуальных машин > Запустить группу ВМ

# Запустить группу виртуальных машин

При запуске группы будут запущены все остановленные ВМ в группе. Вы можете запустить отдельную ВМ, например для диагностики, но для включения [автоматического восстановления](../../concepts/instance-groups/autohealing.md) и [масштабирования](../../concepts/instance-groups/scale.md), необходимо запустить группу целиком.

{% note warning %}

Если группа остановлена Yandex Cloud из-за блокировки за неуплату, снова запустить группу можно только после снятия блокировки.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) откройте каталог, в котором находится нужная группа ВМ.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **Группы виртуальных машин**.
  1. В строке с нужной группой ВМ нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите пункт **Запустить группу**.
  1. В открывшемся окне нажмите кнопку **Запустить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для запуска группы ВМ:

     ```bash
     yc compute instance-group start --help
     ```

  1. Получите список групп ВМ в каталоге по умолчанию:

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
  1. Запустите группу ВМ в каталоге по умолчанию:

     ```bash
     yc compute instance-group start first-instance-group
     ```

     Instance Groups начнет запускать ВМ в группе. Когда все ВМ будут запущены, группа перейдет в статус `ACTIVE`.

- API {#api}

  Запустить группу можно с помощью метода REST API [start](../../instancegroup/api-ref/InstanceGroup/start.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызова gRPC API [InstanceGroupService/Start](../../instancegroup/api-ref/grpc/InstanceGroup/start.md).

  Список доступных групп запрашивайте методом REST API [listInstances](../../instancegroup/api-ref/InstanceGroup/listInstances.md) или вызовом gRPC API [InstanceGroupService/ListInstances](../../instancegroup/api-ref/grpc/InstanceGroup/listInstances.md).

{% endlist %}