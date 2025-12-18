# Trial period has ended


## Issue description {#issue-description}

* You cannot access resources in the cloud linked to a billing account with the `TRIAL_EXPIRED` status.
* The billing account has the `TRIAL_EXPIRED` status.
* The [trial period](../../../billing/concepts/trial-period.md) grant has either expired or been used up.

## Solution {#issue-resolution}

The `TRIAL_EXPIRED` status means that your billing account's [trial period](../../../getting-started/free-trial/concepts/trial-ending.md) has ended because the initial grant has either been used up or expired.

The trial period terms of termination differ for individual and business accounts.

{% list tabs %}

 - Individual account
  
   The trial period ends automatically when you use up the entire grant or one of its [parts](../../../getting-started/usage-grant.md), or when the grant expires.

 - Business account
  
   Automatic termination of the trial period depends on the payment method you selected when [creating your billing account](../../../billing/quickstart/index.md).
   
   Payment method | Terms of termination
   ----- | -----  
   Wire transfer | The grant was used up or expired.
   Credit or debit card  | The grant or one of its [parts](../../../getting-started/usage-grant.md) was used up, or the grant expired.
   
{% endlist %}

Unless you upgraded to the paid version, access to your resources will be suspended for 60 days after the trial period ends:

  * Your VMs and DB clusters will be stopped.
  * You will not be able to read or download any saved data.


You can restore access to your resources if you [upgrade to the paid version](../../../getting-started/free-trial/concepts/upgrade-to-paid.md) within 60 days after the trial period ends. Otherwise, all resources in your cloud will be permanently deleted.

{% note info %}

To cancel the deletion of a cloud with the `PENDING_DELETION` status, follow [this guide](../../../resource-manager/operations/cloud/delete-cancel.md).

Note that if resources are already in the `DELETING` status, you cannot cancel their deletion.

{% endnote %}

You can get a new grant by joining our content program and helping us improve the {{ yandex-cloud }} help content. We welcome both minor editorial improvements and tutorials for solving large-scale and challenging tasks. We will include a link to your GitHub profile on the pages you contributed to. 

The grant will be credited within seven days after your pull request has been approved. You will be able to spend it on any {{ yandex-cloud }} services. For more info on the content program terms and conditions, click [here](https://yandex.cloud/ru/content-program).