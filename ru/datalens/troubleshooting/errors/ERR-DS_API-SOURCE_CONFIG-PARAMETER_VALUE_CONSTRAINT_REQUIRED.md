---
title: Ошибка {{ datalens-full-name }} ERR.DS_API.SOURCE_CONFIG.PARAMETER_VALUE_CONSTRAINT_REQUIRED
description: На странице приведено описание ошибки {{ datalens-full-name }} Value constraint is required.
alternate:
  - href: ru/datalens/troubleshooting/errors/ERR-DS_API-SOURCE_CONFIG-PARAMETER_VALUE_CONSTRAINT_REQUIRED.md
    type: text/markdown
    title: Markdown version
---

# [{{ datalens-full-name }}] Value constraint is required

`ERR.DS_API.SOURCE_CONFIG.PARAMETER_VALUE_CONSTRAINT_REQUIRED`

Для строкового параметра, используемого в шаблоне источника, требуется задать ограничение допустимых значений. Это требование защищает подстановку строковых значений в источник.

Чтобы исправить ошибку:

1. Добавьте ограничение для параметра или отключите его использование в шаблоне.
1. Сохраните датасет.
