To use the `billing.accounts.varWithoutDiscounts` role, you need to assign it for a billing account. This role grants partner accounts all administrator privileges, except the permission to get information about discounts.

{% cut "In Yandex Cloud Billing, users with this role can:" %}

* Display [billing accounts](../../../billing/concepts/billing-account.md) in the list of all accounts.
* View billing account data.
* View info on the [access permissions](../../../iam/concepts/access-control/index.md) granted for the relevant billing accounts.
* View and download [reporting (or closing) documents](../../../billing/payment/documents.md).
* Generate new [reconciliation reports](../../../billing/concepts/act.md#reconciliation-report).
* View and download generated reconciliation reports.
* Get and view notifications on consumption.
* Monitor expenses.
* [View usage details](../../../billing/operations/check-charges.md).
* [Export details](../../../billing/operations/get-folder-report.md).
* Create [budgets](../../../billing/concepts/budget.md).
* [Reserve resource usage](../../../billing/concepts/cvos.md).
* Top up their [personal account](../../../billing/concepts/personal-account.md) using a bank account.
* Link [clouds](../../../resource-manager/concepts/resources-hierarchy.md#cloud) to a billing account.
* Rename billing accounts.
* Redeem promo codes.

{% endcut %}

{% cut "On the Yandex Cloud partner portal, users with this role can:" %}

* [Create](../../../partner/program/var-pin-client.md#client-entry) customer records ([subaccounts](../../../partner/terms.md#sub-account)).
* View the list of subaccounts and info on them.
* Activate subaccounts.
* Suspend subaccounts.
* Re-activate subaccounts.
* Link [clouds](../../../resource-manager/concepts/resources-hierarchy.md#cloud) to subaccounts.
* [Manage](../../../partner/operations/access/partners-account.md) access permissions to subaccounts.
* [View](../../../partner/operations/get-client-stat.md) the details of how the customers use services.
* View [rebate credit](../../../partner/terms.md#rebate) history.
* Withdraw rebate.
* View the history of crediting [referral program](../../../partner/program/referral.md) bonuses.
* Withdraw referral program [bonuses](../../../partner/program/referral.md#premium).
* View the status of settlements with the [referrer company](../../../partner/terms.md#referral-partner).
* Create referral links.
* Activate referral links.
* Modify referral links.

{% endcut %}

This role also includes the `billing.partners.editor` permissions.