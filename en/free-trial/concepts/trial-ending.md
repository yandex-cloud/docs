# End of trial period

The trial period terms of termination differ for individual and business accounts.


{% list tabs group=accounts %}

- Individual account {#individual}

   The trial period ends automatically when you use up the grant or a [part](usage-grant.md) of the grant, or when it expires.

- Business account {#business}

   Automatic termination of the trial period depends on the payment method you selected when [creating your billing account](../../billing/quickstart/index.md).

   | Payment method | Terms of termination |
   ----- | -----  
   | Wire transfer | The grant was used up or expired. |
   | Bank card | The grant or one of its [parts](usage-grant.md) was used up and/or the grant expired. |

{% endlist %}

You do not upgrade to the paid version automatically after the trial period ends. You can [upgrade to the paid version](upgrade-to-paid.md) of {{ yandex-cloud }} with you data intact at any time during the free trial or within 60 days of its end date.

Unless you upgraded to the paid version, access to your resources will be suspended for 60 days after the trial period ends:
* Your VM instances and DB clusters will be stopped.
* You will not be able to read or download any saved data.

You can restore access to your resources if you upgrade to the paid version within 60 days after the end of the trial period. Otherwise, all resources in your cloud will be permanently deleted.

{% include [restore-after-blocking](../../_includes/restore-after-blocking.md) %}

You can also stop using {{ yandex-cloud }} resources before the end of the trial period.

{% include [delete-account](../../_includes/billing/billing-delete-account.md) %}
