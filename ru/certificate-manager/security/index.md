---
title: "Управление доступом в {{ certificate-manager-full-name }}"
description: "Управление доступом в сервисе для получения и обновления TLS-сертификатов от Let's Encrypt, а также для загрузки собственных сертификатов — {{ certificate-manager-full-name }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе, какие роли необходимы для того или иного действия."
---

# Управление доступом в {{ certificate-manager-name }}

В этом разделе вы узнаете:
* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#choosing-roles) для того или иного действия.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `certificate-manager.admin` или одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

На [пользовательский сертификат](../concepts/imported-certificate.md) роль можно назначить через YC CLI или API {{ yandex-cloud }}.

## Какие роли действуют в сервисе {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/certificate-manager/service-roles-hierarchy-with-admin.svg)

### Сервисные роли {#service-roles}

#### certificate-manager.auditor {#certificate-manager-auditor}

{% include [certificate-manager.auditor](../../_roles/certificate-manager/auditor.md) %}

#### certificate-manager.viewer {#certificate-manager-viewer}

{% include [certificate-manager.viewer](../../_roles/certificate-manager/viewer.md) %}

#### certificate-manager.editor {#certificate-manager.editor}

{% include [certificate-manager.editor](../../_roles/certificate-manager/editor.md) %}

#### certificate-manager.admin {#certificate-manager-admin}

{% include [certificate-manager.admin](../../_roles/certificate-manager/admin.md) %}

#### certificate-manager.certificates.downloader {#certificate-manager-certificates-downloader}

{% include [certificate-manager.certificates.downloader](../../_roles/certificate-manager/certificates/downloader.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## Какие роли мне необходимы {#choosing-roles}

В таблице ниже перечислено, какие роли нужны для выполнения указанного действия. Вы всегда можете назначить роль, которая дает более широкие разрешения, нежели указанная. Например, назначить `editor` вместо `viewer`.

Действие | Методы | Необходимые роли
----- | ----- | -----
**Certificate Manager** | | 
Получение списков сертификатов или доменов | `list` | `viewer` на каталог
Получение информации о сертификате или домене | `get` | `viewer` на сертификат или каталог
[Добавление](../operations/managed/cert-create.md) сертификата от Let's Encrypt | `requestNew` | `editor` на каталог
[Изменение](../operations/managed/cert-modify.md), [удаление](../operations/managed/cert-delete.md) сертификата от Let's Encrypt | `update`, `delete` | `editor` на сертификат или каталог
[Добавление](../operations/import/cert-create.md) пользовательского сертификата | `create` | `editor` на каталог
[Обновление](../operations/import/cert-update.md), [изменение](../operations/import/cert-modify.md), [удаление](../operations/import/cert-delete.md) пользовательского сертификата | `update`, `delete` | `editor` на сертификат или каталог
Получение содержимого сертификата: [пользовательского](../operations/import/cert-get-content.md) или [сертификата от Let's Encrypt](../operations/managed/cert-get-content.md) | `get-content` | `certificate-manager.certificates.downloader` на сертификат или каталог
[Добавление домена](../operations/domain/domain-create.md) | `create` | `editor` на каталог
[Изменение домена](../operations/domain/domain-modify.md) и [удаление домена](../operations/domain/domain-delete.md) | `update`, `delete` | `editor` на домен или каталог
[Обновление сертификата у домена](../operations/domain/domain-link-cert.md) | `setPrimaryCertificate` | `editor` на домен или каталог
**IAM** | |
[Назначение роли](../../iam/operations/roles/grant.md), [отзыв роли](../../iam/operations/roles/revoke.md) и просмотр назначенных ролей на каталог или облако | `setAccessBinding`, `updateAccessBindings`, `listAccessBindings` | `admin` или `certificate-manager.admin` на сертификат, домен или каталог 

#### Что дальше {what-is-next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
