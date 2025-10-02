---
title: Как создать MCP-сервер в {{ mcp-hub-name }} из шаблона
description: Следуя данной инструкции, вы научитесь создавать MCP-серверы в {{ mcp-hub-name }} из готовых шаблонов через интерфейс {{ foundation-models-full-name }}.
---

# Создать MCP-сервер в {{ mcp-hub-name }} из шаблона

{% include [note-preview](../../../_includes/note-preview.md) %}

{{ foundation-models-full-name }} предлагает набор [шаблонов](../../concepts/mcp-hub/templates.md) MCP-серверов от внешних партнеров {{ yandex-cloud }}, которые вы можете использовать в ваших AI-агентах для доступа к сервисам этих партнеров.

Чтобы добавить в [{{ mcp-hub-name }}](../../concepts/mcp-hub/index.md) MCP-сервер из готового шаблона:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, на который у вашего аккаунта есть роли [`serverless.mcpGateways.editor`](../../security/index.md#serverless-mcpGateways-editor) и [`serverless.mcpGateways.anonymousInvoker`](../../security/index.md#serverless-mcpGateways-anonymousInvoker) (или выше).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_foundation-models }}**.
  1. На панели слева выберите ![logo-mcp](../../../_assets/console-icons/logo-mcp.svg) **MCP-серверы** и в открывшемся окне:

      1. В блоке **Способ добавления** выберите один из [шаблонов](../../concepts/mcp-hub/templates.md): [Контур.Фокус](https://focus.kontur.ru), [{{ tracker-full-name }}](https://360.yandex.ru/business/tracker/), [{{ search-api-full-name }}](../../../search-api/index.yaml) или [amoCRM](https://www.amocrm.ru/).
      1. В блоке **Инструменты**:

          {% note tip %}

          Чтобы получить токен доступа, обратитесь на сайт подключаемого сервиса.

          {% endnote %}

          {% include [create-server-add-external-steps](../../../_includes/ai-studio/mcp-hub/create-server-add-external-steps.md) %}

      1. В блоке **Параметры сервера**:

          1. {% include [create-server-console-general-params-ss1](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss1.md) %}
          1. {% include [create-server-console-general-params-ss2](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss2.md) %}
          1. {% include [create-server-console-general-params-ss3](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss3.md) %}
          1. {% include [create-server-console-general-params-ss5](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss5.md) %}
      1. Нажмите кнопку **Добавить**

{% endlist %}

{% include [server-creation-result-phrase](../../../_includes/ai-studio/mcp-hub/server-creation-result-phrase.md) %}

#### См. также {#see-also}

* [{#T}](../../concepts/mcp-hub/index.md)
* [{#T}](../../concepts/mcp-hub/templates.md)
* [{#T}](./connect-external.md)
* [{#T}](./create-brand-new.md)