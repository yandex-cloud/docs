# End of trial period

{% if product == "yandex-cloud" %}

The trial period terms of termination differ for individual and business accounts.

{% list tabs %}

- Individual account

   The trial period ends automatically when you use up the grant or a [part](../../usage-grant.md) of the grant, or when it expires.

- Business account

   Automatic termination of the trial period depends on the payment method you selected when [creating your billing account](../../../billing/quickstart/index.md).

   | Payment method | Terms of termination |
   ----- | -----  
   | Bank transfer | The grant was used up or expired. |
   | Bank card | The grant or a [part](../../usage-grant.md) of the grant was used up or it expired. |

{% endlist %}

{% endif %}

{% if product == "cloud-il" %}

The trial period ends automatically when you use up the grant or a [part](../../usage-grant.md) of the grant, or when it expires.

{% endif %}

If the free trial ends and you don't upgraded to the paid version, access to your resources will be suspended for 30 days:
* Your VM instances and DB clusters will be stopped.
* You will not be able to read or download any saved data.

You can restore access to your resources if you upgrade to the paid version within 30 days after the end of the trial period. Otherwise, all resources in your cloud will be permanently deleted.

{% include [restore-after-blocking](../../../_includes/restore-after-blocking.md) %}
