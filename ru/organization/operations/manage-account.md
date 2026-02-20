---
title: Как управлять аккаунтом на портале Мой аккаунт
description: Следуя данной инструкции, вы сможете управлять аккаунтом пользователя на портале Мой аккаунт {{ org-full-name }}.
---

# Управление аккаунтом на портале «Мой аккаунт»

Доступность функциональности портала [Мой аккаунт](../concepts/my-account.md) зависит от типа аккаунта:

| | [Аккаунт на Яндексе](../../iam/concepts/users/accounts.md#passport) | [Федеративный аккаунт](../../iam/concepts/users/accounts.md#saml-federation) | [Локальный аккаунт](../../iam/concepts/users/accounts.md#local) |
---|---|---|---
[Просмотр атрибутов](#view-profile) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg) |
[Изменение атрибутов](#edit-profile) | ![alt](../../_assets/common/no.svg) | ![alt](../../_assets/common/no.svg) | ![alt](../../_assets/common/yes.svg) |
[Изменение пароля](#edit-password) | ![alt](../../_assets/common/no.svg) | ![alt](../../_assets/common/no.svg) | ![alt](../../_assets/common/yes.svg) |
[Удаление refresh-токенов](#delete-refresh-token) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg) |
[Управление способами подтверждения входа](#manage-mfa) | ![alt](../../_assets/common/no.svg) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg) |
[Просмотр групп](#view-groups) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg)
[Просмотр логов](#view-logs) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg)

## Посмотреть атрибуты {#view-profile}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в портал [Мой аккаунт]({{ link-my-account }}).
  1. На панели слева выберите ![alt](../../_assets/console-icons/passport.svg) **{{ ui-key.yacloud_org.center-layout.MyAccountLayout.profile_8kyBA }}**.
  1. В блоке **{{ ui-key.yacloud_org.my-account.ProfileEditPageLayout.main_breadcrumb }}** отобразятся атрибуты вашего аккаунта.

{% endlist %}

## Изменить атрибуты {#edit-profile}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в портал [Мой аккаунт]({{ link-my-account }}).
  1. На панели слева выберите ![alt](../../_assets/console-icons/passport.svg) **{{ ui-key.yacloud_org.center-layout.MyAccountLayout.profile_8kyBA }}**.
  1. Нажмите ![alt](../../_assets/console-icons/person-pencil.svg) **{{ ui-key.yacloud_org.my-account.ProfilePage.edit_action }}**.
  1. Отредактируйте имя, фамилию и контактную информацию.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Изменить пароль {#edit-password}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в портал [Мой аккаунт]({{ link-my-account }}).
  1. На панели слева выберите ![alt](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.center-layout.MyAccountLayout.security_7zQ3g }}**.
  1. В блоке **{{ ui-key.yacloud_org.my-account.login.entry-methods.header }}** нажмите ![alt](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud_org.myaccount.security.EntryMethodsTable.change-action }}**.
  1. Введите текущий пароль и дважды введите новый.
  1. Нажмите **{{ ui-key.yacloud_org.organization.idp.PasswordDialog.action_save-password_gaB2s }}**.

{% endlist %}

## Удалить refresh-токены {#delete-refresh-token}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в портал [Мой аккаунт]({{ link-my-account }}).
  1. На панели слева выберите ![alt](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.center-layout.MyAccountLayout.security_7zQ3g }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.my-account.SecurityPageLayout.refresh_breadcrumb }}**.
  1. Отобразятся все приложения, для которых вы добавили [refresh-токены](../../iam/concepts/authorization/refresh-token.md).
  1. Нажмите ![alt](../../_assets/console-icons/trash-bin.svg) в строке с приложением, для которого вы хотите удалить refresh-токен.
  1. Чтобы удалить все refresh-токены, нажмите ![alt](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_org.my-account.refresh-tokens.action_remove_all }}**. 

{% endlist %}

## Управление способами подтверждения входа {#manage-mfa}

Для управления способами подтверждения входа пользователь должен быть добавлен в [политику MFA](../concepts/mfa.md).

### Добавить способ подтверждения входа {#mfa-add}

{% note warning %}

Перед использованием функции подтверждения входа через WebAuthn убедитесь, что ваш браузер и операционная система поддерживаются. Проверьте совместимость в [таблице поддерживаемых конфигураций](../concepts/mfa.md#webauthn-support).

{% endnote %}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в портал [Мой аккаунт]({{ link-my-account }}).
  1. На панели слева выберите ![alt](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.center-layout.MyAccountLayout.security_7zQ3g }}**.
  1. В блоке **{{ ui-key.yacloud_org.my-account.security.login-confirmation.header }}** нажмите **Добавить способ подтверждения**.
  1. Выберите нужный способ подтверждения входа.

{% endlist %}

### Удалить способ подтверждения входа {#mfa-delete}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в портал [Мой аккаунт]({{ link-my-account }}).
  1. На панели слева выберите ![alt](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.center-layout.MyAccountLayout.security_7zQ3g }}**.
  1. В блоке **{{ ui-key.yacloud_org.my-account.security.login-confirmation.header }}** отобразятся ваши способы подтверждения входа и дата последнего использования.
  1. Нажмите ![alt](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_org.myaccount.security.LoginConfirmationTable.delete-action }}** рядом с нужным способом подтверждения входа.

{% endlist %}

## Посмотреть группы {#view-groups}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в портал [Мой аккаунт]({{ link-my-account }}).
  1. На панели слева выберите ![alt](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.center-layout.MyAccountLayout.groups_pqQRu }}**.
  1. На странице **{{ ui-key.yacloud_org.my-account.GroupsPageLayout.header }}** отобразятся все ваши группы и их идентификаторы.

{% endlist %}

## Посмотреть логи {#view-logs}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в портал [Мой аккаунт]({{ link-my-account }}).
  1. На панели слева выберите ![alt](../../_assets/console-icons/clock.svg) **{{ ui-key.yacloud_org.center-layout.MyAccountLayout.activity_kyqSv }}**.
  1. На открывшейся странице отобразятся ваши аудитные [логи](../concepts/logs.md).
  1. Чтобы увидеть более подробную информацию о событии, нажмите на нужную запись.

     Вы также можете воспользоваться фильтрами вверху страницы, чтобы найти нужные логи.

  Чтобы посмотреть логи всех пользователей [организации](../concepts/organization.md) или [пула](../concepts/user-pools.md), в которых вы являетесь администратором, см. страницу [{#T}](./user-pools/user-get-logs.md).

{% endlist %}
