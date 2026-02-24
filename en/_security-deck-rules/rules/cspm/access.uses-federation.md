### Identity federation (single sign-on, SSO) is configured {#uses-federation}

#|
|| **kind** | **severity** | **ID** ||
|| manual | medium | access.uses-federation ||
|#

#### Description

For the purpose of centralized account management, use [SAML-compatible identity federations](https://yandex.cloud/en/docs/organization/concepts/add-federation). By using identity federations, a company can set up Single Sign-On, which is authentication in Yandex Cloud via their IdP server. With this approach, employees can use their corporate accounts that are subject to the company's security policies, such as:

* Revoking and blocking accounts.
* Password policies.
* Limiting the number of unsuccessful login attempts.
* Blocking access sessions upon expiry of a preset user's idle time.
* Two-factor authentication.

[Yandex Identity Hub](https://yandex.cloud/en/docs/organization) is a single service for managing the organizational structure, setting up integration with the employee catalog, and differentiating user access to the organization's cloud resources.

{% note info "**Tip**" %}

Use federated accounts instead of Yandex ID accounts whenever possible. Keep in mind that there is a separate role, `organization-manager.federations.admin`, you can use to manage a federation.

{% endnote %}

To make sure all authentication requests from Yandex Cloud contain a digital signature, enable the **Sign authentication requests** option. To complete the configuration, download and install a Yandex Cloud certificate. You can download the certificate in the **Sign authentication requests** field immediately after creating a federation.

#### Guides and solutions

**Guides and solutions to use:**

* [Guide on setting up SAML-based identity federations](https://yandex.cloud/en/docs/organization/concepts/add-federation#federation-usage).
* [Guide on configuring a SAML-based federation with KeyCloak](https://www.youtube.com/watch?v=m-oe7V9PvC4).