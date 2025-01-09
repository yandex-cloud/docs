---
title: Управление доступом в {{ data-transfer-full-name }}
description: Управление доступом в сервисе по переносу данных между хранилищами — {{ data-transfer-full-name }}. В разделе описано, какие роли необходимы для того или иного действия, на какие ресурсы можно назначить роль, какие роли действуют в сервисе.
---

# Управление доступом в {{ data-transfer-name }}


В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#required-roles) для того или иного действия.

Для использования сервиса необходимо авторизоваться в консоли управления с [аккаунтом на Яндексе](../../iam/concepts/users/accounts.md#passport) или с [федеративным аккаунтом](../../iam/concepts/users/accounts.md#saml-federation).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

{% include [roles-assign](../../_includes/iam/roles-assign.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Какие роли действуют в сервисе {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/data-transfer/security/service-roles-hierarchy.svg)

### Сервисные роли {#service-roles}

#### data-transfer.auditor {#data-transfer-auditor}

{% include [data-transfer.auditor](../../_roles/data-transfer/auditor.md) %}

#### data-transfer.viewer {#data-transfer-viewer}

{% include [data-transfer.viewer](../../_roles/data-transfer/viewer.md) %}

#### data-transfer.privateAdmin {#data-transfer-privateadmin}

{% include [data-transfer.privateadmin](../../_roles/data-transfer/privateAdmin.md) %}

#### data-transfer.admin {#data-transfer-admin}

{% include [data-transfer.admin](../../_roles/data-transfer/admin.md) %}

### Примитивные роли {#primitive-roles}

#### {{ roles-viewer }} {#viewer}

{% include [roles-viewer](../../_roles/primitive-roles/viewer.md) %}

#### {{ roles-editor }} {#editor}

{% include [roles-editor](../../_roles/primitive-roles/editor.md) %}

#### {{ roles-admin }} {#admin}

{% include [roles-admin](../../_roles/primitive-roles/admin.md) %}

## Какие роли необходимы {#required-roles}

Чтобы пользоваться сервисом, необходима [роль](../../iam/concepts/access-control/roles.md) `editor` или выше на каталог, в котором создаются ресурсы {{ data-transfer-name }}. Роль `viewer` позволит только просматривать список проектов и содержимое файлов, которые были загружены.

Если вы создаете эндпоинт управляемой базы данных для кластера, который находится в другом каталоге, вам потребуется сервисная или примитивная [роль `viewer`](../../iam/roles-reference.md#viewer), выданная на этот каталог.

Если вы создаете эндпоинт управляемой базы данных для стороннего кластера с доступом через интернет, вам потребуется примитивная роль `admin` или сервисная роль `data-transfer.admin` на каталог, в котором создается эндпоинт.

Вы всегда можете назначить роль, которая дает более широкие разрешения (например `admin` вместо `editor`) или назначить роли, которые разрешают только отдельные действия. Подробнее о том, какие роли нужны для совершения конкретных действий с ресурсами {{ data-transfer-name }}, см. в таблице:

| Действие                                                                    | Необходимые роли             |
|-----------------------------------------------------------------------------|------------------------------|
| Получить мета-данные о трансферах и эндпоинтах                              | `data-transfer.viewer`       |
| Получить информацию о квотах сервиса {{ data-transfer-name }}               | `data-transfer.viewer`       |
| Получить информацию о трансферах и эндпоинтах                               | `data-transfer.viewer`       |
| Создать эндпоинт в {{ yandex-cloud }}                                       | `data-transfer.editor` |
| Изменить эндпоинт в {{ yandex-cloud }}                                      | `data-transfer.editor` |
| Удалить эндпоинт в {{ yandex-cloud }}                                       | `data-transfer.editor` |
| Создать трансфер с передачей данных в {{ yandex-cloud }}                    | `data-transfer.privateAdmin` |
| Изменить трансфер с передачей данных в {{ yandex-cloud }}                   | `data-transfer.privateAdmin` |
| Активировать трансфер с передачей данных в {{ yandex-cloud }}               | `data-transfer.privateAdmin` |
| Деактивировать трансфер с передачей данных в {{ yandex-cloud }}             | `data-transfer.privateAdmin` |
| Удалить трансфер с передачей данных в {{ yandex-cloud }}                    | `data-transfer.editor` |
| Создать эндпоинт в {{ yandex-cloud }} или за его пределами                  | `data-transfer.editor`        |
| Изменить эндпоинт в {{ yandex-cloud }} или за его пределами                 | `data-transfer.editor`        |
| Удалить эндпоинт в {{ yandex-cloud }} или за его пределами                  | `data-transfer.editor`        |
| Создать трансфер с передачей данных в {{ yandex-cloud }} или через интернет | `data-transfer.admin`        |
| Изменить трансфер с передачей данных в {{ yandex-cloud }} или через интернет | `data-transfer.admin`       |
| Активировать трансфер с передачей данных в {{ yandex-cloud }} или через интернет | `data-transfer.admin`   |
| Деактивировать трансфер с передачей данных в {{ yandex-cloud }} или через интернет | `data-transfer.admin` |
| Удалить трансфер с передачей данных в {{ yandex-cloud }} или через интернет | `data-transfer.editor`        |

## Что дальше {#whats-next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

