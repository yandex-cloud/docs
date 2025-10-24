---
title: Добавить пользователя в сабаккаунт
description: Следуя данной инструкции, вы сможете добавить пользователя в сабаккаунт партнера и назначить ему роли.
---

# Добавить пользователя в сабаккаунт

Чтобы предоставить пользователю доступ к сабаккаунту партнера, [добавьте](#add-user) его в сабаккаунт и [назначьте](#add-access) роли.

## Добавить пользователя в сабаккаунт {#add-user}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в [консоль управления]({{ link-console-main }}).
  1. Найдите в списке организацию, созданную для сабаккаунта, например: `For subaccount <название_сабаккаунта>`.
  1. [Привяжите](./pin-cloud.md) облако к сабаккаунту. Если облака нет:
     1. На панели слева напротив названия организации нажмите ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.iam.cloud.label_create_cloud }}**.
     1. Укажите название облака и сабаккаунт партнера.
  
  1. Перейдите в [{{ cloud-center }}]({{ link-org-cloud-center }}).
  1. В левом верхнем углу экрана рядом с названием текущей организации нажмите значок ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите нужную организацию, например: `For subaccount <название_сабаккаунта>`.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.center-layout.Layout.organization-description_kvoUz }}** и нажмите **{{ ui-key.yacloud_org.page.users.dropdown.button-text }}**. 
  1. В выпадающем списке выберите **{{ ui-key.yacloud_org.page.users.action.invite-users }}** и введите адрес электронной почты пользователя. Или выберите **{{ ui-key.yacloud_org.page.users.action.add-userpool-user }}** в [пуле](../../organization/concepts/user-pools.md).

{% endlist %}

## Назначить роли {#add-access}

После того как пользователь принял приглашение в организацию, назначьте ему роли:

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. Перейдите в сервис [{{ billing-name }}]({{ link-console-billing }}).
  1. [Добавьте](../../billing/security/index.md#set-member-role) пользователя в сабаккаунт.
  1. [Назначьте](../../billing/security/index.md#set-role) ему роли.

- Партнерский портал {#partner}

  1. Перейдите на [партнерский портал]({{ link-cloud-partners }}).
  1. На панели слева выберите ![icon](../../_assets/console-icons/credit-card.svg) **Сабаккаунты**.
  1. Выберите нужный сабаккаунт из списка.
  1. Перейдите на вкладку ![icon](../../_assets/console-icons/person-gear.svg) **Пользователи**.
  1. В правом верхнем углу нажмите **Добавить пользователя**.
  1. Выберите нужного пользователя из списка и нажмите **Добавить**.
  1. В блоке **Пользователи и роли** напротив добавленного пользователя нажмите ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **Изменить**.
  1. В открывшемся окне назначьте нужные роли.

{% endlist %}