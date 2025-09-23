---
title: Как получить информацию о пользователе пула в {{ org-full-name }}
description: Следуя данной инструкции, вы получить информацию о пользователе пула в {{ org-name }}.
---

# Получить информацию о пользователе пула


{% include [note-preview](../../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}**.
  1. В списке [пулов пользователей](../../concepts/user-pools.md) выберите нужный пул.
  1. Перейдите на вкладку **Участники** и выберите нужного пользователя.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о [пользователе пула](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp user get --help
     ```

  1. Выполните команду:

      ```bash
      yc organization-manager idp user get <идентификатор_пользователя>
      ```

{% endlist %}