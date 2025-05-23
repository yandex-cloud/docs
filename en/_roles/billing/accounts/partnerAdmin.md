To use the `billing.accounts.partnerAdmin` role, you need to assign it to a billing account. It enables access to all partner portal tools and all info stored on the portal, including personal data.

On the Yandex Cloud partner portal, users with this role can:
* Manage [subaccounts](../../../partner/terms.md#sub-account) regardless of the [access permissions](../../../iam/concepts/access-control/index.md) assigned at the [organization](../../../organization/concepts/organization.md) level, excepting the permission to work with a partner.
* View the list of subaccounts, create new ones and update the existing ones, as well as suspend, resume, and delete subaccounts.
* View the list of accounts and info on them, including personal data, as well as edit such info.
* View the list of contacts and info on them, including personal data, as well as edit such contacts.
* View the list of [partner deals](../../../partner/terms.md#deal-reg) and info on them, including personal data, as well as edit such info.
* View info on the partner balance, discounts, and [rebate](../../../partner/terms.md#rebate) withdrawals.
* Create spending agreements for partner rebates and withdraw such rebates.
* [View](../../../partner/operations/get-client-stat.md) details on partner consumption, including partner subaccounts.
* View the list of [partner discounts](../../../partner/portal.md#premium).
* View the [partner tools](../../../partner/program/var-tools.md) page.

This role includes the `billing.accounts.partnerEditor` and `billing.accounts.piiPartnerEditor` permissions.