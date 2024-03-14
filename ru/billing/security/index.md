---
title: "Управление доступом Биллинга"
description: "Доступ к платежному аккаунту предоставляется через сервис {{ billing-name }}. Операции, которые пользователь может выполнять над платежным аккаунтом, определяются назначенной ему ролью."
---

# Управление доступом в сервисе {{ billing-name }}

## Доступ к платежному аккаунту {#billing-account}

Доступ к [платежному аккаунту](../concepts/billing-account.md) предоставляется через сервис {{ billing-name }}. Платежный аккаунт могут создавать пользователи с зарегистрированным аккаунтом на Яндексе или в Яндекс 360:

* Если у вас или вашего сотрудника еще нет аккаунта, создайте его на [Яндексе](https://passport.yandex.ru/registration) или в [Яндекс 360](https://yandex.ru/support/business/add-users.html).
* Если для авторизации на Яндексе вы используете профиль в социальной сети, [заведите логин и пароль](https://passport.yandex.ru/passport?mode=postregistration&create_login=1).

Операции, которые пользователь может выполнять над платежным аккаунтом, определяются назначенной ему ролью. Роли можно назначить аккаунту на Яндексе, [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [федеративным пользователям](../../iam/concepts/federations.md), [группе пользователей](../../organization/operations/manage-groups.md) или [системной группе](../../iam/concepts/access-control/system-group.md).

{% note info %}

Доступ может быть предоставлен только пользователю, к платежному аккаунту которого привязано любое облако в сервисе [{{ iam-name }}](../../iam/). 

{% endnote %}

## Какие роли действуют в сервисе {#roles-list}

### Сервисные роли {#service-roles}

#### billing.accounts.member {#billing-accounts-member}

{% include [billing.accounts.member](../../_roles/billing/accounts/member.md) %}

#### billing.accounts.owner {#billing-accounts-owner}

{% include [billing.accounts.owner](../../_roles/billing/accounts/owner.md) %}

#### billing.accounts.viewer {#billing-accounts-viewer}

{% include [billing.accounts.viewer](../../_roles/billing/accounts/viewer.md) %}

#### billing.accounts.accountant {#billing-accounts-accountant}

{% include [billing.accounts.accountant](../../_roles/billing/accounts/accountant.md) %}

#### billing.accounts.editor {#billing-accounts-editor}

{% include [billing.accounts.editor](../../_roles/billing/accounts/editor.md) %}

#### billing.accounts.admin {#billing-accounts-admin}

{% include [billing.accounts.admin](../../_roles/billing/accounts/admin.md) %}

#### billing.accounts.varWithoutDiscounts {#billing-accounts-var-without-discounts}

{% include [billing.accounts.varwithoutdiscounts](../../_roles/billing/accounts/varWithoutDiscounts.md) %}

#### billing.partners.editor {#billing-partners-editor}

{% include [billing.partners.editor](../../_roles/billing/partners/editor.md) %}

### Примитивные роли {#primitive-roles}

Примитивные роли — роли агрегаторы, определяющие разрешения пользователя для доступа к сервисам. В {{ billing-name }} эти роли соответствуют ролям `billing.accounts.*`: 

* `auditor` — аналогична роли `billing.accounts.viewer` с ограничениями.
* `viewer` — аналогична роли `billing.accounts.viewer`.
* `editor` — аналогична роли `billing.accounts.editor`.
* `admin` — аналогична роли `billing.accounts.admin`.

Примитивные роли могут назначаться только пользователям, добавленным в список **{{ ui-key.yacloud.iam.cloud.incident-notifications.label_users }}**. 

### Доступные операции {#available-operations}

Список доступных операций для ролей каждого типа представлен в таблице ниже.

| Операции                                                | `member` | `owner`   | `viewer` | `accountant`                           | `editor` | `admin`   |
|---------------------------------------------------------|----------------------------------------|----------------------------------------|----------------------------------------|----------------------------------------|----------------------------------------|----------------------------------------|
| Показ платежного аккаунта в списке всех аккаунтов       | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Просмотр данных платежного аккаунта                     | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Просмотр и получение уведомлений о потреблении          | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Просмотр и скачивание отчетных (закрывающих) документов | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Просмотр и скачивание уже сгенерированных актов сверки  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Проверка расходов                                       | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Доступ к детализации                                    | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Пополнение лицевого счета с помощью расчетного счета    | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Генерация нового акта сверки                            | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Активация промокодов                                    | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Привязка облаков к платежному аккаунту                  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Создание экспорта детализации                           | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Создание бюджета                                        | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Резервирование ресурсов                                 | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Выдача ролей на платежный аккаунт                       | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | 
| Просмотр и редактирование ролей                         | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | 
| Переименование платежного аккаунта                      | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  |
| Изменение контактов плательщика                         | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  |
| Изменение платежных реквизитов                          | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  |
| Изменение банковской карты                              | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  |
| Изменение способа оплаты                                | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  |
| Активация пробного периода                              | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  |
| Активация платной версии                                | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  |
| Пополнение лицевого счета с помощью банковской карты    | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  | ![image](../../_assets/common/no.svg)  |

## Добавление пользователя {#set-member-role}

Процесс добавления новых пользователей платежного аккаунта зависит от того, привязан ли платежный аккаунт к организации. 

{% list tabs %}

- С организацией

  [Назначьте](#set-role) нужную роль на платежный аккаунт любому пользователю или сервисному аккаунту в вашей организации.

- Без организации

  {% note info %}

  Чтобы добавить нового пользователя платежного аккаунта, нужна роль `billing.accounts.owner` или `billing.accounts.admin`.

  {% endnote %}

  1. Откройте [консоль управления]({{ link-console-main }}) {{ yandex-cloud }}.
  1. В левом верхнем углу нажмите значок ![image](../../_assets/console-icons/dots-9.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}**.
  1. Выберите сервис ![image](../../_assets/console-icons/credit-card.svg) [**{{ billing-name }}**]({{ link-console-billing }}).
  1. Выберите аккаунт на странице **{{ ui-key.yacloud.billing.label_accounts }}**.
  1. Перейдите на страницу **{{ ui-key.yacloud.billing.account.switch_users }}**.
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.billing.account.users.button_add }}**.
  1. Выберите пользователя из выпадающего списка. В списке отображаются пользователи, облака которых привязаны к вашему платежному аккаунту.
  1. Нажмите кнопку **{{ ui-key.yacloud.billing.account.user-dialog.button_submit }}**.

  Пользователь или сервисный аккаунт получит роль `billing.accounts.member` и будет добавлен в список **{{ ui-key.yacloud.iam.cloud.incident-notifications.label_users }}**. Чтобы разрешить доступ к платежному аккаунту, назначьте нужную роль.

{% endlist %}

## Назначение роли {#set-role}

Процесс назначения роли на платежный аккаунт зависит от того, привязан платежный аккаунт к организации или нет.

{% list tabs %}

- С организацией

  Пользователь, которому назначена роль `billing.accounts.admin`, может предоставить доступ к платежному аккаунту любому пользователю или сервисному аккаунту, относящемуся к той же организации, что и платежный аккаунт. Для этого:

  1. [Убедитесь](../../organization/operations/users-get.md), что в вашей организации есть нужный пользователь. Если нет, [добавьте](../../organization/operations/add-account.md) его.
  1. Откройте [консоль управления]({{ link-console-main }}) {{ yandex-cloud }}.
  1. В левом верхнем углу нажмите значок ![image](../../_assets/main-menu.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}**.
  1. Выберите сервис ![image](../../_assets/billing.svg) [**{{ billing-name }}**]({{ link-console-billing }}).
  1. Выберите аккаунт на странице **{{ ui-key.yacloud.billing.label_accounts }}**.
  1. Перейдите на страницу **{{ ui-key.yacloud.billing.account.switch_users }}**.
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**. В открывшемся окне:

     1. Нажмите кнопку ![image](../../_assets/create.svg) **{{ ui-key.yacloud_components.acl.action.select-subject }}**.
     1. Выберите пользователя или сервисный аккаунт из списка или воспользуйтесь строкой поиска.
     1. Нажмите кнопку ![image](../../_assets/create.svg) **{{ ui-key.yacloud_components.acl.action.add-role }}** и выберите нужную роль.
     1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.

  {% note info %}

  Если назначить сервисную роль {{ billing-name }} на организацию, то она будет выдана и на все платежные аккаунты в этой организации.

  {% endnote %}

- Без организации

  Пользователь, которому назначена роль `billing.accounts.admin`, может предоставить доступ к платежному аккаунту любому пользователю или сервисному аккаунту, добавленному в список **{{ ui-key.yacloud.iam.cloud.incident-notifications.label_users }}**. Для этого:
 
  1. В [консоли управления]({{ link-console-billing }}), в левом верхнем углу страницы, нажмите ![image](../../_assets/console-icons/dots-9.svg) и выберите сервис **{{ billing-name }}**.
  1. Выберите аккаунт на странице **{{ ui-key.yacloud.billing.label_accounts }}**.
  1. Перейдите на страницу **{{ ui-key.yacloud.billing.account.switch_users }}**.
  1. Найдите пользователя или сервисный аккаунт в списке.
  1. В строке с нужным пользователем или сервисным аккаунтом нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.billing.account.users.button_tune-role }}**.
  1. Нажмите кнопку ![image](../../_assets/create.svg) **{{ ui-key.yacloud.billing.account.users.popup-tune-role_add-button }}**.
  1. Выберите необходимую роль из списка.

