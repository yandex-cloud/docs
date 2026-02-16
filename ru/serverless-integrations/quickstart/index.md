---
title: Как начать работать с {{ si-full-name }}
description: Следуя данным инструкциям, вы сможете настраивать интеграции и управлять ими с помощью serverless-технологий в {{ yandex-cloud }}.
keywords:
  - workflows
  - workflow
  - воркфлоу
  - eventrouter
  - event router
  - рабочий процесс
  - спецификация YaWL
  - parallel
  - integration
  - glue
  - интеграции
  - API Gateway
  - шина
  - коннектор
  - правило
---

# Начало работы с {{ si-full-name }}

{{ si-full-name }} позволяет настраивать интеграции и управлять ими с помощью serverless-технологий в {{ yandex-cloud }}.

Начните работу с функциональностями {{ si-name }}:
* [{{ sw-full-name }}](workflows.md) — создайте рабочий процесс, который вызывает функцию {{ sf-name }}, и запустите его. Подробнее о возможностях {{ sw-name }} см. в [Концепциях](../concepts/workflows/workflow.md).

    {% include [workflows-preview-note](../../_includes/serverless-integrations/workflows-preview-note.md) %}

* [{{ er-full-name }}](eventrouter.md) — создайте шину и передайте через нее данные. Подробнее о возможностях {{ er-name }} см. в [Концепциях](../concepts/eventrouter/bus.md).

    {% include [event-router-preview-note](../../_includes/serverless-integrations/event-router-preview-note.md) %}

* {{ api-gw-full-name }} — сконфигурируйте API-шлюз для получения статического ответа, а затем добавьте интеграцию для вызова функции {{ sf-name }}. Подробнее о возможностях см. в [документации {{ api-gw-name }}](../../api-gateway/quickstart/index.md).
