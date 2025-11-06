---
title: Как деактивировать пользователя в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете деактивировать пользователя в {{ org-name }}.
---

# Деактивировать пользователя

Чтобы временно ограничить пользователям доступ к ресурсам организации, вы можете деактивировать их. Деактивация приведет к завершению всех сеансов работы пользователя, и он потеряет доступ к ресурсам организации до повторной [активации](activate-user.md).

{% include [activate-deactivate-passport-user-notice](../../../_includes/organization/activate-deactivate-passport-user-notice.md) %}

## Деактивировать федеративного пользователя {#deactivate-federated}

Чтобы деактивировать аккаунт федеративного пользователя:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  {% include [deactivate-user-ui](../../../_includes/organization/deactivate-user-ui.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для деактивации федеративных пользователей:

     ```bash
     yc organization-manager federation saml suspend-user-accounts --help
     ```

  1. Получите список федераций в организации:

     ```bash
     yc organization-manager federation saml list \
       --organization-id <идентификатор_организации>
     ```

     Где `--organization-id` — [идентификатор организации](../organization-get-id.md), в которой нужно получить список федераций.

  1. Получите список активных пользователей федерации:

     ```bash
     yc organization-manager federation saml list-user-accounts <идентификатор_федерации> \
       --organization-id <идентификатор_организации> \
       --filter active=true
     ```

     Где:

     * `<идентификатор_федерации>` — идентификатор федерации, в которой нужно получить список пользователей.
     * `--organization-id` — идентификатор организации, в которой находится федерация.
     * `--filter active=true` — фильтр для получения только активных пользователей.

  1. Чтобы деактивировать пользователей, передайте их идентификаторы в команде:

     ```bash
     yc organization-manager federation saml suspend-user-accounts <идентификатор_федерации> \
       --subject-ids <идентификатор_пользователя_1>,<идентификатор_пользователя_2>,...,<идентификатор_пользователя_N> \
       --organization-id <идентификатор_организации> \
       --reason <причина_деактивации>
     ```

     Где:
     
     * `<идентификатор_федерации>` — идентификатор федерации, в которой нужно деактивировать пользователей.
     * `--subject-ids` — список идентификаторов пользователей, которых нужно деактивировать.
     * `--organization-id` — идентификатор организации, в которой находится федерация.
     * `--reason` — причина деактивации. Необязательный параметр.

{% endlist %}

## Деактивировать локального пользователя {#deactivate-local}


{% include [note-preview](../../../_includes/note-preview.md) %}

Чтобы деактивировать аккаунт локального пользователя:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  {% include [deactivate-user-ui](../../../_includes/organization/deactivate-user-ui.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для деактивации пользователя [пула](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp user suspend --help
     ```
  1. {% include [cli-list-userpools](../../../_includes/organization/cli-list-userpools.md) %}
  1. {% include [cli-userpool-list-users](../../../_includes/organization/cli-userpool-list-users.md) %}
  1. Чтобы деактивировать пользователя, передайте его идентификатор в команде:

     ```bash
     yc organization-manager idp user suspend <идентификатор_пользователя> \
       --reason <причина_деактивации>
     ```

     Где `--reason` — причина деактивации. Необязательный параметр.

{% endlist %}

#### См. также {#see-also}

* [{#T}](activate-user.md)