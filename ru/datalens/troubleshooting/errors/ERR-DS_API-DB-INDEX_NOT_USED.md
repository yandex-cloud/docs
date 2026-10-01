---
title: Ошибка {{ datalens-full-name }} ERR.DS_API.DB.INDEX_NOT_USED
description: На странице приведено описание ошибки {{ datalens-full-name }} Filtration by any of indexed columns required.
---

# [{{ datalens-full-name }}] Filtration by any of indexed columns required

`ERR.DS_API.DB.INDEX_NOT_USED`

Ошибка возникает, когда профиль пользователя требует использовать индекс или ключ таблицы, но фильтр запроса этого не делает.

Чтобы исправить ошибку, добавьте фильтр по колонкам первичного ключа или ключа сортировки.

Если такой фильтр для отчета неприменим, обратитесь к администратору источника для проверки ограничений и настроек пользователя БД.
