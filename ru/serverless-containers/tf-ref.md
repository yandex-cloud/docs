# Справочник {{ TF }} для {{ serverless-containers-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ serverless-containers-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_serverless_container]({{ tf-provider-resources-link }}/serverless_container) | [Контейнер](./concepts/container.md) |
| [yandex_serverless_container_iam_binding]({{ tf-provider-resources-link }}/serverless_container_iam_binding) | [Привязка](../iam/concepts/access-control/index.md#access-bindings) прав доступа к контейнеру |
| [yandex_function_trigger]({{ tf-provider-resources-link }}/function_trigger) | [Триггер](./concepts/trigger/index.md) |

## Источники данных {#data-sources}

Для {{ serverless-containers-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_serverless_container]({{ tf-provider-datasources-link }}/datasource_serverless_container) | Информация о [контейнере](./concepts/container.md) |