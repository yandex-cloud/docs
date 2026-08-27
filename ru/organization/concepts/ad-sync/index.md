---
title: Синхронизация пользователей и групп с {{ microsoft-idp.ad-short }}
description: Агент {{ ad-sync-agent }} позволяет настраивать синхронизацию пользователей и групп в {{ org-full-name }} с {{ microsoft-idp.ad-full }}.
---

# Синхронизация пользователей и групп с {{ microsoft-idp.ad-full }}


Если для управления пользователями ваша компания использует [{{ microsoft-idp.ad-full }}](https://docs.microsoft.com/ru-ru/windows-server/identity/ad-ds/active-directory-domain-services) и вы хотите организовать для ваших пользователей доступ к {{ yandex-cloud }}, вам не нужно вручную создавать для них учетные записи в {{ yandex-cloud }}. Вместо этого вы можете [синхронизировать](../../operations/sync-ad.md) с {{ org-full-name }} пользователей и группы, созданные в вашем каталоге {{ microsoft-idp.ad-short }}.

{% include [ad-sync-userpoolonly-notice](../../../_includes/organization/ad-sync-userpoolonly-notice.md) %}

Синхронизация пользователей и групп выполняется [агентом](./sync-agent.md) синхронизации {{ ad-sync-agent }}, который может быть запущен на любом сервере под управлением ОС [Linux](https://ru.wikipedia.org/wiki/Linux) или [Windows](https://ru.wikipedia.org/wiki/Windows).

Схема синхронизации:

{% include [sync-agent](../../../_mermaid/other/identity-hub/sync-agent.md) %}

На сервере, где [запущен](../../operations/sync-ad.md) агент синхронизации, должны быть открыты следующие сетевые порты для входящего и исходящего трафика:

* Для обращения к API {{ yandex-cloud }}:

    * `443 (TCP)` — для [HTTPS](https://ru.wikipedia.org/wiki/HTTPS);

* Для обращения к контроллеру домена {{ microsoft-idp.ad-short }}:

    {% include [ad-sync-ports](../../../_includes/organization/ad-sync-ports.md) %}

## Объекты синхронизации {#sync-objects}

Агент {{ ad-sync-agent }} синхронизирует с каталогом {{ microsoft-idp.ad-short }} следующие объекты:

* **Пользователи**.
* **Атрибуты пользователей**.

    Таблица сопоставления атрибутов пользователей:

    Имя атрибута </br>в [конфигурации агента](./sync-agent.md#agent-config) | Имя атрибута в {{ microsoft-idp.ad-short }} </br>(по умолчанию) | Имя атрибута </br>в {{ org-full-name }}
    --- | --- | ---
    `FullName` | `displayName` | `full_name`
    `GivenName` | `givenName` | `given_name`
    `FamilyName` | `sn` | `family_name`
    `Email` | `mail` | `email`
    `PhoneNumber` | `telephoneNumber` | `phone_number`
    `Username` | `userPrincipalName` | `username`
    `EmployeeId` | `employeeID` | `employee_id`
    `Department` | `department` | `department`
    `JobTitle` | `title` | `job_title`
    `CompanyName` | `company` | `company_name`
    н/д | `ObjectGUID` | `external_id`

    В параметре `user_attribute_mapping` [конфигурации агента](./sync-agent.md#agent-config) вы можете настроить сопоставление имен атрибутов пользователя, отличных от заданных по умолчанию для {{ microsoft-idp.ad-short }}, или отключить синхронизацию отдельных атрибутов.
* **Группы пользователей**.
* **Атрибуты групп пользователей**.

    Таблица сопоставления атрибутов групп пользователей:

    Имя атрибута </br>в [конфигурации агента](./sync-agent.md#agent-config) | Имя атрибута в {{ microsoft-idp.ad-short }} </br>(по умолчанию) | Имя атрибута </br>в {{ org-full-name }}
    --- | --- | ---
    `Name` | `name` | `name`
    `Description` | `description` | `description`
    н/д | `ObjectGUID` | `external_id`

    В параметре `group_attribute_mapping` [конфигурации агента](./sync-agent.md#agent-config) вы можете настроить сопоставление имен атрибутов групп пользователей, отличных от заданных по умолчанию для {{ microsoft-idp.ad-short }}, или отключить синхронизацию отдельных атрибутов.
* **Членства пользователей в группах**.
* **[Хеши](https://ru.wikipedia.org/wiki/Хеш-функция) паролей пользователей**.

    Пароли пользователей хранятся в {{ microsoft-idp.ad-short }} не в открытом виде, а в виде хешей. {{ yandex-cloud }}, получив из каталога {{ microsoft-idp.ad-short }} хеш пароля пользователя, формирует на его основе собственный хеш с использованием современного и устойчивого к взлому алгоритма [Argon2](https://ru.wikipedia.org/wiki/Argon2).

    {% note alert %}

    {{ yandex-cloud }} не хранит в своих базах данных пароли пользователей в открытом виде.

    {% endnote %}

### Обратная запись паролей в {{ microsoft-idp.ad-short }} {#password-writeback}

{% include [pw-writeback-preview-notice](../../../_includes/organization/pw-writeback-preview-notice.md) %}

Агент синхронизации позволяет выполнять _обратную запись паролей_ пользователей (password writeback) в {{ microsoft-idp.ad-short }}. Обратная запись паролей обеспечивает обновление пароля пользователя в {{ microsoft-idp.ad-short }}, если пароль этого пользователя был изменен на стороне {{ org-full-name }} в следующих случаях:

* пользователь, для которого настроена синхронизация с {{ microsoft-idp.ad-short }}, [изменил свой пароль](../../../organization/operations/manage-account.md#edit-password) в {{ org-full-name }};
* администратор организации [сбросил пароль](../../../organization/operations/user-pools/reset-user-password.md#reset) пользователя, для которого настроена синхронизация с {{ microsoft-idp.ad-short }};
* пользователь, для которого настроена синхронизация с {{ microsoft-idp.ad-short }}, установил новый пароль в {{ org-full-name }} после того, как пароль этого пользователя был сброшен администратором.

Обратная запись паролей выполняется в следующем порядке:

1. Пользователь или администратор выполняют запрос на изменение пароля пользователя в {{ org-full-name }}.
1. Агент синхронизации предпринимает попытку обновить пароль этого пользователя в {{ microsoft-idp.ad-short }}.

    Попытка смены пароля в {{ microsoft-idp.ad-short }} может завершиться неудачей, например, если новый пароль не соответствует требованиям, заданным в политиках безопасности {{ microsoft-idp.ad-short }}.
1. Если попытка изменить пароль в {{ microsoft-idp.ad-short }} завершилась успехом, пароль пользователя изменяется также и на стороне {{ org-full-name }}.
1. Если попытка изменить пароль в {{ microsoft-idp.ad-short }} завершилась неудачей, пароль пользователя на стороне {{ org-full-name }} также остается неизменным.

Для работы обратной записи паролей аккаунту {{ microsoft-idp.ad-short }}, от имени которого агент выполняет синхронизацию, дополнительно нужны разрешения `Change Password`, `Reset Password` и `Write pwdLastSet`. Назначьте их на весь домен или на те Organization Units (OU), которые попадают под выбранные в конфигурации агента фильтры `sync_settings.filter`.

## Настройка синхронизации {#sync-setup}

Чтобы реализовать синхронизацию пользователей и групп {{ org-full-name }} с {{ microsoft-idp.ad-short }}, необходимо выполнить предварительные настройки, как на стороне вашего [контроллера домена](https://ru.wikipedia.org/wiki/Контроллер_домена) с развернутыми службами {{ microsoft-idp.ad-short }}, так и на стороне {{ yandex-cloud }}.

{% include [ad-sync-kerberos-components-installation-info](../../../_includes/organization/ad-sync-kerberos-components-installation-info.md) %}

### Настройка на стороне контроллера домена {{ microsoft-idp.ad-short }} {#dc-setup}

Для корректной работы [агента](./sync-agent.md) синхронизации на стороне {{ microsoft-idp.ad-short }} выполните следующие действия:

{% include [ad-sync-presetup-ad](../../../_includes/organization/ad-sync-presetup-ad.md) %}

### Настройка на стороне {{ yandex-cloud }} {#yc-setup}

Для корректной работы [агента](./sync-agent.md) синхронизации на стороне {{ yandex-cloud }} выполните следующие действия:

* [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт, от имени которого синхронизация будет выполняться на стороне {{ org-full-name }}.
* [Назначьте](../../../iam/operations/sa/assign-role-for-sa.md#binding-role-organization) сервисному аккаунту следующие [роли](../../../iam/concepts/access-control/roles.md) на [организацию](../organization.md), в которой находится нужный пул пользователей:

    {% include [ad-sync-sa-roles](../../../_includes/organization/ad-sync-sa-roles.md) %}

* (Опционально) [Создайте](../../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) и сохраните [авторизованный ключ](../../../iam/concepts/authorization/key.md) сервисного аккаунта.

    {% include [ad-sync-iam-via-metadata-warning](../../../_includes/organization/ad-sync-iam-via-metadata-warning.md) %}

#### Полезные ссылки {#see-also}

* [{#T}](./sync-agent.md)
* [{#T}](../../operations/sync-ad.md)

[*gmsa_account]: {% include notitle [get-folder-id](../../../_popups/identity-hub/gmsa.md) %}