---
title: Как удалить домен в пуле пользователей {{ org-full-name }}
description: Следуя данной инструкции, вы сможете удалить домен в пуле пользователей {{ org-name }}.
---

# Удалить домен


{% include [note-preview](../../../_includes/note-preview.md) %}

Нельзя удалить [домен](../../concepts/domains.md) по умолчанию или домен, к которому привязаны пользователи.

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** и выберите нужный [пул пользователей](../../concepts/user-pools.md).
  1. В блоке **{{ ui-key.yacloud_org.organization.userpools.caption_domains }}** рядом с необходимым доменом нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_org.organization.userpool.action_delete-domain }}**.
  1. В открывшемся окне подтвердите удаление домена.

{% endlist %}