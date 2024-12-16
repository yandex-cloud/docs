When creating your billing account, you get the `billing.accounts.owner` role automatically. It cannot be revoked, but you can assign it to other users and then revoke from them.

{% cut "In Yandex Cloud Billing, users with this role can:" %}

* Display [billing accounts](../../../billing/concepts/billing-account.md) in the list of all accounts.
* View billing account data.
* View info on the [access permissions](../../../iam/concepts/access-control/index.md) granted for the relevant billing accounts and modify such permissions.
* Activate, deactivate, or modify the [technical support](../../../support/overview.md) service plan, as well as change the billing account from which the payment is debited.
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
* Top up their personal account using a credit or debit card.
* Link [clouds](../../../organization/concepts/manage-services.md#cloud) to a billing account.
* Rename billing accounts.
* Changing payer contact details.
* Change payment details.
* Change their credit or debit card details.
* Change the payment method.
* Redeem promo codes.
* Activate the [trial period](../../../billing/concepts/trial-period.md).
* Activate the [paid version](../../../getting-started/free-trial/concepts/upgrade-to-paid.md).
* [Delete](../../../billing/operations/delete-account.md) billing accounts.

{% endcut %}

{% cut "On the Yandex Cloud partner portal, users with this role can:" %}

* [Create](../../../partner/program/var-pin-client.md#client-entry) customer records ([sub-accounts](../../../partner/terms.md#sub-account)).
* View the list of sub-accounts and info on them.
* Update sub-account records.
* Activate sub-accounts.
* Suspend sub-accounts.
* Re-activate sub-accounts.
* Delete sub-accounts without customer confirmation.
* Link [clouds](../../../organization/concepts/manage-services.md#cloud) to sub-accounts.
* [Manage](../../../partner/operations/access/partners-account.md) access permissions to sub-accounts.
* [View](../../../partner/operations/get-client-stat.md) the details of how the customers use services.
* View [rebate credit](../../../partner/terms.md#rebate) history.
* Withdraw rebate.
* View assigned [specializations](../../../partner/specializations/index.md).
* View the list of [partner commissions](../../../partner/portal.md#premium) and info on them.
* View the history of crediting [referral program](../../../partner/program/referral.md) commissions.
* Withdraw referral program [commissions](../../../partner/program/referral.md#premium).
* View the status of settlements with the [referrer company](../../../partner/terms.md#referral-partner).
* View the list of referral links.
* Create referral links.
* Activate referral links.
* Modify referral links.

{% endcut %}

This role also includes the `billing.accounts.admin` permissions.