{% endlist %}

Назначенная роль будет предоставлена бессрочно.

## Отзыв роли {#delete-role}

Процесс отзыва роли на платежный аккаунт зависит от того, привязан ли платежный аккаунт к организации.

{% list tabs %}

- С организацией

  В любой момент пользователь, которому выдана роль `billing.accounts.admin`, может отозвать у пользователя или сервисного аккаунта в своей организации роль на платежный аккаунт. Для этого:

  1. Откройте [консоль управления]({{ link-console-main }}) {{ yandex-cloud }}.
  1. В левом верхнем углу нажмите значок ![image](../../_assets/main-menu.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}**.
  1. Выберите сервис ![image](../../_assets/billing.svg) [**{{ billing-name }}**]({{ link-console-billing }}).
  1. Выберите аккаунт на странице **{{ ui-key.yacloud.billing.label_accounts }}**.
  1. Перейдите на страницу **{{ ui-key.yacloud.billing.account.switch_users }}**.
  1. Найдите пользователя или сервисный аккаунт в списке, либо воспользуйтесь фильтром по пользователю. 
  1. В строке с нужным пользователем или сервисным аккаунтом нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
  1. Напротив роли, которую необходимо отозвать, нажмите ![image](../../_assets/cross.svg).
  1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**. Роль будет отозвана.

