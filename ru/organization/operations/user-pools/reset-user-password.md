---
title: Как сбросить пароль пользователя в пуле в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете сбросить пароль пользователя в пуле в {{ org-name }}.
---

# Сбросить пароль пользователя


{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** и выберите нужный [пул пользователей](../../concepts/user-pools.md).
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.userpools.title_userpool_members }}**.
  1. В строке с нужным пользователем нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/key.svg) **Сбросить пароль**.
  1. Сохраните новый пароль из всплывающего окна и закройте его.

{% endlist %}