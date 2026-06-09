# Управлять сессиями пользователей

Администратор может просматривать и завершать [сессии](../concepts/sessions.md) {{ org-full-name }} [федеративных](../../iam/concepts/users/accounts.md#saml-federation) и [локальных](../../iam/concepts/users/accounts.md#local) пользователей организации. Для этого администратору на [организацию](../concepts/organization.md) должны быть назначены соответственно роли [`organization-manager.federations.userAdmin`](../security/index.md#organization-manager-federations-userAdmin) и [`organization-manager.userpools.userAdmin`](../security/index.md#organization-manager-userpools-userAdmin) или выше.

{% note warning %}

[Просматривать](manage-account.md#view-sessions) и [завершать](manage-account.md#end-sessions) сессии пользователя [с аккаунтом на Яндексе](../../iam/concepts/users/accounts.md#passport) может только сам этот пользователь.

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

      * **{{ ui-key.yacloud_org.organization.users.user_agent_bHjZs }}** — [идентификатор](https://ru.wikipedia.org/wiki/User_agent) клиентского приложения. Неизменяемое значение.
      * **{{ ui-key.yacloud_org.organization.users.created_at_khi1N }}** — дата и время создания сессии. Неизменяемое значение.
      * **{{ ui-key.yacloud_org.organization.users.last_used_at_899qR }}** — дата и время последнего использования сессии для аутентификации в приложениях, использующих {{ org-full-name }} в качестве поставщика удостоверений. Значение может изменяться в процессе работы с сессией.
      * **{{ ui-key.yacloud_org.organization.users.expires_at_adUqM }}** — [срок жизни](../concepts/sessions.md#session-lifetime) сессии, по истечении которого пользователю придется пройти повторную аутентификацию в {{ org-full-name }}. Неизменяемое значение.
      * **{{ ui-key.yacloud_org.organization.users.ip_address_u9ysH }}** — последний IP-адрес пользователя, с которого в рамках данной сессии он обращался к сервисам, требующим аутентификации через {{ org-full-name }}. Значение может изменяться в процессе работы с сессией.
      * **{{ ui-key.yacloud.common.id }}** — уникальный идентификатор сессии. Неизменяемое значение.

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
* [{#T}](manage-account.md)