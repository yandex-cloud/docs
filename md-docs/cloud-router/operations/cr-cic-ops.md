[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Router](../index.md) > Концепции > Обзор операций

# Обзор операций

## Порядок действий {#order}

Для создания сетевой топологии гибридного облака:

1. [Создайте транковое подключение](../../interconnect/operations/trunk-create.md), чтобы организовать физическую связность между вашей инфраструктурой и Yandex Cloud.
1. Создайте в транковом подключении [приватное](../../interconnect/operations/priv-con-create.md) или [публичное](../../interconnect/operations/pub-con-create.md) соединение.
1. Для приватного соединения [создайте виртуальный маршрутизатор](ri-create.md).
1. [Добавьте приватное соединение](ri-priv-con-add.md) в виртуальный маршрутизатор.
1. [Добавьте облачные сети и IP-префиксы](ri-prefixes-upsert.md), которые должны анонсироваться в вашу инфраструктуру.
1. При необходимости [добавьте статические маршруты](../../interconnect/operations/priv-con-update.md) в приватное соединение для топологии VPC Stitching.

Большинство операций с ресурсами Cloud Interconnect и Cloud Router вы можете выполнять самостоятельно с помощью консоли управления, CLI и API. Для создания, изменения и удаления публичных соединений, изменения емкости транкового подключения, уведомления партнера и организации физической кроссировки прямого подключения вам по-прежнему нужно обращаться в поддержку.

## Транковое подключение {#trunk}

Действие | Самостоятельно | Через поддержку
--- | --- | ---
Получить информацию | [Инструкция](../../interconnect/operations/trunk-get-info.md) | —
Получить список операций | [Инструкция](../../interconnect/operations/trunk-operations.md) | —
Создать прямое подключение | [Инструкция](../../interconnect/operations/trunk-create.md#direct) | Согласительное письмо и физическое подключение описаны в инструкции
Создать подключение через партнера | [Инструкция](../../interconnect/operations/trunk-create.md#partner) | Уведомление партнера описано в инструкции
Изменить основные параметры | [Инструкция](../../interconnect/operations/trunk-update.md#update) | —
Изменить емкость | — | [Инструкция](../../interconnect/operations/trunk-update.md#capacity)
Переместить в другой каталог | [Инструкция](../../interconnect/operations/trunk-move.md) | —
Удалить | [Инструкция](../../interconnect/operations/trunk-delete.md) | —

## Приватное соединение {#prc}

Действие | Самостоятельно | Через поддержку
--- | --- | ---
Получить информацию | [Инструкция](../../interconnect/operations/priv-con-get-info.md) | —
Получить список операций | [Инструкция](../../interconnect/operations/priv-con-operations.md) | —
Создать | [Инструкция](../../interconnect/operations/priv-con-create.md) | —
Изменить параметры | [Инструкция](../../interconnect/operations/priv-con-update.md) | —
Переместить в другой каталог | [Инструкция](../../interconnect/operations/priv-con-move.md) | —
Удалить | [Инструкция](../../interconnect/operations/priv-con-delete.md) | —
Добавить или удалить статические маршруты | [Инструкция](../../interconnect/operations/priv-con-update.md) | —

## Виртуальный маршрутизатор {#ri}

Действие | Самостоятельно | Через поддержку
--- | --- | ---
Получить информацию | [Инструкция](ri-get-info.md) | —
Получить список операций | [Инструкция](ri-operations.md) | —
Создать | [Инструкция](ri-create.md) | —
Изменить основные параметры | [Инструкция](ri-update.md) | —
Изменить сети и IP-префиксы | [Инструкция](ri-prefixes-upsert.md) | —
Добавить приватное соединение | [Инструкция](ri-priv-con-add.md) | —
Удалить приватное соединение | [Инструкция](ri-priv-con-del.md) | —
Удалить | [Инструкция](ri-delete.md) | —

## Публичное соединение {#pbc}

Действие | Самостоятельно | Через поддержку
--- | --- | ---
Получить информацию | [Инструкция](../../interconnect/operations/pub-con-get-info.md) | —
Создать | — | [Инструкция](../../interconnect/operations/pub-con-create.md)
Изменить | — | [Обратиться в поддержку](https://center.yandex.cloud/support)
Удалить | — | [Инструкция](../../interconnect/operations/pub-con-delete.md)

## Прочее {#other}

Действие | Самостоятельно
--- | ---
Получить информацию о партнерах Cloud Interconnect | [Инструкция](../../interconnect/operations/partner-get-info.md)
Получить информацию о точках присутствия | [Инструкция](../../interconnect/operations/pop-get-info.md)