- Без организации

  В любой момент пользователь, которому выдана роль `billing.accounts.admin`, может отозвать роль на платежный аккаунт у пользователя или сервисного аккаунта из списка. Для этого:

  1. В [консоли управления]({{ link-console-billing }}), в левом верхнем углу страницы, нажмите значок ![image](../../_assets/console-icons/dots-9.svg) и выберите сервис **{{ billing-name }}**.
  1. Выберите аккаунт на странице **{{ ui-key.yacloud.billing.label_accounts }}**.
  1. Перейдите на страницу **{{ ui-key.yacloud.billing.account.switch_users }}**.
  1. Найдите пользователя или сервисный аккаунт в списке.
  1. В строке с нужным пользователем или сервисным аккаунтом нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.billing.account.users.button_tune-role }}**.
  1. Напротив роли, которую необходимо отозвать, нажмите ![image](../../_assets/console-icons/xmark.svg). Роль будет отозвана. 

  {% note info %}

  Доступ к платежному аккаунту станет невозможным, если у пользователя отозвать роль `billing.accounts.member`. 

  {% endnote %}

{% endlist %}

## Удаление пользователя {#delete-user}

Удаление пользователей возможно лишь в платежных аккаунтах, которые не привязаны к организации. Для этого:

1. В [консоли управления]({{ link-console-billing }}), в левом верхнем углу страницы, нажмите значок ![image](../../_assets/console-icons/dots-9.svg) и выберите сервис **{{ billing-name }}**.
1. Выберите аккаунт на странице **{{ ui-key.yacloud.billing.label_accounts }}**.
1. Перейдите на страницу **{{ ui-key.yacloud.billing.account.switch_users }}**.
1. Найдите пользователя или сервисный аккаунт в списке.
1. В строке с нужным пользователем или сервисным аккаунтом нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.billing.account.users.button_remove-user }}**.
1. Пользователь будет удален из списка пользователей этого платежного аккаунта.

Если платежный аккаунт привязан к организации, просто [отзовите](#delete-role) нужную роль у пользователя или сервисного аккаунта. Вы можете [исключить пользователя из организации](../../organization/edit-account), чтобы закрыть для него доступ ко всем облакам и ресурсам в ней.
