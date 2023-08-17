# Deleting user data


## Deleting resources via the API {#api}

If a service receives a request to delete a resource via the API, the resource is immediately marked as deleted and cannot be restored. The data is actually deleted within 72 hours.


## Automatic cloud suspension {#block}


Your cloud may be suspended if your account is in arrears, if your trial period is over, or if you violated any of the [{{ yandex-cloud }} Terms of Use](https://yandex.ru/legal/cloud_termsofuse/?lang=en). For more information about the payment process and possible suspension, see **Billing cycle** in the {{ billing-name }} documentation:
* [Individuals](../../billing/payment/billing-cycle-individual.md)
* [Businesses and individual entrepreneurs](../../billing/payment/billing-cycle-business.md)



In a suspended cloud:

1. Virtual machines and other resources are stopped, but the data is not deleted. The cloud can be unblocked, and resources can be relaunched within 60 days (7 days for Terms of Use violations).
1. When this period ends, {{ yandex-cloud }} can mark the resources for deletion and permanently delete them along with the data they contain, within 72 hours.


## Deleting logs of requests to resources {#logs}

Records of API requests to user resources are stored for 12 months. They are used for analyzing information security incidents and preventing fraud.

Records are permanently deleted once the 12-month period expires.


## Deleting a user cloud {#cloud}

When a cloud is deleted:

1. Active virtual machines and other resources are stopped, but the data is not deleted. You have 30 days to restore the cloud and existing resources.
2. If the cloud is not restored within 30 days, resources from every service are marked for deletion and then deleted within 72 hours.

When a contract is terminated, all user's clouds and resources are immediately marked for deletion and deleted within 72 hours.



## Deleting a billing account {#billing-account}

You can only delete a [billing account](../../billing/concepts/billing-account.md) if it is not linked to a cloud, and only with the help of the support team.

1. At the user's request, the billing account is marked for deletion, and the user loses access it within 72 hours.
2. Billing account data may be used to generate financial statements. Therefore, this data is kept until the expiration of the term of the limitation of actions and the term set by the applicable finance laws.
3. When these terms expire, the billing account is irrevocably deleted.

