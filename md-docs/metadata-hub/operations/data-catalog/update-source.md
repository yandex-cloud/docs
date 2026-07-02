[Документация Yandex Cloud](../../../index.md) > [Yandex MetaData Hub](../../index.md) > Data Catalog > Пошаговые инструкции > Источники > Изменение источника

# Изменение источника


{% note info %}

Эта функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
    1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
    1. На панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **Data Catalog**.
    1. В открывшемся списке выберите каталог метаданных, в котором вы хотите изменить источник.
    1. На панели слева выберите ![image](../../../_assets/console-icons/cloud-arrow-up-in.svg) **Источники данных**.
    1. В списке источников нажмите кнопку ![image](../../../_assets/console-icons/ellipsis.svg) в строке с нужным источником и выберите **Редактировать**.
    1. Измените нужные параметры:

        * Описание источника.

        * **ID подключения** — идентификатор управляемого подключения в [Yandex Connection Manager](../../quickstart/connection-manager.md).
        * **Имя базы данных** — имя базы данных, из которой будут загружаться метаданные.

    1. Нажмите кнопку **Сохранить изменения**.

{% endlist %}