Имя события | Описание
--- | ---
`awscompatibility.CreateEphemeralAccessKey` | Создание эфемерного статического ключа доступа
`awscompatibility.CreateTemporaryAccessKey` | Создание временного ключа доступа
`CreateIamToken` | Создание IAM-токена
`credential.ApplicationLoginEvent` | Вход пользователя в приложение
`credential.CreateRefreshTokenForSubject` | Создание [refresh-токена](../../../iam/concepts/authorization/refresh-token.md) для пользователя
`credential.RevokeRefreshTokenForSubject` | Отзыв refresh-токена у пользователя
`credential.RevokeSsoSession` | Завершение SSO-сессии
`mfa.VerifyUserCredential` | Подтверждение учетных данных пользователя в процессе проверки дополнительных [факторов MFA](../../../organization/concepts/mfa.md)
`oslogin.CheckSshPolicy` | Проверка прав на подключение по SSH при доступе по {{ oslogin }}
`oslogin.GenerateSshCertificate` | Генерация SSH-сертификата для доступа по {{ oslogin }}
`RevokeIamToken` | Отзыв IAM-токена