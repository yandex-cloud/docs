# Устранение ошибки при выполнении запроса `Exception Memory limit (total) exceeded`


## Описание проблемы {#issue-description}

При выполнении запроса в {{ CH }} возникает ошибка:

```
DB::Exception: Memory limit (total) exceeded: would use XX.XX GiB (attempt to allocate chunk of XXXXXXXX bytes), maximum: XX.X GiB. (MEMORY_LIMIT_EXCEEDED), Stack trace (when copying this message, always include the lines below)
```

## Решение {#issue-resolution}

Такая ошибка говорит о том, что запрос к базе превышает установленный для пользователя лимит оперативной памяти. Увеличить его можно в [Консоли управления]({{ link-console-main }}) во вкладке **{{ ui-key.yacloud.clickhouse.cluster.switch_users }}**. Для этого нужно изменить параметр `max_memory_usage`. 

{% note warning %}

Лимит `max_memory_usage` не должен превышать параметр `max_server_memory_usage`.

{% endnote %}

Если в кластере включено управление пользователями через SQL, то можно задать этот параметр:

* Для сессии, через `set max_memory_usage`;
* Для всех пользователей по умолчанию, [создав один профиль настроек](https://clickhouse.tech/docs/ru/operations/access-rights/#settings-profiles-management).

## Если проблема осталась {#if-issue-still-persists}

Если вышеописанные действия не помогли решить проблему, [создайте запрос в техническую поддержку]({{ link-console-support }}). При создании запроса укажите следующую информацию:

1. Идентификатор кластера {{ mch-full-name }}.
1. Код запроса к базе.
1. Полный текст сообщения об ошибке.