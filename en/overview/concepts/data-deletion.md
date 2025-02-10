---
title: Deleting user data
description: In this article, you will learn about deleting user data.
---

# Deleting user data


## Deleting resources via the API {#api}

If a service receives a request to delete a resource via the API, the resource is immediately marked as deleted and cannot be restored. The data is actually deleted within 72 hours.


## Automatic cloud suspension {#block}

Your cloud may be suspended due to arrears if your trial period is over or if you violate the [{{ yandex-cloud }}](https://yandex.ru/legal/cloud_termsofuse/?lang=en) Terms of Use. For more information about the payment process and possible suspension, see **Billing cycle** in the {{ billing-name }} documentation:
* [Individuals](../../billing/payment/billing-cycle-individual.md)
* [Businesses and individual entrepreneurs](../../billing/payment/billing-cycle-business.md)

In a suspended cloud:

1. Virtual machines and other resources are stopped, but the data is not deleted. Within 60 days (for violations of the Terms of Use — 7 days), the cloud can be unblocked, and resources can be relaunched.
1. When this period ends, {{ yandex-cloud }} can mark the resources for deletion and permanently delete them along with the data they contain, within 72 hours.


## Deleting logs of requests to resources {#logs}

Records of API requests to user resources are stored for 12 months. They are used for analyzing information security incidents and preventing fraud.

Records are permanently deleted once the 12-month period expires.


## Deleting a user cloud {#cloud}

When a cloud is [deleted](../../resource-manager/operations/cloud/delete.md):

1. Active virtual machines and other resources are stopped, but the data is not deleted. You have 60 days to restore the cloud and resources.
2. If the cloud is not restored within 60 days, resources from every service are marked for deletion and then deleted within 72 hours.

When a contract is terminated, all user's clouds and resources are immediately marked for deletion and deleted within 72 hours.

## How to stop working with {{ yandex-cloud }} {#quit-cloud}

At the user's request, their billing account is marked for deletion, and the user loses access to it within 72 hours.

Billing account data may be used to generate financial statements. Therefore, this data is kept until the expiration of the term of the limitation of actions and the term set by the applicable finance laws.

When these terms expire, the billing account is irrevocably deleted.

{% include [delete-account](../../_includes/billing/billing-delete-account.md) %}