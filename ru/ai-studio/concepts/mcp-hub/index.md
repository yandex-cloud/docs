---
title: '{{ mcp-hub-name }} в {{ foundation-models-full-name }}'
description: '{{ mcp-hub-name }} — это функциональность {{ foundation-models-full-name }}, предназначенная для создания и управления MCP-серверами.'
---

# {{ mcp-hub-name }}

{% include [note-preview](../../../_includes/note-preview.md) %}

{{ foundation-models-full-name }} позволяет использовать [MCP-серверы](../../../glossary/mcp.md) в AI-агентах для взаимодействия с внешними системами, чтобы получать дополнительный контекст или выполнять действия, например, через вызов внешнего [API](https://ru.wikipedia.org/wiki/API).

_{{ mcp-hub-name }}_ — это функциональность {{ foundation-models-name }}, предназначенная для создания, управления и мониторинга MCP-серверов. {{ mcp-hub-name }} позволяет как подключать внешние MCP-серверы, так и создавать собственные MCP-серверы с нуля или из предварительно настроенных шаблонов.

Чтобы обращаться к MCP-серверам в {{ mcp-hub-name }}, необходима [роль](../../security/index.md#serverless-mcpGateways-invoker) `serverless.mcpGateways.invoker` или выше. Чтобы обращаться к внешним MCP-серверам и MCP-серверам, созданным из шаблона, дополнительно необходима [роль](../../security/index.md#serverless-mcpGateways-anonymousInvoker) `serverless.mcpGateways.anonymousInvoker` или выше.

## MCP-серверы {#servers}

MCP-серверы позволяют подключать к [большим языковым моделям (LLM)](../../../glossary/llm.md) сторонние инструменты, такие как API, базы знаний и различные сервисы, которые предоставляют моделям доступ к внешней информации и дают возможность выполнять сложные задачи. Для взаимодействия моделей с этими внешними инструментами в MCP-серверах используется протокол [MCP (Model Context Protocol)](https://modelcontextprotocol.io/docs/getting-started/intro).

{% include [server-tool-number-notice](../../../_includes/ai-studio/mcp-hub/server-tool-number-notice.md) %}

Протокол MCP позволяет:

* интегрировать большие языковые модели в корпоративные системы, сервисы и внутренние базы знаний;
* обеспечить стандартизированный доступ моделей к внешним данным и инструментам;
* упростить разработку и масштабирование решений на базе LLM.

### Транспортные механизмы протокола MCP {#transport}

Протокол MCP предусматривает использование одного из следующих транспортных механизмов:

{% include [transportation-methods](../../../_includes/ai-studio/mcp-hub/transportation-methods.md) %}

### Сценарии использования MCP-серверов {#mcp-use-cases}

Использование MCP-серверов позволяет реализовывать следующие сценарии:

* подключение моделей к [CRM](https://ru.wikipedia.org/wiki/Система_управления_взаимоотношениями_с_клиентами)-, [ERP](https://ru.wikipedia.org/wiki/ERP)-системам или внутренним хранилищам;
* автоматизация бизнес-процессов и рабочих сценариев с использованием [AI](https://ru.wikipedia.org/wiki/Искусственный_интеллект);
* создание специализированных AI-ассистентов (юридических, медицинских, технических и др.);
* интеграция с внешними API для получения актуальной информации, например, новостей, курсов валют и т.п.

## Добавление MCP-серверов в {{ mcp-hub-name }} {#adding-servers}

{{ mcp-hub-name }} предлагает три способа добавления MCP-серверов: подключение существующего внешнего сервера, создание нового сервера из шаблона и создание нового сервера с нуля.

Чтобы создать MCP-сервер, у пользователя должна быть [роль](../../security/index.md#serverless-mcpGateways-editor) `serverless.mcpGateways.editor` или выше.

### Подключение внешнего MCP-сервера {#connect-external}

Этот способ удобен, когда у вас уже есть развернутый внешний MCP-сервер, например, на [smithery.ai](https://smithery.ai/), из [{{ marketplace-full-name }}]({{ link-cloud-marketplace }}) или на [виртуальной машине](../../../compute/concepts/vm.md) {{ compute-full-name }}. Чтобы [добавить](../../operations/mcp-servers/connect-external.md) в {{ mcp-hub-name }} такой MCP-сервер, укажите его адрес и данные для аутентификации, после чего он будет доступен для подключения к агентам.

Подробнее см. в разделе [{#T}](../../operations/mcp-servers/connect-external.md).

{% include [use-responses-api-example](../../../_includes/ai-studio/mcp-hub/use-responses-api-example.md) %}

### Создание MCP-сервера из шаблона {#from-template}

{{ foundation-models-name }} предлагает набор шаблонов MCP-серверов от внешних партнеров {{ yandex-cloud }}, которые вы можете использовать в ваших AI-агентах для доступа к сервисам этих партнеров. Чтобы [добавить](../../operations/mcp-servers/create-from-template.md) в {{ mcp-hub-name }} такой MCP-сервер, выберите нужный шаблон и укажите данные для аутентификации, после чего сервер будет доступен для подключения к вашим агентам.

Подробнее см. в разделе [{#T}](../../operations/mcp-servers/create-from-template.md).

Список доступных шаблонов см. в разделе [{#T}](./templates.md).

### Создание MCP-сервера с нуля {#brand-new}

В {{ mcp-hub-name }} вы также можете самостоятельно [создать новый MCP-сервер](../../operations/mcp-servers/create-brand-new.md), содержащий следующие _инструменты_:

* [Функция](../../../functions/concepts/function.md) {{ sf-full-name }} позволяет запускать ваш код на одном из поддерживаемых языков программирования с необходимыми зависимостями в обслуживаемой [среде выполнения](../../../functions/concepts/runtime/index.md). При увеличении количества вызовов функции происходит ее автоматическое [масштабирование](../../../functions/concepts/function.md#scaling) — создание дополнительных экземпляров.
* HTTPS-запрос позволяет обращаться к внешним [API](https://ru.wikipedia.org/wiki/API). Если у вас есть сервис с действующим API, вы можете преобразовать этот API в формат MCP. Опишите имеющиеся API-методы, и они автоматически конвертируются для использования в агентах.
* [Рабочий процесс](../../../serverless-integrations/concepts/workflows/workflow.md) {{ sw-full-name }} позволяет создавать и подключать к агенту сложные процессы, состоящие из различных взаимодействующих между собой инструментов и сервисов и реализующие собственную логику управления и обработки ошибок.

Подробнее см. в разделе [{#T}](../../operations/mcp-servers/create-brand-new.md).

### Общие настройки MCP-серверов {#server-settings}

MCP-серверы в {{ mcp-hub-name }} могут быть приватными или публичными.

К созданному в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) приватному MCP-серверу без аутентификации могут обращаться только AI-агенты, которые вызваны пользователем или сервисным аккаунтом с назначенной [ролью](../../security/index.md#serverless-mcpGateways-invoker), разрешающей обращаться к MCP-серверам в этом каталоге. Другим агентам для обращения к приватному MCP-серверу требуется аутентификация — [IAM-токен](../../../iam/concepts/authorization/iam-token.md) или [API-ключ](../../../iam/concepts/authorization/api-key.md) сервисного аккаунта.

К публичным MСP-серверам могут обращаться любые агенты без аутентификации.

В настройках MCP-сервера вы можете включить опцию [логирования](../../../logging/concepts/log-group.md), чтобы сохранять информацию об обращениях к серверу в журнале.

#### См. также {#see-also}

* [{#T}](./templates.md)
* [{#T}](../../operations/mcp-servers/connect-external.md)
* [{#T}](../../operations/mcp-servers/create-from-template.md)
* [{#T}](../../operations/mcp-servers/create-brand-new.md)