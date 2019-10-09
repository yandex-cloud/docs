# Billing account statuses

The status of your billing account depends on whether you have any arrears resulting from a failure to pay for resource usage.

## List of statuses {#list}

A billing account can have one of the following statuses:

- `NEW`: a billing account is being created.
- `PENDING`: account confirmation required.
- `PAYMENT_NOT_CONFIRMED`: account confirmation required. An email with further instructions is sent to the email address specified in your Yandex or Yandex.Connect account.
- `TRIAL_ACTIVE`: the trial period has been activated and there is at least one unspent grant.
- `TRIAL_SUSPENDED`: the trial period has not been activated, since the initial grant was given to one of your previously created billing account.
- `TRIAL_EXPIRED`: the trial period has ended or all available grants have been spent.
- `FIRST_PAYMENT_REQUIRED`: account creation must be confirmed by topping up your personal account.
- `ACTIVE`: the paid version has been activated and there are no arrears for resource usage.
- `PAYMENT_REQUIRED`: the account has arrears for service usage.
- `SUSPENDED`: access to resources has been suspended.

## Description of statuses {#descr}

Statuses are described in the table below.

| Status | Balance | Description |
| ----- | ----- | ----- |
| `NEW` | None | The account is being created. |
| `PENDING` | None | The use of Yandex.Cloud services is not allowed. <br/>The status persists until the account is validated by a Yandex.Cloud manager. |
| `PAYMENT_NOT_CONFIRMED` | None | The use of Yandex.Cloud services is not allowed. <br/>The status persists until the account is validated by a Yandex.Cloud manager. |
| `TRIAL_ACTIVE` | None (the initial grant is provided) | The use of Yandex.Cloud services is allowed but limited. <br/>The status persists until the trial period ends, the initial grant is spent, or the paid version is activated. |
| `TRIAL_SUSPENDED` | None | The use of Yandex.Cloud services is not allowed. <br/>The initial grant can only be given to one billing account, you cannot use the trial period during re-registration. <br/>The status persists until the paid version is activated. |
| `TRIAL_EXPIRED` | None | The use of Yandex.Cloud services is not allowed. <br/>The trial period has ended and you have not upgraded to the paid version. <br/>You can upgrade to the paid version of Yandex.Cloud at any time during the trial period or 30 days after it ends, with no data loss. |
| `FIRST_PAYMENT_REQUIRED` | None | The use of Yandex.Cloud services is not allowed. <br/>Most likely, you previously created a billing account that had the trial period activated. <br/>The status persists until you top up your personal account. |
| `ACTIVE` | Positive | All Yandex.Cloud services are available for use. <br/> The status persists until arrears for usage have accumulated. |
| `PAYMENT_REQUIRED` | Negative | The account has arrears for service usage. <br/><br/>The use of the Yandex.Cloud services may be suspended if you don't pay the amount owed in time. During the suspension period, a fee is charged for data storage services, in addition to a late payment fee. |
| `SUSPENDED` | Negative | Access to Yandex.Cloud services is suspended.<br/><br/>The maximum data storage period after suspension is 30 calendar days.<br/><br/>For 30 days after the suspension, the system checks whether a payment is made: <br/> - If you pay the entire outstanding amount, access to resources is restored within 24 hours. <br/> - If you do not pay the entire outstanding amount, all data, including your billing account, is permanently blocked and deleted. |

For more information, see [Billing cycle](../payment/billing-cycle.md).

