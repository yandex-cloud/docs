# Устранение ошибки `No space left on device`


## Описание проблемы {#issue-description}

Попытка создать функцию завершается ошибкой:

```
zip I/O error: No space left on device
zip error: Output file write failure (write error on zip file)
```

## Решение {#issue-resolution}

Такая ошибка указывает на недостаток места – разворачиваемые пакеты превышают [лимиты {{ sf-name }}](../../../functions/concepts/limits.md#functions-limits)

Если нужны наиболее актуальные версии пакетов, а места под них в функции больше нет, то можно задействовать ВМ, на которой будет развернуто приложение.
