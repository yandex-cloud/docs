---
title: Получение списка бакетов в {{ objstorage-full-name }}
description: Следуя данной инструкции, вы сможете получить список бакетов в {{ objstorage-name }}.
---

# Получение списка бакетов

## Получить список бакетов {#get-list}

Для просмотра полного списка [бакетов](../../concepts/bucket.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. На открывшейся странице отобразится полный список бакетов.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения списка бакетов:

     ```bash
     yc storage bucket --help
     ```

  1. {% include [bucket-list-cli](../../../_includes/storage/bucket-list-cli.md) %}

{% endlist %}
