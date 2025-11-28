---
title: Интеграция с {{ objstorage-name }} в {{ mgl-full-name }}
description: Следуя данной инструкции, вы сможете включить хранение данных {{ GL }} в {{ objstorage-name }}.
---

# Интеграция с {{ objstorage-name }}

Интеграция с {{ objstorage-name }} позволяет уменьшить объем данных на дисках [инстанса](../concepts/index.md#instance) и предотвратить их переполнение. Вы можете выбрать типы данных, которые будут храниться в {{ objstorage-name }}:

{% include [s3-object-type](../../_includes/managed-gitlab/s3-object-type.md) %}

[Подробнее об интеграции с {{ objstorage-name }}](../concepts/s3-integration.md).

## Посмотреть список хранимых в {{ objstorage-name }} данных {#objstorage-list}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Нажмите на имя нужного инстанса и выберите вкладку ![image](../../_assets/console-icons/cloud-arrow-up-in.svg) **{{ ui-key.yacloud.gitlab.title_object-storage }}**.

{% endlist %}

## Включить хранение данных в {{ objstorage-name }} {#enable-objstorage}

{% include [objstorage-disable-note](../../_includes/managed-gitlab/objstorage-disable-note.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Нажмите на имя нужного инстанса и выберите вкладку ![image](../../_assets/console-icons/cloud-arrow-up-in.svg) **{{ ui-key.yacloud.gitlab.title_object-storage }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.gitlab.button_configure-data-types }}**.
  1. Выберите типы данных для хранения в {{ objstorage-name }}.
    
      Для каждого выбранного типа данных можно включить проксирование файлов. При этом файлы будут загружаться через сервер {{ GL }}.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

      {% include [objstorage-note](../../_includes/managed-gitlab/objstorage-note.md) %}

{% endlist %}