# Запуск и остановка загрузки


{% note info %}

Эта функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}


Загрузки запускаются автоматически по тому расписанию, которое вы установили для них при [создании](create-ingestion.md) или [изменении](update-ingestion.md). Вы можете запустить или остановить загрузку, если в ее расписании указано **Ручной запуск**.

## Запустить загрузку {#start-ingestion}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно запустить загрузку.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **Data Catalog**.
  1. Выберите каталог метаданных, в котором нужно запустить загрузку, затем на панели слева выберите ![image](../../../_assets/console-icons/arrow-up-from-square.svg) **Загрузки**.
  1. В списке загрузок нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке с нужной загрузкой и выберите пункт **Запустить**.
  
  После успешного завершения загрузка примет статус **Success**, а загруженные данные будут [доступны для просмотра](#see-ingested-data).

{% endlist %}

## Остановить загрузку {#stop-ingestion}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **Data Catalog**.
  1. Выберите каталог, в котором нужно остановить загрузку, затем на панели слева выберите ![image](../../../_assets/console-icons/arrow-up-from-square.svg) **Загрузки**.
  1. В списке загрузок нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке с нужной загрузкой в статусе **Running** и выберите пункт **Остановить**.

{% endlist %}

## Посмотреть загруженные данные {#see-ingested-data}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором была создана загрузка.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **Data Catalog**.
  1. Выберите каталог метаданных, в котором создана загрузка, затем на панели слева выберите ![image](../../../_assets/console-icons/database-magnifier.svg) **Поиск по метаданным**.

  На странице отображается информация о загруженных данных — [источники данных](../../concepts/data-catalog.md#metadata-upload) (кластеры и пользовательские инсталляции), базы данных и таблицы. Здесь вы можете [найти нужные метаданные](search-metadata.md) и [разметить их](markup-metadata.md), а также [проанализировать их структуру и связи между ними](analysis-metadata.md).

{% endlist %}