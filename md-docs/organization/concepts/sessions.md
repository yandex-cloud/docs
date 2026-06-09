# Сессии

После успешной аутентификации пользователя в {{ org-full-name }} через сервис аутентификации [{{ auth-main-host }}](https://{{ auth-main-host }}) для этого пользователя создается _сессия_, при этом для домена `{{ auth-main-host }}` создается [cookie](../../iam/concepts/authorization/cookie.md) `yc_session`.

Сессии позволяют использовать сервисы, применяющие [технологию единого входа](../../glossary/sso.md) (SSO) и использующие {{ org-full-name }} в качестве поставщика удостоверений (IdP), без необходимости повторной аутентификации в {{ org-full-name }}.

Сессия содержит следующие данные о сеансе работы пользователя с {{ org-full-name }}:

* **{{ ui-key.yacloud_org.organization.users.user_agent_bHjZs }}** — [идентификатор](https://ru.wikipedia.org/wiki/User_agent) клиентского приложения. Неизменяемое значение.
* **{{ ui-key.yacloud_org.organization.users.created_at_khi1N }}** — дата и время создания сессии. Неизменяемое значение.
* **{{ ui-key.yacloud_org.organization.users.last_used_at_899qR }}** — дата и время последнего использования сессии для аутентификации в приложениях, использующих {{ org-full-name }} в качестве поставщика удостоверений. Значение может изменяться в процессе работы с сессией.
* **{{ ui-key.yacloud_org.organization.users.expires_at_adUqM }}** — [срок жизни](sessions.md#session-lifetime) сессии, по истечении которого пользователю придется пройти повторную аутентификацию в {{ org-full-name }}. Неизменяемое значение.
* **{{ ui-key.yacloud_org.organization.users.ip_address_u9ysH }}** — последний IP-адрес пользователя, с которого в рамках данной сессии он обращался к сервисам, требующим аутентификации через {{ org-full-name }}. Значение может изменяться в процессе работы с сессией.
* **{{ ui-key.yacloud.common.id }}** — уникальный идентификатор сессии. Неизменяемое значение.

## Срок жизни сессии {#session-lifetime}

В зависимости от типа пользовательского аккаунта срок жизни сессии:

* у [федеративных](../../iam/concepts/users/accounts.md#saml-federation) пользователей определяется настройками [федерации удостоверений](add-federation.md);
* у [локальных](../../iam/concepts/users/accounts.md#local) пользователей определяется настройками [пула пользователей](user-pools.md);
* у пользователей [с аккаунтом на Яндексе](../../iam/concepts/users/accounts.md#passport) составляет 12 часов.

## Управление сессиями пользователей {#session-management}

Пользователь может [просматривать](../operations/manage-account.md#view-sessions) свои текущие сессии, а также [завершать](../operations/manage-account.md#end-sessions) свои сессии на [портале «Мой аккаунт»](my-account.md).

Администратор может [просматривать](../operations/manage-sessions.md#view-sessions) и [завершать](../operations/manage-sessions.md#end-sessions) сессии [федеративных](../../iam/concepts/users/accounts.md#saml-federation) и [локальных](../../iam/concepts/users/accounts.md#local) пользователей организации. Для этого администратору на [организацию](organization.md) должны быть назначены соответственно роли [`organization-manager.federations.userAdmin`](../security/index.md#organization-manager-federations-userAdmin) и [`organization-manager.userpools.userAdmin`](../security/index.md#organization-manager-userpools-userAdmin) или выше.

{% note info %}

Администратор организации не может управлять сессиями других пользователей организации [с аккаунтом на Яндексе](../../iam/concepts/users/accounts.md#passport).

{% endnote %}

Сессия завершается и автоматически пропадает из списка сессий пользователя по истечении срока ее жизни, а также когда пользователь выходит из своего аккаунта, нажав кнопку ![arrow-right-from-square](../../_assets/console-icons/arrow-right-from-square.svg) **{{ ui-key.yacloud_org.center-layout.MyAccountLayout.logout_nXPin }}**.

#### См. также {#see-also}

* [{#T}](../../iam/concepts/authorization/cookie.md)
* [{#T}](../operations/manage-sessions.md)
* [{#T}](../operations/manage-account.md)