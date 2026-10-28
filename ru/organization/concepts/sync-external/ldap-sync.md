---
title: Синхронизация пользователей и групп с LDAP-совместимыми службами каталогов
description: В этом разделе вы узнаете об особенностях синхронизации пользователей и групп в пуле {{ org-full-name }} с пользователями и группами в LDAP-совместимых каталогах.
---

# Синхронизация пользователей и групп с LDAP-совместимыми службами каталогов


Если для управления пользователями ваша компания использует службу каталогов, совместимую с протоколом [LDAP](https://ru.wikipedia.org/wiki/LDAP), и вы хотите организовать для ваших пользователей доступ к {{ yandex-cloud }}, вам не нужно создавать учетные записи для них вручную. Вместо этого вы можете [настроить](../../operations/sync-external/sync-ldap.md) синхронизацию с {{ org-full-name }} пользователей и групп из вашего каталога.

Синхронизация пользователей и групп выполняется [агентом синхронизации {{ ad-sync-agent }}](#sync-agent), который может быть запущен на любом сервере под управлением ОС [Linux](https://ru.wikipedia.org/wiki/Linux) или [Windows](https://ru.wikipedia.org/wiki/Windows).


## Схема синхронизации {sync-flow-chart}

{% include [sync-agent-ldap](../../../_mermaid/other/identity-hub/sync-agent-ldap.md) %}

На сервере, где [запущен](../../operations/sync-external/sync-ldap.md) агент синхронизации, должны быть открыты следующие сетевые порты для входящего и исходящего трафика:

* Для обращения к API {{ yandex-cloud }}:

    * `443 (TCP)` — для [HTTPS](https://ru.wikipedia.org/wiki/HTTPS);

* Для обращения к LDAP-серверу:

    {% include [ldap-sync-ports](../../../_includes/organization/external-sync/ldap-sync-ports.md) %}

## Объекты синхронизации {#sync-objects}

Агент {{ ad-sync-agent }} синхронизирует с внешним LDAP-каталогом следующие объекты:

* **Пользователи**.
* **Атрибуты пользователей**.

    Таблица сопоставления атрибутов пользователей:

    #|
    || **Имя атрибута в конфигурации агента** | **Имя атрибута в {{ org-full-name }}** |::{align="center"} **Имя атрибута во внешнем LDAP-каталоге**&nbsp;^1^ | > | > ||
    || ^ | ^ |::{align="center"} `person`/`inetOrgPerson`/</br>`organizationalPerson` |::{align="center"} `posixAccount` |::{align="center"} `user`</br>([Samba](https://ru.wikipedia.org/wiki/Samba) и [Альт домен](https://www.basealt.ru/alt-domain)) ||
    || `FullName` | `full_name` | `displayName` | `cn` | `displayName` ||
    || `GivenName` | `given_name` | `givenName` | — | `givenName` ||
    || `FamilyName` | `family_name` | `sn` | — | `sn` ||
    || `Email` | `email` | `mail` | — | `mail` ||
    || `PhoneNumber` | `phone_number` | `telephoneNumber` | — | `telephoneNumber` ||
    || `Username` | `username` | `uid` | `uid` | `userPrincipalName` ||
    || `EmployeeId` | `employee_id` | `employeeNumber` | `uidNumber` | `employeeID` ||
    || `Department` | `department` | `departmentNumber` | — | `department` ||
    || `JobTitle` | `job_title` | `title` | — | `title` ||
    || `CompanyName` | `company_name` | `o` | — | `company` ||
    |#

    ^1^ Имена атрибутов, которые используются в LDAP-каталогах, зависят от типа каталога и используемого класса объекта (`objectClass`).

    В параметре `user_attribute_mapping` [конфигурации агента](../../operations/sync-external/sync-ldap.md#config-sync-settings) вы можете настроить сопоставление имен атрибутов пользователя, отличных от заданных по умолчанию для внешних каталогов, или отключить синхронизацию отдельных атрибутов.

* **Группы пользователей**.
* **Атрибуты групп пользователей**.

    Таблица сопоставления атрибутов групп пользователей:

    #|
    || **Имя атрибута в конфигурации агента** | **Имя атрибута в {{ org-full-name }}** |::{align="center"} **Имя атрибута во внешнем LDAP-каталоге**&nbsp;^1^ | > | > ||
    || ^ | ^ |::{align="center"} `groupOfNames`/`groupOfUniqueNames` |::{align="center"} `posixGroup` |::{align="center"} `group`</br>([Samba](https://ru.wikipedia.org/wiki/Samba) и [Альт домен](https://www.basealt.ru/alt-domain)) ||
    || `Name` | `name` | `cn` | `cn` | `name` ||
    || `Description` | `description` | `description` | `description` | `description` ||
    |#

    ^1^ Имена атрибутов, которые используются в LDAP-каталогах, зависят от типа каталога и используемого класса объекта (`objectClass`).

    В параметре `group_attribute_mapping` [конфигурации агента](../../operations/sync-external/sync-ldap.md#config-sync-settings) вы можете настроить сопоставление имен атрибутов групп пользователей, отличных от заданных по умолчанию для внешних каталогов, или отключить синхронизацию отдельных атрибутов.
* **Членства пользователей в группах**.

    Атрибут членства определяется в зависимости от используемого класса `objectClass`:

    Класс | Атрибут
    --- | ---
    `groupOfNames` | `member` (DN)
    `groupOfUniqueNames` | `uniqueMember` (DN)
    `posixGroup` | `memberUid` (UID, значение `uid` пользователя)
    `group` (Samba) | `member` (DN)

* **[Хеши](https://ru.wikipedia.org/wiki/Хеш-функция) паролей пользователей**.

    Как правило, пароли пользователей хранятся во внешних каталогах не в открытом виде, а в виде хешей. {{ yandex-cloud }}, получив из внешнего каталога хеш пароля пользователя, формирует на его основе собственный хеш с использованием современного и устойчивого к взлому алгоритма [Argon2](https://ru.wikipedia.org/wiki/Argon2).

    {% note alert %}

    {{ yandex-cloud }} не хранит в своих базах данных пароли пользователей в открытом виде.

    {% endnote %}

Агент также синхронизирует время последней установки пароля пользователя во внешнем каталоге с {{ org-full-name }}.

Проверяйте имена атрибутов-источников, которые вы указываете в конфигурации агента при их переназначении, и сверяйте с теми именами атрибутов, которые используются в вашем LDAP-каталоге. LDAP-сервер не проверяет значения передаваемых атрибутов, которые заданы в [параметрах конфигурации](#agent-config) `user_attribute_mapping.source` и `group_attribute_mapping.source`, и принимает их как есть.

## Обратная запись паролей во внешние каталоги {#password-writeback}

{% include [pw-writeback-preview-notice](../../../_includes/organization/external-sync/pw-writeback-preview-notice.md) %}

Агент синхронизации позволяет выполнять _обратную запись паролей_ пользователей (password writeback). Обратная запись паролей обновляет пароль пользователя во внешнем каталоге, если пароль этого пользователя был изменен на стороне {{ org-full-name }} в следующих случаях:

* пользователь, для которого настроена синхронизация с внешним каталогом, [изменил свой пароль](../../../organization/operations/manage-account.md#edit-password) в {{ org-full-name }};
* администратор организации [сбросил пароль](../../../organization/operations/user-pools/reset-user-password.md#reset) пользователя, для которого настроена синхронизация с внешним каталогом;
* пользователь, для которого настроена синхронизация с внешним каталогом, установил новый пароль в {{ org-full-name }} после того, как пароль этого пользователя был сброшен администратором.

Обратная запись паролей выполняется в следующем порядке:

1. Пользователь или администратор выполняют запрос на изменение пароля пользователя в {{ org-full-name }}.
1. Агент синхронизации предпринимает попытку обновить пароль этого пользователя во внешнем каталоге.

    Попытка смены пароля во внешнем каталоге может завершиться неудачей. Например, если новый пароль не соответствует требованиям, которые установлены для паролей в настройках каталога.
1. Если попытка изменить пароль во внешнем каталоге завершилась успехом, пароль пользователя изменяется также и на стороне {{ org-full-name }}.
1. Если попытка изменить пароль во внешнем каталоге завершилась неудачей, пароль пользователя на стороне {{ org-full-name }} также остается неизменным.

Чтобы включить обратную запись паролей, задайте параметр `enable_password_writeback: true` и настройте раздел `ldap.password_writeback` в [конфигурации агента](../../operations/sync-external/sync-ldap.md#agent-config).

Для обратной записи паролей в FreeIPA, ApacheDS™ и 389 Directory Server укажите тип каталога в параметре `ldap.password_writeback.flavor`. При работе с FreeIPA или ApacheDS™ для постоянного сброса паролей можно настроить отдельную учетную запись в параметре `ldap.password_writeback.permanent_reset`, в том числе с аутентификацией по протоколу Kerberos.

{% include [ldap-sync-password-wb-second-account-warn](../../../_includes/organization/external-sync/ldap-sync-password-wb-second-account-warn.md) %}

## Настройка синхронизации {#sync-setup}

Чтобы реализовать синхронизацию пользователей и групп {{ org-full-name }} с внешним каталогом, необходимо выполнить предварительные настройки как на стороне вашего LDAP-сервера, так и на стороне {{ yandex-cloud }}.

{% include [ad-sync-kerberos-components-installation-info](../../../_includes/organization/external-sync/ad-sync-kerberos-components-installation-info.md) %}

### Настройка на стороне LDAP-сервера {#dc-setup}

Для корректной работы агента синхронизации на стороне LDAP-сервера выполните следующие действия:

{% include [ldap-sync-presetup-server](../../../_includes/organization/external-sync/ldap-sync-presetup-server.md) %}

### Настройка на стороне {{ yandex-cloud }} {#yc-setup}

{% include [concept-common-yc-setup-part](../../../_includes/organization/external-sync/concept-common-yc-setup-part.md) %}

## Агент синхронизации {#sync-agent}

Агент синхронизации {{ ad-sync-agent }} читает данные о пользователях и группах пользователей во внешнем каталоге и синхронизирует их с данными пользователей и групп пользователей в [пуле](../user-pools.md) {{ org-full-name }}.

Скрипт установки агента синхронизации доступен для следующих операционных систем:

* [Linux]({{ ad-sync-agent-linuxlink }});
* [Windows]({{ ad-sync-agent-windowslink }}).

### Аутентификация на стороне LDAP-сервера {#agent-ldap-auth}

На стороне LDAP-сервера агент синхронизации получает данные пользователей и групп от имени аккаунта, [созданного](#dc-setup) при настройке синхронизации. При получении этих данных используется протокол [LDAP](https://learn.microsoft.com/en-us/windows/win32/api/_ldap/), запросы отправляются на адрес LDAP-сервера, который задан в [конфигурации](#agent-config) агента.

Аутентификация агента на стороне LDAP-сервера может осуществляться по имени и паролю пользователя или с использованием протокола [Kerberos](https://ru.wikipedia.org/wiki/Kerberos) версии 5.

### Аутентификация на стороне {{ yandex-cloud }} {#agent-yc-auth}

{% include [concept-common-agent-yc-auth-part](../../../_includes/organization/external-sync/concept-common-agent-yc-auth-part.md) %}

### Процесс синхронизации {#sync-process}

В процессе синхронизации данных агент {{ ad-sync-agent }} может создавать, изменять или удалять пользователей и группы пользователей в {{ org-full-name }}. Синхронизация пользователей и групп {{ org-full-name }} с пользователями и группами во внешнем каталоге выполняется с периодичностью, которая задана в параметре `sync_settings.interval` конфигурации агента.

При выполнении синхронизации агент считывает данные всех пользователей, групп и их атрибутов во внешнем каталоге и обновляет или создает аналогичных пользователей и группы в пуле пользователей {{ org-full-name }}.

При выполнении синхронизации в пуле пользователей может обнаружиться пользователь или группа пользователей с именами, идентичными именам пользователя или группы, которые требуется синхронизировать. В этом случае агент, в зависимости от [заданных настроек](#agent-config), перезапишет данные из внешнего каталога для существующего пользователя или группы {{ org-full-name }} либо выведет сообщение об ошибке.

#### Тестовый запуск (dry run) {#dry-run}

{% include [concept-common-concept-common-dry-run-part-part](../../../_includes/organization/external-sync/concept-common-dry-run-part.md) %}

Подробнее о том, как запустить агент в режиме dry run, читайте в разделе [{#T}](../../operations/sync-external/sync-ldap.md#dry-run).

### Отслеживаемые изменения {#tracked-changes}

В процессе непрерывной синхронизации агент отслеживает следующие изменения во внешнем каталоге и переносит их в {{ org-full-name }}:

{% include [concept-common-tracked-changes-part](../../../_includes/organization/external-sync/concept-common-tracked-changes-part.md) %}

{% include [ldap-sync-account-expires-solution](../../../_includes/organization/external-sync/ldap-sync-account-expires-solution.md) %}

### Логирование процесса синхронизации {#logging}

{% include [concept-common-logging-part](../../../_includes/organization/external-sync/concept-common-logging-part.md) %}

{% include [ad-sync-log-levels](../../../_includes/organization/external-sync/ad-sync-log-levels.md) %}

### Проверка прав доступа к файлам с аутентификационными данными {#auth-data-security}

При запуске агент синхронизации может проверять права доступа, назначенные файлам, которые используются агентом и содержат чувствительные данные:

* файл [конфигурации агента](#agent-config) может содержать пароль от учетной записи пользователя, от имени которого агент выполняет синхронизацию на стороне внешнего каталога;
* файл `keytab` содержит ключи шифрования, необходимые для аутентификации на LDAP-сервере по протоколу Kerberos;
* файл с [авторизованным ключом](../../../iam/concepts/authorization/key.md) сервисного аккаунта содержит ключ, позволяющий получить доступ к {{ yandex-cloud }}.

{% include [concept-common-auth-data-security-part](../../../_includes/organization/external-sync/concept-common-auth-data-security-part.md) %}

### Конфигурация агента {#agent-config}

Конфигурация агента синхронизации задается в [YAML](https://yaml.org/)-файле и зависит от [способа аутентификации](#agent-ldap-auth) на стороне внешнего каталога.

Примеры конфигурации приведены в [инструкции по настройке синхронизации](../../operations/sync-external/sync-ldap.md#setup-agent), а описание полей — в разделе [{#T}](../../operations/sync-external/sync-ldap.md#agent-config).

#### Полезные ссылки {#see-also}

* [{#T}](../../operations/sync-external/sync-ldap.md)
* [{#T}](./ad-sync.md)
