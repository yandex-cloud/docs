---
title: Управление доступом партнера в {{ marketplace-full-name }}
description: Управление доступом партнера в {{ marketplace-short-name }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе, какие роли необходимы для того или иного действия.
---

# Управление доступом партнера в {{ marketplace-short-name }}

В этом разделе вы узнаете:
* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в профиле партнера](#roles-list);
* [как добавить нового пользователя в профиль партнера](#add-user);
* [как назначить роль в профиле партнера](#assign-role).

## На какие ресурсы можно назначить роль {#resources}

 В [кабинете партнера {{ marketplace-short-name }}]({{ link-cloud-partners }}) можно [назначить роль](#assign-role) на [продукты Marketplace](../concepts/product.md) и на [профиль партнера](../quickstart.md#registration).

## Какие роли действуют в сервисе {#roles-list}

### Сервисные роли {#service-roles}

#### marketplace.meteringAgent {#marketplace-meteringagent}

{% include [marketplace.meteringAgent](../../_roles/marketplace/meteringAgent.md) %}

#### license-manager.saasSubscriptionSupervisor {#license-manager-saasSubscriptionSupervisor}

{% include [license-manager.saasSubscriptionSupervisor](../../_roles/license-manager/saasSubscriptionSupervisor.md) %}

#### marketplace.product.creator {#marketplace-product-creator}

{% include [marketplace.product.creator](../../_roles/marketplace/product/creator.md) %}

#### marketplace.product.admin {#marketplace-product-admin}

{% include [marketplace.product.admin](../../_roles/marketplace/product/admin.md) %}

#### marketplace.publishers.reportViewer {#marketplace-publishers-reportViewer}

{% include [marketplace.publishers.reportViewer](../../_roles/marketplace/publishers/reportViewer.md) %}

#### marketplace.publishers.viewer {#marketplace-publishers-viewer}

{% include [marketplace.publishers.viewer](../../_roles/marketplace/publishers/viewer.md) %}

#### marketplace.publishers.editor {#marketplace-publishers-editor}

{% include [marketplace.publishers.editor](../../_roles/marketplace/publishers/editor.md) %}

#### marketplace.publishers.admin {#marketplace-publishers-admin}

{% include [marketplace.publishers.admin](../../_roles/marketplace/publishers/admin.md) %}

#### marketplace.publishers.owner {#marketplace-publishers-owner}

{% include [marketplace.publishers.owner](../../_roles/marketplace/publishers/owner.md) %}

#### marketplace.publishers.member {#marketplace-publishers-member}

{% include [marketplace.publishers.member](../../_roles/marketplace/publishers/member.md) %}

## Добавление пользователя в профиль партнера {{ marketplace-short-name }} {#add-user}

Чтобы добавить нового пользователя в профиль партнера {{ marketplace-short-name }}, необходима роль `marketplace.publishers.admin` или выше.

Добавить можно только [пользователя с аккаунтом на Яндексе](../../iam/concepts/users/accounts.md#passport) или [федеративного пользователя](../../iam/concepts/users/accounts.md#saml-federation). Чтобы добавить нового пользователя:

{% list tabs group=authentication %}

- Аккаунт на Яндексе {#yandex-account}

  1. Откройте [кабинет партнера {{ marketplace-short-name }}]({{ link-cloud-partners }}).
  1. На панели слева выберите ![persons](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_portal.portal.publisher-users }}**.
  1. В верхней части экрана нажмите кнопку **{{ ui-key.yacloud_portal.acl.common.action_via-email }}** и в открывшемся окне:

      1. Укажите электронный адрес аккаунта на Яндексе, принадлежащего пользователю, которого вы хотите добавить в кабинет партнера.
      1. Нажмите кнопку **{{ ui-key.yacloud_portal.common.action_add }}**.

- Федеративный аккаунт {#federated-account}

  1. Откройте [кабинет партнера {{ marketplace-short-name }}]({{ link-cloud-partners }}).
  1. На панели слева выберите ![persons](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_portal.portal.publisher-users }}**.
  1. В верхней части экрана нажмите кнопку **{{ ui-key.yacloud_portal.acl.common.action_via-federation }}** и в открывшемся окне:

      1. Укажите Name ID федеративного пользователя, которого вы хотите добавить в кабинет партнера.

          Необходимо указывать Name ID, которые возвращает поставщик удостоверений (IdP) после успешной аутентификации. Это могут быть UPN или электронный адрес пользователя.

          Вы можете добавить сразу несколько пользователей, разделив их Name ID переносом строки.

      1. Нажмите кнопку **{{ ui-key.yacloud_portal.common.action_add }}**.

{% endlist %}

В результате новый пользователь появится в списке пользователей на странице **{{ ui-key.yacloud_portal.marketplace_v2.common.page_title_roles }}**. Добавленным пользователям по умолчанию назначаются роли [`marketplace.publishers.member`](#marketplace-publishers-member) и [`marketplace.publishers.viewer`](#marketplace-publishers-viewer).

## Назначение и отзыв роли {#assign-role}

В кабинете партнера {{ marketplace-short-name }} можно назначать роли на определенные продукты или на профиль партнера. Чтобы назначить пользователю роль или отозвать ее:

{% list tabs %}

- На продукт

  1. Откройте [кабинет партнера {{ marketplace-short-name }}]({{ link-cloud-partners }}).
  1. На панели слева выберите ![shopping-cart](../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud_portal.portal.products }}**.
  1. Нажмите на строку с продуктом, на который хотите назначить или отозвать роль. В открывшемся окне:

      1. В меню слева выберите **{{ ui-key.yacloud_portal.marketplace_v2.common.page_title_roles }}**.
      1. В строке с пользователем, для которого вы хотите назначить или отозвать роль, нажмите ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_portal.common.action_change }}**. В открывшемся окне:

          {% include [assign-role](../../_includes/marketplace/assign-role.md) %}

- На профиль партнера

  1. Откройте [кабинет партнера {{ marketplace-short-name }}]({{ link-cloud-partners }}).
  1. На панели слева выберите ![persons](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_portal.portal.publisher-users }}**.
  1. В строке с пользователем, для которого вы хотите назначить или отозвать роль, нажмите ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_portal.common.action_change }}**. В открывшемся окне:

      {% include [assign-role](../../_includes/marketplace/assign-role.md) %}

{% endlist %}