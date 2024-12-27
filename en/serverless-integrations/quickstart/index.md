---
title: Getting started with {{ si-full-name }}
description: Follow this guide to configure and manage integrations using serverless technologies in {{ yandex-cloud }}.
keywords:
  - workflows
  - workflow
  - WF
  - eventrouter
  - event router
  - Workflow
  - YaWL specification
  - parallel
  - integration
  - glue
  - integrations
  - API Gateway
  - bus
  - connector
  - rule
---

# Getting started with {{ si-full-name }}

{{ si-full-name }} enables you to configure and manage integrations using serverless technologies in {{ yandex-cloud }}.

Get started with {{ si-name }} features:
* [{{ sw-full-name }}](workflows.md): Create a workflow invoking a function in {{ sf-name }} and run it. For more information on {{ sw-name }} features, see [Concepts](../concepts/workflows/workflow.md).

    {% include [workflows-preview-note](../../_includes/serverless-integrations/workflows-preview-note.md) %}

* [{{ er-full-name }}](eventrouter.md): Create a bus and use it to transmit data. For more information on {{ er-name }} features, see [Concepts](../concepts/eventrouter/bus.md).

    {% include [event-router-preview-note](../../_includes/serverless-integrations/event-router-preview-note.md) %}

* {{ api-gw-full-name }}: Set up an API gateway for getting static responses, then add an integration to call a function in {{ sf-name }}. For more information on {{ api-gw-name }} features, see the [{{ api-gw-name }} documentation](../../api-gateway/quickstart/index.md).
