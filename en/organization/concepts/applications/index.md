---
title: Applications in {{ org-full-name }}
description: In {{ org-full-name }}, you can authenticate {{ yandex-cloud }} users in external applications using SAML and OIDC applications with single sign-on technology.
---

# Applications in {{ org-full-name }}


Your [organization's](../organization.md) users can authenticate in external applications via single sign-on (SSO). With this in mind, {{ org-full-name }} allows creating _applications_, i.e., {{ yandex-cloud }} [resources](../../../overview/roles-and-resources.md#resources) containing integration settings for {{ org-full-name }} as an _identity provider_ (IdP) on the one hand and a third-party _service provider_ (SP) on the other.

{{ org-full-name }} supports the [SAML](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language) and [OpenID Connect](https://en.wikipedia.org/wiki/OpenID#OpenID_Connect_(OIDC)) (OIDC) single sign-on standards.

The role of service providers can be played by various SSO-enabled services, either based on the [SaaS](https://en.wikipedia.org/wiki/Software_as_a_service) or [on-premise](https://en.wikipedia.org/wiki/On-premises_software) model, e.g., [{{ yandex-360 }}](https://360.yandex.ru/), [GitHub](https://github.com/), [GitLab](https://about.gitlab.com/), [Jenkins](https://www.jenkins.io/), [Jira](https://www.atlassian.com/software/jira), and many more.

Depending on the SSO standard used by your service provider, in {{ org-full-name }}, you can create:

* [SAML apps](./saml.md)
* [OIDC apps](./oidc.md)