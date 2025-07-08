---
title: Как редактировать пул пользователей в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете редактировать пул пользователей в {{ org-name }}.
---

# Редактировать пул пользователей


{% include [note-preview](../../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева выберите ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}**.  
  1. В строке с нужным [пулом пользователей](../../../organization/concepts/user-pools.md) нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../../_assets/console-icons/pencil.svg) **Изменить**.
  1. Задайте новое название или описание пула пользователей.

      Название должно быть уникальным в организации и соответствовать требованиям:

      {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

  1. Задайте новый [домен](../../concepts/domains.md), который будет использоваться для всех пользователей пула по умолчанию.
  1. Добавьте или удалите метки.
  1. Нажмите **{{ ui-key.yacloud_org.actions.save-changes }}**.

{% endlist %}