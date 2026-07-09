### An identity federation (Single Sign-On, SSO) is configured {#idp}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | information | access.idp ||
|#

#### Description

Yandex Cloud provides two options for centralized identity management:

* [Identity federation](https://yandex.cloud/en/docs/organization/concepts/add-federation) (external IdP) for single sign-on (SSO) access to applications. With SSO, users can access multiple applications without having to enter their username and password every time.

If your company has a user and access management system (e.g., Active Directory or Google Workspace), you can use it to authenticate employees in [Yandex Identity Hub](https://yandex.cloud/en/docs/organization/). In which case you do not need to create a new Yandex account for every employee. They can get access to Yandex Cloud services using their corporate accounts.

* [User pools](https://yandex.cloud/en/docs/organization/concepts/user-pools) for linking your [domains](https://yandex.cloud/en/docs/organization/concepts/domains) and managing access permissions, authentication settings, and [My account](https://yandex.cloud/en/docs/organization/concepts/my-account) data you can edit.

Pools and users in pools exist only at the organization level and are subject to Yandex Cloud [security policies](https://yandex.cloud/en/docs/security/standarts).

#### Instructions and solutions

For centralized identity management, use [SAML-compatible identity federations](https://yandex.cloud/en/docs/organization/concepts/add-federation) or [user pools](https://yandex.cloud/en/docs/organization/concepts/user-pools).

With identity federations, you can set up single sign-on authentication in Yandex Cloud via your own IdP server. This way, your employees can use their corporate accounts that are subject to the company security policies.

For more information, see [Identity federations](https://yandex.cloud/en/docs/organization/concepts/add-federation).

User pools group [local users](https://yandex.cloud/en/docs/iam/concepts/users/accounts#local) together, thus allowing you to manage them centrally, link your [domains](https://yandex.cloud/en/docs/organization/concepts/domains), manage access permissions, authentication settings, and [My account](https://yandex.cloud/en/docs/organization/concepts/my-account) data you can edit.

Learn more about creating user pools [here](https://yandex.cloud/en/docs/organization/operations/user-pools/create-userpool).
