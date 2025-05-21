# Посмотреть операции с ресурсами сервиса {{ cloud-desktop-name }}

Все действия с ресурсами сервиса {{ cloud-desktop-name }} сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

## Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Можно получить список операций для конкретного ресурса. Ниже показано, как это сделать для [рабочего стола](../concepts/desktops-and-groups.md). Для других ресурсов сервиса последовательность действий такая же.

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится рабочий стол.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/display.svg) **{{ ui-key.yacloud.vdi.label_desktops }}**.
  1. Выберите нужный рабочий стол.
  1. Перейдите на панель ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** для выбранного рабочего стола.

     В открывшемся списке отображаются операции с выбранным рабочим столом.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список операций для ресурса сервиса {{ cloud-desktop-name }}, воспользуйтесь командой:

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

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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

#### См. также {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)