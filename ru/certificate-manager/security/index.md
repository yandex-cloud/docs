# Управление доступом

В этом разделе вы узнаете:
* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#choosing-roles) для того или иного действия.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

Вы можете назначить роль на [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud), [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) или [сертификат](../concepts/index). Эти роли будут действовать и на вложенные ресурсы.

## Какие роли действуют в сервисе {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/certificate-manager/service-roles-hierarchy-with-admin.svg)

Роли, действующие в сервисе:
* Сервисные роли:
    * {% include [certificate-manager.admin](../../_includes/iam/roles/short-descriptions/certificate-manager.admin.md) %}
    * {% include [certificate-manager.certificates.downloader](../../_includes/iam/roles/short-descriptions/certificate-manager.certificates.downloader.md) %}
    * {% include [resource-manager.clouds.owner](../../_includes/iam/roles/short-descriptions/resource-manager.clouds.owner.md) %}
    * {% include [resource-manager.clouds.member](../../_includes/iam/roles/short-descriptions/resource-manager.clouds.member.md) %}
* Примитивные роли:
    * {% include [viewer](../../_includes/iam/roles/short-descriptions/viewer.md) %}
    * {% include [editor](../../_includes/iam/roles/short-descriptions/editor.md) %}
    * {% include [admin](../../_includes/iam/roles/short-descriptions/admin.md) %}

## Какие роли мне необходимы {#choosing-roles}

В таблице ниже перечислено, какие роли нужны для выполнения указанного действия. Вы всегда можете назначить роль, которая дает более широкие разрешения, нежели указанная. Например, назначить `editor` вместо `viewer`.

Действие | Методы | Необходимые роли
----- | ----- | -----
**Certificate Manager** | | 
Получение списков сертификатов или доменов | `list` | `viewer` на каталог
Получение информации о сертификате или домене | `get` | `viewer` на сертификат или каталог
[Создание](../operations/managed/cert-create.md) сертификата от Let's Encrypt<sup>®</sup> | `requestNew` | `editor` на каталог
[Изменение](../operations/managed/cert-modify.md), [удаление](../operations/managed/cert-delete.md) сертификата от Let's Encrypt | `update`, `delete` | `editor` на сертификат или каталог
[Создание](../operations/import/cert-create.md) пользовательского сертификата | `create` | `editor` на каталог
[Обновление](../operations/import/cert-update.md), [изменение](../operations/import/cert-modify.md), [удаление](../operations/import/cert-delete.md) пользовательского сертификата | `update`, `delete` | `editor` на сертификат или каталог
Получение содержимого сертификата: [пользовательского](../operations/import/cert-get-content.md) или [сертификата от Let's Encrypt](../operations/managed/cert-get-content.md) | `get-content` | `certificate-manager.certificates.downloader` на сертификат или каталог
[Создание домена](../operations/domain/domain-create.md) | `create` | `editor` на каталог
[Изменение домена](../operations/domain/domain-modify.md) и [удаление домена](../operations/domain/domain-delete.md) | `update`, `delete` | `editor` на домен или каталог
[Обновление сертификата у домена](../operations/domain/domain-link-cert.md) | `setPrimaryCertificate` | `editor` на домен или каталог
**IAM** | |
[Назначение роли](../../iam/operations/roles/grant.md), [отзыв роли](../../iam/operations/roles/revoke.md) и просмотр назначенных ролей на каталог или облако | `setAccessBinding`, `updateAccessBindings`, `listAccessBindings` | `admin` или `certificate-manager.admin` на сертификат, домен или каталог 

#### Что дальше {what-is-next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
