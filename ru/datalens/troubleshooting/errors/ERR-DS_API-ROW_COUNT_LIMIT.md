---
title: Ошибка ERR.DS_API.ROW_COUNT_LIMIT
description: На странице приведено описание ошибки ERR.DS_API.ROW_COUNT_LIMIT.
---

# Received too many result data rows

`ERR.DS_API.ROW_COUNT_LIMIT`

Превышено допустимое количество строк.

В {{ datalens-short-name }} есть ограничение на объем данных для отображения в чарте. Для каждого типа визуализации установлен свой [лимит](../../concepts/limits.md) на количество рядов.

Чтобы исправить ошибку, уменьшите объем запрошенных данных с помощью фильтров.
