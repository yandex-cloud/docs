---
title: Как включить правило
description: Следуя данной инструкции, вы сможете включить правило.
---

# Включить правило

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите включить [правило](../../../concepts/eventrouter/rule.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Выберите нужную [шину](../../../concepts/eventrouter/bus.md).
  1. Перейдите на вкладку ![image](../../../../_assets/console-icons/target-dart.svg) **{{ ui-key.yacloud.serverless-event-router.label_rules }}**.
  1. В строке с нужным правилом нажмите ![image](../../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../../_assets/console-icons/toggle-on.svg) **{{ ui-key.yacloud.common.enable }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для включения [правила](../../../concepts/eventrouter/rule.md):

      ```bash
      yc serverless eventrouter rule enable --help
      ```

  1. {% include [get-rules-list](../../../../_includes/serverless-integrations/get-rules-list.md) %}
  1. Включите правило:

      ```bash
      yc serverless eventrouter rule enable <имя_или_идентификатор_правила>
      ```

      Результат:

      ```text
      id: f66aa46qtt1l********
      bus_id: f66epjc9llqt********
      folder_id: b1g681qpemb4********
      cloud_id: b1gia87mbaom********
      created_at: "2025-02-26T10:30:59.611601Z"
      name: renamed-rule
      ...
      status: ENABLED
      ```

- API {#api}

  Чтобы включить [правило](../../../concepts/eventrouter/rule.md), воспользуйтесь методом REST API [Enable](../../../../serverless-integrations/eventrouter/api-ref/Rule/enable.md) для ресурса [Rule](../../../../serverless-integrations/eventrouter/api-ref/Rule/index.md) или вызовом gRPC API [Rule/Enable](../../../../serverless-integrations/eventrouter/api-ref/grpc/Rule/enable.md).

{% endlist %}