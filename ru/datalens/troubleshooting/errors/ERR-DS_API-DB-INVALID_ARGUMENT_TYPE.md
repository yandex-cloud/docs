---
title: Ошибка {{ datalens-full-name }} ERR.DS_API.DB.INVALID_ARGUMENT_TYPE
description: На странице приведено описание ошибки {{ datalens-full-name }} Invalid argument type.
---

# [{{ datalens-full-name }}] Invalid argument type

`ERR.DS_API.DB.INVALID_ARGUMENT_TYPE`

Возникает, когда {{ CH }} получает аргумент неподходящего типа.

Чтобы исправить ошибку:

* Проверьте типы полей и аргументов функции в запросе или вычисляемом поле.
* При необходимости приведите значение к поддерживаемому типу.

В сообщении БД более конкретно указывается проблемная функция или выражение.

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
