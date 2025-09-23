---
title: Как получить список пулов пользователей в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете получить список пулов пользователей в {{ org-name }}.
---

# Получить список пулов пользователей


{% include [note-preview](../../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}**.
  
     Отобразятся все [пулы пользователей](../../concepts/user-pools.md), доступные в вашей организации.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения списка [пулов пользователей](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool list --help
     ```

  1. Выполните команду:

      ```bash
      yc organization-manager idp userpool list --organization-id <идентификатор_организации>
      ```

      Где `--organization-id` — [идентификатор организации](../organization-get-id.md), список пулов пользователей которой нужно получить.

{% endlist %}