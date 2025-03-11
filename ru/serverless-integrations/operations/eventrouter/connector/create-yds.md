---
title: Как создать коннектор для {{ yds-name }}
description: Следуя данной инструкции, вы сможете создать коннектор для {{ yds-full-name }}.
---

# Создать коннектор для {{ yds-name }}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать [коннектор](../../../concepts/eventrouter/connector.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Выберите нужную [шину](../../../concepts/eventrouter/bus.md).
  1. Перейдите на вкладку ![image](../../../../_assets/console-icons/broadcast-signal.svg) **{{ ui-key.yacloud.serverless-event-router.label_connectors }}**.
  1. В правом верхнем углу нажмите **{{ ui-key.yacloud.serverless-event-router.button_create-connector }}**.
  1. В поле **{{ ui-key.yacloud.serverless-event-router.label_connector-source }}** выберите `{{ yds-full-name }}`.
  1. В блоке **Настройки {{ yds-name }}**:

      * Выберите [поток данных](../../../../data-streams/concepts/glossary.md#stream-concepts) и [выделенного потребителя данных](../../../../data-streams/concepts/glossary.md#consumers).
      * Выберите [сервисный аккаунт](../../../../iam/concepts/users/service-accounts.md), у которого есть права на чтение из потока данных.

  1. {% include [connector-create-additional-params](../../../../_includes/serverless-integrations/connector-create-additional-params.md) %}
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания [коннектора](../../../concepts/eventrouter/connector.md):

      ```bash
      yc serverless eventrouter connector create data-stream --help
      ```

  1. Создайте коннектор для {{ yds-name }}:

      ```bash
      yc serverless eventrouter connector create data-stream \
        --bus-id <идентификатор_шины> \
        --database <путь_к_БД>
        --stream-name <имя_потока>
        --consumer <имя_потребителя>
        --service-account-id <идентификатор_сервисного_аккаунта> \
        --name <имя_коннектора> \
        --description "<описание_коннектора>" \
        --labels <список_меток> \
        --deletion-protection
      ```

      Где:

      * `--bus-id` — идентификатор [шины](../../../concepts/eventrouter/bus.md) {{ er-name }}.
      * `--database` — [путь](../../../../ydb/operations/connection.md#endpoint-and-path) к [базе данных](../../../../ydb/concepts/resources.md#database) {{ ydb-full-name }}, указанной в настройках [потока данных](../../../../data-streams/concepts/glossary.md#stream-concepts), например `/{{ region-id }}/b1gia87mbaom********/etnudu2n9ri3********`.
      * `--stream-name` — имя потока данных.
      * `--consumer` — имя [выделенного потребителя данных](../../../../data-streams/concepts/glossary.md#consumers).
      * `--service-account-id` — идентификатор [сервисного аккаунта](../../../../iam/concepts/users/service-accounts.md), у которого есть права на чтение из потока данных.
      * `--name` — имя коннектора. Требования к имени:

          {% include [name-format-2](../../../../_includes/name-format-2.md) %}

      * `--description` — описание коннектора. Необязательный параметр.
      * `--labels` — список меток. Необязательный параметр.

          Можно указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.

      * `--deletion-protection` — защита от удаления коннектора. По умолчанию защита выключена. Пока опция включена, удалить коннектор невозможно. Чтобы отключить защиту от удаления, укажите параметр `--no-deletion-protection`. Необязательный параметр.

      Результат:

      ```text
      id: f66g6jcnc5no********
      bus_id: f66qn4p7uk6p********
      folder_id: b1g681qpemb4********
      cloud_id: b1gia87mbaom********
      created_at: "2025-02-21T10:53:25.994124Z"
      name: yds-via-cli
      description: created via cli
      labels:
        interface: yccli
        owner: admin
      source:
        data_stream:
          database: /{{ region-id }}/b1gia87mbaom********/etntd0p5tauu********
          stream_name: my-ydb-flow
          consumer: consumer-one
          service_account_id: ajelprpohp7r********
      deletion_protection: true
      status: RUNNING
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  Чтобы создать [коннектор](../../../concepts/eventrouter/connector.md) для {{ yds-name }}:

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_serverless_eventrouter_connector" "example_connector" {
        bus_id              = "<идентификатор_шины>"
        name                = "<имя_коннектора>"
        description         = "<описание_коннектора>"
        deletion_protection = <true|false>

        labels = {
          <ключ_1> = "<значение_1>"
          <ключ_2> = "<значение_2>"
          ...
          <ключ_n> = "<значение_n>"
        }

        ymq {
          database           = "<путь_к_БД>"
          stream_name        = "<имя_потока>"
          consumer           = "<имя_потребителя>"
          service_account_id = "<идентификатор_сервисного_аккаунта>"
        }
      }
      ```

      Где:

      * `bus_id` — идентификатор [шины](../../../concepts/eventrouter/bus.md) {{ er-name }}.
      * `name` — имя коннектора. Требования к имени:

          {% include [name-format-2](../../../../_includes/name-format-2.md) %}

      * `description` — описание коннектора. Необязательный параметр.
      * `deletion_protection` — защита от удаления коннектора: `true` или `false`. Пока опция включена, удалить коннектор невозможно. Необязательный параметр.
      * `labels` — список меток. Метки задаются в формате `<ключ> = "<значение>"`. Необязательный параметр.
      * `database` — [путь](../../../../ydb/operations/connection.md#endpoint-and-path) к [базе данных](../../../../ydb/concepts/resources.md#database) {{ ydb-full-name }}, указанной в настройках [потока данных](../../../../data-streams/concepts/glossary.md#stream-concepts), например `/{{ region-id }}/b1gia87mbaom********/etnudu2n9ri3********`.
      * `stream_name` — имя потока данных.
      * `consumer` — имя [выделенного потребителя данных](../../../../data-streams/concepts/glossary.md#consumers).
      * `service_account_id` — идентификатор [сервисного аккаунта](../../../../iam/concepts/users/service-accounts.md), у которого есть права на чтение из потока данных.

      Более подробную информацию о параметрах ресурса `yandex_serverless_eventrouter_connector` см. в [документации провайдера]({{ tf-provider-resources-link }}/serverless_eventrouter_connector).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../../cli/):

      ```bash
      yc serverless eventrouter connector list
      ```

- API {#api}

  Чтобы создать [коннектор](../../../concepts/eventrouter/connector.md) для {{ yds-name }}, воспользуйтесь методом REST API [Create](../../../../serverless-integrations/eventrouter/api-ref/Connector/create.md) для ресурса [connector](../../../../serverless-integrations/eventrouter/api-ref/Connector/index.md) или вызовом gRPC API [connector/Create](../../../../serverless-integrations/eventrouter/api-ref/grpc/Connector/create.md).

{% endlist %}

{% include [connector-created-running](../../../../_includes/serverless-integrations/connector-created-running.md) %}