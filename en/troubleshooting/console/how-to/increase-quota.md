# How to increase quotas


## Issue description {#case-description}

* You need more {{ yandex-cloud }} resources.
* When deploying new resources, {{ yandex-cloud }} displays the message saying `QUOTA_EXCEEDED` or `limit $QUOTA_NAME exceeded`, where `$QUOTA_NAME` is the service name of the quota.

## Solution {#case-resolution}

Quotas serve as a soft constraint for requesting resources and allow you to manage cloud service usage: with quotas, new users cannot take up too many resources for testing purposes. If you need more resources, you can increase your quotas in one of the following ways:

* [Request a quota increase]({{ link-console-quotas }}) from the [management console]({{ link-console-main }}).
* [Create a support ticket]({{ link-console-support }}) and specify which quotas you want to increase and by how much as well as describe how you are planning to use them.

{% note info %}

To request a quota increase, your {{ iam-short-name }} account needs the `quota-manager.requestOperator` role for the cloud where you want to increase a quota.

To request quotas, you can also assign your user the `{{ roles-editor }}` role for the cloud. Note that the `{{ roles-editor }}` role for a cloud grants permissions for all resource management operations.

{% endnote %}

To learn more about roles, see [this article](../../../iam/concepts/access-control/roles.md). For information on how to assign roles, see [this section](../../../iam/operations/roles/grant.md).

For more information on quotas, see [**Quotas and limits for {{ yandex-cloud }} services**](../../../overview/concepts/quotas-limits.md) and the relevant sections and articles for the appropriate service.
