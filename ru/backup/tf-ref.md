---
title: Справочник {{ TF }} для {{ backup-full-name }}
description: На этой странице приведен справочник ресурсов провайдера Terraform, которые поддерживаются для сервиса {{ backup-name }}.
---

# Справочник {{ TF }} для {{ backup-full-name }}


{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ backup-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_backup_policy]({{ tf-provider-resources-link }}/backup_policy) | [Политика резервного копирования](./concepts/policy.md) |
| [yandex_backup_policy_bindings]({{ tf-provider-resources-link }}/backup_policy_bindings) | Привязка политики резервного копирования к [виртуальной машине](../compute/concepts/vm.md) или [серверу {{ baremetal-full-name }}](../baremetal/concepts/servers.md) |

## Источники данных {#data-sources}

Для {{ billing-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_backup_policy]({{ tf-provider-datasources-link }}/backup_policy) | Информация о политике резервного копирования |