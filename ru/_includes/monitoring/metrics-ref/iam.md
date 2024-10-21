Имя метрики пишется в метку `name`.

Общие метки для всех метрик {{ iam-name }}:

| Метка | Значение |
| --- | --- |
| service | Идентификатор сервиса: `iam` |
| key_id | Идентификатор [ключа](../../../iam/concepts/index.md#keys) |
| service_account | Идентификатор [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) |

Метрики сервиса:

| Имя метрики<br>Тип, единицы измерения | Описание<br>Метки |
| --- | --- |
| `service_account.access_key.authentication_events_count`<br>`COUNTER`, штуки | Количество событий аутентификации с использованием статического ключа доступа сервисного аккаунта. |
| `service_account.api_key.authentication_events_count`<br>`COUNTER`, штуки | Количество событий аутентификации с использованием API-ключа сервисного аккаунта. |
| `service_account.api_key.authentication_failed_events_count`<br>`COUNTER`, штуки | Количество неуспешных событий аутентификации с использованием API-ключа сервисного аккаунта.<br>Метка `code` — код ошибки. |
| `service_account.authorized_key.authentication_events_count`<br>`COUNTER`, штуки | Количество событий аутентификации с использованием авторизованного ключа сервисного аккаунта. |
| `service_account.authorized_key.create_token_events_count`<br>`COUNTER`, штуки | Количество событий создания токена с использованием авторизованного ключа сервисного аккаунта. |
| `service_account.authorized_key.create_token_failed_events_count`<br>`COUNTER`, штуки | Количество неуспешных событий создания токена с использованием авторизованного ключа сервисного аккаунта.<br>Метка `code` — код ошибки. |