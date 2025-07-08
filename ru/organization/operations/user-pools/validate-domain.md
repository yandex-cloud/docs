---
title: Как подтвердить домен в пуле пользователей {{ org-full-name }}
description: Следуя данной инструкции, вы сможете подтвердить домен в пуле пользователей {{ org-name }}.
---

# Подтвердить домен


{% include [note-preview](../../../_includes/note-preview.md) %}

Для добавления пользователей можно использовать только подтвержденные [домены](../../concepts/domains.md).

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** и выберите нужный [пул пользователей](../../concepts/user-pools.md).
  1. Выберите домен, который необходимо подтвердить.
  1. В открывшемся блоке будет указана информация для прохождения процедуры проверки прав на домен.
  1. После прохождения процедуры нажмите **{{ ui-key.yacloud_org.common.confirm }}**.

{% endlist %}