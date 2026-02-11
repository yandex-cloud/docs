---
title: Получение информации о хранилище данных в {{ data-catalog-name }}
description: Как просмотреть информацию о выгруженных данных, загрузках, источниках данных и связях хранилища данных в {{ data-catalog-full-name }}.
---

# Получение информации о хранилище данных

{% note info %}

{% include [preview-pp](../../../_includes/preview-pp.md) %}

{% endnote %}

Вы можете просмотреть следующую информацию о хранилище данных:

* [выгруженные данные](#view-assets);
* [загрузки](#get-ingestions);
* [источники данных](#get-sources);
* [связи](#view-lineage).

## Просмотреть выгруженные данные {#view-assets}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, содержащий нужное хранилище данных.
  1. На панели слева выберите ![image](../../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.label_data-store }}**.
  1. Выберите нужное хранилище данных.
  1. Перейдите на вкладку **{{ ui-key.yacloud.data-catalog.label_source-data-tab }}**.

{% endlist %}

## Получить список загрузок {#get-ingestions}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, содержащий нужное хранилище данных.
  1. На панели слева выберите ![image](../../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.label_data-store }}**.
  1. Выберите нужное хранилище данных.
  1. Перейдите на вкладку **{{ ui-key.yacloud.data-catalog.label_ingestions }}**.

{% endlist %}

## Получить список источников данных {#get-sources}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, содержащий нужное хранилище данных.
  1. На панели слева выберите ![image](../../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.label_data-store }}**.
  1. Выберите нужное хранилище данных.
  1. Перейдите на вкладку **{{ ui-key.yacloud.data-catalog.label_sources }}**.

{% endlist %}

## Просмотреть связи между объектами БД {#view-lineage}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, содержащий нужное хранилище данных.
  1. На панели слева выберите ![image](../../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.label_data-store }}**.
  1. Выберите нужное хранилище данных.
  1. Перейдите на вкладку **Связи**.

{% endlist %}
