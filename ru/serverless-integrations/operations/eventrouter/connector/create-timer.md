---
title: Как создать таймер в {{ er-name }}
description: Следуя данной инструкции, вы сможете создать таймер в {{ er-name }}.
---

# Создать таймер

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать [коннектор](../../../concepts/eventrouter/connector.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Выберите нужную [шину](../../../concepts/eventrouter/bus.md).
  1. Перейдите на вкладку ![image](../../../../_assets/console-icons/broadcast-signal.svg) **{{ ui-key.yacloud.serverless-event-router.label_connectors }}**.
  1. В правом верхнем углу нажмите **{{ ui-key.yacloud.serverless-event-router.button_create-connector }}**.
  1. В поле **{{ ui-key.yacloud.serverless-event-router.label_connector-source }}** выберите `{{ ui-key.yc-eventrouter.dynamic-forms.timer_name }}`.
  1. В блоке **{{ ui-key.yc-eventrouter.dynamic-forms.template_connector_timer_base_options_title }}** укажите:

      * в поле **{{ ui-key.yc-eventrouter.dynamic-forms.template_connector_timer_cron_expression_title }}** — расписание генерации событий в формате [cron-выражения](../../../concepts/eventrouter/connector.md#cron-expression).
      * (Опционально) в поле **{{ ui-key.yc-eventrouter.dynamic-forms.template_connector_timer_timezone_title }}** — часовой пояс в формате [tz database](https://ru.wikipedia.org/wiki/Tz_database).
      * (Опционально) в поле **{{ ui-key.yc-eventrouter.dynamic-forms.template_connector_timer_payload_title }}** — сообщение, которое будет передаваться в шину при срабатывании таймера в поле `payload`.

  1. {% include [connector-create-additional-params](../../../../_includes/serverless-integrations/connector-create-additional-params.md) %}
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания [коннектора](../../../concepts/eventrouter/connector.md):

      ```bash
      yc serverless eventrouter connector create timer --help
      ```

  1. Создайте [таймер](../../../concepts/eventrouter/connector.md#timer):

      ```bash
      yc serverless eventrouter connector create timer \
        --bus-id <идентификатор_шины> \
        --cron-expression <расписание_таймера> \
        --time-zone <часовой_пояс> \
        --payload <сообщение> \
        --name <имя_коннектора> \
        --description <описание_коннектора> \
        --labels <список_меток> \
        --deletion-protection
      ```

      Где:

      * `--bus-id` — идентификатор [шины](../../../concepts/eventrouter/bus.md) {{ er-name }}.
      * `--cron-expression` — расписание генерации событий в формате [cron-выражения](../../../concepts/eventrouter/connector.md#cron-expression).
      * `--time-zone` — часовой пояс в формате [tz database](https://ru.wikipedia.org/wiki/Tz_database). Необязательный параметр.
      * `--payload` — сообщение, которое будет передаваться в шину при срабатывании таймера. Необязательный параметр.
      * `--name` — имя коннектора. Требования к имени:

          {% include [name-format-2](../../../../_includes/name-format-2.md) %}

      * `--description` — описание коннектора. Необязательный параметр.
      * `--labels` — список меток. Необязательный параметр.

          Можно указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.

      * `--deletion-protection` — защита от удаления коннектора. По умолчанию защита выключена. Пока опция включена, удалить коннектор невозможно. Чтобы отключить защиту от удаления, укажите параметр `--no-deletion-protection`. Необязательный параметр.

      Результат:

      ```text
      id: f66l8kgo20d8********
      bus_id: f66qn4p7uk6p********
      folder_id: b1g681qpemb4********
      cloud_id: b1gia87mbaom********
      created_at: "2025-02-21T09:04:33.248254Z"
      name: mq-via-cli
      description: created via cli
      labels:
        interface: yccli
        owner: admin
      source:
        timer:
          cron_expression: '*/5 * * ? * *'
          time_zone: Europe/Moscow
          payload: '{"message": "Hello, world!"}'
      deletion_protection: true
      status: RUNNING
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  Чтобы создать [таймер](../../../concepts/eventrouter/connector.md#timer):

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
        timer {
          cron_expression = "<расписание_генерации_событий>"
          timezone        = "<часовой_пояс>"
          payload         = "<сообщение>"
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
      * `cron_expression` — расписание генерации событий в формате [cron-выражения](../../../concepts/eventrouter/connector.md#cron-expression).
      * `timezone` — часовой пояс в формате [tz database](https://ru.wikipedia.org/wiki/Tz_database). Необязательный параметр.
      * `payload` — сообщение, которое будет передаваться в шину при срабатывании таймера. Необязательный параметр.

      Более подробную информацию о параметрах ресурса `yandex_serverless_eventrouter_connector` см. в [документации провайдера]({{ tf-provider-resources-link }}/serverless_eventrouter_connector).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../../cli/):

      ```bash
      yc serverless eventrouter connector list
      ```

- API {#api}

  Чтобы создать [таймер](../../../concepts/eventrouter/connector.md#timer), воспользуйтесь методом REST API [Create](../../../../serverless-integrations/eventrouter/api-ref/Connector/create.md) для ресурса [connector](../../../../serverless-integrations/eventrouter/api-ref/Connector/index.md) или вызовом gRPC API [connector/Create](../../../../serverless-integrations/eventrouter/api-ref/grpc/Connector/create.md).

{% endlist %}

{% include [connector-created-running](../../../../_includes/serverless-integrations/connector-created-running.md) %}
