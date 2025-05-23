To use the `billing.accounts.piiPartnerEditor` role, you need to assign it for a billing account. It enables managing partner rebate withdrawals and subaccounts, as well as viewing partner info, including personal data.

On the Yandex Cloud partner portal, users with this role can:
* Manage [subaccounts](../../../partner/terms.md#sub-account) regardless of the [access permissions](../../../iam/concepts/access-control/index.md) assigned at the [organization](../../../organization/concepts/organization.md) level, excepting the permission to work with a partner.
* View info on the partner balance, discounts, and [rebate](../../../partner/terms.md#rebate) withdrawals.
* Create spending agreements for partner rebates and withdraw such rebates.
* [View](../../../partner/operations/get-client-stat.md) details on partner consumption, including partner subaccounts.
* View the list of [partner discounts](../../../partner/portal.md#premium).
* View the [partner tools](../../../partner/program/var-tools.md) page.
* View the list of accounts and info on them, including personal data.
* View the list of contacts and info on them, including personal data.
* View the list of [partner deals](../../../partner/terms.md#deal-reg) and info on them, including personal data.

This role includes the `billing.accounts.piiPartnerViewer` permissions.