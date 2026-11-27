---
title: Ошибка {{ datalens-full-name }} ERR.DS_API.DB.CANNOT_PARSE
description: На странице приведено описание ошибки {{ datalens-full-name }} Cannot parse.
alternate:
  - href: ru/datalens/troubleshooting/errors/ERR-DS_API-DB-CANNOT_PARSE.md
    type: text/markdown
    title: Markdown version
---

# [{{ datalens-full-name }}] Cannot parse

`ERR.DS_API.DB.CANNOT_PARSE`

Неправильный формат данных. Ошибка обычно связана с наличием пустых (`null`) значений при переводе данных из одного типа в другой.

Чтобы исправить ошибку, обработайте пустые значения, например, с помощью формулы:

```
FLOAT(IF([field_name]="") THEN "0.0" ELSE [field_name] END)
```

Где `field_name` — название поля, в котором возможны пустые (`null`) значения.
