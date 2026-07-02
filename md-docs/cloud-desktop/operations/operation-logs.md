[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Desktop](../index.md) > [Пошаговые инструкции](index.md) > Посмотреть операции с ресурсами сервиса

# Посмотреть операции с ресурсами сервиса Cloud Desktop

Все действия с ресурсами сервиса Cloud Desktop сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

## Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Можно получить список операций для конкретного ресурса. Ниже показано, как это сделать для [рабочего стола](../concepts/desktops-and-groups.md). Для других ресурсов сервиса последовательность действий такая же.

  1. В [консоли управления](https://console.yandex.cloud) откройте каталог, в котором находится рабочий стол.
  1. Перейдите в сервис **Cloud Desktop**.
  1. На панели слева выберите ![image](../../_assets/console-icons/display.svg) **Рабочие столы**.
  1. Выберите нужный рабочий стол.
  1. Перейдите на панель ![image](../../_assets/console-icons/list-check.svg) **Операции** для выбранного рабочего стола.

     В открывшемся списке отображаются операции с выбранным рабочим столом.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список операций для ресурса сервиса Cloud Desktop, воспользуйтесь командой:

  ```bash
  yc desktops <тип_ресурса> list-operations <имя_или_идентификатор_ресурса>
  ```

  **Пример**

  Получить список операций для рабочего стола:

  ```bash
  yc desktops desktop list-operations e3v7nfkhn0q4********
  ```

  Результат:

  ```text
  +----------------------+---------------------+----------------------+---------------------+---------+-----------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS  |   DESCRIPTION   |
  +----------------------+---------------------+----------------------+---------------------+---------+-----------------+
  | e3vlaf6r4241******** | 2024-05-14 17:55:00 | aje9k8luj4qf******** | 2024-05-14 17:55:00 | RUNNING | Restart desktop |
  | e3vns4mmfsal******** | 2024-05-14 17:41:14 | aje9k8luj4qf******** | 2024-05-14 17:45:17 | DONE    | Create desktop  |
  +----------------------+---------------------+----------------------+---------------------+---------+-----------------+
  ```

  По умолчанию информация об операциях выводится в текстовом формате. Чтобы получить более подробную информацию, укажите формат `yaml` или `json` для выводимых данных с помощью параметра `--format`:

  ```bash
  yc desktops desktop list-operations e3v7nfkhn0q4******** --format yaml
  ```

  Результат:

  ```text
  - id: e3vlaf6r4241********
    description: Restart desktop
    created_at: "2024-05-14T17:55:00.742136402Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-05-14T17:55:00.742136402Z"
    metadata:
      '@type': type.googleapis.com/yandex.cloud.clouddesktop.v1.api.RestartDesktopMetadata
      desktop_id: e3v7nfkhn0q4********
  - id: e3vns4mmfsal********
    description: Create desktop
    created_at: "2024-05-14T17:41:14.076Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-05-14T17:45:17.355765714Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.clouddesktop.v1.api.CreateDesktopMetadata
      desktop_id: e3v7nfkhn0q4********
  ```

- API {#api}

  Воспользуйтесь методом REST API [listOperations](../api-ref/Desktop/listOperations.md) для ресурса [Desktop](../api-ref/Desktop/index.md) или вызовом gRPC API [DesktopService/ListOperations](../api-ref/grpc/Desktop/listOperations.md).

{% endlist %}

## Получить подробную информацию об операции {#get-operations-info}

1. [Получите список операций](#get-operations) для ресурса.
1. Скопируйте идентификатор нужной операции.
1. Получите подробную информацию об операции:

    {% list tabs group=instructions %}

    - CLI {#cli}

      Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      Выполните команду:

      ```bash
      yc operation get <идентификатор_операции>
      ```

      Результат:

      ```text
      id: e3vlaf6r4241********
      description: Restart desktop
      created_at: "2024-05-14T17:55:00.742Z"
      created_by: aje9k8luj4qf********
      modified_at: "2024-05-14T17:57:47.065Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.clouddesktop.v1.api.RestartDesktopMetadata
        desktop_id: e3v7nfkhn0q4********
      response:
        '@type': type.googleapis.com/yandex.cloud.clouddesktop.v1.api.Desktop
        id: e3v7nfkhn0q4********
        folder_id: b1g681qpemb4********
        desktop_group_id: e3vud47oonha********
        created_at: "2024-05-14T17:41:14.076Z"
        name: my-desktop-group-1fb68746********
        resources:
          memory: "2147483648"
          cores: "2"
          core_fraction: "100"
        network_interfaces:
          - network_id: enpphqi8uvcm********
            subnet_id: e9bmuh93af4v********
        users:
          - subject_id: aje9k8luj4qf********
      ```

    {% endlist %}

#### Полезные ссылки {#see-also}

[Работа с операциями](../../api-design-guide/concepts/about-async.md)