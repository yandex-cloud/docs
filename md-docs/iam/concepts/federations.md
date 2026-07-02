[Документация Yandex Cloud](../../index.md) > [Yandex Identity and Access Management](../index.md) > [Концепции](index.md) > Федерации удостоверений

# Федерации удостоверений

С помощью [Yandex Identity Hub](../../organization/index.md) вы можете настроить Single Sign-On аутентификацию в Yandex Cloud через ваш Identity Provider, например Active Directory или Google Workspace. 

Такой подход к аутентификации называется федерация удостоверений: сотрудники компании используют свои корпоративные или локальные аккаунты из [пула пользователей](../../organization/concepts/user-pools.md) и аутентифицируются только в корпоративной системе аутентификации. Для доступа к ресурсам в Yandex Cloud им не нужны аккаунты в Яндекс ID.

Для работы в составе федерации удостоверений Identity Provider должен поддерживать стандарт SAML 2.0.

## Что дальше {#what-is-next}

* Узнайте, как [добавить пользователя](../../organization/operations/add-account.md#user-sso) из федерации удостоверений.
* Узнайте, как настроить федерацию удостоверений в документации [Yandex Identity Hub](../../organization/concepts/add-federation.md).