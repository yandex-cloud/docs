# How to increase quotas


## Task description {#case-description}

* You are willing to use more {{ yandex-cloud }} resources;
* When deploying new resources in {{ yandex-cloud }}, the message `QUOTA_EXCEEDED` or `limit $QUOTA_NAME exceeded` is displayed, where `$QUOTA_NAME` is the technical name of the quota.

## Solution {#case-resolution}

Quotas serve as a soft restriction for requesting resources and enable {{ yandex-cloud }} to guarantee service stability, as new users cannot take up too many resources for testing purposes. If you are willing to use more resources, you can increase them in the following ways:

* [Generate a request for a quota increase]({{ link-console-quotas }}). You must have the `quota-manager.requestOperator` [role](../../../iam/concepts/access-control/roles.md#quota-roles) or higher (`editor` or `admin`).
* Contact [support]({{ link-console-support }}) and tell us which quotas you need to increase and by how much.

{% note info %}

To create quota increase requests, your IAM account needs the `quota-manager.requestOperator` role assigned to the cloud where the quota needs to be increased.

Also, you can assign the role of `editor` to the cloud for your user in order to request quotas increase. Note that the `editor` role on the cloud grants permissions for all operations to manage resources.

{% endnote %}

You can learn more about roles and permissions [here](../../../iam/concepts/access-control/roles.md). The procedure for assigning roles is also described in a separate section of [documentation](../../../iam/operations/roles/grant.md).

You can learn more about quotas in {{ yandex-cloud }} on the page [Quotas and limits for Yandex Cloud services](../../../overview/concepts/quotas-limits.md) and in the corresponding sections of the documentation for each service.
