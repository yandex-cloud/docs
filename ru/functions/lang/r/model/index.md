---
title: "Модель программирования на языке R в {{ sf-full-name }}"
description: "Задание обработчика функций подразумевает написание функции R с параметрами event и context."
---

# Модель программирования на языке R

Задание обработчика функций подразумевает написание функции R со следующими параметрами:
* `event` — [запрос](../../../concepts/function-invoke.md#request).
* `context` — информация о [контексте вызова](../context.md).

## Примеры {#examples}

### Работа с аргументами HTTP запроса {#http-req}

Следующая функция выводит значение параметра запроса `arg`:

```R
handler <- function(event, context) {
  return (list(statusCode = 200, body = event$queryStringParameters$arg))
}
```
