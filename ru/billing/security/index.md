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

Сервисные роли — роли, предоставляющие доступ к сервису {{ billing-name }}: 

* `billing.accounts.member` — автоматически выдается при добавлении пользователя в сервисе {{ billing-name }}. Она необходима для показа выбранного платежного аккаунта в списке всех аккаунтов пользователя.
* `billing.accounts.owner` — автоматически выдается при создании платежного аккаунта. Роль, выданную при создании, нельзя отозвать, но можно выдать такую же роль другим пользователям и отозвать ее у них.
* `billing.accounts.viewer` — назначается на платежный аккаунт. Дает право просматривать данные платежного аккаунта, получать информацию о потреблении ресурсов, проверять расходы, выгружать акты сверки и отчетные документы.
* `billing.accounts.editor` — назначается на платежный аккаунт. Дает право получать счет на оплату, активировать промокоды, привязывать облака и сервисы к платежному аккаунту, создавать экспорт детализации, создавать бюджеты, генерировать акты сверки и резервировать ресурсы. Включает в себя роль `billing.accounts.viewer`.
* `billing.accounts.admin` — назначается на платежный аккаунт. Позволяет управлять доступами к платежному аккаунту (кроме роли `billing.accounts.owner`). Включает в себя роль `billing.accounts.editor`.
* `billing.accounts.varWithoutDiscounts` — назначается на платежный аккаунт. Предоставляет партнерским аккаунтам все права администратора, кроме возможности получать информацию о скидках. Включает в себя роль `billing.partners.editor`.
* `billing.partners.editor` — назначается на платежный аккаунт. Дает право редактировать информацию о партнере и его продуктах в партнерском каталоге.

### Примитивные роли {#primitive-roles}

Примитивные роли — роли агрегаторы, определяющие разрешения пользователя для доступа к сервисам. В {{ billing-name }} эти роли соответствуют ролям `billing.accounts.*`: 

* `auditor` — аналогична роли `billing.accounts.viewer` с ограничениями.
* `viewer` — аналогична роли `billing.accounts.viewer`.
* `editor` — аналогична роли `billing.accounts.editor`.
* `admin` — аналогична роли `billing.accounts.admin`.

Примитивные роли могут назначаться только пользователям, добавленным в список **{{ ui-key.yacloud.iam.cloud.incident-notifications.label_users }}**. 

Список доступных операций для каждой роли представлен в таблице ниже.


Операции | `member` | `owner` | `viewer` | `editor` | `admin` |
----- | ----- | ----- | ----- | ----- | ----- 
Показ платежного аккаунта в списке всех аккаунтов | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)| ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg)
Просмотр данных платежного аккаунта | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
Просмотр и получение уведомлений о потреблении | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
Просмотр и скачивание отчетных (закрывающих) документов | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
Просмотр и скачивание уже сгенерированных актов сверки | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
Проверка расходов | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
Доступ к детализации | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
Активация промокодов | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
Пополнение лицевого счета с помощью расчетного счета | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
Привязка облаков к платежному аккаунту | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
Создание экспорта детализации | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
Создание бюджета | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
Генерация нового акта сверки | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
Резервирование ресурсов | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
Выдача ролей на платежный аккаунт | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | 
Просмотр и редактирование ролей | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | 
Переименование платежного аккаунта | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
Изменение контактов плательщика | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
Изменение платежных реквизитов | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
Изменение банковской карты | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
Изменение способа оплаты | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
Активация пробного периода | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
Активация платной версии| ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
Пополнение лицевого счета с помощью банковской карты | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |




## Добавление пользователя {#set-member-role}

Пользователь, которому выдана роль `billing.accounts.admin`, может добавить в список **{{ ui-key.yacloud.iam.cloud.incident-notifications.label_users }}** любого пользователя {{ yandex-cloud }} или сервисный аккаунт. Для этого:

1. Откройте [консоль управления]({{ link-console-main }}) {{ yandex-cloud }}.
1. В левом верхнем углу нажмите значок ![image](../../_assets/console-icons/dots-9.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}**.
1. Выберите сервис ![image](../../_assets/console-icons/credit-card.svg) [**{{ billing-name }}**]({{ link-console-billing }}).
1. Выберите аккаунт на странице **{{ ui-key.yacloud.billing.label_accounts }}**.
1. Перейдите на страницу **{{ ui-key.yacloud.billing.account.switch_users }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.billing.account.users.button_add }}**.
1. Выберите пользователя из выпадающего списка. В списке отображаются пользователи, облака которых привязаны к вашему платежному аккаунту.
1. Нажмите кнопку **{{ ui-key.yacloud.billing.account.user-dialog.button_submit }}**.

Пользователь или сервисный аккаунт получит роль `billing.accounts.member` и будет добавлен в список **{{ ui-key.yacloud.iam.cloud.incident-notifications.label_users }}**. Чтобы разрешить доступ к платежному аккаунту, назначьте нужную роль.

## Назначение роли {#set-role}

Пользователь, которому выдана роль `billing.accounts.admin`, может предоставить доступ к платежному аккаунту любому пользователю или сервисному аккаунту, добавленному в список **{{ ui-key.yacloud.iam.cloud.incident-notifications.label_users }}**. Для этого:
 
1. В [консоли управления]({{ link-console-billing }}), в левом верхнем углу страницы, нажмите ![image](../../_assets/console-icons/dots-9.svg) и выберите сервис **{{ billing-name }}**.
1. Выберите аккаунт на странице **{{ ui-key.yacloud.billing.label_accounts }}**.
1. Перейдите на страницу **{{ ui-key.yacloud.billing.account.switch_users }}**.
1. Найдите пользователя или сервисный аккаунт в списке.
1. Нажмите на ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.billing.account.users.button_tune-role }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.billing.account.users.popup-tune-role_add-button }}**.
1. Выберите необходимую роль из списка. Роль будет предоставлена бессрочно. 

## Отзыв роли {#delete-role}

В любой момент пользователь, которому выдана роль `billing.accounts.admin`, может отозвать роль у пользователя или сервисного аккаунта из списка. Для этого:

1. В [консоли управления]({{ link-console-billing }}), в левом верхнем углу страницы, нажмите значок ![image](../../_assets/console-icons/dots-9.svg) и выберите сервис **{{ billing-name }}**.
1. Выберите аккаунт на странице **{{ ui-key.yacloud.billing.label_accounts }}**.
1. Перейдите на страницу **{{ ui-key.yacloud.billing.account.switch_users }}**.
1. Найдите пользователя или сервисный аккаунт в списке.
1. Нажмите на ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.billing.account.users.button_tune-role }}**.
1. Напротив роли, которую необходимо отозвать, нажмите ![image](../../_assets/console-icons/xmark.svg). Роль будет отозвана. 


{% note info %}

Доступ к платежному аккаунту станет невозможным, если у пользователя будет отозвана роль `billing.accounts.member`. 

{% endnote %}

## Удаление пользователя {#delete-user}

1. В [консоли управления]({{ link-console-billing }}), в левом верхнем углу страницы, нажмите значок ![image](../../_assets/console-icons/dots-9.svg) и выберите сервис **{{ billing-name }}**.
1. Выберите аккаунт на странице **{{ ui-key.yacloud.billing.label_accounts }}**.
1. Перейдите на страницу **{{ ui-key.yacloud.billing.account.switch_users }}**.
1. Найдите пользователя или сервисный аккаунт в списке.
1. Нажмите на ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.billing.account.users.button_remove-user }}**.
1. Пользователь будет удален из списка пользователей этого платежного аккаунта. 
