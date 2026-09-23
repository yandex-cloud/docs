---
title: Ошибка {{ datalens-full-name }} ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.KEY_IS_EMPTY
description: 'На странице приведено описание ошибки {{ datalens-full-name }} Cannot join: key is empty.'
---

# [{{ datalens-full-name }}] Cannot join: key is empty

`ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.KEY_IS_EMPTY`

Ошибка возникает, когда CHYT не может выделить ключ соединения из `ON`/`USING`.

Чтобы исправить ошибку, добавьте хотя бы одно прямое равенство ключевых колонок и убедитесь, что соединяемые колонки входят в префиксы ключей сортировки обеих таблиц.
