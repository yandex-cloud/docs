---
title: Ошибка {{ datalens-full-name }} ERR.DS_API.DB.CANNOT_INSERT_NULL_IN_ORDINARY_COLUMN
description: На странице приведено описание ошибки {{ datalens-full-name }} Cannot convert NULL value to non-Nullable type.
---

# [{{ datalens-full-name }}] Cannot convert NULL value to non-Nullable type

`ERR.DS_API.DB.CANNOT_INSERT_NULL_IN_ORDINARY_COLUMN`


Ошибка возникает, когда {{ CH }} пытается записать или преобразовать значение `NULL` в поле с типом, не допускающим значений `NULL`.

Чтобы исправить ошибку, проверьте схему и данные источника, согласуйте `Nullable`-типы или замените `NULL` подходящим значением с помощью `ifNull`/`coalesce`.



Если ошибка возникает в автоматически сформированном запросе и исправить источник или вычисляемое поле невозможно, обратитесь в [техническую поддержку]({{ link-console-support }}) {{ yandex-cloud }}. В сообщении опишите, когда возникает ошибка.

