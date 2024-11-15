---
title: Управление доступом в {{ kms-full-name }}
description: Управление доступом в сервисе для создания и управления ключами шифрования {{ kms-full-name }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе, какие роли необходимы для того или иного действия.
---

# Управление доступом в {{ kms-name }}

В этом разделе вы узнаете:
* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#choosing-roles) для того или иного действия.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `kms.admin` или одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

В [консоли управления]({{ link-console-main }}), через {{ yandex-cloud }} [CLI](../../cli/cli-ref/managed-services/kms/index.md), [API](../api-ref/authentication.md) или [{{ TF }}]({{ tf-provider-link }}) роль можно назначить на отдельные ресурсы сервиса:

{% include notitle [kms-resources](../../_includes/iam/resources-with-access-control/kms.md) %}

## Какие роли действуют в сервисе {#roles-list}

Управлять доступом к ключам {{ kms-short-name }} можно как с помощью сервисных, так и с помощью примитивных ролей.

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/kms/service-roles-hierarchy.svg)

### Сервисные роли {#service-roles}

Сервисные роли обеспечивают более гранулярный, учитывающий специфику сервиса, контроль над ключами {{ kms-short-name }}: предполагают строгое разделение субъектов на администраторов ключей (роль `kms.admin`) и пользователей (роль `kms.keys.encrypterDecrypter`).

Пользователи, у которых отсутствует роль `resource-manager.clouds.owner` или роль `admin`, не могут назначать роли через консоль управления.

#### kms.keys.encrypter {#kms-keys-encrypter}

{% include [kms.keys.encrypter](../../_roles/kms/keys/encrypter.md) %}

#### kms.keys.decrypter {#kms-keys-decrypter}

{% include [kms.keys.decrypter](../../_roles/kms/keys/decrypter.md) %}

#### kms.keys.encrypterDecrypter {#kms-keys-encrypterDecrypter}

{% include [kms.keys.encrypterDecrypter](../../_roles/kms/keys/encrypterDecrypter.md) %}

#### kms.asymmetricEncryptionKeys.publicKeyViewer {#kms-asymmetricEncryptionKeys-publicKeyViewer}

{% include [kms.asymmetricEncryptionKeys.publicKeyViewer](../../_roles/kms/asymmetricEncryptionKeys/publicKeyViewer.md) %}

#### kms.asymmetricSignatureKeys.publicKeyViewer {#kms-asymmetricSignatureKeys-publicKeyViewer}

{% include [kms.asymmetricSignatureKeys.publicKeyViewer](../../_roles/kms/asymmetricSignatureKeys/publicKeyViewer.md) %}

#### kms.asymmetricSignatureKeys.signer {#kms-asymmetricSignatureKeys-signer}

{% include [kms.asymmetricSignatureKeys.signer](../../_roles/kms/asymmetricSignatureKeys/signer.md) %}

#### kms.asymmetricEncryptionKeys.decrypter {#kms-asymmetricEncryptionKeys-decrypter}

{% include [kms.asymmetricEncryptionKeys.decrypter](../../_roles/kms/asymmetricEncryptionKeys/decrypter.md) %}

#### kms.auditor {#kms-auditor}

{% include [kms.auditor](../../_roles/kms/auditor.md) %}

#### kms.viewer {#kms-viewer}

{% include [kms.viewer](../../_roles/kms/viewer.md) %}

#### kms.editor {#kms-editor}

{% include [kms.editor](../../_roles/kms/editor.md) %}

#### kms.admin {#kms-admin}

{% include [kms.admin](../../_roles/kms/admin.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## Какие роли мне необходимы {#choosing-roles}

**Пример разграничения доступа к ключам**

С ролями рекомендуется работать следующим образом:
1. Владелец (роль `resource-manager.clouds.owner`) или администратор (роль `admin`) облака назначает роль `kms.admin` администратору {{ kms-short-name }}. 
1. Администратор {{ kms-short-name }} создает необходимое количество ключей и назначает (с помощью CLI или API) роли для их использования: субъекты, представляющие разные команды, получают роли `kms.keys.encrypter`, `kms.keys.decrypter`, `kms.asymmetricEncryptionKeys.publicKeyViewer`, `kms.asymmetricEncryptionKeys.decrypter` и `kms.editor` на ключи и каталоги.

Хорошей практикой является хранение ключей {{ kms-short-name }} в выделенном каталоге, отдельно от других ресурсов {{ yandex-cloud }}.

Действие | Методы | Необходимые роли
----- | ----- | -----
**{{ kms-short-name }}** | | 
Получение информации о ключах и версиях | `get`, `listVersions` | `kms.viewer` на ключ на каталог
Операции [симметричного шифрования и расшифрования](../api-ref/SymmetricCrypto/) | `encrypt`, `decrypt`, `reEncrypt`, `generateDataKey` | `kms.keys.encrypterDecrypter` на ключ (шифрование и расшифрование), `kms.keys.encrypter` на ключ (только шифрование), `kms.keys.decrypter` на ключ (только расшифрование)
Получение списка ключей в каталоге | `list` | `kms.auditor` на каталог
Получение открытого ключа асимметричной ключевой пары шифрования | | `kms.asymmetricEncryptionKeys.publicKeyViewer` на ключ
Расшифрование с помощью закрытого ключа асимметричной ключевой пары шифрования | | `kms.asymmetricEncryptionKeys.decrypter` на ключ
[Создание](../operations/key.md#create) и [изменение](../operations/key.md#update) ключа | `create`, `update` | `kms.editor` на каталог
[Ротация ключа](../operations/key.md#rotate) | `rotate` | `kms.editor` на ключ
[Смена основной версии](../operations/version.md#make-primary) | `setPrimaryVersion` | `kms.admin` на ключ
[Удаление ключей](../operations/key.md#delete) и [удаление версий](../operations/version.md#delete)| `delete`, `scheduleVersionDestruction`, `cancelVersionDestruction` | `kms.admin` на ключ
[Назначение роли](../../iam/operations/roles/grant.md), [отзыв роли](../../iam/operations/roles/revoke.md) | `setAccessBindings`, `updateAccessBindings` | `kms.admin` на ключ
Просмотр назначенных ролей на ключ | `listAccessBindings` | `kms.auditor` на ключ

#### Что дальше {#what-is-next}

* [Безопасное использование {{ yandex-cloud }}](../../iam/best-practices/using-iam-securely.md)
* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
