---
title: Ошибка {{ datalens-full-name }} ERR.DS_API.FORMULA.UNKNOWN_SOURCE_COLUMN
description: На странице приведено описание ошибки {{ datalens-full-name }} Unknown referenced source column.
alternate:
  - href: ru/datalens/troubleshooting/errors/ERR-DS_API-FORMULA-UNKNOWN_SOURCE_COLUMN.md
    type: text/markdown
    title: Markdown version
---

# [{{ datalens-full-name }}] Unknown referenced source column

`ERR.DS_API.FORMULA.UNKNOWN_SOURCE_COLUMN`

Поле ссылается на столбец, которого нет в источнике. Возможно столбец раньше существовал, но был удален.

Если в источнике данных он существует, но не распознается датасетом, [обновите поля](../../dataset/create-dataset.md#update-fields).
