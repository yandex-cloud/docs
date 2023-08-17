# Управление пользователями

{{ tracker-name }} поддерживает организации из {{ ya-360 }} и [{{ yandex-cloud }}]({{ link-org-main }}). Дополнительную организацию можно [подключить](https://tracker.yandex.ru/admin/orgs) на странице администрирования {{ tracker-name }}. При подключении второй организации пользователи и группы синхронизируются в {{ tracker-name }} автоматически.

Чтобы работать над задачами вместе с коллегами, добавьте их в {{ tracker-name }}. Это можно сделать несколькими способами:
- [Пригласить в {{ tracker-name }} пользователей](#invite_user), у которых есть аккаунты на Яндексе.
- [Добавить пользователей](../organization/operations/add-account.md) в сервис {{ org-full-name }}.
- [Создать новые аккаунты](#create_users) на домене организации.
- [Настроить федерацию удостоверений](#federation). С помощью федерации удостоверений сотрудники смогут использовать для входа в {{ tracker-name }} свои рабочие аккаунты в Active Directory, Google Workspace или других системах управления учетными записями пользователей.


{% note warning %}

Если в настройках {{ tracker-name }} включен автоматический [полный доступ для новых пользователей](access.md#access-new-users), то при добавлении пользователей в организацию [стоимость использования сервиса](https://cloud.yandex.ru/docs/tracker/pricing#sec_price) может увеличиться.

{% endnote %}

## Пригласить пользователей в организацию {#invite_user}

Чтобы пригласить пользователей в организацию:

{% list tabs %}

- {{ org-full-name }}

  1. Откройте [страницу {{ tracker-name }}]({{ link-tracker }}) и [войдите в аккаунт администратора](user/login.md).

  1. На панели слева нажмите кнопку ![](../_assets/tracker/svg/add-user.svg) **{{ ui-key.startrek.blocks-desktop_b-head.add-user }}**.

  1. В появившемся окне перечислите через запятую почтовые адреса сотрудников (например, `{{ example-account }}`) и нажмите кнопку **{{ ui-key.yacloud_org.entity.invitation.action_send-invitation }}**. Каждый пользователь получит письмо с предложением вступить в организацию.
  
  Чтобы войти в {{ tracker-name }}, приглашенным сотрудникам нужно будет перейти по ссылке из письма.

  Также пригласить пользователей можно в сервисе {{ org-full-name }}, подробнее в [документации](../organization/operations/add-account.md).

- {{ ya-360 }}

  Добавление пользователей в организацию доступно только в самом сервисе [{{ ya-360 }}]((https://admin.yandex.ru/)), на странице управления организацией. Подробнее о добавлении пользователей в {{ ya-360 }} в [документации](https://yandex.ru/support/business/users.html#add-users).

{% endlist %}

## Настроить федерацию удостоверений {#federation}

Федерация удостоверений — это технология, которая позволяет реализовать систему единого входа (Single Sign-On, SSO) и использовать для авторизации в {{tracker-full-name}} корпоративные аккаунты в Active Directory, Google Workspace или других SAML-совместимых системах управления учетными записями пользователей.

Чтобы создать федерацию удостоверений для организации:

{% list tabs %}

- {{ org-full-name }}

  1. Откройте [страницу {{ tracker-name }}]({{ link-tracker }}) и [войдите в аккаунт администратора](user/login.md).

  1. На панели слева нажмите **{{ ui-key.startrek.blocks-desktop_b-queues-info.admin }}** → **{{ ui-key.startrek.ui_components_page-admin_PageAdmin.menu-item-orgs }}**.

  1. В блоке **{{ ui-key.startrek.ui_components_page-admin_OrgPanes_CloudOrgPane.source-title }}** нажмите **{{ ui-key.startrek.ui_components_page-admin_OrgPanes_CloudOrgPane.federation-task-action }}**. Откроется страница сервиса {{ org-full-name }}.

  1. Задайте настройки федерации и нажмите кнопку **{{ ui-key.yacloud_org.form.federation.create.action.create }}**.
  
  Пользователи с корпоративными аккаунтами смогут [войти в {{ tracker-name }}](user/login.md) с помощью кнопки **Войти через SSO**.

  Подробнее о создании федерации читайте в документации [{{ org-full-name }}](../organization/concepts/add-federation.md).

- {{ ya-360 }}

  Следуйте [инструкции](https://yandex.ru/support/business/sso/setup.html) в документации {{ ya-360 }}.

{% endlist %}

## Создать аккаунты пользователей {#create_users}

Чтобы создать аккаунты пользователей, подключите почтовый домен в сервисе [{{ ya-360 }}]({{ link-ya-360 }}) для вашей организации:

1. Откройте [страницу {{ tracker-name }}]({{ link-tracker }}) и [войдите в аккаунт администратора](user/login.md).

1. На панели слева нажмите **{{ ui-key.startrek.blocks-desktop_b-queues-info.admin }}** → **{{ ui-key.startrek.ui_components_page-admin_PageAdmin.menu-item-orgs }}**.

1. В блоке **{{ ui-key.startrek.ui_components_page-admin_OrgPanes_DirectoryOrgPane.source-title }}** нажмите **{{ ui-key.startrek.ui_components_page-admin_OrganizationSmallPane.add-org-button }}**. Откроется окно с вашими организациями. Вы можете создать новую организацию или перейти в существующую.

   {% note info %}

   Если к вашей организации не подключен почтовый домен, в сервисе [{{ ya-360 }}]({{ link-ya-360 }}) нажмите **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesEmptyList.action-configure-mail }}** и добавьте домен. Подробнее читайте в [Справке сервиса]({{ support-business-domain }}). 

   {% endnote %}

1. В сервисе {{ ya-360 }} [создайте аккаунты пользователей]({{ support-business-users }}).

Чтобы [войти в {{ tracker-name }}](user/login.md), сотруднику с аккаунтом на домене нужно будет ввести полный почтовый адрес (например, `login@example.com`) и пароль.

## Удалить аккаунт пользователя {#remove}

Чтобы удалить аккаунт пользователя из {{ tracker-name }}, исключите сотрудника из организации, в которой он состоит:

- [{{ org-full-name }}](../organization/operations/edit-account.md).

- [{{ ya-360 }}](https://yandex.ru/support/business/users.html#sec_delete).

{% note info %}

Чтобы удалить аккаунт пользователя, который зарегистрирован одновременно в {{ org-full-name }} и {{ ya-360 }}, удалите его из обеих организаций.

{% endnote %}

Вы также можете изменить [права доступа](./access.md) для пользователей: режим <q>Чтение</q> не тарифицируется.
