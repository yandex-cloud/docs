# Billing account statuses

The status of your billing account depends on whether you have any arrears resulting from a failure to pay for resource usage.

## List of statuses {#list}

A billing account can have one of the following statuses:
- `NEW`: Billing account is being created.
- `PENDING`: Account confirmation required.
- `PAYMENT_NOT_CONFIRMED`: Account confirmation required. An email with further instructions has been sent to the email address specified in your Yandex or Yandex 360 account.
- `TRIAL_ACTIVE`: Trial period has been activated and there is at least one unspent grant.
- `TRIAL_SUSPENDED`: Trial period has not been activated, as the initial grant was previously provided for another billing account of yours.
- `TRIAL_SUSPENDED`: Trial period has ended or all available grants have been spent.
   `FIRST_PAYMENT_REQUIRED`: You need to confirm account creation by making a deposit.
- `ACTIVE`: Paid version has been activated and there is no outstanding debt for resource usage.
- `PAYMENT_REQUIRED`: There is outstanding debt for service usage.
- `SUSPENDED`: Access to resources has been suspended.

If your account has been suspended for a long time or the cloud status is `PENDING_DELETION`, make sure to manually [cancel](../../resource-manager/operations/cloud/delete-cancel.md) its deletion.

## Description of statuses {#descr}

Statuses are described in the table below.

| Status | Balance | Description |
----- | ----- | -----
| `NEW` | None | Account is being created. |
| `PENDING` | None | Use of {{ yandex-cloud }} services is not allowed.<br/>The status persists until the account is validated by a {{ yandex-cloud }} manager. |
| `PAYMENT_NOT_CONFIRMED` | None | Use of {{ yandex-cloud }} services is not allowed. <br/>The status persists until the account is validated by a {{ yandex-cloud }} manager. |
| `TRIAL_ACTIVE` | None (the initial grant has been provided) | The use of {{ yandex-cloud }} services is allowed but limited. <br/>The status persists until the trial period ends, the initial grant is spent, or the paid version is activated. |
| `TRIAL_SUSPENDED` | None | The use of services is {{ yandex-cloud }} not allowed. <br/>Since the initial grant can only be issued to one billing account within the trial period, you cannot use the trial period when re-registering. <br/>The status persists until the paid version is activated. |
| `TRIAL_EXPIRED` | None | The use of services is {{ yandex-cloud }} not allowed. <br/>The trial period has ended and you have not upgraded to the paid version. <br/>You can upgrade to the paid version of {{ yandex-cloud }} at any time during the trial period or 30 days after it ends, with no data loss. |
| `FIRST_PAYMENT_REQUIRED` | None | The use of services is {{ yandex-cloud }} not allowed. <br/>It's most likely that a previously created billing account activated your trial period. <br/>The status persists until you top up your personal account.| 
| `ACTIVE` | Positive | All {{ yandex-cloud }} services are available for use. <br/> The status persists until arrears for usage have accumulated. |
| `PAYMENT_REQUIRED` | Negative | Account has debts for service usage. <br/><br/>Use of {{ yandex-cloud }} services may be suspended if you don't pay the amount owed in time. During the suspension period, a fee is charged for data storage services, in addition to a late payment fee. |
| `SUSPENDED` | Negative | Access to the use of {{ yandex-cloud }} services is suspended.<br/><br/>The maximum data storage period after the suspension is 60 calendar days.<br/><br/>Within 60 calendar days of suspending access, the system checks whether a payment is made: <br/> - If you pay the entire outstanding amount, your access to resources will be restored within 24 hours. <br/> - If you do not pay the entire outstanding amount, all your data, including your billing account, will be permanently blocked and deleted. |

{% include [suspended](../_includes/billing-suspended.md) %}


For more information, see the following sections:
- [Billing cycle for individuals](../payment/billing-cycle-individual.md)
- [Billing cycle for businesses and individual entrepreneurs](../payment/billing-cycle-business.md)
