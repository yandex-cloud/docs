To use the `billing.accounts.editor` role, you need to assign it for a billing account. It enables you to get payment invoices, redeem promo codes, link clouds and services to your billing account, create details export and budgets, generate reconciliation reports, and reserve resources.

{% cut "In Yandex Cloud Billing, users with this role can:" %}

* Display [billing accounts](../../../billing/concepts/billing-account.md) in the list of all accounts.
* View billing account data.
* View [client offers](../../../billing/concepts/glossary.md#client-offer).
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

* Link [clouds](../../../resource-manager/concepts/resources-hierarchy.md#cloud) to [subaccounts](../../../partner/terms.md#sub-account).

{% endcut %}

This role includes the `billing.accounts.viewer` permissions.