---
title: Как активировать пользователя пула в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете активировать пользователя пула в {{ org-name }}.
---

# Активировать пользователя


{% include [note-preview](../../../_includes/note-preview.md) %}

Активированные пользователи получат доступ к ресурсам организации.

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** и выберите нужный [пул пользователей](../../concepts/user-pools.md).
  1. На вкладке **{{ ui-key.yacloud_org.organization.userpools.title_userpool_members }}** выберите нужного пользователя.
  1. В правом верхнем углу нажмите **Сделать активным**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для активации пользователя [пула](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp user reactivate --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager idp user reactivate <идентификатор_пользователя>
     ```
     
{% endlist %}

#### См. также {#see-also}

* [{#T}](deactivate-user.md)