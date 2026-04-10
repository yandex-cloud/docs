---
title: Управлять сессиями пользователей {{ org-full-name }}
description: Следуя данной инструкции, вы сможете просматривать и завершать сессии федеративных и локальных пользователей в {{ org-full-name }}.
---

# Управлять сессиями пользователей

Администратор может просматривать и завершать [сессии](../concepts/sessions.md) {{ org-full-name }} [федеративных](../../iam/concepts/users/accounts.md#saml-federation) и [локальных](../../iam/concepts/users/accounts.md#local) пользователей организации. Для этого администратору на [организацию](../concepts/organization.md) должны быть назначены соответственно роли [`organization-manager.federations.userAdmin`](../security/index.md#organization-manager-federations-userAdmin) и [`organization-manager.userpools.userAdmin`](../security/index.md#organization-manager-userpools-userAdmin) или выше.

{% note warning %}

[Просматривать](./manage-account.md#view-sessions) и [завершать](./manage-account.md#end-sessions) сессии пользователя [с аккаунтом на Яндексе](../../iam/concepts/users/accounts.md#passport) может только сам этот пользователь.

{% endnote %}

## Посмотреть сессии пользователя {#view-sessions}

Чтобы посмотреть активные сессии федеративного или локального пользователя организации:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![person](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}** и в открывшемся списке выберите нужного [федеративного](../../iam/concepts/users/accounts.md#saml-federation) или [локального](../../iam/concepts/users/accounts.md#local) пользователя.

      Чтобы быстрее найти нужного пользователя, воспользуйтесь фильтром в верхней части экрана.
  1. В открывшемся окне перейдите на вкладку **{{ ui-key.yacloud_org.organization.users.UserPageLayout.title_sso-sessions_pDJYw }}**.

      Открывшийся список содержит следующую информацию о сессиях выбранного пользователя:

      {% include [session-contents-list](../../_includes/organization/session-contents-list.md) %}

{% endlist %}

## Завершить сессии пользователя {#end-sessions}

Чтобы завершить активные сессии федеративного или локального пользователя организации:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![person](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}** и в открывшемся списке выберите нужного [федеративного](../../iam/concepts/users/accounts.md#saml-federation) или [локального](../../iam/concepts/users/accounts.md#local) пользователя.

      Чтобы быстрее найти нужного пользователя, воспользуйтесь фильтром в верхней части экрана.
  1. В открывшемся окне перейдите на вкладку **{{ ui-key.yacloud_org.organization.users.UserPageLayout.title_sso-sessions_pDJYw }}**. 

      Открывшийся список содержит информацию о сессиях выбранного пользователя.
  1. Чтобы завершить определенную сессию пользователя:
  
      1. В строке с нужной сессией нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![arrow-right-from-square](../../_assets/console-icons/arrow-right-from-square.svg) **{{ ui-key.yacloud_org.actions.end }}**.
      1. В открывшемся окне подтвердите завершение сессии.

      В результате на выбранном устройстве доступ пользователя к сервисам, использующим {{ org-full-name }} в качестве поставщика удостоверений, прекратится.
  1. Чтобы завершить все сессии пользователя:

      1. В правом верхнем углу экрана нажмите кнопку ![arrow-right-from-square](../../_assets/console-icons/arrow-right-from-square.svg) **{{ ui-key.yacloud_org.organization.users.action_end-all-sso-sessions_7DUdt }}**.
      1. В открывшемся окне подтвердите завершение всех сессий.

      В результате доступ пользователя к сервисам, использующим {{ org-full-name }} в качестве поставщика удостоверений, прекратится на всех устройствах.
      
  Чтобы возобновить доступ, пользователю придется повторно выполнить аутентификацию в {{ org-full-name }}.

{% endlist %}

#### См. также {#see-also}

* [{#T}](../concepts/sessions.md)
* [{#T}](./manage-account.md)