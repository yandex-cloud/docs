---
title: Получение информации о загрузке
description: Следуя данной инструкции, вы получите информацию о загрузке в {{ data-catalog-full-name }}.
---

# Получение информации о загрузке

{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}

## Получить информацию о загрузке {#ingestion-info}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, в котором создана загрузка.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud.data-catalog.label_ingestions }}** и выберите нужную загрузку.
 
     Откроется вкладка **{{ ui-key.yacloud.data-catalog.label_ingestion-tab-overview }}**, где отображается общая информация о загрузке и конфигурация, заданная при [создании](create-ingestion.md) загрузки.

{% endlist %}

## Получить информацию об операциях, связанных с загрузкой {#ingestion-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, в котором создана загрузка.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud.data-catalog.label_ingestions }}** и выберите нужную загрузку.
  1. Перейдите на вкладку **{{ ui-key.yacloud.data-catalog.label_ingestion-tab-operations }}**.

     На вкладке можно просмотреть список всех операций, а также отфильтровать их по статусу и типу с помощью выпадающих списков.

{% endlist %}

## Получить логи загрузки {#ingestion-logs}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, в котором создана загрузка.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud.data-catalog.label_ingestions }}** и выберите нужную загрузку.
  1. Перейдите на вкладку **{{ ui-key.yacloud.data-catalog.label_ingestion-tab-logs }}**.
  1. В выпадающем списке выберите операцию, чтобы просмотреть связанные с ней логи. Идентификатор и статус нужной операции можно [узнать](#ingestion-operations) на вкладке **{{ ui-key.yacloud.data-catalog.label_ingestion-tab-operations }}**.

{% endlist %}

