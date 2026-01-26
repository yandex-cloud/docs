Допустимые типы субъектов:

* `userAccount` — [аккаунт на Яндексе](../../iam/concepts/users/accounts.md#passport), добавленный в {{ yandex-cloud }}, или аккаунт из [пула пользователей](../../organization/concepts/user-pools.md).
* `serviceAccount` — [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), созданный в {{ yandex-cloud }}.
* `federatedUser` — аккаунт пользователя [федерации удостоверений](../../organization/concepts/add-federation.md).
* `system` — [публичная группа](../../iam/concepts/access-control/public-group.md) пользователей.

    Допустимые значения идентификатора субъекта:

    * `allAuthenticatedUsers` — [все пользователи, прошедшие аутентификацию](../../iam/concepts/access-control/public-group.md#allAuthenticatedUsers).
    * `allUsers` — [любой пользователь](../../iam/concepts/access-control/public-group.md#allUsers), прохождение аутентификации не требуется.
    * `group:organization:<идентификатор_организации>:users` — все пользователи указанной [организации](../../organization/concepts/organization.md).
    * `group:federation:<идентификатор_федерации>:users` — все пользователи указанной федерации удостоверений.

Подробнее о типах субъектов см. в разделе [Субъект, которому назначается роль](../../iam/concepts/access-control/index.md#subject).