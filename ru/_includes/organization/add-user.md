# Добавить пользователя в организацию

Добавьте пользователя в [организацию](../../overview/roles-and-resources.md) и [назначьте](../../iam/operations/roles/grant.md) ему подходящую [роль](../../iam/concepts/access-control/roles.md), чтобы предоставить доступ к ресурсам {{ yandex-cloud }}. Например, роли необходимы, чтобы пользователь мог создавать кластеры управляемой базы данных или следить за состоянием используемых виртуальных машин.

Добавить в организацию можно [пользователей с аккаунтом на Яндексе](../../iam/concepts/users/accounts.md#passport), [федеративных пользователей](../../iam/concepts/users/accounts.md#saml-federation) и [локальных пользователей](../../iam/concepts/users/accounts.md#local). В результате добавленные пользователи станут участниками организации, и вы сможете назначить им роли. Пока пользователю организации не назначены роли, он не имеет доступа к ресурсам в облаках этой организации. О том, как назначить пользователю роль, читайте в разделе [{#T}](../../iam/operations/roles/grant.md).

Чтобы добавлять пользователей в организацию, нужно быть администратором (роль `organization-manager.admin`) или владельцем (роль `organization-manager.organizations.owner`) этой организации, либо иметь роль администратора того типа пользовательских аккаунтов, которые требуется добавить.

{% include [console-user-access](console-user-access.md) %}

## Пользователи с аккаунтом на Яндексе {#useraccount}

{% include notitle [useraccount](./useraccount.md) %}

## Федеративные пользователи {#user-sso}

{% include notitle [user-sso](./user-sso.md) %}

## Локальные пользователи {#local-users}

{% include notitle [local-user](./local-user.md) %}