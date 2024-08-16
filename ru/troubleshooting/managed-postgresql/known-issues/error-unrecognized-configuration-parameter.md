# Устранение ошибки `Unrecognized configuration parameter "stats_temp_directory"`


## Описание проблемы {#issue-description}

При выполнении запроса `SHOW stats_temp_directory` в логах кластера {{ PG }} появляются ошибки `unrecognized configuration parameter "stats_temp_directory"`.

## Решение {#issue-resolution}

Данное поведение [ожидаемо в версии {{ PG }} 15](https://git.postgresql.org/gitweb/?p=postgresql.git;a=commit;h=6f0cf87872ab2fd4a81249ca9d6299b9b1a52277) — эти ошибки можно игнорировать.

## Если проблема осталась {#if-issue-still-persists}

Если кластер {{ mpg-name }} продолжает работать неправильно, [создайте запрос в техническую поддержку]({{ link-console-support }}). При создании запроса укажите идентификатор проблемного кластера и кратко опишите проблему.