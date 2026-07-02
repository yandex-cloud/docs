[Документация Yandex Cloud](../../../index.md) > [Yandex Identity and Access Management](../../index.md) > [Концепции](../index.md) > [Как устроено управление доступом](index.md) > Системные группы

# Системные группы

_Системная группа_ — группа пользователей (субъектов), на которую можно назначать [роли](roles.md). В Yandex Cloud существует три типа системных групп: `All users in organization X`, `All users in federation N` и `All users in userpool P`. Эти группы позволяют предоставить доступ к вашим ресурсам для заданной группы пользователей, но только на те операции, которые позволяет выполнять назначенная роль. В системные группы не входят [сервисные аккаунты](../users/service-accounts.md).

Системные группы являются динамическими: при добавлении нового пользователя в организацию, федерацию или пул пользователей он автоматически получает все права, назначенные на соответствующую организацию, федерацию или пул. При удалении пользователя из организации, федерации или пула пользователь автоматически теряет такие права.

Небезопасно назначать системным группам роли с широким набором разрешений, такие как `editor` или `admin`.

### All users in organization X {#allOrganizationUsers}

Системная группа `All users in organization X` — это все пользователи [организации](../../../organization/quickstart.md) `X`, к которой относится группа.

### All users in federation N {#allFederationUsers}

Системная группа `All users in federation N` — это все пользователи [федерации удостоверений](../../../organization/concepts/add-federation.md) `N`, к которой относится группа.

### All users in userpool P {#allUserpoolUsers}

Системная группа `All users in userpool P` — это все [локальные пользователи](../users/accounts.md#local) [пула пользователей](../../../organization/concepts/user-pools.md) `P`, к которому относится группа.

## Примеры использования {#examples}

* [Аутентификация с помощью Active Directory](../../../tutorials/security/integration-adfs.md)
* [Аутентификация с помощью Microsoft Entra ID](../../../tutorials/security/integration-azure.md)