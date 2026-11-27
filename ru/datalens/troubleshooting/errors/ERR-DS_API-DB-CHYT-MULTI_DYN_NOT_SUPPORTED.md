---
title: Ошибка {{ datalens-full-name }} ERR.DS_API.DB.CHYT.MULTI_DYN_NOT_SUPPORTED
description: На странице приведено описание ошибки {{ datalens-full-name }} Reading multiple dynamic tables or dynamic table together with static table is not supported in CHYT.
alternate:
  - href: ru/datalens/troubleshooting/errors/ERR-DS_API-DB-CHYT-MULTI_DYN_NOT_SUPPORTED.md
    type: text/markdown
    title: Markdown version
---

# [{{ datalens-full-name }}] Reading multiple dynamic tables or dynamic table together with static table is not supported in CHYT

`ERR.DS_API.DB.CHYT.MULTI_DYN_NOT_SUPPORTED`

Ошибка возникает, когда один запрос CHYT читает несколько динамических таблиц либо одновременно динамическую и статическую таблицы.

Чтобы исправить ошибку, оставьте в запросе одну динамическую таблицу, разделите запросы или предварительно материализуйте необходимые данные в одну статическую таблицу.
