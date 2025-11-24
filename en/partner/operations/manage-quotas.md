---
title: Setting up customer quotas
description: Follow this guide to set up customer quotas.
---

# Setting up customer quotas

You can set quotas for customer [clouds](#cloud-quotas) to limit service usage. For example, quotas allow you to:

* Fully restrict the use of DNS in a customer's cloud. To do this, set the {{ dns-name }} quotas to `0`.
* Limit the number of cores for {{ ydb-name }}. To do this, specify the required `ydb.dedicatedComputeCores.count` quota value.
* Limit the number of VMs in the cloud. To do this, specify the required `compute.instances.count` quota value.

For more information about quotas, see the _Quotas and limits_ of a relevant service.

{% note info %}

Quotas are only available for clouds associated with your subaccount.  

You can reduce the service quota yourself without contacting support. If the new value is higher than the current quota, the system will automatically create a support request.

To reset quotas to their original values, contact [support]({{ link-console-support }}).

If you associate the cloud with another subaccount or a direct billing account, the quotas will not reset to their original values.

{% endnote %}

## Setting up cloud quotas {#cloud-quotas}

{% list tabs group=instructions %}

- Partner portal {#partner}

  1. Go to the [partner portal]({{ link-cloud-partners }}).
  1. In the left-hand panel, select ![icon](../../_assets/console-icons/credit-card.svg) **Subaccounts**.
  1. Pick the subaccount you need from the list.
  1. Go to the ![icon](../../_assets/console-icons/chart-donut.svg) **Quotas & Instances** tab.
  1. Select the cloud from the list and click **Go to**.
  1. On the **Cloud quotas** page, use the search bar to find the service you need.
  1. Click ![icon](../../_assets/console-icons/chevron-down.svg) next to the service.
  1. Select one or more quotas and click **Change**.
  1. In the window that opens, edit the value.
  1. Click **Change**.

{% endlist %}
