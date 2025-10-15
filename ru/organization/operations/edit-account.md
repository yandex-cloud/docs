---
title: Удалить аккаунт пользователя из организации {{ org-full-name }}
description: Из этой статьи вы узнаете, как удалить аккаунт пользователя из организации {{ org-full-name }}.
---

# Удалить аккаунт пользователя

Удалить аккаунт из организации может пользователь с ролью `organization-manager.admin` или `organization-manager.organizations.owner`. О том, как назначить пользователю роль, читайте в разделе [{#T}](../security/index.md#add-role).

{% note tip %}

Отменить удаление аккаунта пользователя из [организации](../concepts/organization.md) невозможно. Чтобы вернуть пользователя, который ранее был удален, повторно [добавьте](add-account.md) его в организацию.

{% endnote %}

## Удалить пользователя с аккаунтом на Яндексе или федеративного пользователя {#yandex-and-federated} 

Чтобы удалить из организации пользователя [с аккаунтом на Яндексе](../../iam/concepts/users/accounts.md#passport) или [федеративного](../../iam/concepts/users/accounts.md#saml-federation) пользователя:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  {% include [delete-user-ui](../../_includes/organization/delete-user-ui.md) %}

{% endlist %}

{% note info %}

После удаления из организации [федеративного пользователя](../../iam/concepts/users/accounts.md#saml-federation) он удаляется из федерации и высвобождает использованные квоты. Если в федерации включено автоматическое создание пользователей, удаленный пользователь может выполнить вход в [организацию](../concepts/organization.md) и вновь [стать ее членом](../concepts/membership.md). Чтобы исключить такую возможность, удалите или заблокируйте этого пользователя в IdP.

{% endnote %}

## Удалить локального пользователя {#local}

Чтобы удалить из организации [локального](../../iam/concepts/users/accounts.md#local) пользователя:


{% include [note-preview](../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  {% include [delete-user-ui](../../_includes/organization/delete-user-ui.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления пользователя из [пула](../concepts/user-pools.md):

     ```bash
     yc organization-manager idp user delete --help
     ```
  1. {% include [cli-list-userpools](../../_includes/organization/cli-list-userpools.md) %}
  1. {% include [cli-userpool-list-users](../../_includes/organization/cli-userpool-list-users.md) %}
  1. Чтобы удалить из организации локального пользователя, передайте его идентификатор в команде:

     ```bash
     yc organization-manager idp user delete <идентификатор_пользователя>
     ```

{% endlist %}