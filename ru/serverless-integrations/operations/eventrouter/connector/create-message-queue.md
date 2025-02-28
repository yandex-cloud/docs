---
title: Как создать коннектор для {{ message-queue-name }}
description: Следуя данной инструкции, вы сможете создать коннектор для {{ message-queue-full-name }}.
---

# Создать коннектор для {{ message-queue-name }}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать [коннектор](../../../concepts/eventrouter/connector.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Выберите нужную [шину](../../../concepts/eventrouter/bus.md).
  1. Перейдите на вкладку ![image](../../../../_assets/console-icons/broadcast-signal.svg) **{{ ui-key.yacloud.serverless-event-router.label_connectors }}**.
  1. В правом верхнем углу нажмите **{{ ui-key.yacloud.serverless-event-router.button_create-connector }}**. В открывшемся окне:

      1. В поле **{{ ui-key.yacloud.serverless-event-router.label_connector-source }}** выберите `{{ message-queue-full-name }}`.
      1. В блоке **Настройки сообщений {{ message-queue-name }}**:

          * Выберите каталог и [очередь сообщений](../../../../message-queue/concepts/queue.md).
          * Выберите [сервисный аккаунт](../../../../iam/concepts/users/service-accounts.md), у которого есть права на чтение из очереди сообщений.

      1. (Опционально) Нажмите кнопку ![image](../../../../_assets/console-icons/plus.svg) **Настройки группирования сообщений** и укажите:

          * **Таймаут видимости** — [время](https://yandex.cloud/ru/docs/message-queue/concepts/visibility-timeout) в часах, на которое сообщения скрываются из очереди после того, как один из получателей принял сообщение. Допустимые значения от 0 до 12 часов, значение по умолчанию — 0.
          * **Размер группы** — максимальное количество сообщений, которые {{ er-name }} группирует перед отправкой из источника в [правило](../../../concepts/eventrouter/rule.md). Допустимые значения от 0 до 12, значение по умолчанию — 10.
          * **Таймаут опроса** — максимальное время в миллисекундах, в течение которого {{ er-name }} группирует сообщения перед отправкой из источника в правило. Допустимые значения от 0 до 20 секунд, значение по умолчанию — 10 секунд.

              {% include [connector-about-grouping](../../../../_includes/serverless-integrations/connector-about-grouping.md) %}

      1. {% include [connector-create-additional-params](../../../../_includes/serverless-integrations/connector-create-additional-params.md) %}
      1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания [коннектора](../../../concepts/eventrouter/connector.md):

      ```bash
      yc serverless eventrouter connector create message-queue --help
      ```

  1. Создайте коннектор для {{ message-queue-name }}:

      ```bash
      yc serverless eventrouter connector create message-queue \
        --bus-id <идентификатор_шины> \
        --queue-arn <ARN_очереди> \
        --service-account-id <идентификатор_сервисного_аккаунта> \
        --visibility-timeout <таймаут_видимости> \
        --batch-size <размер_группы> \
        --polling-timeout <таймаут_опроса> \
        --name <имя_коннектора> \
        --description "<описание_коннектора>" \
        --labels <список_меток> \
        --deletion-protection
      ```

      Где:

      * `--bus-id` — идентификатор [шины](../../../concepts/eventrouter/bus.md) {{ er-name }}.
      * `--queue-arn` — ARN [очереди](../../../../message-queue/concepts/queue.md) {{ message-queue-full-name }}.
      * `--service-account-id` — идентификатор [сервисного аккаунта](../../../../iam/concepts/users/service-accounts.md), у которого есть права на чтение из очереди сообщений.
      * `--visibility-timeout` — [время](https://yandex.cloud/ru/docs/message-queue/concepts/visibility-timeout), на которое сообщения скрываются из очереди после того, как один из получателей принял сообщение. Допустимые значения от 0 до 12 часов, значение по умолчанию — 0. Необязательный параметр.
      * `--batch-size` — максимальное количество сообщений, которые {{ er-name }} группирует перед отправкой из источника в [правило](../../../concepts/eventrouter/rule.md). Допустимые значения от 0 до 12, значение по умолчанию — 10. Необязательный параметр.
      * `--polling-timeout` — максимальное время, в течение которого {{ er-name }} группирует сообщения перед отправкой из источника в правило. Допустимые значения от 0 до 20 секунд, значение по умолчанию — 10 секунд. Необязательный параметр.

          {% include [connector-about-grouping](../../../../_includes/serverless-integrations/connector-about-grouping.md) %}

      * `--name` — имя коннектора. Требования к имени:

          {% include [name-format-2](../../../../_includes/name-format-2.md) %}

      * `--description` — описание коннектора. Необязательный параметр.
      * `--labels` — список меток. Необязательный параметр.

          Можно указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.

      * `--deletion-protection` — защита от удаления коннектора. Пока опция включена, удалить коннектор невозможно. Чтобы отключить защиту от удаления, укажите параметр `--no-deletion-protection`. Необязательный параметр.

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
        message_queue:
          queue_arn: yrn:yc:ymq:ru-central1:b1g681qpemb4********:my-queue
          service_account_id: ajelprpohp7r********
          visibility_timeout: 60s
          batch_size: "3"
          polling_timeout: 0.100s
      deletion_protection: true
      status: RUNNING
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  Чтобы создать [коннектор](../../../concepts/eventrouter/connector.md) для {{ message-queue-name }}:

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
          queue_arn          = "<ARN_очереди>"
          service_account_id = "<идентификатор_сервисного_аккаунта>"
          visibility_timeout = "1m"
          batch_size         = "3"
          polling_timeout    = "100ms"
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
      * `queue_arn` — ARN [очереди](../../../../message-queue/concepts/queue.md) {{ message-queue-full-name }}.
      * `service-account-id` — идентификатор [сервисного аккаунта](../../../../iam/concepts/users/service-accounts.md), у которого есть права на чтение из очереди сообщений.
      * `visibility_timeout` — [время](https://yandex.cloud/ru/docs/message-queue/concepts/visibility-timeout), на которое сообщения скрываются из очереди после того, как один из получателей принял сообщение. Допустимые значения от 0 до 12 часов, значение по умолчанию — 0. Необязательный параметр.
      * `batch_size` — максимальное количество сообщений, которые {{ er-name }} группирует перед отправкой из источника в [правило](../../../concepts/eventrouter/rule.md). Допустимые значения от 0 до 12, значение по умолчанию — 10. Необязательный параметр.
      * `polling_timeout` — максимальное время, в течение которого {{ er-name }} группирует сообщения перед отправкой из источника в правило. Допустимые значения от 0 до 20 секунд, значение по умолчанию — 10 секунд. Необязательный параметр.

          {% include [connector-about-grouping](../../../../_includes/serverless-integrations/connector-about-grouping.md) %}

      Более подробную информацию о параметрах ресурса `yandex_serverless_eventrouter_connector` см. в [документации провайдера]({{ tf-provider-resources-link }}/serverless_eventrouter_connector).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../../cli/):

      ```bash
      yc serverless eventrouter connector list
      ```

- API {#api}

  Чтобы создать [коннектор](../../../concepts/eventrouter/connector.md) для {{ message-queue-name }}, воспользуйтесь методом REST API [Create](../../../../serverless-integrations/eventrouter/api-ref/Connector/create.md) для ресурса [connector](../../../../serverless-integrations/eventrouter/api-ref/Connector/index.md) или вызовом gRPC API [connector/Create](../../../../serverless-integrations/eventrouter/api-ref/grpc/Connector/create.md).

{% endlist %}

{% include [connector-created-running](../../../../_includes/serverless-integrations/connector-created-running.md) %}