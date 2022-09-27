# Федерации удостоверений

С помощью [{{ org-full-name }}](../../organization/) вы можете настроить Single Sign-On аутентификацию в {{ yandex-cloud }} через ваш Identity Provider, например Active Directory или Google Workspace. 

Такой подход к аутентификации называется федерация удостоверений: сотрудники компании используют свои корпоративные аккаунты и аутентифицируются только в корпоративной системе аутентификации. Для доступа к ресурсам в {{ yandex-cloud }} им не нужны аккаунты {% if product == "yandex-cloud" %}в Яндекс ID{% endif %}{% if product == "cloud-il" %}Google{% endif %}.

Для работы в составе федерации удостоверений Identity Provider должен поддерживать стандарт SAML 2.0.

## Что дальше {#what-is-next}

* Узнайте, как [добавить пользователя](../operations/users/create.md#federated-user) из федерации удостоверений.
* Узнайте, как настроить федерацию удостоверений в документации [{{ org-full-name }}](../../organization/add-federation.md).
