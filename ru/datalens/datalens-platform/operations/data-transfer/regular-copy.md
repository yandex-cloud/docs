---
title: Регулярное копирование в {{ datalens-platform-full-name }}
description: Следуя данной инструкции, вы сможете создать поставку данных типа Регулярное копирование в {{ datalens-platform-full-name }}
---

# Создание регулярного копирования

[Регулярное копирование](../../concepts/data-transfer/index.md#regular-copy) периодически переносит данные из источника в выбранное пространство имен [REST-каталога](../../concepts/rest-catalog/index.md) по заданному расписанию. Так данные в приемнике поддерживаются в актуальном состоянии без ручной перезагрузки.

{% include [sources](../../../../_includes/dlp/transfer/sources.md) %}

Чтобы создать регулярное копирование:

{% include [regular-copy](../../../../_includes/dlp/transfer/regular-copy-instruction.md) %}

{% include [activate](../../../../_includes/dlp/transfer/activate.md) %}

Чтобы проверить результат:

1. На странице загрузки откройте пространство имен в REST-каталоге.
1. Убедитесь, что в нем появились выбранные таблицы.
1. Откройте таблицу и проверьте ее структуру и данные в блоке **Предпросмотр**.

Подробнее об [изменении настроек](manage-transfer.md#update-transfer) и [приостановке поставки](manage-transfer.md#pause-transfer).
