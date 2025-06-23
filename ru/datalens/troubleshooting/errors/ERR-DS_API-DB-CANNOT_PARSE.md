---
title: Ошибка ERR.DS_API.DB.CANNOT_PARSE
description: На странице приведено описание ошибки ERR.DS_API.DB.CANNOT_PARSE.
---

# Cannot parse

`ERR.DS_API.DB.CANNOT_PARSE`

Неправильный формат данных. Ошибка обычно связана с наличием пустых (`null`) значений при переводе данных из одного типа в другой.

Чтобы исправить ошибку, обработайте пустые значения, например, с помощью формулы:

```
FLOAT(IF([field_name]="") THEN "0.0" ELSE [field_name] END)
```

Где `field_name` — название поля, в котором возможны пустые (`null`) значения.
