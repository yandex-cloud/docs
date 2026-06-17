# Сессии

После успешной аутентификации пользователя в Yandex Identity Hub через сервис аутентификации [auth.yandex.cloud](https://auth.yandex.cloud) для этого пользователя создается _сессия_, при этом для домена `auth.yandex.cloud` создается [cookie](../../iam/concepts/authorization/cookie.md) `yc_session`.

Сессии позволяют использовать сервисы, применяющие [технологию единого входа](../../glossary/sso.md) (SSO) и использующие Yandex Identity Hub в качестве поставщика удостоверений (IdP), без необходимости повторной аутентификации в Yandex Identity Hub.

Сессия содержит следующие данные о сеансе работы пользователя с Yandex Identity Hub:

* **User-Agent** — [идентификатор](https://ru.wikipedia.org/wiki/User_agent) клиентского приложения. Неизменяемое значение.
* **Дата создания** — дата и время создания сессии. Неизменяемое значение.
* **Дата использования** — дата и время последнего использования сессии для аутентификации в приложениях, использующих Yandex Identity Hub в качестве поставщика удостоверений. Значение может изменяться в процессе работы с сессией.
* **Дата окончания** — [срок жизни](sessions.md#session-lifetime) сессии, по истечении которого пользователю придется пройти повторную аутентификацию в Yandex Identity Hub. Неизменяемое значение.
* **IP-адрес** — последний IP-адрес пользователя, с которого в рамках данной сессии он обращался к сервисам, требующим аутентификации через Yandex Identity Hub. Значение может изменяться в процессе работы с сессией.
* **Идентификатор** — уникальный идентификатор сессии. Неизменяемое значение.

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

Сессия завершается и автоматически пропадает из списка сессий пользователя по истечении срока ее жизни, а также когда пользователь выходит из своего аккаунта, нажав кнопку ![arrow-right-from-square](../../_assets/console-icons/arrow-right-from-square.svg) **Выйти из аккаунта**.

#### Полезные ссылки {#see-also}

* [Cookie](../../iam/concepts/authorization/cookie.md)
* [Управлять сессиями пользователей](../operations/manage-sessions.md)
* [Управление аккаунтом на портале «Мой аккаунт»](../operations/manage-account.md)