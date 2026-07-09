### Two-factor authentication is set up for all local users {#userpool-mfa}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | access.userpool-mfa ||
|#

#### Description

**How the rule works:** It checks whether two-factor authentication (2FA) is enabled for the user pool or organization.

**Risks when not complying with the rule:**

* Compromising the password entails granting full access to the cloud. * Risks of leaks and data loss: confidential data theft, data encryption with the aim of extortion, etc. * Risks for the infrastructure: irreversible deletion of VM instances and disks, changes in DNS records to reroute traffic, etc. * Identity and Access Management risks and service account risks: creating new users with admin privileges, stealing API keys and service accounts, getting long-term backdoor access.

#### Instructions and solutions

Set up two-factor authentication for all local users in [Yandex Identity Hub](https://yandex.cloud/en/docs/organization/).

Two-factor authentication boosts protection for user accounts by employing not only the password during authentication but also another factor on top of that: one-time code (in an authenticator app under the [TOTP](https://ru.wikipedia.org/wiki/TOTP) standard or in an SMS message) or means of authentication as per [WebAuthn](https://en.wikipedia.org/wiki/WebAuthn) ([FIDO2](https://en.wikipedia.org/wiki/FIDO_Alliance#FIDO2))).

Multi-factor authentication requirements enforced on users are specified in _MFA policies_:

* [Create](https://yandex.cloud/en/docs/organization/operations/mfa/create-policy) an MFA policy in the [Yandex Identity Hub](https://center.yandex.cloud/organization) UI in Cloud Center. * [Add](https://yandex.cloud/en/docs/organization/operations/mfa/add-users) all users of the pool to the target groups of this policy.
