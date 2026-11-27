---
title: Ошибка {{ datalens-full-name }} ERR.DS_API.DB.EST_EXEC_TOO_LONG
description: 'На странице приведено описание ошибки {{ datalens-full-name }} Estimated query execution time is too long. Maximum: 14400.'
alternate:
  - href: ru/datalens/troubleshooting/errors/ERR-DS_API-DB-EST_EXEC_TOO_LONG.md
    type: text/markdown
    title: Markdown version
---

# [{{ datalens-full-name }}] Estimated query execution time is too long. Maximum: 14400

`ERR.DS_API.DB.EST_EXEC_TOO_LONG`

Ошибка возникает, когда {{ CH }} по текущей скорости оценивает время выполнения запроса выше разрешенного максимума.

Чтобы исправить ошибку, сократите объем обрабатываемых данных с помощью фильтров, упростите соединения и вычисления, используйте ключи сортировки, предварительную агрегацию или материализованное представление.

Если запрос обоснованно должен выполняться дольше, обратитесь к администратору {{ CH }} для проверки лимитов времени и скорости выполнения.
