---
title: Как получить список правил
description: Следуя данной инструкции, вы сможете посмотреть список доступных правил {{ er-full-name }}.
---

# Получить список правил

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите посмотреть список [правил](../../../concepts/eventrouter/rule.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева выберите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Выберите нужную [шину](../../../concepts/eventrouter/bus.md).
  1. Перейдите на вкладку ![image](../../../../_assets/console-icons/target-dart.svg) **{{ ui-key.yacloud.serverless-event-router.label_rules }}**. На странице **{{ ui-key.yacloud.serverless-event-router.label_rules }}** отобразится список правил.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../../../cli/) для просмотра списка [правил](../../../concepts/eventrouter/rule.md):

      ```bash
      yc serverless eventrouter rule list --help
      ```

  1. {% include [get-rules-list](../../../../_includes/serverless-integrations/get-rules-list.md) %}

- API {#api}

  Чтобы посмотреть список [правил](../../../concepts/eventrouter/rule.md), воспользуйтесь методом REST API [list](../../../../serverless-integrations/eventrouter/api-ref/Rule/list.md) для ресурса [Rule](../../../../serverless-integrations/eventrouter/api-ref/Rule/index.md) или вызовом gRPC API [RuleService/List](../../../../serverless-integrations/eventrouter/api-ref/grpc/Rule/list.md).

{% endlist %}