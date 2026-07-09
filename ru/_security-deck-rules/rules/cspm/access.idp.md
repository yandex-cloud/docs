### Настроена федерация удостоверений (Single Sign-On, SSO) {#idp}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | information | access.idp ||
|#

#### Описание

В Yandex Cloud существует два способа централизованно управлять учетными данными пользователей:

* [Федерация удостоверений](https://yandex.cloud/ru/docs/organization/concepts/add-federation) (внешний IdP) — обеспечивает пользователям доступ к приложениям с помощью системы единого входа (Single Sign-On, SSO). С помощью SSO пользователи могут получать доступ ко множеству приложений без необходимости каждый раз вводить свой логин и пароль.

Если в вашей компании есть система управления пользователями и доступом (например, Active Directory или Google Workspace), вы можете использовать ее для аутентификации сотрудников в [Yandex Identity Hub](https://yandex.cloud/ru/docs/organization/). Тогда не нужно будет создавать новый аккаунт в Яндексе для каждого сотрудника компании, сотрудники смогут получить доступ к сервисам Yandex Cloud с помощью своих корпоративных аккаунтов.

* [Пулы пользователей](https://yandex.cloud/ru/docs/organization/concepts/user-pools) — позволяют привязывать ваши [домены](https://yandex.cloud/ru/docs/organization/concepts/domains), управлять правами доступа, настройками аутентификации и данными, доступными для редактирования на портале [Мой аккаунт](https://yandex.cloud/ru/docs/organization/concepts/my-account).

Пулы и пользователи в них существуют только на уровне организаций, на них распространяются [политики безопасности](https://yandex.cloud/ru/docs/security/standarts) Yandex Cloud.

#### Инструкции и решения по выполнению

Для централизованного управления учетными данными используйте [SAML-совместимые федерации удостоверений](https://yandex.cloud/ru/docs/organization/concepts/add-federation) или [пулы пользователей](https://yandex.cloud/ru/docs/organization/concepts/user-pools).

С помощью федераций удостоверений вы можете настроить аутентификацию Single Sign-On в Yandex Cloud через свой сервер IdP. При таком подходе сотрудники имеют возможность использовать свои корпоративные аккаунты, на которые распространяются политики безопасности компании.

Подробнее в разделе [Федерации удостоверений](https://yandex.cloud/ru/docs/organization/concepts/add-federation).

Пулы пользователей объединяют [локальных пользователей](https://yandex.cloud/ru/docs/iam/concepts/users/accounts#local) и позволяют централизованно управлять такими пользователями, привязывать ваши [домены](https://yandex.cloud/ru/docs/organization/concepts/domains), управлять правами доступа, настройками аутентификации и данными, доступными для редактирования на портале [Мой аккаунт](https://yandex.cloud/ru/docs/organization/concepts/my-account).

Подробнее о создании пулов пользователей в разделе [Создать пул пользователей](https://yandex.cloud/ru/docs/organization/operations/user-pools/create-userpool).
