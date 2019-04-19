# Terms of deleting user data

## Deleting resources via API {#api}

If a service receives a request to delete a resource via the API, the resource is immediately marked as deleted and cannot be restored. The data is actually deleted within 72 hours.

## Automatic cloud suspension {#block}

Your cloud can be suspended if there are outstanding charges. For more information about the payment process and possible suspension, read the [Billing documentation](../../billing/payment/billing-cycle.md).

In a suspended cloud, virtual machines and database clusters stop, but data is not deleted. Within 60 days, access to the cloud can be restored, and stopped resources can be restarted. After 60 days have passed, resources are marked as deleted and permanently deleted along with the data within 72 hours.

## Deleting logs of requests to resources

Records of requests to user resources via the API are stored for a year to be used for analyzing information security incidents and prevent fraud. Records are permanently deleted after a year has passed.

## Deleting a user's cloud {#cloud}

When a cloud is deleted, the virtual machines and the database clusters running in it are stopped, but the data is not deleted. The cloud can be restored along with existing resources within 30 days. If this didn't happen, after 30 days resources in all the services are marked as deleted, and are actually deleted within 72 hours.

When a contract is terminated, all clouds and resources of the user are immediately marked as deleted, and are actually deleted within 72 hours.

## Deleting a billing account {#billing-account}

Deleting a [billing account](../../billing/concepts/billing-account.md) is only possible if it is not linked to a cloud, and then only with the help of technical support.

1. At the user's request, the billing account is marked as being deleted and within 72 hours the user can no longer access it.
2. The billing account may be used to generate financial statements up to the date of expiration of the statute of limitations.
3. When the statute of limitations has come into effect, the billing account is irrevocably deleted.

