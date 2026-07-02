[Документация Yandex Cloud](../../../index.md) > [Yandex MetaData Hub](../../index.md) > Data Catalog > Пошаговые инструкции > Источники > Создание источника

# Создание источника


{% note info %}

Эта функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) ресурсов, в котором создан каталог метаданных.
    1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
    1. На панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **Data Catalog**.
    1. В открывшемся списке выберите каталог метаданных, в котором вы хотите создать источник.
    1. На панели слева выберите ![image](../../../_assets/console-icons/cloud-arrow-up-in.svg) **Источники данных**.
    1. Нажмите кнопку **Создать источник данных**.
    1. Задайте уникальное имя источника. После создания источника нельзя будет изменить его имя.
    1. (Опционально) Добавьте описание источника.
    1. Выберите тип бэкенда, из которого будут поставляться метаданные. После создания источника его тип нельзя будет изменить. Доступные бэкенды:
       
       * PostgreSQL;
       * MySQL®;
       * ClickHouse®;
       * Yandex StoreDoc/MongoDB;
       * OpenSearch;
       * Greenplum®;
       * Yandex Data Transfer;
       * WebSQL;
       * DataLens.

    1. Укажите параметры источника для выбранного типа бэкенда:

        * **ID подключения** — идентификатор управляемого подключения в [Yandex Connection Manager](../../quickstart/connection-manager.md).
        * **Имя базы данных** — имя базы данных, из которой будут загружаться метаданные.

    1. Нажмите кнопку **Создать**.

{% endlist %}