Имя события | Описание
--- | ---
`AddFederatedUserAccounts` | Добавление пользователя в федерацию
`CreateAccessKey` | Создание статического ключа
`CreateApiKey` | Создание API-ключа
`CreateCertificate` | Добавление сертификата для федерации
`CreateFederation` | Создание федерации
`CreateIamCookieForSubject` | Вход федеративного пользователя ^*^
`CreateKey` | Создание пары ключей для сервисного аккаунта
`CreateServiceAccount` | Создание сервисного аккаунта
`DeleteAccessKey` | Удаление статического ключа
`DeleteApiKey` | Удаление API-ключа
`DeleteCertificate` | Удаление сертификата для федерации
`DeleteFederation` | Удаление федерации
`DeleteKey` | Удаление пары ключей для сервисного аккаунта
`DeleteServiceAccount` | Удаление сервисного аккаунта
`DetectLeakedCredential` | Обнаружение секрета в открытом источнике
`DisableService` | Отзыв у сервиса доступа к ресурсам других сервисов в облаке
`EnableService` | Выдача сервису доступа к ресурсам других сервисов в облаке
`SetServiceAccountAccessBindings` | Назначение прав доступа для сервисного аккаунта
`UpdateAccessKey` | Обновление статического ключа
`UpdateApiKey` | Обновление API-ключа
`UpdateCertificate` | Обновление сертификата
`UpdateFederation` | Обновление федерации
`UpdateKey` | Обновление пары ключей
`UpdateServiceAccount` | Обновление сервисного аккаунта
`UpdateServiceAccountAccessBindings` | Изменение прав доступа для сервисного аккаунта
`workload.CreateFederatedCredential` | Создание [привязки](../../../iam/concepts/workload-identity.md#federated-credentials) в федерации сервисных аккаунтов
`workload.DeleteFederatedCredential` | Удаление привязки из федерации сервисных аккаунтов
`workload.oidc.CreateFederation` | Создание [федерации сервисных аккаунтов](../../../iam/concepts/workload-identity.md)
`workload.oidc.DeleteFederation` | Удаление федерации сервисных аккаунтов
`workload.oidc.UpdateFederation` | Изменение федерации сервисных аккаунтов

\* Событие попадает в аудитный лог, только если [область сбора аудитных логов](../../../audit-trails/concepts/trail.md#collecting-area) трейла — `Организация`.