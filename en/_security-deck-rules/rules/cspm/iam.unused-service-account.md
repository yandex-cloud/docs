### The period since the service account was last used does not exceed 90 days {#unused-service-account}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | iam.unused-service-account ||
|#

#### Description

**How the rule works:** The rule tracks the date of the service account's last authentication date and outputs accounts that were last authenticated more than 90 days ago.

Risks when not complying with the rule:

* Unauthorized use of a service account.
* Accumulation of unused service account keys with indefinite validity.
* No database for investigating incidents.
* Violation of the principle of least privilege for unactive accounts.

A [service account](https://yandex.cloud/en/docs/iam/concepts/users/service-accounts) is an account that can be used by a program to manage resources in Yandex Cloud. A service account is used to make requests on behalf of an application.

It is crucial to track the date of last authentication for service accounts. Not doing so means there is no way to detect unexpected use scenarios for service accounts: during off-hours, from an unusual access point, or after the application has been taken out of service.

Especially dangerous in this regard are service accounts with elevated privileges. An unused account with extensive rights is a ready-made attack vector when its key is compromised.

If a service account's key is compromised and there is no data on its last authentication date, no timeline can be drawn up for the incident, and there is no way to assess the scale of unauthorized access or identify affected resources. This directly increases mean time to repair (MTTR) and incident impact.

#### Instructions and solutions

* Follow the principle of [least privilege](https://yandex.cloud/en/docs/iam/best-practices/using-iam-securely#restrict-access) when assigning access permissions to service accounts.
* Regularly audit access permissions through [Cloud Infrastructure Entitlement Management (CIEM)](https://yandex.cloud/en/docs/security-deck/concepts/ciem) to detect unactive service accounts with excessive permissions.
* Keep service account keys in [Yandex Lockbox](https://yandex.cloud/en/docs/lockbox/concepts/secret) rather than in code or environment variables.
