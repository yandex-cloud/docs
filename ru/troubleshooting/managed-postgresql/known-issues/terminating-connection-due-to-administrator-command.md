# Устранение ошибки `terminating connection due to administrator command` и `ERROR: odyssey: remote server read/write error`


## Описание проблемы {#issue-description}

В кластере {{ mpg-name }} транзакция завершается ошибкой `terminating connection due to administrator command`  или  `"ERROR: odyssey: remote server read/write error sefc96761678e: (null) SSL SYSCALL error: EOF detected"`.

## Решение {#issue-resolution}

Ошибка может возникать, если транзакция не успела выполниться за 12 часов. В {{ yandex-cloud }} есть [ограничение на длительность сессии](../../../managed-postgresql/concepts/limits.md#mpg-quotas).

Чтобы увеличить длительность сессии, измените значение параметра `Session duration timeout` в настройках кластера — подробнее об этом параметре описано [в документации](../../../managed-postgresql/concepts/settings-list#setting-session-duration-timeout.md). Время для настройки указывается в миллисекундах.

Изменение этого параметра не приведет к сбоям в работе кластера.

{% note info %}

При восстановлении кластера из резервной копии значение параметра `Session duration timeout` сбрасывается до значения по умолчанию — 12 часов.

{% endnote %}
