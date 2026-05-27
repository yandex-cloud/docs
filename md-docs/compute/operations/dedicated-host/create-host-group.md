# Создание группы выделенных хостов


Вы можете создать группу [выделенных хостов](../../concepts/dedicated-host.md), предназначенных для размещения исключительно ваших виртуальных машин в Yandex Cloud.

По умолчанию в облаке установлена [нулевая квота](../../concepts/limits.md#compute-quotas) на использование выделенных хостов. Чтобы изменить [квоту](https://console.yandex.cloud/cloud?section=quotas), обратитесь в [техническую поддержку](https://center.yandex.cloud/support).

Чтобы создать группу выделенных хостов:

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите список возможных [типов](../../concepts/dedicated-host.md#host-types) выделенных хостов:

      ```bash
      yc compute host-type list
      ```

      Результат:

      ```bash
      +------------------------------+-------+--------------+-------+---------------+
      |              ID              | CORES |    MEMORY    | DISKS |   DISK SIZE   |
      +------------------------------+-------+--------------+-------+---------------+
      ...
      | intel-6338-c108-m704-n3200x6 |   108 | 755914244096 |     6 | 3198924357632 |
      +------------------------------+-------+--------------+-------+---------------+
      ```

  1. Создайте группу выделенных хостов выбранного типа. В группе может быть один или несколько хостов.

      ```bash
      yc compute host-group create \
        --fixed-size <количество_выделенных_хостов_в_группе> \
        --type <тип_выделенных_хостов> \
        --zone <зона_доступности>
      ```

      Где:

      * `--fixed-size` — количество выделенных хостов в группе.
      * `--type` — тип выделенных хостов.
      * `--zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой будет размещена группа.

      Результат:

      ```text
      done (6s)
      id: abcdefg1hi23********
      folder_id: m4n56op78mev********
      created_at: "2020-10-13T07:36:49Z"
      zone_id: ru-central1-a
      status: READY
      type_id: intel-6230-c66-m454
      maintenance_policy: RESTART
      scale_policy:
        fixed_scale:
          size: "2"
      ```

- API {#api}

  1. Выберите тип хоста с помощью метода REST API [list](../../api-ref/HostType/list.md) для ресурса [HostType](../../api-ref/HostType/index.md) или вызова gRPC API [HostTypeService/List](../../api-ref/grpc/HostType/list.md).
  1. Создайте группу выделенных хостов с помощью метода REST API [create](../../api-ref/HostGroup/create.md) для ресурса [HostGroup](../../api-ref/HostGroup/index.md) или вызова gRPC API [HostGroupService/Create](../../api-ref/grpc/HostGroup/create.md).

{% endlist %}

#### См. также {#see-also}

* [Создание виртуальной машины в группе выделенных хостов](running-host-group-vms.md)
* [Создание виртуальной машины на выделенном хосте](running-host-vms.md)