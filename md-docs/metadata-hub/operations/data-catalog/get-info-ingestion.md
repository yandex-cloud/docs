# Получение информации о загрузке

{% note info %}

Эта функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}

## Получить информацию о загрузке {#ingestion-info}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **Data Catalog**.
  1. В открывшемся списке выберите каталог метаданных, в котором создана загрузка.
  1. На панели слева выберите ![image](../../../_assets/console-icons/arrow-up-from-square.svg) **Загрузки** и выберите нужную загрузку.
 
     Откроется вкладка **Обзор**, где отображается общая информация о загрузке и конфигурация, заданная при [создании](create-ingestion.md) загрузки.

{% endlist %}

## Получить информацию об операциях, связанных с загрузкой {#ingestion-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **Data Catalog**.
  1. В открывшемся списке выберите каталог метаданных, в котором создана загрузка.
  1. На панели слева выберите ![image](../../../_assets/console-icons/arrow-up-from-square.svg) **Загрузки** и выберите нужную загрузку.
  1. Перейдите на вкладку **Операции**.

     На вкладке можно просмотреть список всех операций, а также отфильтровать их по статусу и типу с помощью выпадающих списков.

{% endlist %}

## Получить логи загрузки {#ingestion-logs}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **Data Catalog**.
  1. В открывшемся списке выберите каталог метаданных, в котором создана загрузка.
  1. На панели слева выберите ![image](../../../_assets/console-icons/arrow-up-from-square.svg) **Загрузки** и выберите нужную загрузку.
  1. Перейдите на вкладку **Логи**.
  1. В выпадающем списке выберите операцию, чтобы просмотреть связанные с ней логи. Идентификатор и статус нужной операции можно [узнать](#ingestion-operations) на вкладке **Операции**.

{% endlist %}