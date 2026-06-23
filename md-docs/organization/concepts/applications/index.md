# Приложения в Yandex Identity Hub


Пользователи вашей [организации](../organization.md) могут аутентифицироваться во внешних приложениях с помощью [технологии единого входа](../../../glossary/sso.md) (SSO). Для этого Yandex Identity Hub позволяет создавать _приложения_ — [ресурсы](../../../overview/roles-and-resources.md#resources) Yandex Cloud, которые содержат настройки интеграции Yandex Identity Hub как _поставщика удостоверений_ (Identity Provider, IdP) с одной стороны и стороннего _поставщика услуг_ (Service Provider, SP) — с другой.

Yandex Identity Hub поддерживает стандарты технологии единого входа [SAML](https://ru.wikipedia.org/wiki/SAML) и [OpenID Connect](https://ru.wikipedia.org/wiki/OpenID#OpenID_Connect) (OIDC).

В качестве поставщика услуг могут выступать различные сервисы, поддерживающие технологию единого входа, которые могут работать как по модели [SaaS](https://ru.wikipedia.org/wiki/Программное_обеспечение_как_услуга), так и по модели [on-premise](https://en.wikipedia.org/wiki/On-premises_software). Например: [Яндекс 360](https://360.yandex.ru/), [GitHub](https://github.com/), [GitLab](https://about.gitlab.com/), [Jenkins](https://www.jenkins.io/), [Jira](https://www.atlassian.com/software/jira) и множество других.

В зависимости от используемого поставщиком услуг стандарта SSO в Yandex Identity Hub вы можете создать:

* [SAML-приложения](saml.md)
* [OIDC-приложения](oidc.md)