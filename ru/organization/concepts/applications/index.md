---
title: Приложения в {{ org-full-name }}
description: В {{ org-full-name }} вы можете аутентифицировать пользователей {{ yandex-cloud }} во внешних приложениях с помощью SAML- и OIDC-приложений с использованием технологии единого входа.
---

# Приложения в {{ org-full-name }}


Пользователи вашей [организации](../organization.md) могут аутентифицироваться во внешних приложениях с помощью [технологии единого входа](../../../glossary/sso.md) (SSO). Для этого {{ org-full-name }} позволяет создавать _приложения_ — [ресурсы](../../../overview/roles-and-resources.md#resources) {{ yandex-cloud }}, которые содержат настройки интеграции {{ org-full-name }} как _поставщика удостоверений_ (Identity Provider, IdP) с одной стороны и стороннего _поставщика услуг_ (Service Provider, SP) — с другой.

{{ org-full-name }} поддерживает стандарты технологии единого входа [SAML](https://ru.wikipedia.org/wiki/SAML) и [OpenID Connect](https://ru.wikipedia.org/wiki/OpenID#OpenID_Connect) (OIDC).

В качестве поставщика услуг могут выступать различные сервисы, поддерживающие технологию единого входа, которые могут работать как по модели [SaaS](https://ru.wikipedia.org/wiki/Программное_обеспечение_как_услуга), так и по модели [on-premise](https://en.wikipedia.org/wiki/On-premises_software). Например: [{{ yandex-360 }}](https://360.yandex.ru/), [GitHub](https://github.com/), [GitLab](https://about.gitlab.com/), [Jenkins](https://www.jenkins.io/), [Jira](https://www.atlassian.com/software/jira) и множество других.

В зависимости от используемого поставщиком услуг стандарта SSO в {{ org-full-name }} вы можете создать:

* [SAML-приложения](./saml.md)
* [OIDC-приложения](./oidc.md)