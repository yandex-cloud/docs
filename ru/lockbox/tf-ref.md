---
title: Справочник {{ TF }} для {{ lockbox-full-name }}
description: На этой странице приведен справочник ресурсов и источников данных провайдера {{ TF }}, которые поддерживаются для сервиса {{ lockbox-name }}.
---

# Справочник {{ TF }} для {{ lockbox-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ lockbox-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_lockbox_secret]({{ tf-provider-resources-link }}/lockbox_secret) | [Секрет](./concepts/secret.md#secret) |
| [yandex_lockbox_secret_iam_binding]({{ tf-provider-resources-link }}/lockbox_secret_iam_binding) | [Назначение](../iam/concepts/access-control/index.md#access-bindings) прав доступа к секрету |
| [yandex_lockbox_secret_version]({{ tf-provider-resources-link }}/lockbox_secret_version) | [Версия секрета](./concepts/secret.md#version)<br> Вместо `lockbox_secret_version` рекомендуется использовать `lockbox_secret_version_hashed` |
| [yandex_lockbox_secret_version_hashed]({{ tf-provider-resources-link }}/lockbox_secret_version_hashed) | [Версия секрета](./concepts/secret.md#version), хранит в состоянии {{ TF }} значения в хешированном виде. <br> Хранить данные в таком виде безопаснее, чем в открытом. <br> Может содержать не более 10 пар ключей и значений |

## Источники данных {#data-sources}

Для {{ lockbox-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_lockbox_secret]({{ tf-provider-datasources-link }}/lockbox_secret) | Информация о [секрете](./concepts/secret.md#secret) |
| [yandex_lockbox_secret_version]({{ tf-provider-datasources-link }}/lockbox_secret_version) | Информация о [версии секрета](./concepts/secret.md#version) |
