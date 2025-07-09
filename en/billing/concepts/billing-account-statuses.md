# Billing account statuses

The status of your billing account depends on whether you have any arrears of payment for resources consumed.

## List of statuses {#list}

A billing account can have one of the following statuses: 
- `NEW`: Billing account is being created.
- `PENDING`: Account confirmation required.
- `PAYMENT_NOT_CONFIRMED`: Account confirmation required. An email with further instructions is sent to the email address specified in your Yandex or Yandex 360 account.
- `TRIAL_ACTIVE`: [Trial period](trial-period.md) is active, and there is at least one unspent grant.
- `TRIAL_SUSPENDED`: Access to resources under the trial period has been suspended (e.g., due to a violation of antifraud requirements). 
- `TRIAL_EXPIRED`: Trial period has ended or all available grants have been spent.
- `FIRST_PAYMENT_REQUIRED`: You need to confirm the account creation by topping up your personal account.
- `ACTIVE`: Paid version has been activated and there are no arrears of payment for resources consumed. 
- `PAYMENT_REQUIRED`: Account is in arrears of payment for the services consumed.
- `SUSPENDED`: Access to resources has been suspended.
- `PENDING_INACTIVATION`: Account deletion has been initiated.

If your account has been suspended for a long time and the cloud status is `PENDING_DELETION`, make sure to manually [cancel](../../resource-manager/operations/cloud/delete-cancel.md) its deletion after the suspension is over.

## Description of statuses {#descr}

Statuses are described in the table below. 

Status | Balance                                    | Description
----- |-------------------------------------------| ----- 
`NEW` | None | Account is being created.
`PENDING` | None | Use of {{ yandex-cloud }} services is not allowed.<br/>The status persists until the account is validated by a {{ yandex-cloud }} manager.
`PAYMENT_NOT_CONFIRMED` | None | Use of {{ yandex-cloud }} services is not allowed. <br/>The status persists until the account is validated by a {{ yandex-cloud }} manager.
`TRIAL_ACTIVE` | None (the initial grant has been provided) | Use of {{ yandex-cloud }} services is allowed but limited. <br/>The status persists until the trial period ends, the initial grant is spent, or the paid version is activated. 
`TRIAL_SUSPENDED` | None | Use of {{ yandex-cloud }} services is not allowed. <br/>As part of the trial period, the initial grant can only be issued to one billing account, so you cannot use the trial period when re-registering. <br/>The status persists until you activate the paid version.
`TRIAL_EXPIRED` | None | Use of {{ yandex-cloud }} services is not allowed. <br/>The trial period has ended and you have not upgraded to the paid version. <br/>You can upgrade to the paid version of {{ yandex-cloud }} at any time during the trial period or 60 days after it expires, without losing any data.
`FIRST_PAYMENT_REQUIRED` | None | Use of {{ yandex-cloud }} services is not allowed. <br/>Most likely, you had previously created a billing account for which a trial period was activated. <br/>The status persists until you top up your personal account.
`ACTIVE` | Positive | All {{ yandex-cloud }} services are available for use. <br/>This status persists until your account runs into arrears.
`PAYMENT_REQUIRED` | Negative | Account is in arrears of payment for the services consumed. <br/><br/>Use of {{ yandex-cloud }} services may be suspended if the arrears are not paid in due time. During the suspension period, a fee is charged for data storage services, in addition to a late payment fee.
`SUSPENDED` | Negative | Use of {{ yandex-cloud }} services is suspended.<br/><br/>The maximum data storage period after the suspension is 60 calendar days.<br/><br/>Within 60 calendar days of suspending access, the system checks whether a payment is made: <br/> - If you pay the entire outstanding amount, your access to resources will be restored within 24 hours. <br/> - If you do not pay the entire outstanding amount, all your data, including your billing account, will be permanently blocked and deleted.<br/><br/>You cannot recover deleted clouds if they are linked to a blocked account.
`PENDING_INACTIVATION` | Any value  | Request to delete the billing account was submitted.<br/><br/> We are verifying if the account can be deleted. For reasons why an account cannot be deleted, see [Deleting a billing account](../operations/delete-account.md).

  {% include [suspended](../_includes/billing-suspended.md) %}

## Viewing billing account status {#watch-account-status}

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. {% include [move-to-billing-step](../../billing/_includes/move-to-billing-step.md) %}
  1. Billing account status is displayed under **{{ ui-key.yacloud_billing.billing.title_accounts }}** in the **{{ ui-key.yacloud_billing.billing.accounts.column_status }}** column.
  
  ![billing-account-statuses](../../_assets/billing/concepts/billing-account-statuses/billing-account-statuses.png)

{% endlist %}

For more information, see the following sections:
- [Billing cycle for individuals](../payment/billing-cycle-individual.md)
- [Billing cycle for businesses and individual entrepreneurs](../payment/billing-cycle-business.md)