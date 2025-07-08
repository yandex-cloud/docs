---
title: Как изменить данные пользователя в пуле в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете изменить данные пользователя в пуле в {{ org-name }}.
---

# Изменить данные пользователя


{% include [note-preview](../../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** и выберите нужный [пул пользователей](../../concepts/user-pools.md).
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.userpools.title_userpool_members }}**.
  1. В строке с нужным пользователем нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud_org.organization.userpools.action_update-user }}**.
  1. Измените логин, [домен](../../concepts/domains.md) и полное имя.
  1. Добавьте или измените электронную почту.
  1. Удалите пользовательское изображение или загрузите новое.
  1. В блоке **{{ ui-key.yacloud_org.organization.userpools.title_personal-info }}** измените полное имя и номер телефона пользователя.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}