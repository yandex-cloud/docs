To use the `billing.accounts.partnerEditor` role, you need to assign it for a billing account. It enables managing accounts, subaccounts, contacts, and partner deals. This role does not provide access to personal data.

On the Yandex Cloud partner portal, users with this role can:
* Manage [subaccounts](../../../partner/terms.md#sub-account) regardless of the [access permissions](../../../iam/concepts/access-control/index.md) assigned at the [organization](../../../organization/concepts/organization.md) level, excepting the permission to work with a partner.
* View the list of subaccounts, create new ones and update the existing ones, as well as suspend, resume, and delete subaccounts.
* View the list of accounts and info on them (except for personal data), as well as edit such info.
* View the list of contacts and info on them (except for personal data), as well as edit such contacts.
* View the list of [partner deals](../../../partner/terms.md#deal-reg) and info on them (except for personal data), as well as edit such info.
* View the list of [partner discounts](../../../partner/portal.md#premium).
* View the [partner tools](../../../partner/program/var-tools.md) page.

This role includes the `billing.accounts.partnerViewer` permissions.