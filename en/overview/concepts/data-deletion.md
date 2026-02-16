---
title: Deleting user data
description: In this article, you will learn about deleting user data.
---

# Deleting user data

When and how user data is deleted depends on the reason for deletion.

## Automatic cloud suspension {#block}

Your cloud may be suspended due to arrears if your trial period is over or if you violate the [{{ yandex-cloud }}](https://yandex.ru/legal/cloud_termsofuse/?lang=en) Terms of Use. For more information about the payment process and possible suspension, see **Billing cycle** in the {{ billing-name }} documentation:
* [Individuals](../../billing/payment/billing-cycle-individual.md)
* [Businesses and individual entrepreneurs](../../billing/payment/billing-cycle-business.md)

In a suspended cloud:

1. Virtual machines and other resources are stopped, but the data is not deleted. Within 60 days (for violations of the Terms of Use — 7 days), the cloud can be unblocked, and resources can be relaunched.
1. When this period ends, {{ yandex-cloud }} can mark the resources for deletion and permanently delete them along with the data they contain, within 72 hours.

In a suspended cloud, user data may be [deleted](#automatic-deletion).


## Resource deletion timelines {#deletion-timelines}

Resource deletion timelines depend on reasons for deleting the resources and their type.

{% note info %}

When a contract is terminated, all user's clouds and resources are immediately marked for deletion and deleted within 72 hours.

{% endnote %}

### Deleting a user’s suspended cloud {#automatic-deletion}

When a cloud is suspended due to unpaid charges or after the trial period ends, resources are deleted in the following order:

1. Active VMs and other cloud resources are stopped, but the data is not deleted. Following that, you have 60 days to restore the cloud and resources.
1. If the cloud is not restored within 60 days after suspension, resources from every service are marked for deletion and then deleted within 72 hours.

If a cloud is suspended due to your violation of the {{ yandex-cloud }} terms of use:

1. Active VMs and other cloud resources are stopped, but the data is not deleted. Following that, you have 7 days to correct the violations and restore access to your resources.
1. If the cloud is not restored within 7 days after suspension, {{ yandex-cloud }} _may_ mark its resources for deletion and delete them within 72 hours.

You cannot cancel cloud deletion after it starts.

### Deleting clouds and folders on user request {#deletion-on-request}

When creating a request for deleting a [cloud](../../resource-manager/operations/cloud/delete.md) or [folder](../../resource-manager/operations/folder/delete.md), you can specify whether to delete the resource immediately or after a certain delay. The default deletion delay is seven days. Throughout this period, the resources will be stopped, and the cloud/folder status will change to `PENDING_DELETION`.

Once the delay period ends, the cloud/folder status will change to `DELETING`. This status means it is being permanently deleted, which can take up to 72 hours. As a result, all resources created in the cloud/folder will be deleted together with it.

{% include [alert-pending-deletion](../../_includes/resource-manager/alert-pending-deletion.md) %}

Under [certain circumstances](../../resource-manager/concepts/resources-hierarchy.md#inability-to-delete), the system may interrupt the folder deletion.

### Deleting logs of requests to resources {#logs}

Records of API requests to user resources are stored for one year. They are used for analyzing information security incidents and preventing fraud.

Records are permanently deleted after 12 months.

## Discontinuing a cloud {#quit-cloud}

{% include [delete-account](../../_includes/billing/billing-delete-account.md) %}

{% include [billing-delete-account-see-also](../../_includes/billing/billing-delete-account-see-also.md) %}
