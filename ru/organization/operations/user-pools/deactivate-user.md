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