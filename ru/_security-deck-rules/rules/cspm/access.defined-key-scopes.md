### Для API-ключей сервисных аккаунтов заданы минимально необходимые области действия {#defined-key-scopes}

#|
|| **kind** | **severity** | **ID** ||
|| manual | medium | access.defined-key-scopes ||
|#

#### Описание

Область действия — совокупность разрешенных сервисному аккаунту действий с ресурсами сервиса. В сервисе может быть больше одной области действия. API-ключ с заданными областями действия нельзя использовать в других сервисах или областях действия.

[Области действия](https://yandex.cloud/ru/docs/iam/concepts/authorization/api-key#scoped-api-keys) ограничивают применение [API-ключей](https://yandex.cloud/ru/docs/iam/concepts/authorization/api-key) в дополнение к собственным правам доступа сервисного аккаунта. Настройка ограничений области и срока действия позволяет снизить риск несанкционированного использования ключей. Задавайте для API-ключей только те области действия, которые действительно необходимы.

Больше информации: <https://yandex.cloud/ru/docs/security/standard/authentication#api-key-scopes>

#### Инструкции и решения по выполнению

[Создайте](https://yandex.cloud/ru/docs/iam/operations/authentication/manage-api-keys#create-api-key) API-ключ с заданной областью действия.