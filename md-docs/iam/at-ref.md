# Справочник аудитных логов Yandex Audit Trails

В Audit Trails для Yandex Identity and Access Management поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.iam.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`CreateAccessKey` | Создание статического ключа
`CreateApiKey` | Создание API-ключа
`CreateCertificate` | Добавление сертификата для федерации
`CreateIamCookieForSubject` | Вход федеративного пользователя ^*^
`CreateKey` | Создание пары ключей для сервисного аккаунта
`CreateServiceAccount` | Создание сервисного аккаунта
`DeleteAccessKey` | Удаление статического ключа
`DeleteApiKey` | Удаление API-ключа
`DeleteCertificate` | Удаление сертификата для федерации
`DeleteKey` | Удаление пары ключей для сервисного аккаунта
`DeleteServiceAccount` | Удаление сервисного аккаунта
`DetectLeakedCredential` | Обнаружение секрета в открытом источнике
`DisableService` | Отзыв у сервиса доступа к ресурсам других сервисов в облаке
`EnableService` | Выдача сервису доступа к ресурсам других сервисов в облаке
`mfa.CreateUserCredential` | Создание учетных данных пользователя в процессе проверки дополнительных [факторов MFA](../organization/concepts/mfa.md)
`mfa.DeleteUserCredential` | Удаление учетных данных пользователя в процессе проверки дополнительных [факторов MFA](../organization/concepts/mfa.md)
`mfa.UpdateUserCredential` | Изменение учетных данных пользователя в процессе проверки дополнительных [факторов MFA](../organization/concepts/mfa.md)
`oauthclient.CreateOAuthClient` | Создание OAuth-клиента
`oauthclient.CreateOAuthClientSecret` | Создание секрета для OAuth-клиента
`oauthclient.DeleteOAuthClient` | Удаление OAuth-клиента
`oauthclient.DeleteOAuthClientSecret` | Удаление секрета для OAuth-клиента
`oauthclient.UpdateOAuthClient` | Обновление OAuth-клиента
`ReactivateServiceAccount` | Активация сервисного аккаунта
`RevokeLeakedCredential` | Отзыв скомпрометированного секрета
`SetServiceAccountAccessBindings` | Назначение прав доступа для сервисного аккаунта
`SuspendServiceAccount` | Деактивация сервисного аккаунта
`UpdateAccessKey` | Обновление статического ключа
`UpdateApiKey` | Обновление API-ключа
`UpdateCertificate` | Обновление сертификата
`UpdateKey` | Обновление пары ключей
`UpdateServiceAccount` | Обновление сервисного аккаунта
`UpdateServiceAccountAccessBindings` | Изменение прав доступа для сервисного аккаунта
`workload.CreateFederatedCredential` | Создание [привязки](concepts/workload-identity.md#federated-credentials) в федерации сервисных аккаунтов
`workload.DeleteFederatedCredential` | Удаление привязки из федерации сервисных аккаунтов
`workload.oidc.CreateFederation` | Создание [федерации сервисных аккаунтов](concepts/workload-identity.md)
`workload.oidc.DeleteFederation` | Удаление федерации сервисных аккаунтов
`workload.oidc.SetFederationAccessBindings` | Назначение прав доступа федерации сервисных аккаунтов
`workload.oidc.UpdateFederation` | Изменение федерации сервисных аккаунтов
`workload.oidc.UpdateFederationAccessBindings` | Изменение прав доступа федерации сервисных аккаунтов

\* Событие попадает в аудитный лог, только если [область сбора аудитных логов](../audit-trails/concepts/trail.md#collecting-area) трейла — `Организация`.

## Справочник событий уровня сервисов {#data-plane-events}

Имя события | Описание
--- | ---
`awscompatibility.CreateEphemeralAccessKey` | Создание эфемерного статического ключа доступа
`awscompatibility.CreateTemporaryAccessKey` | Создание временного ключа доступа
`CreateIamToken` | Создание IAM-токена
`credential.ApplicationLoginEvent` | Вход пользователя в приложение
`credential.CreateRefreshTokenForSubject` | Создание [refresh-токена](concepts/authorization/refresh-token.md) для пользователя
`credential.CreateYcSsprToken` | Создание токена для самостоятельного сброса пароля
`credential.RevokeRefreshTokenForSubject` | Отзыв refresh-токена у пользователя
`credential.RevokeSsoSession` | Завершение SSO-сессии
`mfa.VerifyUserCredential` | Подтверждение учетных данных пользователя в процессе проверки дополнительных [факторов MFA](../organization/concepts/mfa.md)
`oslogin.CheckSshPolicy` | Проверка прав на подключение по SSH при доступе по OS Login
`oslogin.GenerateSshCertificate` | Генерация SSH-сертификата для доступа по OS Login
`RevokeIamToken` | Отзыв IAM-токена