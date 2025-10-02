---
title: Как подключить к {{ mcp-hub-name }} внешний MCP-сервер
description: Следуя данной инструкции, вы научитесь подключать к {{ mcp-hub-name }} через интерфейс {{ foundation-models-full-name }} действующие сторонние MCP-серверы.
---

# Подключить внешний MCP-сервер к {{ mcp-hub-name }}

{% include [note-preview](../../../_includes/note-preview.md) %}

Если у вас уже есть развернутый внешний MCP-сервер, например, на [smithery.ai](https://smithery.ai/), в [{{ marketplace-full-name }}]({{ link-cloud-marketplace }}) или на [виртуальной машине](../../../compute/concepts/vm.md) {{ compute-full-name }}, вы можете подключить его к [{{ mcp-hub-name }}](../../concepts/mcp-hub/index.md).

Чтобы добавить существующий внешний MCP-сервер в {{ mcp-hub-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, на который у вашего аккаунта есть роли [`serverless.mcpGateways.editor`](../../security/index.md#serverless-mcpGateways-editor) и [`serverless.mcpGateways.anonymousInvoker`](../../security/index.md#serverless-mcpGateways-anonymousInvoker) (или выше).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_foundation-models }}**.
  1. На панели слева выберите ![logo-mcp](../../../_assets/console-icons/logo-mcp.svg) **MCP-серверы** и в открывшемся окне:

      1. В блоке **Способ добавления** выберите опцию ![plug-connection](../../../_assets/console-icons/plug-connection.svg) **Подключить**.
      1. В блоке **Инструменты** нажмите кнопку **Добавить инструменты** и в открывшемся окне:

          {% include [create-server-add-external-steps](../../../_includes/ai-studio/mcp-hub/create-server-add-external-steps.md) %}

      1. В блоке **Параметры сервера**:

          1. {% include [create-server-console-general-params-ss1](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss1.md) %}
          1. {% include [create-server-console-general-params-ss2](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss2.md) %}
          1. {% include [create-server-console-general-params-ss3](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss3.md) %}
          1. {% include [create-server-console-general-params-ss4](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss4.md) %}
          1. {% include [create-server-console-general-params-ss5](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss5.md) %}
      1. Нажмите кнопку **Добавить**

{% endlist %}

{% include [server-creation-result-phrase](../../../_includes/ai-studio/mcp-hub/server-creation-result-phrase.md) %}

## Использовать Responses API для обращения к внешнему MCP-серверу {#use-responses-api}

{% include [use-responses-api-example](../../../_includes/ai-studio/mcp-hub/use-responses-api-example.md) %}

#### См. также {#see-also}

* [{#T}](../../concepts/mcp-hub/index.md)
* [{#T}](./create-from-template.md)
* [{#T}](./create-brand-new.md)