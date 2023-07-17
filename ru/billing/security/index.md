---
title: "Управление доступом Биллинга"
description: "Доступ к платежному аккаунту предоставляется через сервис {{ billing-name }}. Операции, которые пользователь может выполнять над платежным аккаунтом, определяются назначенной ему ролью."
---

# Управление доступом к сервису {{ billing-name }}


## Доступ к сервису {#billing}

{% include [yandex-account](../_includes/yandex-account.md) %}


## Доступ к платежному аккаунту {#billing-account}

Доступ к [платежному аккаунту](../concepts/billing-account.md) предоставляется через сервис {{ billing-name }}. Операции, которые пользователь может выполнять над платежным аккаунтом, определяются назначенной ему ролью. 

{% note info %}

Доступ может быть предоставлен только пользователю, добавленному в любое облако в сервисе [{{ iam-name }}](../../iam/). 

{% endnote %}

## Роли в платежном аккаунте {#role-list}

В сервисе {{ billing-name }} существуют следующие роли: 

{% list tabs %}
        
- Сервисные роли
  
  Сервисные роли — роли, предоставляющие доступ к сервису {{ billing-name }}: 
  
  * `billing.accounts.member` —  автоматически выдается при добавлении пользователя в сервис {{ billing-name }}. <br/>Роль необходима для доступа к сервису {{ billing-name }} облака всем пользователям, кроме владельцев платежного аккаунта. Роль не позволяет выполнять какие-либо действия с платежным аккаунтом и используется только в сочетании с ролью `viewer` или `editor`.
  * `billing.accounts.owner`  — автоматически выдается при создании платежного аккаунта и не может быть переназначена на другого пользователя. Роль позволяет выполнять любые действия с платежным аккаунтом. 
  
- Примитивные роли
  
  Примитивные роли — роли, предоставляющие доступ к платежному аккаунту облака: 
   
  * `viewer` — роль выдается владельцем платежного аккаунта и позволяет просматривать некоторые данные о платежном аккаунте. 
  * `editor` — роль выдается владельцем платежного аккаунта, позволяет просматривать и редактировать некоторые данные о платежном аккаунте. 
  * `admin` — роль выдается владельцем платежного аккаунта, позволяет просматривать и редактировать некоторые данные о платежном аккаунте, назначать и отзывать роли добавленных пользователей. 
  
  Примитивные роли могут назначаться только пользователям, добавленным в список **Пользователи**. 
  
{% endlist %}

Список доступных операций для каждой роли представлен в таблице ниже.


Операции | `member` | `owner` | `viewer` | `editor` | `admin` |
----- | ----- | ----- | ----- | ----- | ----- 
Активация пробного периода | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
Активация платной версии| ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
Проверка расходов | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
Доступ к детализации | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
Активация промокодов | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
Пополнение лицевого счета с помощью банковской карты | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
Пополнение лицевого счета с помощью расчетного счета | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
Просмотр данных платежного аккаунта | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
Переименование платежного аккаунта | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
Изменение контактов плательщика | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
Изменение платежных реквизитов | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
Изменение банковской карты | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
Изменение способа оплаты | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
Выдача ролей на платежный аккаунт | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | 
Просмотр и редактирование ролей | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | 
Привязка облаков к платежному аккаунту | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
Создание экспорта детализации | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
Создание бюджета | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
Просмотр и получение уведомлений о потреблении | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
Просмотр и скачивание отчетных (закрывающих) документов | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
Просмотр и скачивание уже сгенерированных актов сверки | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
Генерация нового акта сверки | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
Резервирование ресурсов | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |



## Добавление пользователя {#set-member-role}

Владелец платежного аккаунта может добавить в список **Пользователи** любого пользователя {{ yandex-cloud }} или сервисный аккаунт. Для этого:

1. Откройте [консоль управления]({{ link-console-main }}) {{ yandex-cloud }}.
1. В левом верхнем углу нажмите кнопку ![image](../../_assets/main-menu.svg) **Все сервисы**.
1. Выберите вкладку ![image](../../_assets/billing.svg) [**Биллинг**]({{ link-console-billing }}).
1. Выберите аккаунт на странице **Аккаунты**.
1. Перейдите на страницу **Управление доступом**.
1. Нажмите кнопку **Добавить пользователя**.
1. Выберите пользователя из выпадающего списка. В списке отображаются пользователи вашей организации.
1. Нажмите кнопку **Добавить**.

Пользователь или сервисный аккаунт получит роль `billing.accounts.member` и будет добавлен в список **Пользователи**. Чтобы разрешить доступ к платежному аккаунту, назначьте нужную роль.

## Назначение роли {#set-role}

Владелец может предоставить доступ к платежному аккаунту любому пользователю или сервисному аккаунту, добавленному в список **Пользователи**. Для этого:
 
1. В [консоли управления]({{ link-console-billing }}), в левом верхнем углу страницы, нажмите ![image](../../_assets/main-menu.svg) и перейдите на вкладку **Биллинг**.
1. Выберите аккаунт на странице **Аккаунты**.
1. Перейдите на страницу **Управление доступом**.
1. Найдите пользователя или сервисный аккаунт в списке.
1. Нажмите на ![image](../../_assets/horizontal-ellipsis.svg) и выберите пункт **Настроить роли**.
1. Нажмите кнопку **Назначить роль**.
1. Выберите необходимую роль из списка. Роль будет предоставлена бессрочно. 

## Отзыв  роли {#delete-role}

В любой момент владелец платежного аккаунта может отозвать роль у пользователя или сервисного аккаунта из списка. Для этого:

1. В [консоли управления]({{ link-console-billing }}), в левом верхнем углу страницы, нажмите ![image](../../_assets/main-menu.svg) и перейдите на вкладку **Биллинг**.
1. Выберите аккаунт на странице **Аккаунты**.
1. Перейдите на страницу **Управление доступом**.
1. Найдите пользователя или сервисный аккаунт в списке.
1. Нажмите на ![image](../../_assets/horizontal-ellipsis.svg) и выберите пункт **Настроить роли**.
1. Напротив роли, которую необходимо отозвать, нажмите ![image](../../_assets/cross.svg). Роль будет отозвана. 


{% note info %}

Доступ к платежному аккаунту станет невозможным, если в Биллинге у пользователя будет отозвана роль `billing.accounts.member`. 

{% endnote %}
