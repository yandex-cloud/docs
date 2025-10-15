---
title: Как активировать пользователя в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете активировать пользователя в {{ org-name }}.
---

# Активировать пользователя

Вы можете активировать пользователей, которые ранее были [деактивированы](./deactivate-user.md). После активации пользователи вновь получают доступ к тем ресурсам организации, на которые им назначены [права доступа](../../../iam/concepts/access-control/roles.md).

{% include [activate-deactivate-passport-user-notice](../../../_includes/organization/activate-deactivate-passport-user-notice.md) %}

## Активировать федеративного пользователя {#activate-federated}

Чтобы активировать аккаунт федеративного пользователя:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  {% include [activate-user-ui](../../../_includes/organization/activate-user-ui.md) %}

{% endlist %}


## Активировать локального пользователя {#activate-local}


{% include [note-preview](../../../_includes/note-preview.md) %}

Чтобы активировать аккаунт локального пользователя:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  {% include [activate-user-ui](../../../_includes/organization/activate-user-ui.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для активации пользователя [пула](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp user reactivate --help
     ```
  1. {% include [cli-list-userpools](../../../_includes/organization/cli-list-userpools.md) %}
  1. {% include [cli-userpool-list-users](../../../_includes/organization/cli-userpool-list-users.md) %}
  1. Чтобы активировать пользователя, передайте его идентификатор в команде:

     ```bash
     yc organization-manager idp user reactivate <идентификатор_пользователя>
     ```

{% endlist %}

#### См. также {#see-also}

* [{#T}](deactivate-user.md)