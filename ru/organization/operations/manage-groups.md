# Управление группами пользователей

Вы можете объединять пользователей в [группы](../concepts/groups.md) по любому признаку: например, в соответствии с их должностными обязанностями или отделом.

## Создать группу {#create-group}

{% include [create-group-org](../../_includes/organization/create-group-org.md) %}

## Добавить участников {#add-member}

{% include [group-add-member.md](../../_includes/organization/group-add-member.md) %}

## Редактировать группу {#edit-group}

{% include [group-edit](../../_includes/organization/group-edit.md) %}

## Настроить доступ к управлению группой {#access-manage-group}

Измените права [субъекта](../../iam/concepts/access-control/index.md#subject) на доступ к группе как к ресурсу.

### Назначить роль {#set-access-binding}

{% include [accessbinding-group-as-object](../../_includes/organization/accessbinding-group-as-object.md) %}

### Отозвать роль {#remove-access-binding}

{% include [accessbinding-remove](../../_includes/organization/accessbinding-remove.md) %}

## Настроить доступ группы к работе в {{ yandex-cloud }} {#access}

Чтобы участники группы могли работать с сервисами {{ yandex-cloud }}, назначьте группе соответствующие [роли](../../iam/concepts/access-control/roles.md).

### Назначить роль на отдельный ресурс {#access-services}

В консоли управления можно назначить роль на облако, каталог или сервисный аккаунт.

Чтобы выдать доступ группе на ресурс:

{% include [accessbinding-group-as-subject](../../_includes/organization/accessbinding-group-as-subject.md) %}

### Назначить роль на всю организацию {#access-organization}

Роль, которая выдана на всю организацию, позволяет участникам группы управлять всеми ресурсами {{ yandex-cloud }}, которые подключены к организации, в соответствии с правами роли.

{% include [accessbinding-group-as-subject-org](../../_includes/organization/accessbinding-group-as-subject-org.md) %}

## Сопоставить группу пользователей {#group-mapping}

{% include notitle [preview](../../_includes/note-preview-by-request.md) %}

Чтобы настроить права доступа пользователей к ресурсам {{ yandex-cloud }} с помощью [сопоставления групп](../concepts/add-federation.md#group-mapping):

1. [Создайте группы пользователей](#create-group) в {{ org-name }}.
1. [Настройте права доступа](#access) этих групп к ресурсам {{ yandex-cloud }}.
1. Создайте группы пользователей в вашем [поставщике удостоверений](../concepts/add-federation.md#federation-usage) и добавьте в них пользователей.

    {% note info %}

    Вы можете использовать существующие группы пользователей.

    {% endnote %}

1. Задайте сопоставление групп пользователей в настройках SAML-атрибутов поставщика удостоверений. В зависимости от используемого поставщика удостоверений, воспользуйтесь одной из следующих инструкций:

   * [Microsoft AD FS](https://learn.microsoft.com/en-us/power-pages/security/authentication/saml2-settings#create-an-ad-fs-relying-party-trust)
   * [Google](https://support.google.com/a/answer/11143403?sjid=815248229840499495-EU)
   * [KeyCloak](https://www.keycloak.org/docs/22.0.3/server_admin/#_protocol-mappers). В дополнение к инструкции, задайте значение `member` для атрибута **Group attribute name** .

1. Задайте сопоставление групп пользователей в настройках федерации:

    1. [Войдите в аккаунт]({{ link-passport-login }}) администратора или владельца организации.
    1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-main }}).
    1. На панели слева выберите раздел ![icon-federation](../../_assets/organization/icon-federation.svg) [{{ ui-key.yacloud_org.pages.federations }}]({{ link-org-federations }}).
    1. Выберите нужную федерацию и перейдите на вкладку **{{ ui-key.yacloud_org.form.group-mapping.note.tab-idp }}**.
    1. Включите опцию **{{ ui-key.yacloud_org.form.group-mapping.field.idp }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud_org.form.group-mapping.create.add }}** и задайте сопоставление:
        * **{{ ui-key.yacloud_org.form.group-mapping.note.group-name }}** — укажите имя группы поставщика удостоверений.
        * **{{ ui-key.yacloud_org.form.group-mapping.note.iam-group }}** — выберите группу {{ org-name }} из списка.
    1. Повторите предыдущий шаг для всех сопоставляемых групп.
