---
title: Как деактивировать пользователя пула в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете деактивировать пользователя пула в {{ org-name }}.
---

# Деактивировать пользователя


{% include [note-preview](../../../_includes/note-preview.md) %}

Деактивация приведет к завершению всех сеансов работы пользователя, и он потеряет доступ к ресурсам организации до повторной активации.

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** и выберите нужный [пул пользователей](../../concepts/user-pools.md).
  1. На вкладке **{{ ui-key.yacloud_org.organization.userpools.title_userpool_members }}** выберите нужного пользователя.
  1. В верхнем правом углу нажмите **Сделать неактивным**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для деактивации пользователя [пула](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp user suspend --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager idp user suspend <идентификатор_пользователя> \
       --reason <причина_деактивации>
     ```

     Где `--reason` — причина деактивации. Необязательный параметр.

{% endlist %}

#### См. также {#see-also}

* [{#T}](activate-user.md)