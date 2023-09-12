# What to do if the trial period is over

## Issue description {#issue-description}

* You are unable to access resources located in the cloud linked to the billing account with the status `TRIAL_EXPIRED`.
* The billing account has the status `TRIAL_EXPIRED`;
* The  grant issued within the [trial period](../../../billing/concepts/trial-period.md) was used up or expired.

## Solution {#issue-resolution}

`TRIAL_EXPIRED` status on billing account means that the [trial period](../../../getting-started/free-trial/concepts/trial-ending.md) is over, because you used up the entire grant or [its part](../../../free-trial/concepts/usage-grant.md). This will also happen when trial perion grant expires.

The trial period terms of termination differ for individual and business accounts.

{% list tabs %}

- Individual account

   The trial period ends automatically when you use up the grant or a [part](../../../free-trial/concepts/usage-grant.md) of the grant, or when it expires.

- Business account

   Automatic termination of the trial period depends on the payment method you selected when [creating your billing account](../../../billing/quickstart/index.md).

   | Payment method | Terms of termination |
   ----- | -----  
   | Bank transfer | The grant was used up or expired. |
   | Bank card | The grant or a [part](../../../free-trial/concepts/usage-grant.md) of the grant was used up or it expired. |

{% endlist %}

Upgrade to the paid version after the trial period termination should be done manually. You can [upgrade to the paid version](../../../free-trial/concepts/upgrade-to-paid.md) of {{ yandex-cloud }} at any time during the free trial or during 30 days after trial period termination, to avoid data loss.

If the free trial ends and you don't upgraded to the paid version, access to your resources will be suspended for 30 days with specified restrictions:

* Your VM instances and DB clusters will be stopped.
* You will not be able to read or download any saved data.

You can restore access to your resources if you upgrade to the paid version manually within 30 days after the end of the trial period. Otherwise, all resources in your cloud will be permanently deleted.

{% include [restore-after-blocking](../../../_includes/restore-after-blocking.md) %}

{% note info %}

You can cancel the cloud deletion if it is in the `PENDING_DELETION` status by following actions described in [this manual](../../../resource-manager/operations/cloud/delete-cancel.md).
If the resources are already in the `DELETING` status, it will not be possible to cancel their deletion.

{% endnote %}

