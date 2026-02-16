---
title: Как посмотреть логи пользователя
description: Следуя данной инструкции, вы сможете посмотреть логи пользователей организации или всех пользователей пула.
---

# Посмотреть логи пользователя


{% include [roles-for-view-logs](../../../_includes/organization/roles-for-view-logs.md) %}

## Посмотреть логи пользователя организации {#organization}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ cloud-center }}]({{ cloud-center-link }}) с учетной записью администратора или владельца организации.
  1. На панели слева выберите ![icon-users](../../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}** и в открывшемся списке выберите нужного пользователя.
  
     При необходимости воспользуйтесь строкой поиска или фильтром вверху страницы.

  1. Чтобы посмотреть историю аутентификации пользователя, перейдите на вкладку **{{ ui-key.yacloud_org.organization.users.UserPageLayout.title_auth-audit-log_sajZE }}**.     
  1. Чтобы посмотреть события, вызванные действиями пользователя, перейдите на вкладку **{{ ui-key.yacloud_org.organization.users.UserPageLayout.title_audit-log_fGywF }}**.
  1. Чтобы увидеть более подробную информацию о событии, нажмите на нужную запись.

  Вы также можете воспользоваться фильтрами вверху страницы, чтобы найти нужные логи.

{% endlist %}

## Посмотреть логи пользователей конкретного пула {#pool}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}**.
  1. В списке [пулов пользователей](../../concepts/user-pools.md) выберите нужный пул.
  1. Чтобы посмотреть историю аутентификации пользователя, перейдите на вкладку **{{ ui-key.yacloud_org.organization.users.UserPageLayout.title_auth-audit-log_sajZE }}**.     
  1. Чтобы посмотреть события, вызванные действиями пользователя, перейдите на вкладку **{{ ui-key.yacloud_org.organization.users.UserPageLayout.title_audit-log_fGywF }}**.
  1. Чтобы увидеть более подробную информацию о событии, нажмите на нужную запись.

  Вы также можете воспользоваться фильтрами вверху страницы, чтобы найти нужные события.

{% endlist %}