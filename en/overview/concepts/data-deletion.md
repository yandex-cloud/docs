# Terms of deleting user data

## Resource deletion via the API {#api}

If a service receives a request to delete a resource via the API, the resource is immediately marked as deleted and cannot be restored. The data is actually deleted within 72 hours.

## Automatic cloud suspension {#block}

Your cloud may be suspended if there are arrears on your account, if your trial period is over, or if you are in violation of the [Yandex.Cloud terms of use](https://yandex.ru/legal/cloud_termsofuse/?lang=en). For more information about the payment process and possible suspension, read the [Billing documentation](../../billing/payment/billing-cycle.md).

In a suspended cloud:

1. Virtual machines and other resources are stopped, but data is not deleted. Within 60 days (if you violate the terms of use — 7 days), the cloud can be unsuspended, and stopped resources can be launched.
2. When this period is over, Yandex.Cloud can mark the resources for deletion and permanently delete them along with the data in the course of 72 hours.

## Deleting logs of requests to resources {#logs}

Records of API requests to user resources are stored for one year. They are used for analyzing information security incidents and preventing fraud.

Records are permanently deleted after a year has passed.

## Deleting a user's cloud {#cloud}

When a cloud is deleted:

1. Running virtual machines and other resources are stopped, but data is not deleted. You have 30 days to restore the cloud along with existing resources.
2. If the cloud was not restored within 30 days, resources of all services are marked for deletion and then actually deleted within 72 hours.

When a contract is terminated, all clouds and resources of the user are immediately marked for deletion and then actually deleted within 72 hours.

## Deleting a billing account {#billing-account}

A [billing account](../../billing/concepts/billing-account.md) can be deleted only if it is not linked to a cloud, and only with the help of technical support.

1. At the user's request, the billing account is marked for deletion and within 72 hours the user can no longer access it.
2. Billing account data may be used to generate financial statements. Therefore, this data is kept until the expiration of the term of the limitation of actions and the term set by the applicable finance laws.
3. When these terms expire, the billing account is irrevocably deleted.

