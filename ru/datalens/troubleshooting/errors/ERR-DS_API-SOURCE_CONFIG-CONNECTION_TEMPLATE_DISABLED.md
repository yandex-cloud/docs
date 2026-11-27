---
title: Ошибка {{ datalens-full-name }} ERR.DS_API.SOURCE_CONFIG.CONNECTION_TEMPLATE_DISABLED
description: На странице приведено описание ошибки {{ datalens-full-name }} Template is disabled for this connection.
alternate:
  - href: ru/datalens/troubleshooting/errors/ERR-DS_API-SOURCE_CONFIG-CONNECTION_TEMPLATE_DISABLED.md
    type: text/markdown
    title: Markdown version
---

# [{{ datalens-full-name }}] Template is disabled for this connection

`ERR.DS_API.SOURCE_CONFIG.CONNECTION_TEMPLATE_DISABLED`

В датасете включена подстановка параметров в шаблон источника, но подключение ее запрещает.

Чтобы исправить ошибку, проверьте настройку подключения:

* Разрешите шаблоны, если это допустимо.
* Уберите подстановки из пути таблицы или запроса и отключите шаблон в датасете.
