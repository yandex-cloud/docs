---
title: Как создать правило с приемником {{ yds-full-name }}
description: Следуя данной инструкции, вы сможете создать правило с приемником {{ yds-full-name }}.
---

# Создать правило с приемником {{ yds-full-name }}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать [правило](../../../concepts/eventrouter/rule.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Выберите нужную [шину](../../../concepts/eventrouter/bus.md).
  1. Перейдите на вкладку ![image](../../../../_assets/console-icons/target-dart.svg) **{{ ui-key.yacloud.serverless-event-router.label_rules }}**.
  1. В правом верхнем углу нажмите **{{ ui-key.yacloud.serverless-event-router.button_create-rule }}**.

  1. {% include [target-filter-console](../../../../_includes/serverless-integrations/target-filter-console.md) %}
  1. В блоке **{{ ui-key.yacloud.serverless-event-router.label_targets }}** нажмите **{{ ui-key.yacloud.common.add }}** и настройте приемник:

      1. Укажите тип приемника `{{ yds-full-name }}`.
      1. Выберите [базу данных](../../../../ydb/concepts/resources.md#database) {{ ydb-name }}, указанную в настройках [потока данных](../../../../data-streams/concepts/glossary.md#stream-concepts) {{ yds-name }}, в который будут отправляться сообщения, соответствующие правилу.
      1. Введите имя потока данных, в который будут отправляться сообщения, соответствующие правилу.
      1. Выберите [сервисный аккаунт](../../../../iam/concepts/users/service-accounts.md), которому назначена [роль](../../../../data-streams/security/index.md#yds-writer) `yds.writer` или выше на выбранный поток данных, или [создайте](../../../../iam/operations/sa/create.md) новый.
      1. {% include [target-retry-console](../../../../_includes/serverless-integrations/target-retry-console.md) %}
      1. {% include [target-transformer-console](../../../../_includes/serverless-integrations/target-transformer-console.md) %}
      1. {% include [target-dlq-console](../../../../_includes/serverless-integrations/target-dlq-console.md) %}

  1. {% include [target-additional-console](../../../../_includes/serverless-integrations/target-additional-console.md) %}
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания [правила](../../../concepts/eventrouter/rule.md):

      ```bash
      yc serverless eventrouter rule create --help
      ```

  1. Создайте правило с приемником {{ yds-full-name }}:

      ```bash
      yc serverless eventrouter rule create \
        --bus-id <идентификатор_шины> \
        --filter '<jq-шаблон>' \
        --yds-target \
      database=<путь_к_базе_данных>,\
      stream-name=<имя_потока_данных>,\
      service-account-id=<сервисный_аккаунт_потока>,\
      retry-attempts=<количество_попыток>,\
      maximum-age=<интервал>,\
      transformer=<jq-шаблон>,\
      dlq-arn=<очередь_DLQ>,\
      dlq-service-account-id=<идентификатор_сервисного_аккаунта_DLQ> \
        --name <имя_правила> \
        --description "<описание_правила>" \
        --deletion-protection \
        --labels <список_меток>
      ```

      Где:

      {% include [target-basics-cli](../../../../_includes/serverless-integrations/target-basics-cli.md) %}

      * `--yds-target` — параметр для настройки приемника с типом `{{ yds-full-name }}` и его свойства:

          * `database` — [путь](../../../../ydb/operations/connection.md#endpoint-and-path) к [базе данных](../../../../ydb/concepts/resources.md#database) {{ ydb-name }}, указанной в настройках [потока данных](../../../../data-streams/concepts/glossary.md#stream-concepts) {{ yds-name }}, в который будут отправляться сообщения, соответствующие правилу.
          * `stream-name` — имя потока данных, в который будут отправляться сообщения, соответствующие правилу.
          * `service-account-id` — идентификатор [сервисного аккаунта](../../../../iam/concepts/users/service-accounts.md), которому назначена [роль](../../../../data-streams/security/index.md#yds-writer) `yds.writer` или выше на выбранный поток данных.


          {% include [target-retry-cli](../../../../_includes/serverless-integrations/target-retry-cli.md) %}

          {% include [target-transformer-cli](../../../../_includes/serverless-integrations/target-transformer-cli.md) %}


          {% include [target-dlq-cli](../../../../_includes/serverless-integrations/target-dlq-cli.md) %}

      {% include [target-additional-cli](../../../../_includes/serverless-integrations/target-additional-cli.md) %}

      Результат:

      ```text
      id: f66vfpjrkc35********
      bus_id: f66epjc9llqt********
      folder_id: b1g681qpemb4********
      cloud_id: b1gia87mbaom********
      created_at: "2025-02-26T14:04:47.710918Z"
      name: new-rule
      description: created via cli
      labels:
        owner: admin
        version: beta
      filter:
        jq_filter: .firstName == "Ivan"
      targets:
        - yds:
            database: /{{ region-id }}/b1gia87mbaom********/etnvqsesnr5g********
            stream_name: new-stream
            service_account_id: ajelprpohp7r********
          transformer:
            jq_transformer: .
          retry_settings:
            retry_attempts: "3"
            maximum_age: 600s
          dead_letter_queue:
            queue_arn: yrn:yc:ymq:{{ region-id }}:b1g681qpemb4********:dlq-42
            service_account_id: ajelprpohp7r********
          status: ENABLED
      status: ENABLED
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  Чтобы создать [правило](../../../concepts/eventrouter/rule.md) с приемником {{ yds-full-name }}:

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_serverless_eventrouter_rule" "example_rule" {
        bus_id    = "<идентификатор_шины>"
        jq_filter = "<jq-шаблон>"

        yds {
          database           = "<путь_к_базе_данных>"
          stream_name        = "<имя_потока_данных>"
          service_account_id = "<идентификатор_сервисного_аккаунта>"
        }
      
        name        = "<имя_правила>"
        description = "<описание_правила>"

        labels = {
          <ключ_1> = "<значение_1>"
          <ключ_2> = "<значение_2>"
          ...
          <ключ_n> = "<значение_n>"
        }
      }
      ```

      Где:

      * `bus_id` — идентификатор [шины](../../../concepts/eventrouter/bus.md) {{ er-name }}.
      * `jq_filter` — [jq-шаблон](https://jqlang.github.io/jq/manual/) для [фильтрации](../../../concepts/eventrouter/rule.md#filter) событий.
      * `yds` — блок для настройки приемника с типом `{{ yds-full-name }}` и его параметры:

          * `database` — [путь](../../../../ydb/operations/connection.md#endpoint-and-path) к [базе данных](../../../../ydb/concepts/resources.md#database) {{ ydb-name }}, указанной в настройках [потока данных](../../../../data-streams/concepts/glossary.md#stream-concepts) {{ yds-name }}, в который будут отправляться сообщения, соответствующие правилу.
          * `stream_name` — имя потока данных, в который будут отправляться сообщения, соответствующие правилу.
          * `service_account_id` — идентификатор [сервисного аккаунта](../../../../iam/concepts/users/service-accounts.md), которому назначена [роль](../../../../data-streams/security/index.md#yds-writer) `yds.writer` или выше на выбранный поток данных.

      {% include [target-additional-tf](../../../../_includes/serverless-integrations/target-additional-tf.md) %}

      Более подробную информацию о параметрах ресурса `yandex_serverless_eventrouter_rule` см. в [документации провайдера]({{ tf-provider-resources-link }}/serverless_eventrouter_rule).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../../cli/):

      ```bash
      yc serverless eventrouter rule list
      ```

- API {#api}

  Чтобы создать [правило](../../../concepts/eventrouter/rule.md) с приемником {{ yds-full-name }}, воспользуйтесь методом REST API [Create](../../../../serverless-integrations/eventrouter/api-ref/Rule/create.md) для ресурса [rule](../../../../serverless-integrations/eventrouter/api-ref/Rule/index.md) или вызовом gRPC API [rule/Create](../../../../serverless-integrations/eventrouter/api-ref/grpc/Rule/create.md).

{% endlist %}

{% include [rule-created-enabled](../../../../_includes/serverless-integrations/rule-created-enabled.md) %}