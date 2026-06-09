# Создать рабочий стол

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором будет создан [рабочий стол](../../concepts/desktops-and-groups.md).
  1. Перейдите в сервис **Cloud Desktop**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/display.svg) **Рабочие столы**.
  1. Нажмите кнопку **Создать рабочий стол**.
  1. Выберите группу рабочих столов, в которой будет создан рабочий стол.
  1. Укажите подсеть, в которой будет размещен рабочий стол.

      {% note info %}

      Чтобы рабочий стол имел доступ в интернет, в подсети должен быть [настроен NAT-шлюз](../../../vpc/operations/create-nat-gateway.md).

      {% endnote %}

  1. Укажите пользователя, для которого создается рабочий стол.
  1. Нажмите кнопку **Создать**.

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. Посмотрите описание команды [CLI](../../../cli/index.md) для создания [рабочего стола](../../concepts/desktops-and-groups.md):

      ```bash
      yc desktops desktop create --help
      ```

  1. Выберите [группу рабочих столов](../../concepts/desktops-and-groups.md):

      ```bash
      yc desktops group list
      ```
      
      Результат:
      
      ```text
      +----------------------+------------------+--------+---------------------+
      |          ID          |       NAME       | STATUS |   CREATED (UTC-0)   |
      +----------------------+------------------+--------+---------------------+
      | e3v1rbln45tl******** | my-desktop-group | ACTIVE | 2024-10-09 20:12:00 |
      | e3v7ikg3d4ga******** | ubuntu-group     | ACTIVE | 2024-10-09 19:34:10 |
      | e3v80f10pc01******** | kosmos-group     | ACTIVE | 2024-10-09 18:58:17 |
      +----------------------+------------------+--------+---------------------+
      ```

  1. Создайте рабочий стол:

      ```bash
      yc desktops desktop create \
        --desktop-group-id <идентификатор_группы_рабочих_столов> \
        --user-account-id <идентификатор_пользователя>
      ```

      Где:

      * `--desktop-group-id` — идентификатор группы рабочих столов.
      * `--user-account-id` — идентификатор пользователя, для которого создается рабочий стол.

      Результат:
      
      ```text
      id: e3vmvhgbgac4********
      folder_id: b1g681qpemb4********
      desktop_group_id: e3v1rbln45tl********
      created_at: "2024-10-09T22:42:28.020Z"
      name: cli-desktop-5-6aa9b029038119b1
      resources:
        memory: "4294967296"
        cores: "2"
        core_fraction: "100"
      network_interfaces:
        - network_id: enp0asmd9pr9********
          subnet_id: e2lb1da2dd9v********
      users:
        - subject_id: aje9k8luj4qf********
      ```

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/Desktop/create.md) для ресурса [Desktop](../../api-ref/Desktop/index.md) или вызовом gRPC API [DesktopService/Create](../../api-ref/grpc/Desktop/create.md).

{% endlist %}

Рабочий стол появится в списке, после этого вы можете к нему [подключиться](connect.md).