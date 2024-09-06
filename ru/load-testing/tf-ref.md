---
title: "Справочник {{ TF }} для {{ load-testing-full-name }}"
description: "На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ load-testing-name }}."
---

# Справочник {{ TF }} для {{ load-testing-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ load-testing-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_loadtesting_agent]({{ tf-provider-resources-link }}/loadtesting_agent) | [Агент](./concepts/agent.md) |

## Источники данных {#data-sources}

Для {{ load-testing-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_loadtesting_agent]({{ tf-provider-datasources-link }}/datasource_loadtesting_agent) | Информация об [агенте](./concepts/agent.md) |
