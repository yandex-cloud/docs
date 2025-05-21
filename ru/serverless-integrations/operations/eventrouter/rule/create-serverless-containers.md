---
title: Как создать правило с приемником {{ serverless-containers-full-name }}
description: Следуя данной инструкции, вы сможете создать правило с приемником {{ serverless-containers-full-name }}.
---

# Создать правило с приемником {{ serverless-containers-full-name }}

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

      1. Укажите тип приемника `{{ serverless-containers-full-name }}`.
      1. Выберите [контейнер](../../../../serverless-containers/concepts/container.md), в который будут отправляться сообщения, соответствующие правилу, и его [ревизию](../../../../serverless-containers/concepts/container.md#revision).
      1. Укажите путь, который будет указываться после ссылки для вызова.

          Например, если ссылка для вызова — `https://<идентификатор_контейнера>.containers.yandexcloud.net/`, а путь — `/hello`, контейнер будет вызываться по пути `https://<идентификатор_контейнера>.containers.yandexcloud.net/hello`.

      1. Выберите [сервисный аккаунт](../../../../iam/concepts/users/service-accounts.md), которому назначена [роль](../../../../serverless-containers/security/index.md#serverless-containers-containerinvoker) `serverless-containers.containerInvoker` или выше на выбранный контейнер, или [создайте](../../../../iam/operations/sa/create.md) новый.
      1. {% include [target-retry-console](../../../../_includes/serverless-integrations/target-retry-console.md) %}
      1. {% include [target-grouping-console](../../../../_includes/serverless-integrations/target-grouping-console.md) %}
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

  1. Создайте правило с приемником {{ serverless-containers-full-name }}:

      ```bash
      yc serverless eventrouter rule create \
        --bus-id <идентификатор_шины> \
        --filter '<jq-шаблон>' \
        --container-target \
      container-id=<идентификатор_контейнера>,\
      container-revision-id=<идентификатор_ревизии_контейнера>,\
      path=<путь>,\
      service-account-id=<идентификатор_сервисного_аккаунта_контейнера>,\
      retry-attempts=<количество_попыток>,\
      maximum-age=<интервал>,\
      max-count=<максимальное_число_сообщений>,\
      max-bytes=<максимальное_число_байтов>,\
      cutoff=<время_ожидания>,\
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

      * `--container` — параметр для настройки приемника с типом `{{ serverless-containers-full-name }}` и его свойства:

          * `container-id` — идентификатор [контейнера](../../../../serverless-containers/concepts/container.md), в который будут отправляться сообщения, соответствующие правилу.
          * `container-revision-id` — идентификатор [ревизии контейнера](../../../../serverless-containers/concepts/container.md#revision).
          * `path` — путь, который будет указываться после ссылки для вызова.

              Например, если ссылка для вызова — `https://<идентификатор_контейнера>.containers.yandexcloud.net/`, а путь — `/hello`, контейнер будет вызываться по пути `https://<идентификатор_контейнера>.containers.yandexcloud.net/hello`.

          * `service-account-id` — идентификатор [сервисного аккаунта](../../../../iam/concepts/users/service-accounts.md), которому назначена [роль](../../../../serverless-containers/security/index.md#serverless-containers-containerinvoker) `serverless-containers.containerInvoker` или выше на выбранный контейнер.


          {% include [target-retry-cli](../../../../_includes/serverless-integrations/target-retry-cli.md) %}

          {% include [target-transformer-cli](../../../../_includes/serverless-integrations/target-transformer-cli.md) %}


          {% include [target-grouping-cli](../../../../_includes/serverless-integrations/target-grouping-cli.md) %}

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
        - container:
            container_id: bbams2eulief********
            container_revision_id: bba9af1vblvj********
            path: /hello
            service_account_id: ajelprpohp7r********
            batch_settings:
              max_count: "1"
              max_bytes: "10000"
              cutoff: 60s
          transformer:
            jq_transformer: .
          retry_settings:
            retry_attempts: "3"
            maximum_age: 600s
          dead_letter_queue:
            queue_arn: yrn:yc:ymq:{{ region-id }}:b1g681qpemb4********:dlq-42
            service_account_id: ajelprpohp7r********
          status: ENABLED
      deletion_protection: true
      status: ENABLED
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  Чтобы создать [правило](../../../concepts/eventrouter/rule.md) с приемником {{ serverless-containers-full-name }}:

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_serverless_eventrouter_rule" "example_rule" {
        bus_id    = "<идентификатор_шины>"
        jq_filter = "<jq-шаблон>"
       
        container {
          container_id          = "<идентификатор_контейнера>"
          container_revision_id = "<идентификатор_ревизии_контейнера>"
          path                  = "<путь>"
          service_account_id    = "<идентификатор_сервисного_аккаунта>"
          
          batch_settings {
            max_bytes  = <максимальное_число_байтов>
            max_count  = <максимальное_число_сообщений>
            cutoff     = "<время_ожидания>"
          }
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
      * `container` — блок для настройки приемника с типом `{{ serverless-containers-full-name }}` и его параметры:

          * `container_id` — идентификатор [контейнера](../../../../serverless-containers/concepts/container.md), в который будут отправляться сообщения, соответствующие правилу.
          * `container_revision_id` — идентификатор [ревизии контейнера](../../../../serverless-containers/concepts/container.md#revision).
          * `path` — путь, который будет указываться после ссылки для вызова.

              Например, если ссылка для вызова — `https://<идентификатор_контейнера>.containers.yandexcloud.net/`, а путь — `/hello`, контейнер будет вызываться по пути `https://<идентификатор_контейнера>.containers.yandexcloud.net/hello`.

          * `service_account_id` — идентификатор [сервисного аккаунта](../../../../iam/concepts/users/service-accounts.md), которому назначена [роль](../../../../serverless-containers/security/index.md#serverless-containers-containerinvoker) `serverless-containers.containerInvoker` или выше на выбранный контейнер.

          {% include [target-grouping-tf](../../../../_includes/serverless-integrations/target-grouping-tf.md) %}

      {% include [target-additional-tf](../../../../_includes/serverless-integrations/target-additional-tf.md) %}

      Более подробную информацию о параметрах ресурса `yandex_serverless_eventrouter_rule` см. в [документации провайдера]({{ tf-provider-resources-link }}/serverless_eventrouter_rule).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../../cli/):

      ```bash
      yc serverless eventrouter rule list
      ```

- API {#api}

  Чтобы создать [правило](../../../concepts/eventrouter/rule.md) с приемником {{ serverless-containers-full-name }}, воспользуйтесь методом REST API [Create](../../../../serverless-integrations/eventrouter/api-ref/Rule/create.md) для ресурса [rule](../../../../serverless-integrations/eventrouter/api-ref/Rule/index.md) или вызовом gRPC API [rule/Create](../../../../serverless-integrations/eventrouter/api-ref/grpc/Rule/create.md).

{% endlist %}

{% include [rule-created-enabled](../../../../_includes/serverless-integrations/rule-created-enabled.md) %}