### An identity federation (Single Sign-On, SSO) is configured {#idp}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | information | access.idp ||
|#

#### Description

**How this rule works:** The rule checks whether centralized identity management (federation or user pools) is configured for the organization.

Yandex Cloud has two ways to manage user accounts centrally:

* [Identity federation](https://yandex.cloud/en/docs/organization/concepts/add-federation) (external IdP) for single sign-on (SSO) into Yandex Cloud. If your company already runs a user and access management system (Active Directory, Google Workspace, Keycloak), you can use it to authenticate employees in [Yandex Identity Hub](https://yandex.cloud/en/docs/organization/) — no need to create a separate Yandex account for each employee, and the company's password and account policies stay in effect.

* [User pools](https://yandex.cloud/en/docs/organization/concepts/user-pools) for centrally managing local accounts in your domains, with control over authentication settings and account data.

Without centralized account management, employees use personal Yandex ID accounts to access cloud resources. That works, but offboarding becomes manual and error-prone, password and 2FA policies cannot be enforced from one place, and the company has limited visibility into who has active access.

**Risks if the rule is not followed:** Former employees may retain access to cloud resources, corporate security policies (password complexity, 2FA) cannot be enforced uniformly, and there is no centralized audit trail for access events — making it difficult to detect unauthorized access.

#### Instructions and solutions

Set up centralized account management for the organization:

* For most companies, configure a [SAML-compatible identity federation](https://yandex.cloud/en/docs/organization/operations/setup-federation) with your existing IdP — this enables SSO and inherits the company's account policies.
* For accounts that do not fit into the corporate IdP (for example, partners, contractors), use [user pools](https://yandex.cloud/en/docs/organization/operations/user-pools/create-userpool).
* Enable [group mapping](https://yandex.cloud/en/docs/organization/operations/federation-group-mapping) between the IdP and Identity Hub so that role assignments follow IdP groups, not individual accounts.
