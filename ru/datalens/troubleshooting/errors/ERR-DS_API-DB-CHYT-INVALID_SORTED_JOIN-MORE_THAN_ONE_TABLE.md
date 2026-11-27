---
title: Ошибка {{ datalens-full-name }} ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.MORE_THAN_ONE_TABLE
description: На странице приведено описание ошибки {{ datalens-full-name }} Cannot join a concatenation of tables with another table.
alternate:
  - href: ru/datalens/troubleshooting/errors/ERR-DS_API-DB-CHYT-INVALID_SORTED_JOIN-MORE_THAN_ONE_TABLE.md
    type: text/markdown
    title: Markdown version
---

# [{{ datalens-full-name }}] Cannot join a concatenation of tables with another table

`ERR.DS_API.DB.CHYT.INVALID_SORTED_JOIN.MORE_THAN_ONE_TABLE`

При подключении к CHYT в JOIN нельзя использовать два диапазона таблиц (и слева, и справа).

Чтобы исправить ошибку, один из диапазонов перепишите как подзапрос.
