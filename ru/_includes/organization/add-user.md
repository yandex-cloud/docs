# Добавить пользователя в организацию

Добавьте пользователя в [организацию](../../overview/roles-and-resources.md) и [назначьте](../../iam/operations/roles/grant.md) ему подходящую [роль](../../iam/concepts/access-control/roles.md) для доступа к ресурсам {{ yandex-cloud }}. Например, пользователь сможет создавать кластеры управляемой базы данных или следить за состоянием используемых виртуальных машин.

Добавить можно [пользователей с аккаунтом на Яндексе](../../iam/concepts/users/accounts.md#passport) и [федеративных пользователей](../../iam/concepts/users/accounts.md#saml-federation). Для этого нужно быть администратором (роль `organization-manager.admin`) или владельцем (роль `organization-manager.organizations.owner`) организации. О том, как назначить пользователю роль, читайте в разделе [{#T}](../../iam/operations/roles/grant.md).

{% include [console-user-access](console-user-access.md) %}

## Пользователи с аккаунтом на Яндексе {#useraccount}

{% include notitle [useraccount](./useraccount.md) %}

## Федеративные пользователи {#user-sso}

{% include notitle [user-sso](./user-sso.md) %}
