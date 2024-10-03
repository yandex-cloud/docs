# Billing cycle for businesses and individual entrepreneurs


1. You [activate the paid version](../operations/activate-commercial.md) before the [trial period](../../billing/concepts/trial-period.md) expires.

   {% include [billing-how-to-use-grant](../../_includes/billing-how-to-use-grant.md) %}

1. If you get a grant, you are free to use it. The grant amount is reduced progressively as you consume the resources of {{ yandex-cloud }} services.

1. The grant amount and validity period are checked throughout the reporting period.

   * If the grant amount is greater than zero and the grant has not expired, go back to step 2.
   * If the grant has expired or the grant amount is zero, go to step 4.


1. You consume and pay for the use of {{ yandex-cloud }} resources at the end of each reporting period, and a [billing threshold](../concepts/billing-threshold.md) is not provided.

1. Verification is performed to check whether it is past the end of the reporting period:

   * If the reporting period has not ended yet, go back to step 4.
   * If a reporting period has ended, a [report](../concepts/act.md) and an [invoice](../concepts/invoice.md) are generated. Copies of these documents will be sent to the email address of the billing account owner. Go to step 5.1.

   1. At the end of the reporting period, your personal account balance is checked:

      * If the balance is positive, go back to step 4.
      * If the balance is negative, go to step 6.


1. Payment is made for consumed {{ yandex-cloud }} resources:

   * [Top up](../operations/pay-the-bill.md) your personal account to a positive value within the deadline stipulated in the agreement.   

   1. Payment for used resources is verified:

      * If you top up your personal account before the deadline stipulated in the agreement, go back to step 2.      
      * If you failed to top up your personal account, {{ yandex-cloud }} reserves the right to change the status of your billing account to [SUSPENDED](../concepts/billing-account-statuses.md). Go to step 7.

         {% include [suspended](../_includes/billing-suspended.md) %}

1. If your account is in arrears, the use of {{ yandex-cloud }} resources may be suspended:

   * Your VM instances and DB clusters will be stopped completely.
   * You will not be able to read or download any saved data.

   During the suspension period, you will be charged the cost of data storage services and a late payment fee. Go to step 8.

1. Payment of the entire outstanding amount is checked throughout the 60-day suspension period:

   1. If you pay off the amount due during this time, access to resources is restored within 24 hours. The billing account status will be changed to [ACTIVE](../concepts/billing-account-statuses.md). Go back to step 2.

   1. Otherwise, access to {{ yandex-cloud }} services may be permanently blocked. All your data, including your [billing account](../concepts/billing-account.md), will be permanently deleted.


{% include [blocked-note](../_includes/blocked-note.md) %}


#### See also

* [Grant](../concepts/bonus-account.md)
* [Billing threshold](../concepts/billing-threshold.md)
* [Personal account](../concepts/personal-account.md)
* [Billing account](../concepts/billing-account.md)