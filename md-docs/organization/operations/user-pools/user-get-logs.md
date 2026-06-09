# Посмотреть логи пользователя


Права на просмотр [логов](../../concepts/logs.md) пользователя зависят от его [роли](../../security/index.md) в [организации](../../concepts/organization.md) или [пуле пользователей](../../concepts/user-pools.md):

* `organization-manager.viewer`, `organization-manager.editor`, `organization-manager.admin` или `organization-manager.organizations.owner` — логи любого пользователя организации на [странице пользователя](user-get-logs.md#organization);
* `organization-manager.userpools.admin` и выше — логи всех пользователей пула на [странице в пуле](user-get-logs.md#pool);
* остальные пользователи — только свои логи в портале [Мой аккаунт](../../concepts/my-account.md).

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